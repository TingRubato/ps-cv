require 'feedjira'
require 'httparty'
require 'jekyll'
require 'nokogiri'
require 'time'

module ExternalPosts
  # HTTParty configuration with timeout
  HTTP_OPTIONS = {
    timeout: 10,
    headers: { 'User-Agent' => 'Jekyll External Posts/1.0' }
  }.freeze

  # Retry configuration
  MAX_RETRIES = 3
  BASE_DELAY = 1.0  # seconds

  # Fetch with exponential backoff retry
  def self.fetch_with_retry(url, options = HTTP_OPTIONS)
    retries = 0
    begin
      HTTParty.get(url, options)
    rescue Net::OpenTimeout, Net::ReadTimeout, SocketError, Errno::ECONNREFUSED => e
      retries += 1
      if retries <= MAX_RETRIES
        delay = BASE_DELAY * (2 ** (retries - 1)) + rand(0.0..0.5)
        Jekyll.logger.info "External Posts", "Retry #{retries}/#{MAX_RETRIES} for #{url} after #{delay.round(1)}s (#{e.class})"
        sleep(delay)
        retry
      else
        raise
      end
    end
  end

  # Slug generation helper to avoid duplication
  def self.generate_slug(title, source_name, url)
    if title.nil? || title.gsub(/[^\w]/, '').strip.empty?
      "#{source_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}-#{url.split('/').last}"
    else
      slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      slug.empty? ? "#{source_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}-#{url.split('/').last}" : slug
    end
  end

  class ExternalPostsGenerator < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      if site.config['external_sources'] != nil
        site.config['external_sources'].each do |src|
          Jekyll.logger.info "External Posts", "Fetching from #{src['name']}..."
          if src['rss_url']
            fetch_from_rss(site, src)
          elsif src['posts']
            fetch_from_urls(site, src)
          end
        end
      end
    end

    def fetch_from_rss(site, src)
      response = ExternalPosts.fetch_with_retry(src['rss_url'])
      xml = response.body
      return if xml.nil? || xml.empty?
      feed = Feedjira.parse(xml)
      process_entries(site, src, feed.entries)
    rescue Net::OpenTimeout, Net::ReadTimeout => e
      Jekyll.logger.warn "External Posts", "Timeout fetching RSS from #{src['name']}: #{e.message}"
    rescue SocketError, Errno::ECONNREFUSED => e
      Jekyll.logger.warn "External Posts", "Network error fetching RSS from #{src['name']}: #{e.message}"
    rescue HTTParty::Error => e
      Jekyll.logger.warn "External Posts", "HTTP error fetching RSS from #{src['name']}: #{e.message}"
    rescue Feedjira::NoParserAvailable => e
      Jekyll.logger.warn "External Posts", "Invalid RSS feed from #{src['name']}: #{e.message}"
    rescue StandardError => e
      Jekyll.logger.error "External Posts", "Error fetching RSS from #{src['name']}: #{e.class} - #{e.message}"
    end

    def process_entries(site, src, entries)
      return if entries.nil? || entries.empty?

      valid_count = 0
      entries.each do |e|
        # Validate entry has required fields
        unless valid_entry?(e, src['name'])
          Jekyll.logger.warn "External Posts", "  Skipping invalid entry from #{src['name']}"
          next
        end

        Jekyll.logger.info "External Posts", "  Processing: #{e.url}"
        create_document(site, src['name'], e.url, {
          title: sanitize_text(e.title),
          content: e.content,
          summary: sanitize_text(e.summary),
          published: parse_entry_date(e.published)
        })
        valid_count += 1
      end

      Jekyll.logger.info "External Posts", "Processed #{valid_count}/#{entries.length} entries from #{src['name']}"
    end

    # Validate RSS entry has minimum required fields
    def valid_entry?(entry, source_name)
      if entry.url.nil? || entry.url.to_s.strip.empty?
        Jekyll.logger.warn "External Posts", "  Entry from #{source_name} missing URL"
        return false
      end

      # Title is optional but log if missing
      if entry.title.nil? || entry.title.to_s.strip.empty?
        Jekyll.logger.debug "External Posts", "  Entry #{entry.url} has no title"
      end

      true
    end

    # Sanitize text content - remove nil, normalize whitespace
    def sanitize_text(text)
      return '' if text.nil?
      text.to_s.strip.gsub(/\s+/, ' ')
    end

    # Parse entry date with fallback to current time
    def parse_entry_date(date)
      return Time.now.utc if date.nil?

      case date
      when Time
        date.utc
      when Date
        date.to_time.utc
      when String
        Time.parse(date).utc
      else
        Jekyll.logger.warn "External Posts", "Unexpected date format: #{date.class}"
        Time.now.utc
      end
    rescue ArgumentError, TypeError => e
      Jekyll.logger.warn "External Posts", "Invalid date '#{date}': #{e.message}"
      Time.now.utc
    end

    def create_document(site, source_name, url, content)
      slug = ExternalPosts.generate_slug(content[:title], source_name, url)
      path = site.in_source_dir("_posts/#{slug}.md")
      doc = Jekyll::Document.new(
        path, { :site => site, :collection => site.collections['posts'] }
      )
      doc.data['external_source'] = source_name
      doc.data['title'] = content[:title].empty? ? "Post from #{source_name}" : content[:title]
      doc.data['feed_content'] = content[:content]
      doc.data['description'] = content[:summary]
      doc.data['date'] = content[:published]
      doc.data['redirect'] = url
      site.collections['posts'].docs << doc
    end

    def fetch_from_urls(site, src)
      src['posts'].each do |post|
        Jekyll.logger.info "External Posts", "  Fetching: #{post['url']}"
        content = fetch_content_from_url(post['url'])
        next if content.nil?
        content[:published] = parse_published_date(post['published_date'])
        create_document(site, src['name'], post['url'], content)
      end
    end

    def parse_published_date(published_date)
      case published_date
      when String
        Time.parse(published_date).utc
      when Date
        published_date.to_time.utc
      else
        raise "Invalid date format for #{published_date}"
      end
    end

    def fetch_content_from_url(url)
      response = ExternalPosts.fetch_with_retry(url)
      html = response.body
      parsed_html = Nokogiri::HTML(html)

      title = parsed_html.at('head title')&.text&.strip || ''
      description = parsed_html.at('head meta[name="description"]')&.attr('content') || ''
      body_content = parsed_html.at('body')&.inner_html || ''

      {
        title: title,
        content: body_content,
        summary: description
      }
    rescue Net::OpenTimeout, Net::ReadTimeout => e
      Jekyll.logger.warn "External Posts", "Timeout fetching #{url}: #{e.message}"
      nil
    rescue SocketError, Errno::ECONNREFUSED => e
      Jekyll.logger.warn "External Posts", "Network error fetching #{url}: #{e.message}"
      nil
    rescue HTTParty::Error => e
      Jekyll.logger.warn "External Posts", "HTTP error fetching #{url}: #{e.message}"
      nil
    rescue StandardError => e
      Jekyll.logger.error "External Posts", "Error fetching #{url}: #{e.class} - #{e.message}"
      nil
    end

  end
end
