#!/bin/sh
# Usage: scripts/make-thumbnails.sh images/foo.jpg [images/bar.png ...]
# Creates 900x900 centre-cropped JPEG thumbnails in images/thumbnails/. Needs ffmpeg.
set -eu

SIZE=900
OUT_DIR="$(dirname "$0")/../images/thumbnails"
mkdir -p "$OUT_DIR"

for src in "$@"; do
  name="$(basename "${src%.*}")"
  out="$OUT_DIR/$name.jpg"

  # Lanczos-scale so the shorter side is $SIZE, crop the centre, then lightly
  # sharpen to offset the softness from downscaling.
  ffmpeg -v error -y -i "$src" \
    -vf "scale=$SIZE:$SIZE:force_original_aspect_ratio=increase:flags=lanczos+accurate_rnd,crop=$SIZE:$SIZE,unsharp=5:5:0.6:5:5:0" \
    -q:v 3 -frames:v 1 -update 1 "$out"
  echo "$out"
done
