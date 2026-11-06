---
layout: page
title: NIW Self Report
description: A self-assessment web app for EB-2 NIW, EB-1A and EB-1B petitions. You get a free score, a paid PDF report, and scoring anchored to Matter of Dhanasar.
img: assets/img/niw-selfreport/resource-hub.png
importance: 2
toc:
  sidebar: left
---

> ##### NOT LEGAL ADVICE
>
> NIW Self Report is a preparation tool. It helps you organize evidence and find gaps before you talk to an attorney. It does not replace one.
> {: .block-warning }

**Live:** [signme.today](https://signme.today)

When I was preparing my own NIW petition, the questions that cost me the most time were simple ones. How strong is this record, honestly? Which prong is weakest? What evidence am I missing? Answering them usually meant a paid consultation, or a lot of reading through forum threads.

I wrote down a rough scoring approach in [a quantified way to evaluate your EB2-NIW petition]({% post_url 2024-12-04-quantified-niw %}). NIW Self Report is that idea turned into a working product. You describe your record, it scores the record against the Dhanasar framework, and it tells you what to fix before filing.

{% include figure.liquid loading="lazy" path="assets/img/niw-selfreport/resource-hub.png" title="Resource hub" alt="NIW Self Report resource hub page with the headline 'Prepare a clearer evidence record before attorney review', a start-assessment button, and article cards for EB-2 NIW, EB-1A, Form I-140 and a multi-category comparison" class="img-fluid rounded z-depth-1" %}

<div class="caption">The resource hub: source-backed articles and checklists for EB-2 NIW, EB-1A and EB-1B, next to the assessment.</div>

---

## What it does

1. **Guided intake.** A multi-step form, with an AI-assisted chat option, collects your endeavor, your evidence and your plans in the US. Drafts save automatically, so you can leave and come back.
2. **Free score and summary.** Every assessment returns an overall score, a readiness level, strengths, weaknesses and missing evidence.
3. **Paid report tiers.** Basic and Pro unlock a typeset PDF with prong-by-prong analysis, strategy suggestions, and benchmarks tied to citations in _Dhanasar_.
4. **Evidence research.** For NIW, it can look up public sources to check whether your claims about your field and endeavor hold up.
5. **Resource hub.** Articles and printable checklists, managed through a headless CMS.

## How the score works

The score is a weighted composite, and the weights follow where adjudicators actually push back:

| Dimension                                        | Weight | Source                          |
| ------------------------------------------------ | ------ | ------------------------------- |
| Prong 1: substantial merit & national importance | 20%    | LLM analysis                    |
| Prong 2: well positioned to advance the endeavor | 35%    | LLM analysis                    |
| Prong 3: beneficial to waive labor certification | 25%    | LLM analysis                    |
| Craft score: quality of the application itself   | 20%    | Deterministic, from intake data |

Prong 2 carries the most weight because it's where RFEs tend to land. The craft score never comes from the model. It's computed in code from evidence completeness (35%), narrative specificity (25%), plan clarity (20%), and whether you've acknowledged and addressed your weak points (20%). Some of the score can be gamed by a persuasive LLM answer. That part can't.

The result is mapped onto four filing verdicts:

- **90+**: file now
- **75–89**: file after targeted revisions
- **60–74**: rebuild the theory before filing
- **below 60**: do not file on the current record

Report benchmarks for citations, grants, letters, publications, patents and awards each carry a pinpoint citation to _Matter of Dhanasar_, 26 I&N Dec. 884 (AAO 2016). Every number in the report points back to the precedent it's based on.

## Architecture

```
Intake → Zod validation → evidence research (Tavily, NIW only)
       → LLM generation (AWS Bedrock) → schema-validated structured output
       → sanitize → normalize scores → Postgres
```

- **Stack.** Next.js 16 (App Router), TypeScript, Prisma + PostgreSQL, Payload CMS for resources, Auth.js with Google sign-in, Stripe checkout, React-PDF reports.
- **Models.** AWS Bedrock through the AWS credential chain, so there are no separate AI API keys. The assessment and chat models are configured independently.
- **Async processing.** Generating an assessment can take tens of seconds. `POST /api/assess` enqueues a durable job row and returns immediately, and the client polls for status. A reconcile route picks up stale jobs. Failed runs retry up to 3 times.
- **Structured output.** The model returns schema-validated JSON, with a text-and-parse fallback when it doesn't. Output is sanitized before it's stored or shown.
- **Access control.** Four modes, checked in order: owner session, a hashed access-grant cookie (so you can take an assessment without an account), a legacy token with a grace period, then deny. An anonymous assessment gets attached to your account at checkout.
- **Rate limiting.** A fixed-window Lua script runs in Redis. If Redis errors, a circuit breaker switches to in-memory limits for 30 seconds.
- **Infrastructure.** AWS Elastic Beanstalk, RDS PostgreSQL, Route 53 and SES, with a `/api/health` endpoint.

Each non-obvious choice has a short ADR in the repo, covering the job queue, anonymous access grants, the dual PDF pipeline and the rate-limit fallback.

## Testing an LLM product

You can't unit-test whether a model gives good immigration advice. What you can test is everything around the model:

- **35 `node:test` suites.** These cover scoring, parsing, sanitizing, access control, Stripe webhook idempotency, rate limiting and the Dhanasar benchmarks.
- **Prompt-injection tests.** Intake text is untrusted input, so these check that a user can't talk the model into a better score.
- **An eval harness.** Fixed fixture profiles each have an expected score range, an expected readiness level and keywords the analysis must mention. A regression suite fails when a prompt or model change moves the results out of range.
- **Playwright end-to-end tests.** These run the full intake → assessment → purchase → report flow.

## What I learned

- **Keep the model away from the parts that must be stable.** The craft score and the verdict bands live in deterministic code, so part of every score can't drift when a prompt or a model changes.
- **Durable queues beat fire-and-forget.** The first version ran generation in the background with Next.js `after()`. It had no automatic retry and no path for stuck jobs. Moving the jobs into Postgres rows made every failure visible and retryable.
- **Cite everything.** People applying for green cards are rightly skeptical. Tying every benchmark to a page of _Dhanasar_ does more for trust than any marketing copy.

Related: [USCIS Stability?]({{ '/projects/USCIS-Stability/' | relative_url }}), a less serious look at NIW processing data through Lyapunov stability.
