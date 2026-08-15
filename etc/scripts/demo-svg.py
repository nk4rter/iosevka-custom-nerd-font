#!/usr/bin/env python3

# Usage: demo-svg.py <font> <text> <svg>

import json, subprocess, sys

from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.transformPen import TransformPen
from fontTools.ttLib import TTFont

SIZE, PAD, FG, BG = 22, 0.6, "#e4e7ec", "#16181d"  # px per em, em, colors

font, text, dest = sys.argv[1], sys.argv[2], sys.argv[3]
out = subprocess.check_output(["hb-shape", f"--font-file={font}", f"--text-file={text}",
                               "-O", "json", "--no-glyph-names"], text=True)
lines = [json.loads(line or "[]") for line in out.splitlines()]

f = TTFont(font)
upm, h, glyphs, names = f["head"].unitsPerEm, f["hhea"], f.getGlyphSet(), f.getGlyphOrder()
lh, pad = h.ascender - h.descender + h.lineGap, round(PAD * upm)
w = 2 * pad + max(sum(g["ax"] for g in line) for line in lines)
ht = 2 * pad + lh * len(lines)

def outline(gid):
    pen = SVGPathPen(glyphs)  # font units are y-up, SVG is y-down
    glyphs[names[gid]].draw(TransformPen(pen, (1, 0, 0, -1, 0, 0)))
    return pen.getCommands()  # empty for blank glyphs

paths = {gid: outline(gid) for gid in sorted({g["g"] for line in lines for g in line})}

svg = open(dest, "w")
print(f'<svg xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Font sample"'
      f' width="{w / upm * SIZE:.0f}" height="{ht / upm * SIZE:.0f}" viewBox="0 0 {w} {ht}">',
      f'<rect width="{w}" height="{ht}" fill="{BG}"/>', "<defs>",
      *(f'<path id="g{gid}" d="{d}"/>' for gid, d in paths.items() if d),
      "</defs>", f'<g fill="{FG}">', sep="\n", file=svg)
for row, line in enumerate(lines):
    x, y = pad, pad + row * lh + h.ascender
    for g in line:
        if paths[g["g"]]:
            print(f'<use href="#g{g["g"]}" x="{x + g["dx"]}" y="{y - g["dy"]}"/>', file=svg)
        x += g["ax"]
print("</g>", "</svg>", sep="\n", file=svg)
