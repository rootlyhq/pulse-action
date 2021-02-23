<div align="center">
  <img alt="logo" src="./docs/images/logo.png" height="250px">

  <h1>pulse-action</h1>

  <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/rootly-io/pulse-action">
  <br>
  <img alt="build" src="https://github.com/rootly-io/pulse-action/workflows/build/badge.svg" />
  <img alt="lint" src="https://github.com/rootly-io/pulse-action/workflows/lint/badge.svg" />
  <br />
  <br />
  <i>A GitHub action for sending a rootly pulse</i>
</div>

<hr />

## 🔢 Inputs

| **Input Name** | **Description**                                                                                                          | **Required** |
| -------------- | ------------------------------------------------------------------------------------------------------------------------ | ------------ |
| summary        | Summary of the pulse                                                                                                     | Yes          |
| api_key        | A api key for rootly                                                                                                     | Yes          |
| services       | Services associated with the pulse. Separate with commas.                                                                | No           |
| environments   | Environments associated with the pulse. Separate with commas.                                                            | No           |
| labels         | Labels associated with the pulse. Separate with commas and separate key-value pair with = (no spaces before or after =). | No           |

## ⚙️ Example

```yaml
name: Deploy Website

on: push

jobs:
  pulse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: make deploy
      - name: rootly-pulse
        uses: rootly-io/pulse-action@main
        with:
          api_key: ${{ secrets.ROOTLY_API_KEY }}
          summary: Deploy Website
          environments: production
          services: elasticsearch-prod
          labels: platform=osx,version=2
```
