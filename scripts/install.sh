#!/usr/bin/env bash
# Install rootly-cli for the current runner OS/arch and add it to PATH.
#
# Env:
#   ROOTLY_CLI_VERSION  Version to install, e.g. "0.6.0" or "latest" (required)
#   RUNNER_OS           Linux | macOS | Windows (set by GitHub Actions)
#   RUNNER_ARCH         X64 | ARM64 (set by GitHub Actions)
#   RUNNER_TEMP         Scratch dir (set by GitHub Actions)
#   GITHUB_PATH         PATH file (set by GitHub Actions)
set -euo pipefail

REPO="rootlyhq/rootly-cli"

version="${ROOTLY_CLI_VERSION:?ROOTLY_CLI_VERSION is required}"
version="${version#v}"

if [ "${version}" = "latest" ]; then
  # Follow the releases/latest redirect instead of the API to avoid rate limits.
  url="$(curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/${REPO}/releases/latest")"
  version="${url##*/v}"
fi

case "${RUNNER_OS:-}" in
  Linux) os="linux"; ext="tar.gz"; bin="rootly" ;;
  macOS) os="darwin"; ext="tar.gz"; bin="rootly" ;;
  Windows) os="windows"; ext="zip"; bin="rootly.exe" ;;
  *) echo "::error::Unsupported runner OS: ${RUNNER_OS:-unknown}" >&2; exit 1 ;;
esac

case "${RUNNER_ARCH:-}" in
  X64) arch="amd64" ;;
  ARM64) arch="arm64" ;;
  *) echo "::error::Unsupported runner arch: ${RUNNER_ARCH:-unknown}" >&2; exit 1 ;;
esac

if [ "${os}" = "windows" ] && [ "${arch}" = "arm64" ]; then
  echo "::error::rootly-cli does not publish windows/arm64 builds" >&2
  exit 1
fi

archive="rootly-cli_${version}_${os}_${arch}.${ext}"
base_url="https://github.com/${REPO}/releases/download/v${version}"
install_dir="${RUNNER_TEMP:?RUNNER_TEMP is required}/rootly-cli/${version}"
work_dir="$(mktemp -d)"
trap 'rm -rf "${work_dir}"' EXIT

echo "Installing rootly-cli v${version} (${os}/${arch})"
curl -fsSL --retry 3 -o "${work_dir}/${archive}" "${base_url}/${archive}"
curl -fsSL --retry 3 -o "${work_dir}/checksums.txt" "${base_url}/checksums.txt"

expected="$(awk -v f="${archive}" '$2 == f { print $1 }' "${work_dir}/checksums.txt")"
if [ -z "${expected}" ]; then
  echo "::error::No checksum found for ${archive}" >&2
  exit 1
fi
if command -v sha256sum >/dev/null 2>&1; then
  actual="$(sha256sum "${work_dir}/${archive}" | awk '{ print $1 }')"
else
  actual="$(shasum -a 256 "${work_dir}/${archive}" | awk '{ print $1 }')"
fi
if [ "${expected}" != "${actual}" ]; then
  echo "::error::Checksum mismatch for ${archive}: expected ${expected}, got ${actual}" >&2
  exit 1
fi

mkdir -p "${install_dir}"
if [ "${ext}" = "zip" ]; then
  unzip -oq "${work_dir}/${archive}" "${bin}" -d "${install_dir}"
else
  tar -xzf "${work_dir}/${archive}" -C "${install_dir}" "${bin}"
fi
chmod +x "${install_dir}/${bin}"

if [ -n "${GITHUB_PATH:-}" ]; then
  echo "${install_dir}" >> "${GITHUB_PATH}"
fi
if [ -n "${GITHUB_OUTPUT:-}" ]; then
  echo "version=${version}" >> "${GITHUB_OUTPUT}"
fi

"${install_dir}/${bin}" version
