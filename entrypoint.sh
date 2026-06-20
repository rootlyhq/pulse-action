#!/bin/sh
set -e

if [ -z "${INPUT_API_KEY}" ]; then
  echo "Error: api_key input is required" >&2
  exit 1
fi

if [ -z "${INPUT_SUMMARY}" ]; then
  echo "Error: summary input is required" >&2
  exit 1
fi

export ROOTLY_API_KEY="${INPUT_API_KEY}"

set -- rootly pulse create

if [ -n "${INPUT_ENVIRONMENTS}" ]; then
  set -- "$@" --environments="${INPUT_ENVIRONMENTS}"
fi

if [ -n "${INPUT_SERVICES}" ]; then
  set -- "$@" --services="${INPUT_SERVICES}"
fi

if [ -n "${INPUT_LABELS}" ]; then
  set -- "$@" --labels="${INPUT_LABELS}"
fi

if [ -n "${INPUT_SOURCE}" ]; then
  set -- "$@" --source="${INPUT_SOURCE}"
fi

if [ -n "${INPUT_REFS}" ]; then
  set -- "$@" --refs="${INPUT_REFS}"
fi

exec "$@" "${INPUT_SUMMARY}"
