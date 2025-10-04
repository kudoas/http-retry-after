# frozen_string_literal: true

require "time"

module HttpRetryAfter
  VERSION = "0.1.0"

  class Error < StandardError; end
  class InvalidHeaderError < Error; end

  # Parse a Retry-After header value and return the remaining seconds
  #
  # @param header_value [String] The Retry-After header value
  # @return [Integer] The number of seconds to wait
  # @raise [InvalidHeaderError] When the header value is invalid
  #
  # @example Parse a numeric delay
  #   HttpRetryAfter.parse("120") #=> 120
  #
  # @example Parse an HTTP date
  #   HttpRetryAfter.parse("Wed, 21 Oct 2015 07:28:00 GMT") #=> 3600 (assuming current time)
  def self.parse(header_value)
    return 0 if header_value.nil? || header_value.strip.empty?

    header_value = header_value.strip

    # Try to parse as numeric delay first (only integers allowed)
    if header_value.match?(/\A\d+\z/)
      return header_value.to_i
    end

    # Check if it looks like a malformed number (contains decimal point or other non-date characters)
    if header_value.match?(/\A[\d.]+\z/) || header_value.match?(/\A[a-zA-Z]+\z/)
      raise InvalidHeaderError, "Invalid Retry-After header format: #{header_value}"
    end

    # Try to parse as HTTP date
    begin
      retry_time = Time.parse(header_value)
      delay = (retry_time - Time.now).to_i
      return [delay, 0].max # Don't return negative values
    rescue ArgumentError
      raise InvalidHeaderError, "Invalid Retry-After header format: #{header_value}"
    end
  end
end