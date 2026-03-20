# frozen_string_literal: true

require_relative '../spec_helper'
require 'feedjira'
require 'httparty'

# Load the plugin under test
require_relative '../../_plugins/external-posts'

class ExternalPostsTest < PluginTestCase
  def setup
    super
    WebMock.reset!
  end

  # Test slug generation helper
  def test_generate_slug_with_valid_title
    slug = ExternalPosts.generate_slug('Hello World Post', 'Medium', 'https://example.com/post')
    assert_equal 'hello-world-post', slug
  end

  def test_generate_slug_with_empty_title
    slug = ExternalPosts.generate_slug('', 'Medium', 'https://example.com/my-post')
    assert_equal 'medium-my-post', slug
  end

  def test_generate_slug_with_nil_title
    slug = ExternalPosts.generate_slug(nil, 'Medium', 'https://example.com/my-post')
    assert_equal 'medium-my-post', slug
  end

  def test_generate_slug_with_special_characters
    slug = ExternalPosts.generate_slug('Hello! @World# $Post%', 'Medium', 'https://example.com/post')
    assert_equal 'hello-world-post', slug
  end

  def test_generate_slug_with_foreign_characters
    slug = ExternalPosts.generate_slug('日本語タイトル', 'Medium', 'https://example.com/my-post')
    assert_equal 'medium-my-post', slug
  end

  # Test retry logic
  def test_fetch_with_retry_success
    stub_request(:get, 'https://example.com/feed.xml')
      .to_return(status: 200, body: '<rss></rss>')

    response = ExternalPosts.fetch_with_retry('https://example.com/feed.xml')
    assert_equal '<rss></rss>', response.body
  end

  def test_fetch_with_retry_after_transient_failure
    stub_request(:get, 'https://example.com/feed.xml')
      .to_timeout
      .then.to_return(status: 200, body: '<rss></rss>')

    # Mock sleep to speed up tests
    ExternalPosts.stub_const(:BASE_DELAY, 0.01) do
      response = ExternalPosts.fetch_with_retry('https://example.com/feed.xml')
      assert_equal '<rss></rss>', response.body
    end
  end

  def test_fetch_with_retry_max_retries_exceeded
    stub_request(:get, 'https://example.com/feed.xml')
      .to_timeout

    # Should raise after max retries
    assert_raises(Net::OpenTimeout) do
      ExternalPosts.stub_const(:BASE_DELAY, 0.01) do
        ExternalPosts.fetch_with_retry('https://example.com/feed.xml')
      end
    end
  end

  # Test HTTP options configuration
  def test_http_options_has_timeout
    assert_equal 10, ExternalPosts::HTTP_OPTIONS[:timeout]
  end

  def test_http_options_has_user_agent
    assert_includes ExternalPosts::HTTP_OPTIONS[:headers]['User-Agent'], 'Jekyll'
  end
end
