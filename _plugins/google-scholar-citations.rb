require "active_support/all"
require 'nokogiri'
require 'open-uri'

module Helpers
  extend ActiveSupport::NumberHelper
end

module Jekyll
  class GoogleScholarCitationsTag < Liquid::Tag
    # Thread-safe citation cache with mutex protection
    @citations_mutex = Mutex.new
    @citations = {}

    class << self
      attr_reader :citations_mutex, :citations

      def get_citation(article_id)
        @citations_mutex.synchronize { @citations[article_id] }
      end

      def set_citation(article_id, count)
        @citations_mutex.synchronize { @citations[article_id] = count }
      end
    end

    def initialize(tag_name, params, tokens)
      super
      splitted = params.split(" ").map(&:strip)
      @scholar_id = splitted[0]
      @article_id = splitted[1]

      if @scholar_id.nil? || @scholar_id.empty?
        Jekyll.logger.warn "Scholar", "Invalid scholar_id provided"
      end

      if @article_id.nil? || @article_id.empty?
        Jekyll.logger.warn "Scholar", "Invalid article_id provided"
      end
    end

    def render(context)
      article_id = context[@article_id.strip]
      scholar_id = context[@scholar_id.strip]
      article_url = "https://scholar.google.com/citations?view_op=view_citation&hl=en&user=#{scholar_id}&citation_for_view=#{scholar_id}:#{article_id}"

      begin
        # If the citation count has already been fetched, return it (thread-safe)
        cached = GoogleScholarCitationsTag.get_citation(article_id)
        return cached if cached

        # Sleep for a random amount of time to avoid being blocked
        sleep(rand(1.5..3.5))

        # Fetch the article page
        doc = Nokogiri::HTML(URI.open(article_url, "User-Agent" => "Ruby/#{RUBY_VERSION}", open_timeout: 10, read_timeout: 10))

        # Attempt to extract the "Cited by n" string from the meta tags
        citation_count = 0

        # Look for meta tags with "name" attribute set to "description"
        description_meta = doc.css('meta[name="description"]')
        og_description_meta = doc.css('meta[property="og:description"]')

        if !description_meta.empty?
          cited_by_text = description_meta[0]['content']
          matches = cited_by_text.match(/Cited by (\d+[,\d]*)/)

          if matches
            citation_count = matches[1].sub(",", "").to_i
          end

        elsif !og_description_meta.empty?
          cited_by_text = og_description_meta[0]['content']
          matches = cited_by_text.match(/Cited by (\d+[,\d]*)/)

          if matches
            citation_count = matches[1].sub(",", "").to_i
          end
        end

        citation_count = Helpers.number_to_human(citation_count, :format => '%n%u', :precision => 2, :units => { :thousand => 'K', :million => 'M', :billion => 'B' })

      rescue Net::OpenTimeout, Net::ReadTimeout => e
        citation_count = "N/A"
        Jekyll.logger.warn "Scholar", "Timeout fetching citation count for #{article_id}: #{e.message}"

      rescue SocketError, Errno::ECONNREFUSED => e
        citation_count = "N/A"
        Jekyll.logger.warn "Scholar", "Network error fetching citation count for #{article_id}: #{e.message}"

      rescue OpenURI::HTTPError => e
        citation_count = "N/A"
        Jekyll.logger.warn "Scholar", "HTTP error fetching citation count for #{article_id}: #{e.message}"

      rescue StandardError => e
        citation_count = "N/A"
        Jekyll.logger.error "Scholar", "Unexpected error fetching citation count for #{article_id}: #{e.class} - #{e.message}"
      end

      GoogleScholarCitationsTag.set_citation(article_id, citation_count)
      return "#{citation_count}"
    end
  end
end

Liquid::Template.register_tag('google_scholar_citations', Jekyll::GoogleScholarCitationsTag)
