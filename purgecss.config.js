module.exports = {
  content: ["_site/**/*.html", "_site/**/*.js"],
  css: ["_site/assets/css/*.css"],
  output: "_site/assets/css/",
  skippedContentGlobs: ["_site/assets/**/*.html"],
  // Safelist commonly used dynamic classes
  safelist: {
    standard: [
      // Bootstrap dynamic classes
      /^col-/,
      /^row-/,
      /^modal/,
      /^tooltip/,
      /^popover/,
      /^carousel/,
      /^fade/,
      /^show/,
      /^hide/,
      /^active/,
      /^disabled/,
      // Theme classes
      /^theme-/,
      /^dark/,
      /^light/,
      // MathJax
      /^MathJax/,
      /^mjx-/,
      // Syntax highlighting
      /^highlight/,
      /^language-/,
      /^code-/,
      // Animation classes
      /^animated/,
      /^animation-/,
    ],
    deep: [/modal$/, /tooltip$/, /popover$/],
    greedy: [/^fa-/, /^fab-/, /^fas-/, /^far-/],
  },
  // Variables to keep
  variables: true,
  // Keyframes to keep
  keyframes: true,
  // Font faces to keep
  fontFace: true,
};
