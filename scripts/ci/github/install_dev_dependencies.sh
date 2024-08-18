#!/usr/bin/env bash
set -eu
python3 -m poetry install --only=dev --no-root
echo "VIRTUAL_ENV=$PWD/.venv" >> "$GITHUB_ENV"
echo "PATH=$PWD/.venv/bin:$PATH" >> "$GITHUB_ENV"
