---
layout: page
permalink: /publications/
title: publications
description: Peer-reviewed papers, newest first.
nav: true
nav_order: 6
---

<p>
  <a class="cv-pdf-btn pub-scholar" href="https://scholar.google.com/citations?user={{ site.data.socials.scholar_userid }}&hl=en" target="_blank" rel="noopener noreferrer">
    <i class="ai ai-google-scholar" aria-hidden="true"></i> Google Scholar profile
  </a>
</p>

{% for data in site.data.resume %}
{% if data[0] == 'publications' %}
{% include resume/publications.liquid %}
{% endif %}
{% endfor %}
