# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'jekyll'
require 'webmock/minitest'

# Disable external network requests during tests
WebMock.disable_net_connect!(allow_localhost: true)

# Test helper module for Jekyll plugin testing
module JekyllTestHelper
  # Create a minimal Jekyll site for testing
  def create_site(config = {})
    default_config = {
      'source' => fixture_path,
      'destination' => File.join(fixture_path, '_site'),
      'collections' => { 'posts' => { 'output' => true } },
      'baseurl' => '',
      'url' => 'http://localhost:4000',
      'third_party_libraries' => { 'download' => false },
      'data' => {
        'socials' => { 'scholar_userid' => 'test_user_id' }
      }
    }
    Jekyll::Site.new(Jekyll.configuration(default_config.merge(config)))
  end

  # Path to test fixtures
  def fixture_path
    @fixture_path ||= File.expand_path('fixtures', __dir__)
  end

  # Create a minimal fixture directory structure
  def setup_fixtures
    FileUtils.mkdir_p(File.join(fixture_path, '_posts'))
    FileUtils.mkdir_p(File.join(fixture_path, '_plugins'))
    FileUtils.mkdir_p(File.join(fixture_path, '_site'))
  end

  # Clean up fixtures after tests
  def teardown_fixtures
    FileUtils.rm_rf(File.join(fixture_path, '_site'))
  end

  # Helper to load a plugin file
  def load_plugin(plugin_name)
    plugin_path = File.expand_path("../../_plugins/#{plugin_name}.rb", __dir__)
    load plugin_path
  end

  # Stub an HTTP response
  def stub_http_request(url, body:, status: 200, headers: {})
    stub_request(:get, url)
      .to_return(status: status, body: body, headers: headers)
  end

  # Create a Liquid context for testing tags
  def create_liquid_context(variables = {})
    site = create_site
    Liquid::Context.new([variables], {}, { site: site })
  end
end

# Base test class for all plugin tests
class PluginTestCase < Minitest::Test
  include JekyllTestHelper

  def setup
    setup_fixtures
  end

  def teardown
    teardown_fixtures
  end
end
