# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "http-retry-after"
  spec.version = "0.1.0"
  spec.authors = ["kudoas"]
  spec.email = ["your-email@example.com"]

  spec.summary = "Parse HTTP Retry-After header and convert to remaining seconds"
  spec.description = "A simple gem to parse HTTP Retry-After headers and convert them to remaining seconds, supporting both numeric delay and HTTP date formats"
  spec.homepage = "https://github.com/kudoas/http-retry-after"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kudoas/http-retry-after"
  spec.metadata["changelog_uri"] = "https://github.com/kudoas/http-retry-after/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Development dependencies
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake", "~> 13.0"
end