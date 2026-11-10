# Agent rules

## Gallery photos need thumbnails

The photo gallery (`<section class="gallery">` in `index.html`) shows 900x900 JPEG thumbnails (displayed at 450px tall, so they stay sharp on high-density screens) that link to the full-size image.

Whenever a photo is added to the gallery:

1. Put the full-size image in `images/`.
2. Run `scripts/make-thumbnails.sh images/<name>.<ext>`. This writes a centre-cropped 900x900 JPEG to `images/thumbnails/<name>.jpg` (uses `ffmpeg`).
3. In the gallery, link to the full image and use the thumbnail as the `<img>`:

   ```html
   <a href="./images/<name>.jpg"
     ><img loading="lazy" src="./images/thumbnails/<name>.jpg" alt="..." class="preview fill"
   /></a>
   ```

4. Any `<link rel="prefetch">` for a gallery photo must point at the thumbnail, not the full image.

Thumbnails are committed to the repo. If a full-size image is replaced, regenerate its thumbnail.
