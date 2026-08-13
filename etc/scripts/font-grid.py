#!/usr/bin/env python3

import sys

from fontTools.ttLib import TTFont

f = TTFont(sys.argv[1])
upm = f["head"].unitsPerEm
adv = f["hmtx"][f.getBestCmap()[ord("A")]][0]  # monospace: any glyph will do
h = f["hhea"]
lh = h.ascender - h.descender + h.lineGap

print(f"shape = {round(1000 * adv / upm)}     # {adv}/{upm} em")
print(f"leading = {round(1000 * lh / upm)}     "
      f"# hhea {h.ascender} + {-h.descender} + {h.lineGap} = {lh}/{upm} em")
