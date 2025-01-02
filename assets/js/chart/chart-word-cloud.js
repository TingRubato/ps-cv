function renderWordCloudChart(selector) {
  const width = 500,
    height = 500;

  const svg = d3
    .select(selector)
    .append("svg")
    .attr("width", width)
    .attr("height", height)
    .style("max-width", "100%")
    .style("height", "auto")
    .attr("font-family", "Impact")
    .attr("text-anchor", "middle");

  // Add a dynamic title to the SVG
  const title = svg
    .append("text")
    .attr("x", width / 2)
    .attr("y", 30)
    .attr("text-anchor", "middle")
    .attr("font-size", "18px")
    .attr("font-weight", "bold")
    .text("Word Cloud Visualization");

  const g = svg.append("g").attr("transform", `translate(${width / 2}, ${height / 2})`);

  // Fetch data
  fetch("/ps-cv/assets/json/company name cloud.csv")
    .then((res) => res.text())
    .then((csv) =>
      d3.csvParse(csv, (d) => ({
        company_name: d.company_name.replace(/\+/g, " "), // Replace '+' with spaces
        scrap_time: new Date(d.scrap_time),
      }))
    )
    .then((data) => {
      // Group data by rounded minute and count word frequencies
      const grouped = d3.group(data, (d) => d3.timeMinute(d.scrap_time));

      const processedData = Array.from(grouped, ([time, records]) => ({
        time,
        words: d3.rollup(
          records,
          (v) => v.length, // Count frequency
          (d) => d.company_name
        ),
      })).map((d) => ({
        time: d.time,
        words: Array.from(d.words, ([text, frequency]) => ({ text, frequency })),
      }));

      // Create scrubber
      const scrubber = d3
        .select(selector)
        .append("input")
        .attr("type", "range")
        .attr("min", 0)
        .attr("max", processedData.length - 1)
        .attr("value", 0);
      const scrubberLabel = d3
        .select(selector)
        .append("p")
        .attr("class", "scrubber-label")
        .style("text-align", "center") // Center the text
        .style("margin-top", "10px")
        .text(`Showing data as of ${d3.utcFormat("%Y-%m-%d %H:%M:%S")(processedData[0].time)}`);

      // Initialize automatic scrubber update
      let currentIndex = 0;
      const delay = 2000; // 2 seconds per update

      function cycleScrubber() {
        currentIndex = (currentIndex + 1) % processedData.length; // Loop through indices
        scrubber.property("value", currentIndex); // Update scrubber position
        const selectedTime = processedData[currentIndex];
        update(selectedTime.words, selectedTime.time); // Update word cloud
      }

      const intervalId = setInterval(cycleScrubber, delay);

      // Stop cycling on user interaction with scrubber
      scrubber.on("input", function () {
        clearInterval(intervalId); // Stop the interval
        currentIndex = +this.value;
        const selectedTime = processedData[currentIndex];
        if (selectedTime) {
          update(selectedTime.words, selectedTime.time);
        }
      });

      // Render initial state
      update(processedData[0].words, processedData[0].time);

      // Update function
      function update(words, time) {
        const currentFormattedTime = d3.utcFormat("%Y-%m-%d %H:%M:%S")(time);
        title.text(`As of ${currentFormattedTime}`);

        const layout = d3.layout
          .cloud()
          .size([width, height])
          .words(
            words.map((d) => ({
              text: d.text,
              size: Math.sqrt(d.frequency) * 20,
            }))
          )
          .padding(5)
          .rotate(() => (Math.random() > 0.5 ? 90 : 0))
          .font("Impact")
          .fontSize((d) => d.size)
          .on("end", (renderedWords) => {
            const text = g.selectAll("text").data(renderedWords, (d) => d.text);

            text
              .enter()
              .append("text")
              .attr("font-size", 1e-6)
              .attr("fill", () => d3.schemeCategory10[Math.floor(Math.random() * 10)])
              .attr("text-anchor", "middle")
              .text((d) => d.text)
              .merge(text)
              .transition()
              .duration(1000)
              .ease(d3.easeCubicOut)
              .attr("font-size", (d) => d.size)
              .attr("transform", (d) => `translate(${d.x}, ${d.y}) rotate(${d.rotate})`);

            text.exit().transition().duration(1000).ease(d3.easeCubicIn).attr("font-size", 1e-6).attr("opacity", 0).remove();
          });

        layout.start();
      }
    })
    .catch((error) => console.error("Error loading word cloud CSV data:", error));
}
