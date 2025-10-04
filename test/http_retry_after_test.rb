# frozen_string_literal: true

require "test_helper"

class HTTPRetryAfterTest < Minitest::Test
  def test_has_version_number
    refute_nil HTTP::RetryAfter::VERSION
  end

  def test_module_is_accessible
    assert defined?(HTTP::RetryAfter)
  end

  def test_parsed_http_date
    response = HTTP::RetryAfter.parse_http_date("Wed, 21 Oct 2015 07:28:00 GMT")
    assert_equal Time.utc(2015, 10, 21, 7, 28, 0), response
  end

  def test_parsed_http_date_with_invalid_format
    assert_raises(HTTP::RetryAfter::InvalidFormatError) do
      HTTP::RetryAfter.parse_http_date("not a valid http date")
    end
  end

  def test_parsed_seconds
    now = Time.now
    response = HTTP::RetryAfter.parse_seconds("120")
    assert_in_delta now + 120, response, 1
  end

  def test_parsed_negative_seconds
    assert_raises(HTTP::RetryAfter::NegativeRetryAfterError) do
      HTTP::RetryAfter.parse_seconds("-10")
    end
  end

  def test_parsed_seconds_with_non_numeric_value
    assert_raises(HTTP::RetryAfter::InvalidFormatError) do
      HTTP::RetryAfter.parse_seconds("abc")
    end
  end

  def test_parse_with_seconds_string
    now = Time.now
    response = HTTP::RetryAfter.parse("45")
    assert_in_delta now + 45, response, 1
  end

  def test_parse_with_http_date
    response = HTTP::RetryAfter.parse("Wed, 21 Oct 2015 07:28:00 GMT")
    assert_equal Time.utc(2015, 10, 21, 7, 28, 0), response
  end

  def test_parse_with_negative_seconds
    assert_raises(HTTP::RetryAfter::NegativeRetryAfterError) do
      HTTP::RetryAfter.parse("-1")
    end
  end

  def test_parse_with_invalid_value
    assert_raises(HTTP::RetryAfter::InvalidFormatError) do
      HTTP::RetryAfter.parse("not a retry after value")
    end
  end

  def test_parse_with_nil_value
    assert_raises(HTTP::RetryAfter::InvalidFormatError) do
      HTTP::RetryAfter.parse(nil)
    end
  end
end
