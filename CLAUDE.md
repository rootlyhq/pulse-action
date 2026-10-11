# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a GitHub Action (`rootlyhq/pulse-action`) that sends pulses to Rootly. It installs `rootly-cli` from GitHub releases and invokes `rootly pulse create`.

## Architecture

- **Composite GitHub Action**: runs on Linux, macOS, and Windows runners (x64/arm64)
- **action.yml**: Defines inputs (summary, api_key, environments, services, labels, source, refs, api_host, version), outputs (pulse_id, cli_version), and the two steps below
- **scripts/install.sh**: Downloads the `rootly-cli` archive for `RUNNER_OS`/`RUNNER_ARCH`, verifies it against `checksums.txt`, and adds it to `GITHUB_PATH`
- **scripts/pulse.sh**: Maps `INPUT_*` env vars to `rootly pulse create` flags and writes `pulse_id` to `GITHUB_OUTPUT`
- Inputs are passed to scripts via `env:`, never interpolated with `${{ }}` inside `run:`, to avoid script injection

The default `rootly-cli` version lives in `action.yml` (`inputs.version.default`). Dependabot does not bump it; update it by hand.

## Lint & Test Commands

```bash
shellcheck scripts/*.sh
go run github.com/rhysd/actionlint/cmd/actionlint@latest
zizmor .

# Install the CLI locally the way the action does
RUNNER_OS=macOS RUNNER_ARCH=ARM64 RUNNER_TEMP=$(mktemp -d) ROOTLY_CLI_VERSION=0.6.0 bash scripts/install.sh
```

## CI Workflows

- **ci.yml**: actionlint + zizmor + shellcheck, then runs the action end to end on ubuntu (x64/arm64), macOS, and Windows against `test/stub_server.py`, and checks the request body and outputs
- **release.yml**: On release publish, moves the major tag (e.g. `v3`) to the release commit

All third-party actions are pinned to full commit SHAs.
