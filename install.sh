#!/bin/sh

set -e
cd "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"

FONT_DIR="${1:-${XDG_DATA_HOME:-$HOME/.local/share}/fonts}/IosevkaCustomNerdFont"

if [ ! -d out ]; then
  echo >&2 "ERROR: 'out' not found; run ./build.sh first"
  exit 1
fi

rm -rf "$FONT_DIR"
mkdir -p "$FONT_DIR"

echo >&2 "INFO: Installing to $FONT_DIR"
cp out/* "$FONT_DIR/"

if command -v fc-cache >/dev/null 2>&1; then
  echo >&2 "INFO: Updating font cache"
  fc-cache -f "$FONT_DIR"
fi

echo >&2 "DONE"
