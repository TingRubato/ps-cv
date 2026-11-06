---
layout: post
title: I Talk to ChatGPT About the Same Things I Text My Friends About. A Machine Can Still Tell Them Apart 99% of the Time.
description: I embedded 30,412 of my own ChatGPT prompts and 58,791 of my own text messages with the same multilingual model. The topics rise and fall in lockstep, and the Chinese share is identical, yet the two corpora almost never mix.
date: 2026-11-06
author: Ting Xu
tags: data nlp
categories: analysis
thumbnail: assets/img/two-registers/neighbours.png
toc:
  sidebar: left
---

A few weeks ago I ran topic modeling on every text message I had sent. Then I exported my ChatGPT history and ran the same pipeline on my side of those conversations, only my prompts and never the model's replies.

I expected two pictures of two different lives: friends and food on one side, code and paperwork on the other. That isn't what came back. The topics line up month by month. When immigration paperwork took over my life, it took over both. When I started writing songs again, both corpora show it in the same month.

The strange part is that the text itself doesn't overlap at all. Put all 7,738 documents in one space and ask each one who its nearest neighbors are, and 99% of the time the answer comes from its own pile. I write about the same things to people and to a machine, and I write about them in two completely different voices.

> **Key Takeaways**
>
> - For three shared topics (immigration, songwriting, factory machines), the monthly share of my texts and my ChatGPT prompts correlates at r = 0.74 to 0.87.
> - Both corpora are 22% Chinese-dominant documents. Language isn't what separates them.
> - Even so, 99–100% of each document's 10 nearest neighbors come from its own corpus, far above the 41–59% you'd expect by chance. That holds when I match document lengths too.
> - Once I subtract each corpus's average "voice", the practical topics match cleanly (cosine up to 0.70). The emotional ones barely match anything (0.18–0.32), and what they do match is a ChatGPT topic about rewriting messages.
> - Per 100 messages, I say "please" 24 times more often to ChatGPT, and laugh 45 times more often with people.

---

## What data did I actually use?

Two corpora, both written by me, embedded with the same model.

**Texts to people.** 58,791 iMessages I sent between March 2024 and September 2026, grouped into 4,569 documents. One document is one conversation on one day. The full archive goes back to 2017, but I cut it to the window where both sources exist.

**Prompts to ChatGPT.** 30,412 of my own turns across 3,169 chats from the same window, with one chat per document. I kept typed messages and voice transcripts. I dropped the assistant's replies, hidden system text, code blocks and URLs. Long turns are usually pasted material, so for anything over 1,500 characters I kept only the first and last 300, which is where the actual instruction tends to be.

Both went through [BGE-M3](https://arxiv.org/abs/2402.03216), a multilingual embedding model that maps Chinese and English into one 1,024-dimensional space. That matters here because I switch languages constantly. The per-corpus topics came from UMAP + HDBSCAN with c-TF-IDF keywords, and I labeled the clusters by hand: 35 topics for texts, 25 for ChatGPT.

For context on how I use ChatGPT compared with everyone else: OpenAI's large usage study (Chatterji et al., [NBER Working Paper 34255](https://www.nber.org/papers/w34255), September 2025) found that practical guidance, seeking information and writing make up nearly 80% of ChatGPT conversations. My mix leans harder toward code and immigration paperwork than that, but writing help is a big share of mine too. That turns out to matter below.

{% include figure.liquid loading="lazy" path="assets/img/two-registers/chatgpt-map.png" title="Map of my ChatGPT chats" alt="UMAP projection of 3,169 ChatGPT chats colored by four domains: code and infrastructure, immigration and business, writing and music, and work hardware, with panels showing how the occupied regions shift across 2024, 2025 and 2026" class="img-fluid rounded z-depth-1" %}

<div class="caption">My ChatGPT prompts on their own, 2024 to 2026. Code dominates 2024, immigration and business work peaks in late 2024 and early 2025, and songwriting takes over from mid-2025.</div>

## Do the two corpora follow the same life?

Yes, and more closely than I expected.

I matched three topics that obviously exist in both corpora. Then I computed each one's share of the month's documents, separately for texts and prompts, and correlated the two series across the 31 months.

<!-- [ORIGINAL DATA] -->

| Shared topic          | Texting topic(s)                       | ChatGPT topic(s)                                           | Correlation |
| --------------------- | -------------------------------------- | ---------------------------------------------------------- | ----------- |
| Immigration paperwork | NIW & immigration                      | Visa procedures, NIW arguments, exhibits, client petitions | r = 0.80    |
| Songwriting           | Music releases, songwriting & feelings | Songwriting & Suno prompts                                 | r = 0.74    |
| Factory machines      | Machine troubleshooting                | CNC, PLC & machines                                        | r = 0.87    |

{% include figure.liquid loading="lazy" path="assets/img/two-registers/lockstep.png" title="Shared topics move together" alt="Three line charts comparing the monthly share of texts and ChatGPT prompts for immigration paperwork, songwriting and factory machines; in each panel the two lines rise and fall together" class="img-fluid rounded z-depth-1" %}

<div class="caption">Three-month moving average. The correlations in the titles use the unsmoothed monthly shares. No lag improved on zero for any of the three.</div>

I also tried shifting one series against the other by up to four months, since I half-expected ChatGPT to lead (ask the machine first, tell friends later) or lag. It didn't. The best lag was zero for all three. Whatever was going on, I was talking to both at once.

Two smaller pairs were looser. Work email automation correlated at only 0.29, and health topics at 0.34. Both did better with ChatGPT shifted three months, so for those I texted people about it a bit before I started asking the machine. With only 31 months of data I wouldn't read much into that.

The amplitudes differ more than the timing does. At its peak in autumn 2024, immigration work was 37% of my ChatGPT chats and 16% of my text conversations. A lot of my AI use is work that has no reason to show up in a text.

## So why can a model tell them apart?

Here is the result that surprised me most.

I put all 7,738 documents into one embedding space and found each document's 10 nearest neighbors by cosine similarity. If the topics overlap, a text about immigration should sometimes land next to a ChatGPT prompt about immigration. Given the corpus sizes, a document picked at random would have 59% of its neighbors from its own corpus if it's a text, and 41% if it's a prompt.

The observed numbers were 100% and 99%.

<!-- [ORIGINAL DATA] -->

{% include figure.liquid loading="lazy" path="assets/img/two-registers/neighbours.png" title="Nearest neighbors stay in their own corpus" alt="Bar chart showing that 100 percent of texts' and 99 percent of prompts' nearest neighbors come from the same corpus, unchanged after matching document length, and still 96 and 85 percent after removing each corpus's average embedding, all well above the chance lines at 59 and 41 percent" class="img-fluid rounded z-depth-1" %}

My first suspect was length. A text-day has a median of 239 characters and a ChatGPT chat has 884. So I kept only documents between 400 and 1,500 characters (1,210 texts, 1,071 chats) and reran it. Nothing changed: 100% and 99%.

My second suspect was language, since BGE-M3 does react to script. But the Chinese share is basically identical. 22.3% of text-days and 22.0% of chats are majority Chinese, and the average Chinese character share is 17.6% against 17.5%. Language can't be what splits them.

What's left is register: the shape of how I write to each audience. To a person I write short, reactive lines that lean on context we both already have. To ChatGPT I write briefs: imperatives, pasted context, constraints spelled out because the reader starts with nothing. The embedding model picks up on that before it picks up on the topic.

You can test that idea directly. If register is a roughly constant offset for each corpus, then subtracting each corpus's mean embedding should remove most of it. It removes some. Same-corpus neighbors drop to 96% for texts and 85% for prompts. That is still well above chance, so the gap isn't just one shared offset.

## Which topics cross over once the voice is removed?

After centering, I compared topic centroids across the two corpora. For each texting topic I asked which ChatGPT topic sits closest.

<!-- [UNIQUE INSIGHT] -->

{% include figure.liquid loading="lazy" path="assets/img/two-registers/bridges.png" title="Which texting topics have a ChatGPT twin" alt="Dot plot of the closest ChatGPT topic for fourteen texting topics: factory machines and immigration match at 0.70, money, AI tools, music and work email near 0.5, while emotional topics such as deep talks, encouragement, dating and check-ins match a rewriting topic at only 0.18 to 0.32" class="img-fluid rounded z-depth-1" %}

The split is clean.

**Practical topics have twins.** Factory machine troubleshooting matches CNC & PLC work at 0.70. Immigration matches visa procedures at 0.70. Money matches tax and payroll at 0.52, and music releases match Suno prompts at 0.48. These are problems, and I bring problems to both.

**Emotional topics don't.** Deep talks, encouragement, dating and everyday check-ins match at 0.18 to 0.32, the weakest scores in the set. And the ChatGPT topic they land nearest is always the same one: _Rewriting & communication style_.

That last detail is what I keep thinking about. Going by my own data, I don't confide in ChatGPT. When feelings show up there, they come as an editing job: help me say this to someone. The conversation itself still happens with a person. That fits the NBER finding that writing help, mostly editing text the user brings, is one of the main things people use ChatGPT for.

Logistics barely match either. Addresses, arrivals and "coming over" land at 0.16 on a catch-all errands topic. Nobody asks a chatbot what time dinner is.

## Fun facts from inside the topics

The topic labels hide a lot, so I went back to raw counts. Everything below is a simple aggregate: keyword matches, dates and the model name ChatGPT stores with each chat. No message text is involved.

<!-- [ORIGINAL DATA] -->

### I say "please" to the machine and "haha" to people

{% include figure.liquid loading="lazy" path="assets/img/two-registers/manners.png" title="Manners by audience" alt="Dumbbell chart of phrase rates per 100 sent messages: laughing is 9 per 100 texts but 0.2 per 100 prompts, swearing 2.6 versus 1.1, sorry 0.7 versus 0.5, while please is 0.5 versus 11.9, can you 0.8 versus 7.7 and why 1.1 versus 3.5" class="img-fluid rounded z-depth-1" %}

Per 100 messages, I say "please" (or 请) 11.9 times to ChatGPT and 0.5 times to people. That's 24 times more polite to software. Laughter runs the other way: 9 laughs per 100 texts, 0.2 per 100 prompts. I basically never laugh at ChatGPT.

A prompt is longer than a text, so I checked the same counts per 1,000 characters. The direction holds. "Please" is still 4 times more common in prompts, and laughter is 200 times more common in texts.

Swearing is the cleanest split. 21% of my text conversation-days contain at least one swear word. Only 6% of my ChatGPT chats do. Apparently I'm on my best behavior with the machine and myself with my friends.

### Code happens in English, paperwork happens in Chinese

The overall Chinese share is the same in both corpora, but it is not spread evenly across topics.

| Topic                            | Corpus  | Chinese characters |
| -------------------------------- | ------- | ------------------ |
| Code errors & debugging          | ChatGPT | 2.8%               |
| Docker & self-hosting            | ChatGPT | 3.1%               |
| Money & payments                 | Texts   | 42%                |
| NIW & immigration                | Texts   | 46%                |
| Health, biology & chemistry      | ChatGPT | 47%                |
| Chinese news, politics & society | ChatGPT | 48%                |

I debug in English because error messages are in English. Health, money and immigration happen in Chinese. The two languages divide up my life by subject, not by who I'm talking to.

### Some topics never leave work hours

Weekends are 23% of the calendar days in both corpora, close to the 2/7 you'd expect. Some topics ignore that completely.

- **Factory machine troubleshooting** gets 1.5% of its text conversation-days on weekends. Of its 1,018 timestamped messages, none was sent between midnight and 5 a.m. The machines are a 9-to-5 problem.
- **Work email & IoT buttons** on ChatGPT: 6% on weekends.
- **Docker & self-hosting** on ChatGPT: 34% on weekends, the most weekend-heavy topic in either corpus. Fixing my home server is what I do for fun.

My texting peaks at 1 p.m. Only 2.4% of my texts go out between midnight and 5 a.m., so I'm less of a night owl than I thought.

### My biggest ChatGPT topic isn't code

Songwriting & Suno prompts is the single largest ChatGPT topic, with 317 chats, or 11% of everything assigned to a topic. Rewriting & communication style is second at 222, and code errors only third at 186. My record is six separate songwriting chats in one day, in August 2026.

### Where I spent the expensive model

Only 5.6% of my chats used a reasoning model (o1, or the GPT-5 "thinking" variants). For NIW arguments & RFEs it was 21%, nearly four times the average. When the stakes were a green card, I paid for the slow model.

### The longest conversation was with a circuit

My median ChatGPT chat runs 5 turns, and 16% are one-shot. Everyday emails & errands has a median of 1 turn: ask, copy, leave. The longest chat in the whole export, 316 turns, sits in Circuits & embedded. Nothing else in my ChatGPT history held my attention for 316 messages.

## What should you take from this if you're not me?

This is one person's data, so it proves nothing about anyone else. It did change how I think about three things.

**Topic models undercount overlap between sources.** If I had clustered both corpora together, I'd have found two big islands and concluded my AI use and my social life are separate. Topically they're tightly linked. The embedding was splitting by voice. If you merge corpora from different channels (support tickets and chat logs, emails and Slack), check the cross-source neighbor rate before you trust shared clusters. Centering each source is a cheap first fix, though it won't remove everything.

**Correlation across channels is a cheap life signal.** Month by month, the shared topics are a fairly honest record of what was weighing on me. Immigration dominated late 2024 into early 2025, and it shows in both channels at once. I wrote about that period in [a quantified way to evaluate an EB2-NIW petition]({% post_url 2024-12-04-quantified-niw %}).

**The emotional layer stays human.** I didn't plan it that way, but my data says I keep it there. The AI helps me phrase things. People get the actual conversation.

## Limitations

- **Different units.** A text document is one conversation-day and a ChatGPT document is one chat. Matching lengths didn't change the result, but the units still differ in structure.
- **Different cleaning.** I removed code, URLs and the middle of long pasted turns from ChatGPT prompts only. Some of the register gap is pasted material that survived the trim.
- **Keyword counts are crude.** The fun-fact rates come from regex matches in English and Chinese. They miss slang and sarcasm. The ChatGPT side also has code and the middle of long pastes removed. Hour-of-day data exists only for texts, because the ChatGPT corpus stores dates without times.
- **Hand labels.** Topic names are mine, and the "emotional" grouping in the last chart is my call.
- **One person, one model.** BGE-M3 is one embedding model. Another model might weigh register and topic differently.
- **Privacy.** Every number here is an aggregate. No message text, names or contacts from either corpus appear in this post, and the people I text never agreed to be data, so it stays that way.

## Conclusion

I went in expecting two lives and found one life written in two voices. The topics move together, the language mix is identical, and the timing has no lag. Even so, a model can tell a text from a prompt almost every time, because I write to people as if they already know me and to ChatGPT as if it needs a brief.

If you want to try this on your own data, both pipelines are small: export, keep only your own turns, embed everything with one multilingual model, then check each document's nearest neighbors. I'd like to hear whether your numbers look like mine.
