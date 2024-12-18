function renderSunburstChart(selector) {
  const width = 900;
  const radius = width / 6;

  const color = d3.scaleOrdinal(d3.quantize(d3.interpolateRainbow, 10));

  fetch("/ps-cv/assets/json/niw.json")
    .then((response) => response.json())
    .then((data) => {
      const hierarchy = d3
        .hierarchy(data)
        .sum((d) => d.value || 0)
        .sort((a, b) => b.value - a.value);

      const root = d3.partition().size([2 * Math.PI, hierarchy.height + 1])(hierarchy);
      root.each((d) => (d.current = d));

      // Initialize zoom scale and rotation angle
      let zoomScale = 1;
      let rotationAngle = 0;

      // Arc generator adjusted for dynamic radius based on zoom scale
      const arcGenerator = d3
        .arc()
        .startAngle((d) => d.x0 + rotationAngle)
        .endAngle((d) => d.x1 + rotationAngle)
        .padAngle((d) => Math.min((d.x1 - d.x0) / 2, 0.005))
        .padRadius(radius * 1.5)
        .innerRadius((d) => d.y0 * radius * zoomScale)
        .outerRadius((d) => Math.max(d.y0 * radius * zoomScale, d.y1 * radius * zoomScale - 1));

      const svg = d3
        .select(selector)
        .append("svg")
        .attr("width", "100%")
        .attr("height", "100%")
        .attr("viewBox", [-width / 2, -width / 2, width, width])
        .style("font", "10px sans-serif");

      const g = svg.append("g");

      const path = g
        .append("g")
        .selectAll("path")
        .data(root.descendants().slice(1))
        .join("path")
        .attr("fill", (d) => {
          while (d.depth > 1) d = d.parent;
          return color(d.data.name);
        })
        .attr("fill-opacity", 0.6)
        .attr("d", (d) => arcGenerator(d.current))
        .on("click", clicked);

      path.append("title").text(
        (d) =>
          `${d
            .ancestors()
            .map((d) => d.data.name)
            .reverse()
            .join("/")}\n${d.value}`
      );

      const label = g
        .append("g")
        .attr("pointer-events", "none")
        .attr("text-anchor", "middle")
        .style("user-select", "none")
        .selectAll("text")
        .data(root.descendants().slice(1))
        .join("text")
        .attr("dy", "0.35em")
        .style("font-size", "9px")
        .style("fill", "#000")
        .attr("transform", (d) => labelTransform(d.current))
        .text((d) => d.data.name);

      const center = g
        .append("circle")
        .datum(root)
        .attr("r", radius / 2.5)
        .attr("fill", "white")
        .style("cursor", "pointer")
        .on("click", () => clicked(null, root));

      center.append("title").text("Click to return to the top layer");

      function clicked(event, p) {
        root.each((d) => {
          d.target = {
            x0: Math.max(0, Math.min(1, (d.x0 - p.x0) / (p.x1 - p.x0))) * 2 * Math.PI,
            x1: Math.max(0, Math.min(1, (d.x1 - p.x0) / (p.x1 - p.x0))) * 2 * Math.PI,
            y0: Math.max(0, d.y0 - p.depth),
            y1: Math.max(0, d.y1 - p.depth),
          };
        });

        const t = g.transition().duration(750);

        path
          .transition(t)
          .tween("data", (d) => {
            const i = d3.interpolate(d.current, d.target);
            return (t) => (d.current = i(t));
          })
          .attrTween("d", (d) => () => arcGenerator(d.current));

        label
          .transition(t)
          .attr("transform", (d) => labelTransform(d.current))
          .attr("fill-opacity", (d) => +labelVisible(d.target));
      }

      function labelVisible(d) {
        return d.y1 <= 3 && d.y0 >= 1 && (d.y1 - d.y0) * (d.x1 - d.x0) > 0.03;
      }

      function labelTransform(d) {
        const x = ((d.x0 + d.x1) / 2 + rotationAngle) * (180 / Math.PI);
        const y = ((d.y0 + d.y1) / 2) * radius * zoomScale;
        return `rotate(${x - 90}) translate(${y},0) rotate(${x < 180 ? 0 : 180})`;
      }

      // Set up zoom behavior
      const zoom = d3
        .zoom()
        .scaleExtent([0.5, 5]) // Adjust the min and max zoom scale
        .on("zoom", (event) => {
          zoomScale = event.transform.k;
          rotationAngle = event.transform.x / 100; // Dividing by 100 for smoother rotation
          updateChart();
        });

      // Apply zoom behavior to SVG
      svg.call(zoom);

      function updateChart() {
        // Update arc generator with new zoom scale and rotation angle
        arcGenerator
          .innerRadius((d) => d.y0 * radius * zoomScale)
          .outerRadius((d) => Math.max(d.y0 * radius * zoomScale, d.y1 * radius * zoomScale - 1))
          .startAngle((d) => d.x0 + rotationAngle)
          .endAngle((d) => d.x1 + rotationAngle);

        // Update paths
        path.attr("d", (d) => arcGenerator(d.current));

        // Update labels
        label.attr("transform", (d) => labelTransform(d.current));
      }
    })
    .catch((error) => console.error("Error loading JSON data:", error));
}
