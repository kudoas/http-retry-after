# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

- No changes yet.

## [0.1.0]

### Added

- Initial release of `HTTP::RetryAfter.parse` with delta-seconds and HTTP-date parsing.
- `HTTP::RetryAfter.parse_seconds` helper that rejects negative values.
- `HTTP::RetryAfter.parse_http_date` helper backed by `Time.httpdate`.
- `HTTP::RetryAfter::NegativeRetryAfterError` and `HTTP::RetryAfter::InvalidFormatError` for error handling.
