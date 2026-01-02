# Repository Guidelines

## Project Structure

- Core implementation: `lib/http/retry_after.rb` contains parsing logic; `lib/http/retry_after/version.rb` holds the version. `http-retry-after.gemspec` defines gem metadata and Ruby requirement (>= 3.0).
- Tests: Minitest specs in `test/**/*_test.rb`; default Rake task runs them. `test/test_helper.rb` sets load paths and requires the gem.
- Build outputs: `pkg/` is used for built gems. `CHANGELOG.md` tracks releases; `LICENSE.txt` is MIT.

## Setup and Development

- Install dependencies: `bundle install`.
- Run tests: `bundle exec rake test` (or `bundle exec rake`; default task is test).
- REPL check: `bundle exec irb -Ilib -rhttp/retry_after` to try parsing helpers interactively.
- Build gem: `gem build http-retry-after.gemspec`; keep `pkg/` clean between builds.
- Release CI Ruby version: set `release-please.yml` `ruby-version` to the stable version used in CI matrix (prefer latest stable; update when CI matrix changes).

## Coding Style and Naming

- Ruby 2-space indentation; keep `# frozen_string_literal: true` at the top of Ruby files.
- Public API: `HTTP::RetryAfter.parse`, `parse_seconds`, `parse_http_date`. Reuse `NegativeRetryAfterError` and `InvalidFormatError`; keep messages aligned with `"Invalid Retry-After value: ..."` style.
- Keep rescue blocks minimal; rely on `Integer(...)` and `Time.httpdate` behavior for parsing. Avoid new external dependencies or monkey patches.

## Testing Guidelines

- Framework: Minitest. Add cases to `*_test.rb`, using existing assertions (`assert_raises`, `assert_in_delta`) as patterns.
- Time-sensitive logic: wrap `Time.now` calculations with `assert_in_delta`; cover boundaries (negative values, nil, malformed strings).
- Run `bundle exec rake test` before PRs; add regression tests when altering time math or error handling.

## Commit and Pull Request

- Commit style mirrors current history: Conventional Commits-like prefixes (`feat|fix|chore|docs: ...`) with issue numbers `(#123)` when relevant.
- PRs: include summary, motivation, key changes, and test results as bullets. `CHANGELOG.md` is auto-updated; do not edit it manually.
- Keep one concern per PR, ensure Rake tests pass, and attach repro steps or screenshots only when helpful.

## Security and Maintenance

- Do not commit secrets. Treat header values as untrusted input; preserve validation and consistent exceptions.
- Renovate (`renovate.json`) updates dependencies; confirm tests/CI before merging. If Ruby version requirements change, update the gemspec and README together.
