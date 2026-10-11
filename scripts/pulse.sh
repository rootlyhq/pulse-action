#!/usr/bin/env bash
# Send a pulse with rootly-cli. Inputs arrive as INPUT_* env vars so that
# user-supplied values are never interpolated into shell source.
set -euo pipefail

if [ -z "${INPUT_API_KEY:-}" ]; then
  echo "::error::api_key input is required" >&2
  exit 1
fi

if [ -z "${INPUT_SUMMARY:-}" ]; then
  echo "::error::summary input is required" >&2
  exit 1
fi

export ROOTLY_API_KEY="${INPUT_API_KEY}"

if [ -n "${INPUT_API_HOST:-}" ]; then
  export ROOTLY_API_HOST="${INPUT_API_HOST}"
fi

args=(pulse create)

if [ -n "${INPUT_ENVIRONMENTS:-}" ]; then
  args+=(--environments="${INPUT_ENVIRONMENTS}")
fi

if [ -n "${INPUT_SERVICES:-}" ]; then
  args+=(--services="${INPUT_SERVICES}")
fi

if [ -n "${INPUT_LABELS:-}" ]; then
  args+=(--labels="${INPUT_LABELS}")
fi

if [ -n "${INPUT_SOURCE:-}" ]; then
  args+=(--source="${INPUT_SOURCE}")
fi

if [ -n "${INPUT_REFS:-}" ]; then
  args+=(--refs="${INPUT_REFS}")
fi

output="$(rootly "${args[@]}" --summary="${INPUT_SUMMARY}" --format=json)"
echo "${output}"

if [ -n "${GITHUB_OUTPUT:-}" ] && command -v jq >/dev/null 2>&1; then
  echo "pulse_id=$(jq -r '.data.id // empty' <<<"${output}")" >> "${GITHUB_OUTPUT}"
fi
