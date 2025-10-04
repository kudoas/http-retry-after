# frozen_string_literal: true

require_relative "retry_after/version"
require "time"

module HTTP
  module RetryAfter
    class NegativeRetryAfterError < StandardError; end
    class InvalidFormatError < StandardError; end

    def self.parse(retry_after)
      parse_seconds(retry_after)
    rescue InvalidFormatError
      parse_http_date(retry_after)
    end

    def self.parse_seconds(retry_after)
      seconds = begin
        Integer(retry_after)
      rescue
        raise InvalidFormatError, "Invalid Retry-After value: #{retry_after.inspect}"
      end

      raise NegativeRetryAfterError, "Negative Retry-After value: #{seconds}" if seconds.negative?
      Time.now + seconds
    end

    def self.parse_http_date(retry_after)
      Time.httpdate(retry_after)
    rescue
      raise InvalidFormatError, "Invalid Retry-After value: #{retry_after.inspect}"
    end
  end
end
