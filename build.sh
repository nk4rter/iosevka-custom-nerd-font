#!/bin/sh

# Node.js >=22.12.0

set -e
cd "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"

cp private-build-plans.toml Iosevka/
(cd Iosevka && npm install && npm run build -- ttf::IosevkaCustom)

for style in Regular Italic Bold BoldItalic; do
  python3 nerd-fonts/font-patcher \
    "Iosevka/dist/IosevkaCustom/TTF/IosevkaCustom-$style.ttf" \
    --complete --careful --outputdir out
done

echo >&2 'DONE'
