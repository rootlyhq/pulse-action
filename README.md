<div align="center">
  <img alt="logo" src="./docs/images/logo.png" height="250px">

  <h1>pulse-action</h1>

  <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/rootlyhq/pulse-action">
  <br>
  <img alt="build" src="https://github.com/rootlyhq/pulse-action/workflows/build/badge.svg" />
  <img alt="lint" src="https://github.com/rootlyhq/pulse-action/workflows/lint/badge.svg" />
  <br />
  <br />
  <i>A GitHub Action for sending a Rootly pulse</i>
</div>

<hr />

Powered by [rootly-cli](https://github.com/rootlyhq/rootly-cli).

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

## Example

```yaml
name: Deploy Website

on: push

jobs:
  pulse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      - run: make deploy
      - name: rootly-pulse
        uses: rootlyhq/pulse-action@master
        with:
          api_key: ${{ secrets.ROOTLY_API_KEY }}
          summary: Deploy Website
          environments: production # Not required
          services: elasticsearch-prod # Not required
          labels: platform=ubuntu,version=2 # Not required
          source: k8s # Not required
          refs: sha=${{ github.sha }} # Not required
```
