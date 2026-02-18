# Changelog

## [Unreleased]

### Changed

- Migrated from `rootlyhq/cli` to `rootlyhq/rootly-cli` as the underlying CLI tool
- Dockerfile now installs `rootly-cli` from GitHub releases instead of using the deprecated `rootlyhq/cli` Docker image
- Added `entrypoint.sh` to map GitHub Action inputs to `rootly-cli` flags
- Command invocation changed from `rootly pulse <summary>` to `rootly pulse create <summary>`
- Environment variable renamed from `ROOTLY_API_TOKEN` to `ROOTLY_API_KEY`

## [1.2.0] - 2024-10-21

### Changed

- Bump actions/checkout from 4 to 6

## [1.1.0] - 2023-06-01

### Changed

- Update README to use master branch
- Add Dependabot for GitHub Actions

## [1.0.0] - 2022-10-01

### Added

- Initial release
- Support for `summary`, `api_key`, `services`, `environments`, `labels`, `source`, and `refs` inputs
- Docker-based GitHub Action using Alpine Linux
- CI workflows for build and lint (hadolint)
