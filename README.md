# HttpRetryAfter

A simple Ruby gem that parses HTTP `Retry-After` headers and converts them to remaining seconds.

The `Retry-After` header is used by servers to indicate when a client should retry a request. This header can contain either:
- A numeric delay in seconds (e.g., `"120"`)
- An HTTP date when the client can retry (e.g., `"Wed, 21 Oct 2015 07:28:00 GMT"`)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'http-retry-after'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install http-retry-after

## Usage

```ruby
require 'http_retry_after'

# Parse numeric delay (seconds)
HttpRetryAfter.parse("120")  #=> 120

# Parse HTTP date format
HttpRetryAfter.parse("Wed, 21 Oct 2015 07:28:00 GMT")  #=> 3600 (example, depends on current time)

# Handle edge cases
HttpRetryAfter.parse(nil)     #=> 0
HttpRetryAfter.parse("")      #=> 0
HttpRetryAfter.parse("   ")   #=> 0

# Past dates return 0
past_date = "Wed, 21 Oct 2020 07:28:00 GMT"
HttpRetryAfter.parse(past_date)  #=> 0

# Invalid formats raise an error
begin
  HttpRetryAfter.parse("invalid")
rescue HttpRetryAfter::InvalidHeaderError => e
  puts "Invalid header: #{e.message}"
end
```

### Real-world Example

```ruby
require 'net/http'
require 'http_retry_after'

response = Net::HTTP.get_response(uri)

if response.code == '429' # Too Many Requests
  retry_after_header = response['Retry-After']
  if retry_after_header
    delay = HttpRetryAfter.parse(retry_after_header)
    puts "Rate limited. Retrying in #{delay} seconds..."
    sleep(delay)
    # Retry the request
  end
end
```

## API Reference

### `HttpRetryAfter.parse(header_value)`

Parses a `Retry-After` header value and returns the remaining seconds.

**Parameters:**
- `header_value` (String): The value of the Retry-After header

**Returns:**
- `Integer`: Number of seconds to wait before retrying

**Raises:**
- `HttpRetryAfter::InvalidHeaderError`: When the header value is invalid

**Supported Formats:**
- Numeric delay: `"60"`, `"3600"`
- HTTP date formats: RFC 2822, ISO 8601, and other formats supported by Ruby's `Time.parse`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kudoas/http-retry-after.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).