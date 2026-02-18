#!/bin/sh
set -e

# Map GitHub Action inputs to rootly-cli flags
# GitHub Actions passes inputs as INPUT_<NAME> environment variables

if [ -z "${INPUT_API_KEY}" ]; then
  echo "Error: api_key input is required" >&2
  exit 1
fi

if [ -z "${INPUT_SUMMARY}" ]; then
  echo "Error: summary input is required" >&2
  exit 1
fi

export ROOTLY_API_KEY="${INPUT_API_KEY}"

# Build the command
CMD="rootly pulse create"

# Add optional flags
if [ -n "${INPUT_ENVIRONMENTS}" ]; then
  CMD="${CMD} --environments=\"${INPUT_ENVIRONMENTS}\""
fi

if [ -n "${INPUT_SERVICES}" ]; then
  CMD="${CMD} --services=\"${INPUT_SERVICES}\""
fi

if [ -n "${INPUT_LABELS}" ]; then
  CMD="${CMD} --labels=\"${INPUT_LABELS}\""
fi

if [ -n "${INPUT_SOURCE}" ]; then
  CMD="${CMD} --source=\"${INPUT_SOURCE}\""
fi

if [ -n "${INPUT_REFS}" ]; then
  CMD="${CMD} --refs=\"${INPUT_REFS}\""
fi

# Summary as positional argument
CMD="${CMD} \"${INPUT_SUMMARY}\""

eval ${CMD}
