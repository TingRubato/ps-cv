function renderBarchart(selector) {
  const svg = d3
    .select(selector)
    .select("svg")
    .classed("d3-chart-svg", true) // Apply class to SVG
    .attr("width", 400) // Ensure numeric values
    .attr("height", 400);

  const data = [10, 20, 30, 40, 50];

  svg
    .selectAll("rect")
    .data(data)
    .enter()
    .append("rect")
    .attr("x", (d, i) => i * 100 + 10)
    .attr("y", (d) => 400 - d * 8)
    .attr("width", 80)
    .attr("height", (d) => d * 8)
    .attr("fill", "steelblue");
}
