---
layout: page
title: slides
permalink: /slides/
description: A growing collection of some slides that I did.
nav: true
nav_order: 3
display_categories: [teaching, work]
horizontal: false
---

<!-- pages/slides.md -->
<div class="slides">
{% if site.enable_project_categories and page.display_categories %}
  <!-- Display categorized slides -->
  {% for category in page.display_categories %}
  <a id="{{ category }}" href=".#{{ category }}">
    <h2 class="category">{{ category }}</h2>
  </a>
  {% assign categorized_slides = site.slides | where: "category", category %}
  {% assign sorted_slides = categorized_slides | sort: "importance" %}
  <!-- Generate cards for each project -->
  {% if page.horizontal %}
  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
    {% for slide in sorted_slides %}
      {% include slides_horizontal.liquid %}
    {% endfor %}
    </div>
  </div>
  {% else %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for slide in sorted_slides %}
      {% include slides.liquid %}
    {% endfor %}
  </div>
  {% endif %}
  {% endfor %}

{% else %}

<!-- Display slides without categories -->

{% assign sorted_slides = site.slides | sort: "importance" %}

  <!-- Generate cards for each project -->

{% if page.horizontal %}

  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
    {% for slide in sorted_slides %}
      {% include slides_horizontal.liquid %}
    {% endfor %}
    </div>
  </div>
  {% else %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for slide in sorted_slides %}
      {% include slides.liquid %}
    {% endfor %}
  </div>
  {% endif %}
{% endif %}
</div>
