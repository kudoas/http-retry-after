# http-retry-after

[![Gem Version](https://badge.fury.io/rb/http-retry-after.svg?icon=si%3Arubygems)](https://badge.fury.io/rb/http-retry-after)

`http-retry-after` is a Ruby gem for parsing HTTP `Retry-After` header values and converting them into Ruby `Time` instances, so clients can respect server retry policies defined in RFC 9110 without reimplementing parsing logic.

## What is Retry-After?

The HTTP `Retry-After` response header, defined in [RFC 9110, Section 10.2.2](https://www.rfc-editor.org/rfc/rfc9110.html#name-retry-after), tells a client when it may retry a request after receiving a response such as `503 Service Unavailable` or `429 Too Many Requests`. The value can be either an HTTP-date, indicating the time after which the retry is safe, or a delta-seconds value that expresses the remaining seconds until the retry should be attempted. Servers may also include additional hints (for example `Retry-After: 120` for two minutes) so clients can implement a backoff strategy.

## Usage

Require the gem and call `HTTP::RetryAfter.parse` with either a delta-seconds value or an HTTP-date string:

```ruby
require "http/retry-after"

# Delta-seconds value (interpreted as seconds from now)
HTTP::RetryAfter.parse("120")

# HTTP-date value
HTTP::RetryAfter.parse("Wed, 21 Oct 2015 07:28:00 GMT")
```

When `parse` receives a string it first attempts to interpret it as delta seconds and, if that fails, falls back to parsing an HTTP-date. You can also call the lower-level helpers directly when you already know which format you are dealing with:

```ruby
HTTP::RetryAfter.parse_seconds("30")
HTTP::RetryAfter.parse_http_date("Wed, 21 Oct 2015 07:28:00 GMT")
```

Working with `Net::HTTP`:

```ruby
require "net/http"
require "uri"
require "http/retry-after"

uri = URI("https://httpbin.org/response-headers?Retry-After=120")
response = Net::HTTP.get_response(uri)

retry_after_header = response["Retry-After"]
retry_at = HTTP::RetryAfter.parse(retry_after_header)
```

Errors:

- `HTTP::RetryAfter::NegativeRetryAfterError` is raised when a negative delta-seconds value is provided.
- `HTTP::RetryAfter::InvalidFormatError` is raised when the value cannot be interpreted as seconds or an HTTP-date (including `nil` values or malformed strings).

Both helpers return a `Time` object. `parse_seconds` uses `Time.now + seconds`, so the result is in the current system timezone, whereas `parse_http_date` uses `Time.httpdate` and returns a UTC timestamp.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "http-retry-after"
```

And then execute:

```sh
bundle install
```

## Development

After checking out the repository, install dependencies and run the test suite:

```sh
bundle install
bundle exec rake test
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kudoas/http-retry-after. This project is intended to be a safe, welcoming space for collaboration.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
