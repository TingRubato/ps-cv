// Function to render an occlusion chart
function renderOcclusionChart(selector) {
  const width = 600;
  const height = 450;

  // Combine descriptive words and technical skills
  const words = [
    // Descriptive Words
    "Innovative",
    "Resilient",
    "Interdisciplinary",
    "Analytical",
    "Empathetic",
    "Visionary",
    "Adaptable",
    "Collaborative",
    "Passionate",
    "Mentor",
    "Curious",
    "Meticulous",
    "Communicative",
    "Human-Centered",
    "Forward-Thinking",
    "Creative",
    "Persistent",
    "Thoughtful",
    "Problem-Solving",
    "Independent",
    "Strategic",
    "Experimental",
    "Pragmatic",
    "Reflective",
    "Logical",
    "Inspirational",
    "Intuitive",
    "Open-Minded",
    "Observant",
    "Diligent",
    "Determined",
    "Ambitious",
    "Focused",
    "Grounded",
    "Versatile",
    "Original",
    "Authentic",
    "Empirical",
    "Community-Oriented",
    "Ethical",
    "Decisive",
    "Organized",
    "Self-Motivated",
    "Purpose-Driven",
    "Practical",
    "Respectful",
    "Inquisitive",
    "Balanced",
    "Polished",
    "Quick-Learning",
    "Leadership-Oriented",
    "Introspective",
    "Dependable",
    "Resourceful",
    "Self-Aware",
    "Transformative",

    // Technical Skills
    "C",
    "Python",
    "MATLAB",
    "C#",
    "SQL",
    "Shell",
    "Git",
    "Docker",
    "AWS",
    "Node.js",
    "REST API",
    "SciKit",
    "PyTorch",
    "TensorFlow",
    "LLM",
    "Transformers",
    "AWS Sagemaker",
    "Yolo",
    "Embedded Systems",
    "RTOS",
    "MCU",
    "DSPs",
    "Oscilloscope",
    "AWS IoT",
    "I2C",
    "CAD",
    "Altium",
    "MIDI",
    "Music Theory",
    "librosa",
    "music21",
    "Signal Processing",
    "MIR",
    "LaTeX",
    "Zotero",
    "Overleaf",
    "Data Analysis",
    "Data Scraping",
    "SPSS",
    "Manim",
  ];

  // Create SVG container
  const svg = d3
    .select(selector)
    .append("svg")
    .attr("width", width)
    .attr("height", height)
    .attr("viewBox", [0, 0, width, height])
    .attr("style", "max-width: 100%; height: auto; font: 14.5px sans-serif; cursor: pointer;");

  // Color palette for words
  const colorPalette = d3.scaleOrdinal(d3.schemeSet3);

  // Create nodes for each word
  const nodes = words.map((word, i) => ({
    id: i,
    text: word,
    x: Math.random() * width,
    y: Math.random() * height,
    radius: Math.random() * 10 + 20, // Adjust for size variety
  }));

  // Add text elements with colors
  const text = svg
    .selectAll("text")
    .data(nodes)
    .join("text")
    .attr("x", (d) => d.x)
    .attr("y", (d) => d.y)
    .attr("font-size", (d) => d.radius / 2 + "px")
    .attr("fill", (d) => colorPalette(d.text)) // Assign color from palette
    .attr("text-anchor", "middle")
    .text((d) => d.text)
    .attr("data-priority", 0);

  // Define a force simulation for better distribution
  const simulation = d3
    .forceSimulation(nodes)
    .force("x", d3.forceX(width / 2).strength(0.05)) // Center alignment
    .force("y", d3.forceY(height / 2).strength(0.05)) // Center alignment
    .force(
      "collide",
      d3.forceCollide((d) => d.radius)
    ) // Prevent overlap
    .on("tick", () => {
      text.attr("x", (d) => d.x).attr("y", (d) => d.y);
    });

  // Occlusion logic
  function occlusion(svg, against = "text") {
    const nodes = d3
      .sort(svg.selectAll(against), (node) => +node.getAttribute("data-priority"))
      .reverse()
      .map((node) => {
        const { x, y, width, height } = node.getBoundingClientRect();
        return { node, x, y, width, height };
      });

    const visible = [];
    for (const d of nodes) {
      const occluded = visible.some((e) => intersectRect(d, e));
      d3.select(d.node)
        .classed("occluded", occluded)
        .style("opacity", occluded ? 0.3 : 1); // Adjust opacity for occluded words
      if (!occluded) visible.push(d);
    }
  }

  // Intersection detection for rectangles
  function intersectRect(a, b) {
    return !(a.x + a.width < b.x || b.x + b.width < a.x || a.y + a.height < b.y || b.y + b.height < a.y);
  }

  // Add interactivity
  let priority = 0;
  text
    .on("mouseover", function () {
      d3.select(this).attr("fill", "red").raise();
      svg.call(occlusion);
    })
    .on("mouseout", function () {
      d3.select(this).attr("fill", (d) => colorPalette(d.text));
      svg.call(occlusion);
    })
    .on("click", function () {
      const node = d3.select(this);
      const cur = +node.attr("data-priority");
      node.attr("data-priority", cur ? null : ++priority).attr("fill", cur ? colorPalette(node.text) : "steelblue");
      svg.call(occlusion);
    });

  // Perform initial occlusion calculation
  svg.call(occlusion);
}
