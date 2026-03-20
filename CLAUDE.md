# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Ting Xu's personal academic website built with the **al-folio** Jekyll theme. Static site with portfolio projects, publications, blog posts, and a custom music collection.

- **Live URL:** https://tingrubato.github.io/ps-cv
- **Theme:** [al-folio](https://github.com/alshedivat/al-folio)
- **Core Stack:** Jekyll 4.3 (Ruby), Liquid templates, SCSS

## Development Commands

### With Nix (Recommended)

```bash
nix develop                       # Enter dev environment (Ruby, Node, Python, ImageMagick)
bundle install && npm install     # First-time setup
bundle exec jekyll serve          # Dev server at http://localhost:4000/ps-cv/
bundle exec jekyll build          # Production build (outputs to _site/)
```

Nix sets `GEM_HOME=$PWD/.gems` — gems install locally, not system-wide. The `.gems/` directory is gitignored.

### With Docker

```bash
docker compose up  # http://localhost:8080
```

### Testing

```bash
bundle exec rake test             # Run all tests (Minitest)
bundle exec rake test_plugins     # Run plugin tests only
bundle exec ruby -Ispec spec/plugins/google_scholar_citations_spec.rb  # Single test file
```

Tests use Minitest + WebMock. Test files live in `spec/` with fixtures in `spec/fixtures/`. WebMock blocks all external HTTP in tests.

### Code Formatting

```bash
npx prettier --write .            # Format all files
npx prettier . --check            # Check without writing (CI runs this)
```

Prettier uses `@shopify/prettier-plugin-liquid` for `.liquid` files. CI will fail PRs with formatting issues.

## Architecture

### Key Configuration

- **`_config.yml`** — Master configuration. Check here first for feature flags, plugin settings, collection definitions, and `enable_*` toggles.
- **`baseurl: /ps-cv`** — All links must account for this subpath when not using Liquid helpers.

### Content Collections

| Collection | Directory | Notes |
|-----------|-----------|-------|
| Blog posts | `_posts/` | Named `YYYY-MM-DD-title.md` |
| Projects | `_projects/` | Portfolio items |
| Music | `_musics/` | Custom collection with pagination (4 per page) |
| News | `_news/` | Homepage announcements |
| Slides | `_slides/` | Presentations |
| Pages | `_pages/` | Static pages (about, cv, projects) |
| Publications | `_bibliography/papers.bib` | BibTeX → auto-generated page via jekyll-scholar |

### Data Sources

- `assets/json/resume.json` — Primary CV data (JSON Resume format)
- `_data/cv.yml` — Fallback CV data
- `_data/socials.yml` — Social links (includes `scholar_userid` used by plugins)
- `_data/repositories.yml` — GitHub repos to showcase

### Styling

- `_sass/_themes.scss` — Theme colors (`--global-theme-color`)
- `_sass/_variables.scss` — CSS variables
- `_sass/_design-system.scss`, `_sass/_components.scss`, `_sass/_glow.scss`, `_sass/_animations.scss` — Custom style extensions

### Custom Plugins (`_plugins/`)

- `google-scholar-citations.rb` — Fetches citation counts (uses HTTParty, caches results)
- `inspirehep-citations.rb` — InspireHEP citation integration
- `external-posts.rb` — Pulls posts from external RSS feeds (uses Feedjira)
- `hide-custom-bibtex.rb` — Filters internal BibTeX fields from display
- `download-3rd-party.rb` — Downloads third-party library assets

**Plugin rules enforced by CI:** No `rescue Exception` (use `StandardError`), no `puts` (use `Jekyll.logger`).

### Layout Chain

`_layouts/default.liquid` is the base layout. Other layouts (`post`, `bib`, `distill`, `musics`) extend it. Reusable partials live in `_includes/`.

## CI/CD

GitHub Actions on push/PR to `main`:

| Workflow | What it checks |
|----------|---------------|
| `deploy.yml` | Builds site, purges unused CSS, deploys to `gh-pages` branch |
| `prettier.yml` | Prettier formatting check (blocks PR on failure) |
| `quality-gates.yml` | Template line count (<300 lines), pinned gems, no deprecated patterns, runs tests |
| `broken-links.yml` | Link validation with lychee |

The deploy workflow runs `purgecss` after building — keep `purgecss.config.js` in sync if adding new CSS selectors that might be dynamically generated.
