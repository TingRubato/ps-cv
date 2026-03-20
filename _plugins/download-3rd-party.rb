require 'css_parser'
require 'digest'
require 'fileutils'
require 'nokogiri'
require 'open-uri'
require 'uri'

# Helper module for downloading third-party assets
module ThirdPartyDownloader
  FONT_FILE_TYPES = %w[otf ttf woff woff2].freeze
  IMAGE_FILE_TYPES = %w[.gif .jpg .jpeg .png .webp].freeze
  OPEN_TIMEOUT = 10
  READ_TIMEOUT = 30

  class << self
    # Validate URL is safe to download from
    def valid_url?(url)
      return false if url.nil? || url.empty?
      return false if url.start_with?('|')  # Security check

      begin
        uri = URI.parse(url)
        uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      rescue URI::InvalidURIError
        false
      end
    end

    # Build local asset path with optional baseurl
    def local_asset_path(config, *path_parts)
      base = config['baseurl'] || ''
      File.join(base, 'assets', 'libs', *path_parts)
    end

    # Download file with proper error handling and timeouts
    def download_file(url, dest)
      return unless valid_url?(url)

      dir = File.dirname(dest)
      FileUtils.mkdir_p(dir) unless File.directory?(dir)

      return if File.file?(dest)

      Jekyll.logger.info "Download", "Fetching #{url}"
      File.open(dest, "wb") do |saved_file|
        URI.open(url, "rb", open_timeout: OPEN_TIMEOUT, read_timeout: READ_TIMEOUT) do |read_file|
          saved_file.write(read_file.read)
        end
      end

      unless File.file?(dest)
        raise "Failed to download #{url} to #{dest}"
      end

      Jekyll.logger.info "Download", "Saved to #{dest}"
    rescue Net::OpenTimeout, Net::ReadTimeout => e
      Jekyll.logger.warn "Download", "Timeout downloading #{url}: #{e.message}"
    rescue OpenURI::HTTPError => e
      Jekyll.logger.warn "Download", "HTTP error downloading #{url}: #{e.message}"
    rescue StandardError => e
      Jekyll.logger.error "Download", "Error downloading #{url}: #{e.class} - #{e.message}"
    end

    # Update CSS rule set URL to local path
    def update_rule_set_url(rule_set, rule, dest, dirname, config, file_types)
      return unless rule_set[rule]&.include?('url(')

      url = extract_url_from_css(rule_set[rule])
      return unless url

      file_name = File.basename(url.split('?').first)
      return unless file_name.end_with?(*file_types)

      # Ensure absolute URL
      url = URI.join(url, url).to_s unless url.start_with?('https://')

      download_file(url, File.join(dest, file_name))

      # Update rule to local path
      previous_rule = rule_set[rule]
      local_path = local_asset_path(config, dirname, file_name)
      rule_set[rule] = build_css_url(rule_set[rule], local_path)

      Jekyll.logger.debug "Download", "Updated CSS: #{previous_rule} -> #{rule_set[rule]}"
    end

    # Extract URL from CSS url() function
    def extract_url_from_css(css_value)
      url = css_value.split('url(').last.split(')').first
      url = url[1..-2] if url.start_with?('"', "'")
      url
    end

    # Build CSS url() with optional format suffix
    def build_css_url(original_rule, local_path)
      parts = original_rule.split(' ')
      if parts.length > 1
        "url(#{local_path}) #{parts.last}"
      else
        "url(#{local_path})"
      end
    end

    # Download fonts by scraping directory listing
    def download_fonts_from_listing(url, dest)
      return unless valid_url?(url)
      return if File.directory?(dest) && !Dir.empty?(dest)

      Jekyll.logger.info "Download", "Fetching fonts from #{url}"
      doc = fetch_html(url)
      return unless doc

      doc.css('a').each do |link|
        href = link['href']
        next unless href

        file_name = File.basename(href.split('?').first)
        next unless file_name.end_with?(*FONT_FILE_TYPES)

        download_file(URI.join(url, href).to_s, File.join(dest, file_name))
      end
    end

    # Download images by scraping directory listing
    def download_images_from_listing(url, dest)
      return unless valid_url?(url)
      return if File.directory?(dest) && !Dir.empty?(dest)

      Jekyll.logger.info "Download", "Fetching images from #{url}"
      doc = fetch_html(url)
      return unless doc

      doc.xpath('/html/body/div/div[3]/table/tbody/tr/td[1]/a').each do |link|
        href = link['href']
        next unless href

        file_name = File.basename(href.split('?').first)
        next unless file_name.end_with?(*IMAGE_FILE_TYPES)

        download_file(URI.join(url, href).to_s, File.join(dest, file_name))
      end
    end

    # Download fonts from CSS file and rewrite URLs
    def download_fonts_from_css(config, url, dest, lib_name)
      return unless valid_url?(url)

      file_name = File.basename(url.split('?').first)
      file_name = 'google-fonts.css' if file_name == 'css'

      return file_name if File.file?(File.join(dest, file_name))

      Jekyll.logger.info "Download", "Processing CSS fonts from #{url}"

      # Use Chrome UA to get woff2 fonts
      doc = fetch_html(url, chrome_user_agent: true)
      return unless doc

      css = CssParser::Parser.new
      css.load_string!(doc.document.text)

      css.each_rule_set do |rule_set|
        update_rule_set_url(
          rule_set, 'src',
          File.join(dest, 'fonts'),
          File.join(lib_name, 'fonts'),
          config,
          FONT_FILE_TYPES
        )
      end

      output_path = File.join(dest, file_name)
      File.write(output_path, css.to_s)
      Jekyll.logger.info "Download", "Saved modified CSS to #{output_path}"

      file_name
    end

    private

    def fetch_html(url, chrome_user_agent: false)
      user_agent = if chrome_user_agent
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36"
      else
        "Ruby/#{RUBY_VERSION}"
      end

      Nokogiri::HTML(URI.open(url, "User-Agent" => user_agent, open_timeout: OPEN_TIMEOUT, read_timeout: READ_TIMEOUT))
    rescue Net::OpenTimeout, Net::ReadTimeout => e
      Jekyll.logger.warn "Download", "Timeout fetching #{url}: #{e.message}"
      nil
    rescue OpenURI::HTTPError => e
      Jekyll.logger.warn "Download", "HTTP error fetching #{url}: #{e.message}"
      nil
    rescue StandardError => e
      Jekyll.logger.error "Download", "Error fetching #{url}: #{e.class} - #{e.message}"
      nil
    end
  end
end

# Main Jekyll hook for downloading third-party libraries
Jekyll::Hooks.register :site, :after_init do |site|
  libs = site.config['third_party_libraries']
  next unless libs

  # Replace {{version}} placeholders in all URLs
  libs.each do |key, value|
    next if key == 'download' || !value.is_a?(Hash) || !value['url']

    value['url'].each do |type, url|
      if url.is_a?(Hash)
        url.each do |type2, url2|
          next unless url2.is_a?(String) && url2.include?('{{version}}')
          libs[key]['url'][type][type2] = url2.gsub('{{version}}', value['version'].to_s)
        end
      elsif url.is_a?(String) && url.include?('{{version}}')
        libs[key]['url'][type] = url.gsub('{{version}}', value['version'].to_s)
      end
    end
  end

  # Download libraries if enabled
  next unless libs['download']

  Jekyll.logger.info "Download", "Starting third-party library downloads..."
  download_count = 0

  libs.each do |key, value|
    next if key == 'download' || !value.is_a?(Hash) || !value['url']

    value['url'].each do |type, url|
      if url.is_a?(Hash)
        url.each do |type2, url2|
          file_name = File.basename(url2.split('?').first)
          dest = File.join(site.source, 'assets', 'libs', key, file_name)
          ThirdPartyDownloader.download_file(url2, dest)
          libs[key]['url'][type][type2] = ThirdPartyDownloader.local_asset_path(site.config, key, file_name)
          download_count += 1
        end
      elsif type == 'fonts'
        file_name = File.basename(url.split('?').first)

        if file_name.end_with?('css')
          file_name = ThirdPartyDownloader.download_fonts_from_css(
            site.config, url,
            File.join(site.source, 'assets', 'libs', key),
            key
          )
          libs[key]['url'][type] = ThirdPartyDownloader.local_asset_path(site.config, key, file_name) if file_name
        else
          local_path = value.dig('local', type)
          ThirdPartyDownloader.download_fonts_from_listing(
            url,
            File.join(site.source, 'assets', 'libs', key, local_path)
          ) if local_path
        end
        download_count += 1
      elsif type == 'images'
        local_path = value.dig('local', type)
        ThirdPartyDownloader.download_images_from_listing(
          url,
          File.join(site.source, 'assets', 'libs', key, local_path)
        ) if local_path
        download_count += 1
      else
        file_name = File.basename(url.split('?').first)
        dest = File.join(site.source, 'assets', 'libs', key, file_name)
        ThirdPartyDownloader.download_file(url, dest)
        libs[key]['url'][type] = ThirdPartyDownloader.local_asset_path(site.config, key, file_name)
        download_count += 1
      end
    end
  end

  Jekyll.logger.info "Download", "Completed processing #{download_count} assets"
end
