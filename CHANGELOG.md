# Changelog

All notable changes to this project will be documented in this file.

## [0.2.0](https://github.com/kudoas/http-retry-after/compare/http-retry-after-v0.1.1...http-retry-after/v0.2.0) (2026-01-03)


### Features

* add lib ([42b8a48](https://github.com/kudoas/http-retry-after/commit/42b8a487f8e98a50b80808f5db27d5ad4afcab00))
* update CI Ruby version matrix and modify CHANGELOG formatting ([#15](https://github.com/kudoas/http-retry-after/issues/15)) ([3b3b05c](https://github.com/kudoas/http-retry-after/commit/3b3b05c36e0e1073171bd40dde2d7a730f32d790))
* update required Ruby version to 3.1 in gemspec ([#17](https://github.com/kudoas/http-retry-after/issues/17)) ([f85b32c](https://github.com/kudoas/http-retry-after/commit/f85b32ce7f9192e736362db2cc66f30f636d3736))


### Bug Fixes

* improve error handling in parse_seconds and parse_http_date methods ([#4](https://github.com/kudoas/http-retry-after/issues/4)) ([558c11b](https://github.com/kudoas/http-retry-after/commit/558c11b81f04bb9184bd1678b4c20d819c05d6e7))

## [0.1.1](https://github.com/kudoas/http-retry-after/compare/v0.1.0...v0.1.1) (2026-01-02)

### Bug Fixes

- improve error handling in parse_seconds and parse_http_date methods ([#4](https://github.com/kudoas/http-retry-after/issues/4)) ([558c11b](https://github.com/kudoas/http-retry-after/commit/558c11b81f04bb9184bd1678b4c20d819c05d6e7))

## 0.1.0

### Added

- Initial release of `HTTP::RetryAfter.parse` with delta-seconds and HTTP-date parsing.
- `HTTP::RetryAfter.parse_seconds` helper that rejects negative values.
- `HTTP::RetryAfter.parse_http_date` helper backed by `Time.httpdate`.
- `HTTP::RetryAfter::NegativeRetryAfterError` and `HTTP::RetryAfter::InvalidFormatError` for error handling.
