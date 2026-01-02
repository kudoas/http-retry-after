# frozen_string_literal: true

require_relative "lib/http/retry_after/version"

Gem::Specification.new do |spec|
  spec.name          = "http-retry-after"
  spec.version       = HTTP::RetryAfter::VERSION
  spec.authors       = ["Daichi KUDO"]
  spec.summary       = "A Ruby gem for handling HTTP Retry-After headers."
  spec.description   = <<~DESC
    HTTP::RetryAfter is a Ruby gem that provides functionality to parse and handle HTTP Retry-After headers, which indicate how long a client should wait before making a follow-up request.
  DESC
  spec.homepage      = "https://github.com/kudoas/http-retry-after"
  spec.license       = "MIT"

  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.required_ruby_version = ">= 3.1"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0")
  end
  spec.executables = Dir.exist?("bin") ? Dir.children("bin").reject { |f| f == "setup" } : []
  spec.require_paths = ["lib"]
end
