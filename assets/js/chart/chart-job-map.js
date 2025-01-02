function renderJobMap(selector) {
  const width = 960,
    height = 600;

  const color = d3.scaleOrdinal(d3.schemeCategory10);
  const projection = d3.geoAlbersUsa().scale(1280).translate([480, 300]);
  const geoPath = d3.geoPath(projection);

  // Create SVG container
  const svg = d3.select(selector).append("svg").attr("width", width).attr("height", height);

  // Add title
  const title = svg
    .append("text")
    .attr("x", width / 2)
    .attr("y", 40)
    .attr("text-anchor", "middle")
    .attr("font-size", 18)
    .attr("font-weight", "bold")
    .text("Job Posting Map");

  // Tooltip setup
  const tooltip = d3
    .select("body")
    .append("div")
    .style("position", "absolute")
    .style("background", "white")
    .style("border", "1px solid black")
    .style("padding", "5px")
    .style("border-radius", "3px")
    .style("pointer-events", "none")
    .style("opacity", 0);

  // Fetch data
  Promise.all([
    fetch("/ps-cv/assets/json/10m.json").then((res) => res.json()),
    fetch("/ps-cv/assets/json/formatted.csv")
      .then((res) => res.text())
      .then((csv) =>
        d3.csvParse(csv, (d) => ({
          latitude: +d["0"],
          longitude: +d["1"],
          job_keyword: d.job_keyword.replace(/\+/g, " "),
          time: d3.utcParse("%Y-%m-%d %H:%M")(`${d.Date} ${d.Time}`),
        }))
      ),
  ])
    .then(([us, data]) => {
      const cleanedData = data.filter((d) => d.time).sort((a, b) => a.time - b.time);

      // Adjust US map structure
      us.objects.lower48 = {
        type: "GeometryCollection",
        geometries: us.objects.states.geometries.filter((d) => d.id !== "02" && d.id !== "15"), // Exclude Alaska and Hawaii
      };

      svg.append("path").datum(topojson.merge(us, us.objects.lower48.geometries)).attr("fill", "#ddd").attr("d", d3.geoPath());

      svg
        .append("path")
        .datum(topojson.mesh(us, us.objects.lower48, (a, b) => a !== b))
        .attr("fill", "none")
        .attr("stroke", "white")
        .attr("stroke-linejoin", "round")
        .attr("d", d3.geoPath());

      const g = svg.append("g").attr("fill", "none").attr("stroke", "black");

      // Add data points
      const dots = g
        .selectAll("circle")
        .data(cleanedData)
        .join("circle")
        .attr("transform", (d) => {
          const coords = projection([d.longitude, d.latitude]);
          return coords ? `translate(${coords[0]}, ${coords[1]})` : null;
        })
        .attr("fill", (d) => color(d.job_keyword))
        .attr("r", 0)
        .on("mouseover", (event, d) => {
          tooltip
            .style("opacity", 1)
            .html(
              `<strong>Job Keyword:</strong> ${d.job_keyword}<br>
               <strong>Time:</strong> ${d3.utcFormat("%Y-%m-%d %H:%M")(d.time)}`
            )
            .style("left", `${event.pageX + 10}px`)
            .style("top", `${event.pageY - 20}px`);
        })
        .on("mousemove", (event) => {
          tooltip.style("left", `${event.pageX + 10}px`).style("top", `${event.pageY - 20}px`);
        })
        .on("mouseout", () => {
          tooltip.style("opacity", 0);
        });

      // Add legend
      const legend = svg.append("g").attr("transform", "translate(50, 425)");
      legend
        .selectAll("g")
        .data([...new Set(cleanedData.map((d) => d.job_keyword))])
        .join("g")
        .attr("transform", (d, i) => `translate(0, ${i * 20})`)
        .append("rect")
        .attr("width", 12)
        .attr("height", 12)
        .attr("fill", (d) => color(d));

      legend
        .selectAll("g")
        .append("text")
        .attr("x", 18)
        .attr("y", 6)
        .attr("dy", "0.35em")
        .attr("font-size", 12)
        .text((d) => d);

      let currentIndex = 0;
      const delay = 50; // 2 seconds per update

      function cycleScrubber() {
        if (currentIndex >= cleanedData.length) {
          currentIndex = 0; // Restart from the beginning
        }
        const currentTime = cleanedData[currentIndex].time;
        updateChart(currentTime);
        currentIndex++;
      }

      // Start the automatic update cycle
      setInterval(cycleScrubber, delay);

      // Initial rendering of the chart
      updateChart(cleanedData[0].time);

      //Update the chart based on the time
      function updateChart(time) {
        dots
          .filter((d) => d.time <= time)
          .transition()
          .attr("r", 3); // Show dots

        dots
          .filter((d) => d.time > time)
          .transition()
          .attr("r", 0); // Hide dots

        title.text(`Job Postings as of ${d3.utcFormat("%Y-%m-%d %H:%M")(time)}`);
      }
    })
    .catch((error) => console.error("Error loading data or rendering the map:", error));
}
