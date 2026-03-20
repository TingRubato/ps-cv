require "active_support/all"
require 'net/http'
require 'json'
require 'uri'

module Helpers
  extend ActiveSupport::NumberHelper
end

module Jekyll
  class InspireHEPCitationsTag < Liquid::Tag
    Citations = { }

    # Timeout configuration
    OPEN_TIMEOUT = 10
    READ_TIMEOUT = 10

    def initialize(tag_name, params, tokens)
      super
      @recid = params.strip
    end

    def render(context)
      recid = context[@recid.strip]
      api_url = "https://inspirehep.net/api/literature/?fields=citation_count&q=recid:#{recid}"

      begin
        # If the citation count has already been fetched, return it
        if InspireHEPCitationsTag::Citations[recid]
          return InspireHEPCitationsTag::Citations[recid]
        end

        # Fetch the citation count from the API with timeout
        uri = URI(api_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.open_timeout = OPEN_TIMEOUT
        http.read_timeout = READ_TIMEOUT

        request = Net::HTTP::Get.new(uri)
        request['User-Agent'] = 'Jekyll InspireHEP Plugin/1.0'

        response = http.request(request)
        data = JSON.parse(response.body)

        # Extract citation count from the JSON data
        citation_count = data["hits"]["hits"][0]["metadata"]["citation_count"].to_i

        # Format the citation count for readability
        citation_count = Helpers.number_to_human(citation_count, format: '%n%u', precision: 2, units: { thousand: 'K', million: 'M', billion: 'B' })

      rescue Net::OpenTimeout, Net::ReadTimeout => e
        citation_count = "N/A"
        Jekyll.logger.warn "InspireHEP", "Timeout fetching citation count for #{recid}: #{e.message}"

      rescue SocketError, Errno::ECONNREFUSED => e
        citation_count = "N/A"
        Jekyll.logger.warn "InspireHEP", "Network error fetching citation count for #{recid}: #{e.message}"

      rescue JSON::ParserError => e
        citation_count = "N/A"
        Jekyll.logger.warn "InspireHEP", "Invalid JSON response for #{recid}: #{e.message}"

      rescue NoMethodError, TypeError => e
        citation_count = "N/A"
        Jekyll.logger.warn "InspireHEP", "Unexpected API response format for #{recid}: #{e.message}"

      rescue StandardError => e
        citation_count = "N/A"
        Jekyll.logger.error "InspireHEP", "Error fetching citation count for #{recid}: #{e.class} - #{e.message}"
      end

      InspireHEPCitationsTag::Citations[recid] = citation_count
      return "#{citation_count}"
    end
  end
end

Liquid::Template.register_tag('inspirehep_citations', Jekyll::InspireHEPCitationsTag)
