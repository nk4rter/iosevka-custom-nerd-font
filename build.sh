#!/bin/sh

# Node.js >=22.12.0

set -e
cd "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"

cp private-build-plans.toml Iosevka/
(cd Iosevka && npm install && npm run build -- ttf::IosevkaCustom)

for f in Iosevka/dist/IosevkaCustom/TTF/*; do
  python3 nerd-fonts/font-patcher $f --complete --careful --outputdir out
done

echo >&2 'DONE'
