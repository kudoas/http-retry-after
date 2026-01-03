# Changelog

All notable changes to this project will be documented in this file.

## [0.3.0](https://github.com/kudoas/http-retry-after/compare/v0.2.0...v0.3.0) (2026-01-03)


### Features

* update http-retry-after version to 0.2.0 and bundler to 4.0.3 in Gemfile.lock ([#21](https://github.com/kudoas/http-retry-after/issues/21)) ([7898eb8](https://github.com/kudoas/http-retry-after/commit/7898eb84794bb2000a3e35e2e9c92db4f3fae74a))
* update Ruby version to v4.0 ([fcd35b8](https://github.com/kudoas/http-retry-after/commit/fcd35b8c37568dcc1c295dbbd7b07ff4509721e5))

## [0.2.0](https://github.com/kudoas/http-retry-after/compare/v0.1.1...v0.2.0) (2026-01-03)


### Features

* update CI Ruby version matrix and modify CHANGELOG formatting ([#15](https://github.com/kudoas/http-retry-after/issues/15)) ([3b3b05c](https://github.com/kudoas/http-retry-after/commit/3b3b05c36e0e1073171bd40dde2d7a730f32d790))
* update required Ruby version to 3.1 in gemspec ([#17](https://github.com/kudoas/http-retry-after/issues/17)) ([f85b32c](https://github.com/kudoas/http-retry-after/commit/f85b32ce7f9192e736362db2cc66f30f636d3736))

## [0.1.1](https://github.com/kudoas/http-retry-after/compare/v0.1.0...v0.1.1) (2026-01-02)

### Bug Fixes

- improve error handling in parse_seconds and parse_http_date methods ([#4](https://github.com/kudoas/http-retry-after/issues/4)) ([558c11b](https://github.com/kudoas/http-retry-after/commit/558c11b81f04bb9184bd1678b4c20d819c05d6e7))

## 0.1.0

### Added

- Initial release of `HTTP::RetryAfter.parse` with delta-seconds and HTTP-date parsing.
- `HTTP::RetryAfter.parse_seconds` helper that rejects negative values.
- `HTTP::RetryAfter.parse_http_date` helper backed by `Time.httpdate`.
- `HTTP::RetryAfter::NegativeRetryAfterError` and `HTTP::RetryAfter::InvalidFormatError` for error handling.
