#!/bin/sh

set -e
cd "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"

NODE_REQUIREMENT=">=22.12.0"

if ! command -v node >/dev/null 2>&1; then
  echo >&2 "ERROR: 'node' not found; Iosevka needs Node.js $NODE_REQUIREMENT"
  exit 1
fi

NODE_VERSION=$(node --version)
NODE_MAJOR=$(echo "$NODE_VERSION" | sed -e 's/^v//' -e 's/[^0-9].*//')
NODE_MINOR=$(echo "$NODE_VERSION" | sed -e 's/^v[0-9]*\.//' -e 's/[^0-9].*//')

NODE_OK=""
if [ "$NODE_MAJOR" -ge 23 ]; then
  NODE_OK=1
elif [ "$NODE_MAJOR" -eq 22 ] && [ "$NODE_MINOR" -ge 12 ]; then
  NODE_OK=1
fi

if [ -z "$NODE_OK" ]; then
  echo >&2 "ERROR: 'node' $NODE_VERSION is too old; Iosevka needs Node.js $NODE_REQUIREMENT"
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo >&2 "ERROR: 'npm' not found"
  exit 1
fi

cp private-build-plans.toml Iosevka/
(cd Iosevka && npm install && npm run build -- ttf::IosevkaCustom)

for style in Regular Italic Bold BoldItalic; do
  python3 nerd-fonts/font-patcher \
    "Iosevka/dist/IosevkaCustom/TTF/IosevkaCustom-$style.ttf" \
    --complete --careful --outputdir out
done

echo >&2 'DONE'
