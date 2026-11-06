# Blog Audit Report

**Audit Date:** 2026-08-12
**Scope:** `_posts/` (9 posts)
**Total Posts:** 9
**Average Score:** 45/100

No canonical `scripts/analyze_blog.py` analyzer was bundled in this install, so per-post scores come from 9 parallel `blog-reviewer` agent runs (one per post) applying the standard 5-category 100-point rubric, seeded with site-wide facts confirmed directly against the repo (see Technical section below) so all 9 scored against the same baseline.

## Health Overview

| Metric                           | Count                   |
| -------------------------------- | ----------------------- |
| Posts Scoring 90+ (Excellent)    | 0                       |
| Posts Scoring 70-89 (Good)       | 0                       |
| Posts Scoring 50-69 (Needs Work) | 4                       |
| Posts Scoring <50 (Poor)         | 5                       |
| Orphan Pages (0 inbound)         | 6                       |
| Dead-End Pages (0 outbound)      | 8                       |
| Cannibalization Issues           | 0 (see note)            |
| Stale or Decaying Content        | 1 High, 3 Medium, 5 Low |

No post scored above 60. This is a site-wide technical/E-E-A-T floor problem, not primarily a writing-quality problem — see Sitewide Findings below.

## Sitewide Findings (apply to all 9 posts)

These account for most of the Technical and E-E-A-T point loss across every post and should be fixed once, centrally, rather than per-post:

1. **`serve_schema_org: false` and `serve_og_meta: false`** in `_config.yml` — no Schema.org JSON-LD (Article/BlogPosting/Person) and no OpenGraph/Twitter Card meta tags are emitted anywhere on the site. Zero rich-result eligibility, broken social-share previews.
2. **No `author:` frontmatter field on any post** — the post layout's byline (`_layouts/post.liquid:22`, `{% if page.author %}by {{ page.author }}{% endif %}`) never renders. No per-post author attribution despite an about page existing (`_pages/about.md`, `_pages/about_ting.md`).
3. **No `last_updated` / `dateModified` frontmatter anywhere** — no freshness signal for search engines or readers; every post reads as unmaintained since publish.
4. **Near-total absence of internal linking** (see Orphan/Dead-End section) — only 3 outbound links exist across all 9 posts, all from one file.
5. robots.txt and jekyll-sitemap are correctly configured (all crawlers including GPTBot/ClaudeBot/PerplexityBot allowed, sitemap.xml generated) — this part is fine. No `llms.txt` exists.

## Per-Post Scores

| Post                               | Score  | Content /30 | SEO /25 | E-E-A-T /15 | Technical /15 | AI Citation /15 |
| ---------------------------------- | ------ | ----------- | ------- | ----------- | ------------- | --------------- |
| 2023-12-12-suicide.md              | 16/100 | 4           | 7       | 2           | 0             | 3               |
| 2024-04-14-quiet-cool.md           | 54/100 | 24          | 13      | 3           | 3             | 11              |
| 2024-04-28-observability.md        | 42/100 | 15          | 10.5    | 5           | 3             | 8.5             |
| 2024-05-01-ezzy-job.md             | 52/100 | 22          | 11      | 3           | 5             | 11              |
| 2024-12-04-quantified-niw.md       | 44/100 | 13          | 13      | 4           | 4             | 10              |
| 2025-01-15-guided-portfolio.md     | 43/100 | 15          | 16      | 4           | 2             | 6               |
| 2025-03-06-reflection.md           | 54/100 | 21          | 12      | 7           | 4             | 10              |
| 2025-07-09-journey-back-to-self.md | 39/100 | 18          | 9       | 3           | 3             | 6               |
| 2026-03-19-adc-vmid-calibration.md | 60/100 | 26          | 18      | 3           | 1             | 12              |

## Prioritized Action Queue (Lowest Score First)

| Priority | Post                               | Score | Top Issue                                                                                                                                        | Recommended Action                                                                                                                                                                           |
| -------- | ---------------------------------- | ----- | ------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1        | 2023-12-12-suicide.md              | 16    | **P0**: No crisis-support resources on a suicide-statistics post; near-zero body content (one caption + a chart)                                 | Add a crisis-resources block (e.g. 988 Lifeline) before/after the chart; write real analysis and interpretation, not just an embed                                                           |
| 2        | 2025-07-09-journey-back-to-self.md | 39    | **P0**: Specific medication/dosage disclosures (Trintellix, 20mg) and a casual suicide-attempt reference on a professional CV site               | Strip specific medical details; re-evaluate tone/scope fit before this stays live on a job-search-facing portfolio                                                                           |
| 3        | 2024-04-28-observability.md        | 42    | **P0**: Intro promises "Plugins" and "Alerting" sections that don't exist anywhere in the body                                                   | Write the missing sections or delete the promised bullets; also fix `date: 2024-04-01` vs filename `2024-04-28` mismatch                                                                     |
| 4        | 2025-01-15-guided-portfolio.md     | 43    | **P0**: Dead link (`href="#"`) on the Manuscript 1 card; `.container-card { min-width: 700px }` breaks mobile with no media query                | Link the real DOI/PDF or remove the CTA; add a responsive breakpoint                                                                                                                         |
| 5        | 2024-12-04-quantified-niw.md       | 44    | **P0**: Fabricated scoring weights/thresholds (0.8, 0.9, ≥70/100) presented as authoritative on a YMYL immigration-law topic, with no disclaimer | Add a prominent "illustrative heuristic, not legal advice" disclaimer; cite USCIS Policy Manual / Matter of Dhanasar directly                                                                |
| 6        | 2024-05-01-ezzy-job.md             | 52    | **P0**: Meta description ships with typos ("elegent", "d3j") straight into `<meta name="description">`                                           | Rewrite: "Build an automated Python job-posting scraper with real-time alerts and D3.js visualizations."                                                                                     |
| 7        | 2024-04-14-quiet-cool.md           | 54    | **P0**: Published `fan_control_server.py` crashes on startup — uses `sys.stdout` without `import sys`                                            | Add the missing import; also fix `layout: page` → `layout: post` (currently drops date/tags/categories from render)                                                                          |
| 8        | 2025-03-06-reflection.md           | 54    | **P0**: Broken heading numbering — body jumps from unheaded intro straight to "2. The Social Psychology..." with no "1." heading                 | Add the missing `## 1.` heading or drop manual numbering; verify `label.bib`'s `display = {false}` field actually renders (unrecognized by local `template.v2.js`, needs a live build check) |
| 9        | 2026-03-19-adc-vmid-calibration.md | 60    | **P0**: Zero source citations on hardware claims (ESP32 ADC sample-and-hold behavior, ESD structures)                                            | Cite the ESP32 technical reference manual inline; also add `alt=` text (currently only `title=` is passed to `figure.liquid`)                                                                |

### Checked and cleared

`2024-04-28-observability.md` lines ~142, 164-165: the reviewing agent flagged what looked like real Tailscale hostnames/credentials in code blocks. Checked directly — `stonecat-duck.ts.net`, `you-do-not-have-permission.ts.net`, `username-for-real`, `nobody-should-know-this` are deliberately joke placeholder values, not a real leak. No action needed.

## Topic Cannibalization

No true keyword cannibalization found — all 9 posts target distinct topics/queries, so no merge/redirect action is needed. Two soft notes:

| Topic overlap               | Posts                                                                                                                       | Recommendation                                                                                                                                              |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Self-identity / labels      | `reflection.md` (research-based, analytical) vs. `journey-back-to-self.md` (autobiographical)                               | **Differentiate** — already sufficiently distinct in angle; consider cross-linking them to each other instead of treating as competing                      |
| Homelab / embedded hardware | `quiet-cool.md` (ML fan control), `observability.md` (Grafana/Prometheus monitoring), `adc-vmid-calibration.md` (ESP32 ADC) | **Differentiate** — distinct sub-topics, no title/keyword overlap. This is a cross-linking opportunity, not a cannibalization risk (see Orphan Pages below) |

## Orphan Pages (0 Inbound Links)

Only one internal link edge exists on the entire site: `guided-portfolio.md` links out to `quantified-niw.md`, `ezzy-job.md`, and `observability.md` (via hardcoded absolute URLs with identical non-descriptive anchor text "Click to read more" — should be relative links with descriptive anchors). Every other link in every other post is external or nonexistent.

| Page                               | Inbound Links | Recommended Link Sources                                                                                                         |
| ---------------------------------- | ------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| 2023-12-12-suicide.md              | 0             | guided-portfolio.md (add as a portfolio item); no other data-viz post exists to link from                                        |
| 2024-04-14-quiet-cool.md           | 0             | observability.md (shared homelab topic), adc-vmid-calibration.md (shared ESP32 topic), guided-portfolio.md                       |
| 2025-01-15-guided-portfolio.md     | 0             | \_pages/about.md / about_ting.md (site nav), and a footer link back from each post it indexes                                    |
| 2025-03-06-reflection.md           | 0             | journey-back-to-self.md (shared identity theme), guided-portfolio.md                                                             |
| 2025-07-09-journey-back-to-self.md | 0             | reflection.md (identity theme), quantified-niw.md (immigration theme), quiet-cool.md/adc-vmid-calibration.md (engineering theme) |
| 2026-03-19-adc-vmid-calibration.md | 0             | quiet-cool.md (ESP32/homelab), observability.md (homelab monitoring), guided-portfolio.md                                        |

## Dead-End Pages (0 Outbound Links)

Every post except `guided-portfolio.md` has zero outbound internal links: `suicide.md`, `quiet-cool.md`, `observability.md`, `ezzy-job.md`, `quantified-niw.md`, `reflection.md`, `journey-back-to-self.md`, `adc-vmid-calibration.md` (8 posts).

## Stale Content

No post has a `last_updated`/`dateModified` field, so "last updated" below is the original publish date — there is no record of any post ever being revisited.

| Post                               | Last Updated | Days Stale | Priority                                                                                  | Refresh Effort                                                              |
| ---------------------------------- | ------------ | ---------- | ----------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| 2023-12-12-suicide.md              | 2023-12-12   | 974        | Low (static reference chart)                                                              | Light — verify NCHS/Census source links still resolve, add crisis resources |
| 2024-04-14-quiet-cool.md           | 2024-04-14   | 850        | Medium (code rot: placeholder repo link, unverified library APIs)                         | Moderate                                                                    |
| 2024-04-28-observability.md        | 2024-04-01   | 863        | Medium (Grafana/Prometheus/Traefik syntax drift over 2+ years)                            | Moderate                                                                    |
| 2024-05-01-ezzy-job.md             | 2024-05-01   | 833        | Medium-High (scraper targets external sites whose markup/API likely changed)              | Moderate-Heavy                                                              |
| 2024-12-04-quantified-niw.md       | 2024-12-04   | 616        | **High** (YMYL immigration-law content; USCIS policy shifts)                              | Moderate — verify against current USCIS Policy Manual, add disclaimer       |
| 2025-01-15-guided-portfolio.md     | 2025-01-15   | 574        | Medium (index page, plus has an active dead link + CSS bug)                               | Light (bug fixes) + ongoing (add new work)                                  |
| 2025-03-06-reflection.md           | 2025-03-06   | 524        | Low (cited research is stable)                                                            | Light — fix headings/grammar only                                           |
| 2025-07-09-journey-back-to-self.md | 2025-07-09   | 399        | Low for freshness / High for content revision (sensitive disclosures, independent of age) | Heavy — editorial judgment call, not a fact update                          |
| 2026-03-19-adc-vmid-calibration.md | 2026-03-19   | 146        | Low (newest post)                                                                         | Light — citations + alt text only                                           |

## Suggested Next Steps

1. Run `/blog analyze _posts/2023-12-12-suicide.md` first — lowest score, and the P0 (missing crisis resources) is a trust/safety issue independent of SEO.
2. Fix the 5 sitewide gaps once (schema/OG toggle, author frontmatter, `last_updated` field, internal linking pass) rather than patching each post individually — this alone should lift every post's Technical and E-E-A-T subscores.
3. Confirm the Tailscale credential/hostname exposure in `observability.md` before anything else ships.
4. Run `/blog flow optimize` on `adc-vmid-calibration.md` (highest scorer, strong original technical content) — closest to being a genuinely strong AI-citation candidate once citations and alt text are added.
