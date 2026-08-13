#!/bin/sh

# sudo apt install -y ttfautohint fontforge python3-fontforge

set -e
cd $(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)

if [ -s "$HOME/.nvm/nvm.sh" ]; then
  . "$HOME/.nvm/nvm.sh"
  nvm use --lts >/dev/null
fi

(cd Iosevka && npm install && npm run build -- ttf::IosevkaCustom)

rm -rf patched
for style in Regular Italic Bold BoldItalic; do
  python3 nerd-fonts/font-patcher \
    "Iosevka/dist/IosevkaCustom/TTF/IosevkaCustom-$style.ttf" \
    --complete --careful --outputdir out
done
