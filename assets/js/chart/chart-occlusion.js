// Skills cloud on the home page.
// Words are sized by weight (1-3), colored by category, and packed with a
// spiral placement that keeps every label inside the SVG box without overlaps.
function renderOcclusionChart(selector) {
  const width = 640;
  const height = 460;
  const pad = 6; // gap between labels and from the edges

  // Category classes are written out in full so purgecss can see them.
  const groups = [
    {
      cls: "wc-code",
      words: [
        ["Python", 3],
        ["Embedded C", 2],
        ["C#", 1],
        ["SQL", 2],
        ["MATLAB", 2],
        ["REST APIs", 2],
        ["Docker", 2],
        ["Git", 1],
        ["Shell", 1],
        ["Node.js", 1],
      ],
    },
    {
      cls: "wc-ml",
      words: [
        ["PyTorch", 3],
        ["TensorFlow", 2],
        ["scikit-learn", 2],
        ["LLMs", 2],
        ["Transformers", 1],
        ["YOLO", 1],
        ["Anomaly Detection", 2],
        ["Predictive Maintenance", 2],
        ["AWS SageMaker", 1],
      ],
    },
    {
      cls: "wc-iot",
      words: [
        ["Industrial IoT", 3],
        ["Embedded Systems", 3],
        ["Telemetry Pipelines", 2],
        ["AWS IoT", 2],
        ["Edge Computing", 1],
        ["IoT Gateways", 1],
        ["RTOS", 2],
        ["Microcontrollers", 1],
        ["I2C", 1],
        ["Altium", 1],
        ["CAD", 1],
      ],
    },
    {
      cls: "wc-signal",
      words: [
        ["Signal Processing", 3],
        ["DSP", 2],
        ["MIR", 2],
        ["Music Theory", 2],
        ["MIDI", 1],
        ["librosa", 1],
        ["music21", 1],
      ],
    },
    {
      cls: "wc-research",
      words: [
        ["Data Analysis", 2],
        ["Data Scraping", 1],
        ["LaTeX", 1],
        ["SPSS", 1],
        ["Zotero", 1],
        ["Manim", 1],
      ],
    },
    {
      cls: "wc-trait",
      words: [
        ["Curious", 1],
        ["Interdisciplinary", 1],
        ["Analytical", 1],
        ["Creative", 1],
        ["Resourceful", 1],
        ["Collaborative", 1],
        ["Adaptable", 1],
        ["Mentor", 1],
      ],
    },
  ];

  const nodes = groups.flatMap((g) => g.words.map(([text, w]) => ({ text, w, cls: g.cls })));

  // Heaviest words are placed first, so they land nearest the center.
  nodes.sort((a, b) => b.w - a.w);

  const svg = d3
    .select(selector)
    .append("svg")
    .attr("viewBox", [0, 0, width, height])
    .attr("role", "img")
    .attr("aria-label", "Skills: " + nodes.map((d) => d.text).join(", "))
    .attr("class", "skills-cloud")
    .attr("style", "width: 100%; max-width: " + width + "px; height: auto; font-family: inherit;");

  const text = svg
    .selectAll("text")
    .data(nodes)
    .join("text")
    .attr("class", (d) => d.cls)
    .attr("font-size", (d) => 11 + d.w * 4 + "px")
    .attr("font-weight", (d) => (d.w === 3 ? 600 : 400))
    .attr("text-anchor", "middle")
    .attr("dominant-baseline", "central")
    .text((d) => d.text);

  // Measure the real rendered label size for collision and bounds.
  text.each(function (d) {
    const b = this.getBBox();
    d.hw = b.width / 2 + pad / 2;
    d.hh = b.height / 2 + pad / 2;
  });

  // Spiral placement: each word takes the first spot on an outward spiral where it
  // fits inside the box without touching an already placed word. Deterministic, so
  // the cloud looks the same on every visit.
  // ponytail: O(n²) overlap scan, fine for ~50 words; use a quadtree past a few hundred.
  const placed = [];
  const hits = (d) => placed.some((p) => Math.abs(p.x - d.x) < p.hw + d.hw && Math.abs(p.y - d.y) < p.hh + d.hh);
  const inside = (d) => d.x - d.hw >= 0 && d.x + d.hw <= width && d.y - d.hh >= 0 && d.y + d.hh <= height;
  for (const d of nodes) {
    d.hidden = true;
    for (let t = 0; t < 600; t += 0.05) {
      d.x = width / 2 + 2.2 * t * Math.cos(t) * (width / height);
      d.y = height / 2 + 2.2 * t * Math.sin(t);
      if (inside(d) && !hits(d)) {
        d.hidden = false;
        placed.push(d);
        break;
      }
    }
  }

  text.attr("display", (d) => (d.hidden ? "none" : null));
  text.attr("x", (d) => d.x).attr("y", (d) => d.y);

  // Hovering a word highlights its whole category.
  text
    .on("mouseover", (event, d) => {
      svg.classed("has-hover", true);
      text.classed("is-hover", (o) => o.cls === d.cls);
    })
    .on("mouseout", () => {
      svg.classed("has-hover", false);
      text.classed("is-hover", false);
    });
}
