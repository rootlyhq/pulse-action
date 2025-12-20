# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a GitHub Action (`rootlyhq/pulse-action`) that sends pulses to Rootly. It wraps the `rootlyhub/cli` Docker image and invokes the `rootly pulse` command.

## Architecture

- **Docker-based GitHub Action**: Uses `rootlyhub/cli:latest` as the base image
- **action.yml**: Defines inputs (summary, api_key, environments, services, labels, source, refs)
- **Dockerfile**: Minimal - just sets the CLI image and runs `rootly pulse`

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
