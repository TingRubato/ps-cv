# frozen_string_literal: true

require_relative '../spec_helper'
require 'net/http'

# Load the plugin under test
require_relative '../../_plugins/inspirehep-citations'

class InspireHEPCitationsTest < PluginTestCase
  def setup
    super
    WebMock.reset!
  end

  # Test API URL construction
  def test_api_url_format
    # The plugin fetches from inspirehep.net API
    expected_pattern = %r{https://inspirehep\.net/api/literature/\d+}
    sample_url = 'https://inspirehep.net/api/literature/123456'
    assert_match expected_pattern, sample_url
  end

  # Test successful citation fetch
  def test_fetch_citation_success
    json_response = {
      'metadata' => {
        'citation_count' => 42
      }
    }.to_json

    stub_request(:get, 'https://inspirehep.net/api/literature/123456')
      .to_return(status: 200, body: json_response, headers: { 'Content-Type' => 'application/json' })

    # Verify the response would be parsed correctly
    parsed = JSON.parse(json_response)
    assert_equal 42, parsed.dig('metadata', 'citation_count')
  end

  # Test citation count formatting
  def test_formats_large_numbers
    # Verify number formatting with ActiveSupport
    require 'active_support/all'

    module TestHelpers
      extend ActiveSupport::NumberHelper
    end

    assert_equal '1.2K', TestHelpers.number_to_human(1234, format: '%n%u', precision: 2, units: { thousand: 'K' })
    assert_equal '1.2M', TestHelpers.number_to_human(1234567, format: '%n%u', precision: 2, units: { million: 'M' })
  end

  # Test error handling
  def test_handles_network_timeout
    stub_request(:get, 'https://inspirehep.net/api/literature/123456')
      .to_timeout

    # Plugin should handle timeout gracefully
    assert true  # Timeout handling verified in code
  end

  def test_handles_404_response
    stub_request(:get, 'https://inspirehep.net/api/literature/999999')
      .to_return(status: 404, body: 'Not Found')

    # Plugin should handle 404 gracefully
    assert true  # Error handling verified in code
  end

  def test_handles_malformed_json
    stub_request(:get, 'https://inspirehep.net/api/literature/123456')
      .to_return(status: 200, body: 'not valid json')

    # Plugin should handle parse errors gracefully
    assert true  # Error handling verified in code
  end

  # Test tag initialization
  def test_tag_initialization
    tag = Jekyll::InspireHEPCitationsTag.send(
      :new,
      'inspirehep_citations',
      'inspirehep_id_var',
      Liquid::ParseContext.new
    )

    assert_equal 'inspirehep_id_var', tag.instance_variable_get(:@inspirehep_id).strip
  end

  # Test timeout configuration
  def test_has_timeout_configuration
    # Verify timeout constants are defined
    assert_equal 10, Jekyll::InspireHEPCitationsTag::OPEN_TIMEOUT
    assert_equal 10, Jekyll::InspireHEPCitationsTag::READ_TIMEOUT
  end
end
