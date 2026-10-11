<div align="center">
  <img alt="logo" src="./docs/images/logo.png" height="250px">

  <h1>pulse-action</h1>

  <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/rootlyhq/pulse-action">
  <br>
  <img alt="ci" src="https://github.com/rootlyhq/pulse-action/actions/workflows/ci.yml/badge.svg" />
  <br />
  <br />
  <i>A GitHub Action for sending a Rootly pulse</i>
</div>

<hr />

Powered by [rootly-cli](https://github.com/rootlyhq/rootly-cli). Runs as a composite action on Linux, macOS, and Windows runners (x64 and arm64; Windows x64 only). The CLI binary is downloaded from GitHub releases and verified against its published SHA-256 checksum.

## Inputs

| **Input Name** | **Description**                                                                                                          | **Required** |
| -------------- | ------------------------------------------------------------------------------------------------------------------------ | ------------ |
| summary        | Summary of the pulse                                                                                                     | Yes          |
| api_key        | Rootly API key                                                                                                           | Yes          |
| services       | Services associated with the pulse. Separate with commas.                                                                | No           |
| environments   | Environments associated with the pulse. Separate with commas.                                                            | No           |
| labels         | Labels associated with the pulse. Separate with commas and separate key-value pair with = (no spaces before or after =). | No           |
| source         | Source of the pulse                                                                                                      | No           |
| refs           | Refs associated with the pulse. Separate with commas and separate key-value pair with = (no spaces before or after =).   | No           |
| api_host       | Rootly API host. Defaults to `api.rootly.com`.                                                                           | No           |
| version        | rootly-cli version to install (e.g. `0.6.0`), or `latest`. Defaults to the version pinned by this release of the action. | No           |

## Outputs

| **Output Name** | **Description**                |
| --------------- | ------------------------------ |
| pulse_id        | ID of the created pulse        |
| cli_version     | Installed rootly-cli version   |

## Example

```yaml
name: Deploy Website

on: push

jobs:
  pulse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v7
      - run: make deploy
      - name: rootly-pulse
        uses: rootlyhq/pulse-action@v3
        with:
          api_key: ${{ secrets.ROOTLY_API_KEY }}
          summary: Deploy Website
          environments: production # Not required
          services: elasticsearch-prod # Not required
          labels: platform=ubuntu,version=2 # Not required
          source: k8s # Not required
          refs: sha=${{ github.sha }} # Not required
```

For stricter supply-chain guarantees, pin the action to a full commit SHA instead of `@v3`.

## Upgrading from v2

v3 replaces the Docker container with a composite action. Inputs are unchanged, so most workflows only need to bump `@v2` (or `@master`) to `@v3`. Notable differences:

- The action now runs on macOS and Windows runners and on arm64, not just Linux x64.
- No Docker image is built per run, so the step starts in seconds.
- `rootly-cli` is pinned to a tested version instead of always pulling the latest release. Set `version: latest` to keep the old behaviour.
