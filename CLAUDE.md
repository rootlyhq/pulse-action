# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a GitHub Action (`rootlyhq/pulse-action`) that sends pulses to Rootly. It installs `rootly-cli` from GitHub releases and invokes `rootly pulse create`.

## Architecture

- **Docker-based GitHub Action**: Installs `rootly-cli` from `rootlyhq/rootly-cli` releases
- **action.yml**: Defines inputs (summary, api_key, environments, services, labels, source, refs)
- **Dockerfile**: Alpine-based, downloads rootly-cli binary
- **entrypoint.sh**: Maps GitHub Action `INPUT_*` env vars to rootly-cli flags

## Build & Lint Commands

```bash
# Build the Docker image locally
docker build .

# Lint the Dockerfile (uses hadolint)
# CI runs: brpaz/hadolint-action@master
```

## CI Workflows

- **build.yml**: Runs `docker build .` on every push
- **lint.yml**: Runs hadolint on the Dockerfile on every push
