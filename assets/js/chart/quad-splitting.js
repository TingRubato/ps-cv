/**
 * Quad-Splitting Visualization
 *
 * Author: You
 * Date:   2023-xx-xx
 *
 * Description:
 * This file implements the "quad-splitting" animation you developed
 * in Observable, adapted for direct use in a Jekyll site.
 *
 * Usage in an HTML (or Liquid) page:
 * ---------------------------------------------------
 * <canvas id="quadCanvas" width="1024" height="1024" style="max-width:100%;"></canvas>
 * <script type="module">
 * import { initQuadSplitting } from "{{ '/assets/js/chart/quad-splitting.js' | relative_url }}";
 *
 * // Kick off the animation
 * initQuadSplitting("{{ '/assets/img/photo.png' | relative_url }}", "quadCanvas");
 * </script>
 * ---------------------------------------------------
 */

// --- 1) External library imports via ES modules (CDN) ---
import { easeCubicInOut } from "https://cdn.jsdelivr.net/npm/d3-ease@3.0.1/+esm";
import * as d3interpolate from "https://cdn.jsdelivr.net/npm/d3-interpolate@3.0.1/+esm";
import tinyqueue from "https://cdn.jsdelivr.net/npm/tinyqueue@3.0.0/+esm";

// --- 2) Helper functions ---

// Weighted average
function weightedAverage(histogram) {
  let total = 0;
  let value = 0;
  for (let i = 0; i < 256; ++i) {
    total += histogram[i];
    value += histogram[i] * i;
  }
  value /= total || 1;
  let error = 0;
  for (let i = 0; i < 256; ++i) {
    error += (value - i) ** 2 * histogram[i];
  }
  return [value, Math.sqrt(error / (total || 1))];
}

// Color from histogram
function colorFromHistogram(histogram) {
  const [r, re] = weightedAverage(histogram.subarray(0, 256));
  const [g, ge] = weightedAverage(histogram.subarray(256, 512));
  const [b, be] = weightedAverage(histogram.subarray(512, 768));
  return [
    Math.round(r),
    Math.round(g),
    Math.round(b),
    re * 0.2989 + ge * 0.587 + be * 0.114, // Weighted error
  ];
}

/**
 * Creates a histogram for a sub-region of the image.
 * @param {CanvasRenderingContext2D} ctx - 2D context with the full image drawn.
 * @param {number} x      - left coordinate
 * @param {number} y      - top coordinate
 * @param {number} w      - width
 * @param {number} h      - height
 * @returns {Uint32Array} - histogram (RGBA 4x256)
 */
function computeHistogram(ctx, x, y, w, h) {
  const { data } = ctx.getImageData(x, y, w, h);
  const histogram = new Uint32Array(1024); // 4 channels * 256
  for (let i = 0, n = data.length; i < n; i += 4) {
    ++histogram[0 * 256 + data[i + 0]];
    ++histogram[1 * 256 + data[i + 1]];
    ++histogram[2 * 256 + data[i + 2]];
    ++histogram[3 * 256 + data[i + 3]];
  }
  return histogram;
}

/**
 * Loads an image (returns a Promise).
 * @param {string} src - URL of the image
 * @returns {Promise<HTMLImageElement>}
 */
function loadImage(src) {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.crossOrigin = "anonymous"; // Include this if loading from another domain
    img.onload = () => resolve(img);
    img.onerror = () => {
      reject(new Error(`Failed to load image at ${src}`));
    };
    img.src = src;
  });
}

// --- 3) Quad class ---
class Quad {
  constructor(ctx, x, y, w, h, area_power = 0.25) {
    const [r, g, b, error] = colorFromHistogram(computeHistogram(ctx, x, y, w, h));
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    // Convert R,G,B → #rrggbb
    this.color = "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
    this.score = error * Math.pow(w * h, area_power);
  }

  split(ctx, area_power) {
    const dx = this.w / 2;
    const dy = this.h / 2;
    const x1 = this.x,
      x2 = this.x + dx;
    const y1 = this.y,
      y2 = this.y + dy;
    return [
      new Quad(ctx, x1, y1, dx, dy, area_power),
      new Quad(ctx, x2, y1, dx, dy, area_power),
      new Quad(ctx, x1, y2, dx, dy, area_power),
      new Quad(ctx, x2, y2, dx, dy, area_power),
    ];
  }
}

// --- 4) Main function to init everything ---

/**
 * Initialize the quad-splitting animation on the given canvas.
 *
 * @param {string} imageURL         - The path (URL) to the source image (e.g. "/assets/img/photo.png")
 * @param {string} [canvasId="quadCanvas"] - The ID of the <canvas> you want to draw on
 * @param {number} [areaPower=0.25] - The exponent for area weighting in the “score” calculation
 * @param {number} [canvasSize=1024]- The base size of your animation (should match <canvas> width/height)
 */
export async function initQuadSplitting(imageURL, canvasId = "quadCanvas", areaPower = 0.25, canvasSize = 1024) {
  // 1) Load the image
  const baseImage = await loadImage(imageURL);

  // 2) Create a hidden canvas for pixel/histogram computations
  const hiddenCanvas = document.createElement("canvas");
  hiddenCanvas.width = canvasSize;
  hiddenCanvas.height = canvasSize;
  const hiddenCtx = hiddenCanvas.getContext("2d");

  // Draw the base image so we can read its pixels
  hiddenCtx.drawImage(baseImage, 0, 0, canvasSize, canvasSize);

  // 3) Get the visible canvas from the DOM
  const mainCanvas = document.getElementById(canvasId);
  if (!mainCanvas) {
    console.error(`Canvas with id="${canvasId}" not found in DOM.`);
    return;
  }
  const mainCtx = mainCanvas.getContext("2d");

  // Optionally draw the original image first (so user sees it instantly)
  mainCtx.drawImage(baseImage, 0, 0, canvasSize, canvasSize);

  // 4) The main quad-splitting logic
  const quads = new tinyqueue([new Quad(hiddenCtx, 0, 0, canvasSize, canvasSize, areaPower)], (a, b) => b.score - a.score);

  // We'll run an animation loop that "splits" the largest quad if score >= threshold
  const threshold = 50;

  // Repeatedly pop the biggest quad, split it, animate the transition
  while (true) {
    const q = quads.pop();
    if (!q || q.score < threshold) break;

    const newQuads = q.split(hiddenCtx, areaPower);

    // For the fancy animation from Observable: we interpolate from 4 identical quads (the old one)
    // to 4 new quads. Then we draw partial frames.
    const qsi = d3interpolate.interpolate([q, q, q, q], newQuads);

    // Push new quads into the queue
    for (const nq of newQuads) {
      quads.push(nq);
    }

    // The number of frames in the transition.
    // If you want a smoother or faster anim, tweak below (currently ~ one step per 10 px).
    const steps = Math.max(1, Math.floor(q.w / 10));
    for (let j = 1; j <= steps; j++) {
      const t = easeCubicInOut(j / steps);

      // Clear just the region we're animating
      mainCtx.clearRect(q.x, q.y, q.w, q.h);

      // For each sub-quad in the interpolation
      for (const s of qsi(t)) {
        mainCtx.fillStyle = s.color;
        mainCtx.beginPath();
        mainCtx.moveTo(s.x + s.w, s.y + s.h / 2);
        mainCtx.arc(s.x + s.w / 2, s.y + s.h / 2, s.w / 2, 0, 2 * Math.PI);
        mainCtx.fill();
      }

      // Small delay so we can see the animation in real-time
      await new Promise((r) => setTimeout(r, 10));
    }
  }
}
