# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-10-04

### Added
- Initial release of HttpRetryAfter gem
- Support for parsing numeric delay format (e.g., "120")
- Support for parsing HTTP date format (e.g., "Wed, 21 Oct 2015 07:28:00 GMT") 
- Returns remaining seconds as integer
- Handles edge cases (nil, empty string, past dates)
- Proper error handling with InvalidHeaderError for invalid formats
- Comprehensive test suite with RSpec
- Complete documentation and usage examples