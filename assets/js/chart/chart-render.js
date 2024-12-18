function render(selector) {
  const svg = d3.select(selector).attr("width", 600).attr("height", 400);

  svg.append("circle").attr("cx", 300).attr("cy", 200).attr("r", 100).style("fill", "steelblue");
}
