# Asset Optimization Guide

This document describes the asset optimization pipeline and best practices for the ps-cv Jekyll site.

## Current Asset Breakdown

| Directory          | Size    | Description                   |
| ------------------ | ------- | ----------------------------- |
| `assets/img/`      | 60 MB   | Images (PNG, JPEG, GIF)       |
| `assets/video/`    | 27 MB   | Video files                   |
| `assets/pdf/`      | 18 MB   | PDF documents                 |
| `assets/fonts/`    | 9.2 MB  | Font files (TTF, WOFF, WOFF2) |
| `assets/plotly/`   | 4.1 MB  | Plotly visualizations         |
| `assets/js/`       | 3.2 MB  | JavaScript files              |
| `assets/css/`      | 1.6 MB  | Stylesheets                   |
| `assets/json/`     | 1.4 MB  | JSON data files               |
| `assets/audio/`    | 1.3 MB  | Audio samples                 |
| `assets/webfonts/` | 1 MB    | Web font files                |
| **Total**          | ~126 MB |                               |

## Image Optimization

### Requirements

1. **Maximum dimensions**: 2000px on longest side for general images
2. **Profile photos**: 800x800px maximum
3. **Thumbnails**: 400px width
4. **Format preference**: WebP with JPEG/PNG fallback

### Recommended Tools

```bash
# Convert PNG to WebP (lossy, 80% quality)
cwebp -q 80 input.png -o output.webp

# Optimize JPEG with mozjpeg
cjpeg -quality 85 input.jpg > output.jpg

# Batch resize with ImageMagick
mogrify -resize "2000x2000>" -quality 85 *.jpg
```

### Lazy Loading

Add `loading="lazy"` to images below the fold:

```html
<img src="image.jpg" loading="lazy" alt="Description" />
```

In Liquid templates:

```liquid
{% include figure.liquid path="assets/img/photo.jpg" loading="lazy" %}
```

## Video Compression

### Requirements

1. **Format**: MP4 (H.264) for compatibility
2. **Resolution**: 1080p maximum, 720p preferred
3. **Bitrate**: 2-4 Mbps for 1080p content

### Compression with FFmpeg

```bash
# Compress video to 720p, 2Mbps
ffmpeg -i input.mp4 -vf scale=-1:720 -b:v 2M -c:a aac output.mp4

# Create poster image
ffmpeg -i input.mp4 -vframes 1 -q:v 2 poster.jpg
```

## Font Optimization

### Current State

- 13 font files across TTF, WOFF, and WOFF2 formats
- Total size: ~10 MB (fonts + webfonts)

### Subsetting Strategy

For custom fonts, create subsets with only needed characters:

```bash
# Install pyftsubset
pip install fonttools

# Subset to Latin characters only
pyftsubset font.ttf \
  --unicodes="U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD" \
  --output-file=font-subset.woff2 \
  --flavor=woff2
```

### Font Display

Always use `font-display: swap` in @font-face rules:

```css
@font-face {
  font-family: "CustomFont";
  src: url("font.woff2") format("woff2");
  font-display: swap;
}
```

## CSS Optimization

### PurgeCSS Integration

CSS purging is configured in `purgecss.config.js` and runs via npm:

```bash
# Run after Jekyll build
npm run purgecss

# Or use combined build command
npm run build:css
```

### Safelist

Dynamic classes that shouldn't be purged are safelisted:

- Bootstrap grid/modal/tooltip classes
- Theme classes (`dark`, `light`, `theme-*`)
- MathJax classes
- Syntax highlighting classes

## PDF Optimization

### Requirements

1. **Compression**: Use PDF optimization tools
2. **Web-optimized**: Enable linearization for fast web display

```bash
# Compress with Ghostscript
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH \
   -sOutputFile=output.pdf input.pdf
```

## Build Pipeline

### Production Build

```bash
# Full optimized build
bundle exec jekyll build
npm run purgecss
```

### Development

```bash
# Skip optimization for faster rebuilds
bundle exec jekyll serve
```

## Performance Targets

| Metric                   | Target                   |
| ------------------------ | ------------------------ |
| First Contentful Paint   | < 1.5s                   |
| Largest Contentful Paint | < 2.5s                   |
| Total page weight        | < 1 MB (excluding media) |
| Image format             | WebP preferred           |
| Font files loaded        | < 200 KB                 |

## Future Improvements

1. **Automated WebP conversion**: Add build-time image conversion
2. **Responsive images**: Generate srcset variants
3. **Font subsetting**: Implement automated font subsetting in CI
4. **Image CDN**: Consider using a CDN for large media files
