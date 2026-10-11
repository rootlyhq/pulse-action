# Changelog

## [3.0.0] - 2026-10-11

### Changed

- Converted from a Docker action to a composite action; removed `Dockerfile` and `entrypoint.sh`
- Runs on Linux, macOS, and Windows runners, on both x64 and arm64 (Windows x64 only)
- `rootly-cli` is pinned to `0.6.0` by default instead of always installing the latest release
- Downloaded `rootly-cli` archives are verified against the release `checksums.txt`
- Replaced `build` and `lint` workflows with a single `ci` workflow (actionlint, zizmor, shellcheck, end-to-end test on every runner OS against a stub API)
- Dependabot no longer tracks Docker images; cooldown raised to 7 days

### Added

- `version` input to choose the `rootly-cli` version (or `latest`)
- `api_host` input to target a non-default Rootly API host
- `pulse_id` and `cli_version` outputs
- `release` workflow that moves the major version tag (e.g. `v3`) when a release is published

## [2.0.0] - 2026-02-18

### Changed

- Migrated from `rootlyhq/cli` to `rootlyhq/rootly-cli` as the underlying CLI tool
- Dockerfile now installs `rootly-cli` from GitHub releases instead of using the deprecated `rootlyhq/cli` Docker image
- Added `entrypoint.sh` to map GitHub Action inputs to `rootly-cli` flags
- Command invocation changed from `rootly pulse <summary>` to `rootly pulse create <summary>`
- Environment variable renamed from `ROOTLY_API_TOKEN` to `ROOTLY_API_KEY`
- Base image switched to `alpine:latest`
- Resolved hadolint warnings (DL3018, DL4006)

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
