# Project Context: Ting Xu's Academic Website (al-folio theme)

## Overview
This project is a personal academic website and CV for **Ting Xu**, built using the **al-folio** Jekyll theme. It is a static site designed to showcase a portfolio, publications, blog posts, and projects.

*   **URL:** `https://tingrubato.github.io/ps-cv`
*   **Theme:** [al-folio](https://github.com/alshedivat/al-folio)
*   **Core Technology:** Jekyll (Ruby), Liquid, Sass.

## Key Directories and Files

### Configuration & Dependencies
*   **`_config.yml`**: The master configuration file. Controls site settings, plugins, navigation, feature flags (e.g., dark mode, TOC), and analytics. **Consult this first for any global changes.**
*   **`Gemfile`**: Lists Ruby gems required for Jekyll and its plugins.
*   **`package.json`**: Minimal Node.js configuration, primarily for the `prettier` code formatter.
*   **`Dockerfile` / `docker-compose.yml`**: Configurations for containerized development.

### Content Management
*   **`_pages/`**: core static pages like `about.md`, `cv.md`, `projects.md`, `publications.md`.
*   **`_posts/`**: Blog posts (Markdown). Naming convention: `YYYY-MM-DD-title.md`.
*   **`_projects/`**: Project portfolio items.
*   **`_news/`**: Short announcements/news items.
*   **`_musics/`**: Custom collection for music-related content (specific to this user's customization).
*   **`_bibliography/papers.bib`**: BibTeX file containing publication data. This drives the auto-generated publications page.
*   **`_data/`**: YAML/JSON data files for structured content:
    *   `cv.yml`: Fallback data for the CV page.
    *   `socials.yml`: Social media links.
    *   `repositories.yml`: GitHub repositories to showcase.
*   **`assets/json/resume.json`**: Primary source for the CV page (follows JSON Resume standard).

### Layout & Design
*   **`_layouts/`**: Liquid templates for different page types (e.g., `post.liquid`, `cv.liquid`, `bib.liquid`).
*   **`_includes/`**: Reusable partials (headers, footers, specific component logic).
*   **`_sass/`**: SCSS styles. `_themes.scss` and `_variables.scss` are key for theming.

## Development Workflow

### Prerequisites
*   Ruby & Bundler
*   Node.js (optional, for Prettier)
*   Docker (optional)

### Setup & Run
1.  **Install Dependencies:**
    ```bash
    bundle install
    npm install # for prettier
    ```
2.  **Serve Locally:**
    ```bash
    bundle exec jekyll serve
    ```
    Access at `http://localhost:4000/ps-cv/`.
3.  **Code Formatting:**
    The project enforces Prettier formatting.
    ```bash
    npx prettier --write .
    ```

## Common Tasks

*   **Adding a Publication:** Edit `_bibliography/papers.bib`.
*   **Updating CV:** Edit `assets/json/resume.json` (preferred) or `_data/cv.yml`.
*   **New Blog Post:** Create a file in `_posts/` with appropriate front matter.
*   **Changing Theme Colors:** Edit `_sass/_variables.scss` or `_sass/_themes.scss`.

## Notes for the Agent
*   This site uses a `baseurl` of `/ps-cv`. Ensure links account for this if not using relative paths or Liquid helpers.
*   The `musics` collection is a custom addition; check `_config.yml` for its specific settings (e.g., pagination).
*   Always check `_config.yml` for "enabled" flags before assuming a feature (like `giscus` comments or `newsletter`) is active.
