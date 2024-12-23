---
layout: page
title: EB2-NIW in Math
description: A quantified methods to evaluate your EB2-NIW petition.
img: assets/img/dhanasar/niw.png
importance: 1
category: work
d3: true
pretty_table: true
toc:
  sidebar: left
chart_scripts:
  - chart/chart-sunburst.js
---

## **Introduction**

The regulations outlined in 8 CFR § 204.5(k) define the eligibility criteria for second-preference employment-based immigrant visas (EB-2), including the requirements for a National Interest Waiver (NIW). Historically, petitions were evaluated under the _Matter of New York State Dept. of Transportation_ (NYSDOT), a framework often criticized for its opaque standards and inconsistent application. In response, _Matter of Dhanasar_, 26 I&N Dec. 884 (AAO 2016), introduced a clearer, more flexible three-prong test to guide U.S. Citizenship and Immigration Services (USCIS) adjudicators.

Dhanasar’s three-prong framework requires that a petitioner demonstrate:

1. **Substantial Merit and National Importance**
2. **Positioning to Advance the Proposed Endeavor**
3. **Balancing the National Interest**

USCIS typically assesses these prongs sequentially. If **Prong 1** is not met, further analysis ends. Only upon passing **Prong 1** do they evaluate **Prong 2**, and only if both prongs are satisfied do they proceed to **Prong 3**. This hierarchical structure necessitates a mathematical model that reflects conditional progression, ensuring that each subsequent evaluation is grounded in the validated findings of the previous stage.

Earlier attempts at modeling the NIW framework as independent axes in a three-dimensional coordinate system did not account for this sequential logic. Instead, we now introduce a refined, tiered model that aligns with the adjudication process. This approach uses a structured, stepwise scoring system, applying well-defined thresholds at each prong before advancing to the next. Such a model offers transparency, consistency, and the mathematical rigor needed to ensure equitable and logical adjudications.

---

## **Conceptual Foundations: Sequential Evaluation of Dhanasar’s Prongs**

<div id="chart-sunburst"></div>
<script src="{{ '/assets/js/chart/chart-sunburst.js' | relative_url }}" defer></script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    if (typeof renderSunburstChart === 'function') {
      renderSunburstChart('#chart-sunburst'); // Call the function
    } else {
      console.error("Function 'renderSunburstChart' is not defined.");
    }
  });
</script>

Our improved mathematical model integrates conditional logic with weighted scoring. In essence, each prong is a "gate" that must be cleared before proceeding. This ensures that time and analytic effort are focused on the criteria relevant to the petitioner’s demonstrated accomplishments and potential. The model’s core principle is to maintain strict adherence to the Dhanasar framework while quantifying each determination to minimize subjectivity.

---

### **Prong 1: Substantial Merit and National Importance**

This first prong considers whether the proposed endeavor has substantial merit and national importance. Under _Matter of Dhanasar_, this includes fields such as education, technology, public health, or environmental improvements, and can account for direct or indirect benefits. Notably, an undertaking need not have an immediate quantifiable economic impact; it suffices if it presents a clear, plausible path to substantial merit on a national scale.

#### **Mathematical Model for Prong 1:**

We employ a **binary scoring matrix** augmented by category importance. Each category contributes a point (1 or 0), and certain categories are “key” indicators with a higher weight. The petitioner’s total score is a weighted sum of these indicators. The final score is normalized to a scale of 0 to 8, allowing for straightforward interpretation.

| **Category**                                | **Criteria**                                                | **Base Score** | **Weight** | **Weighted Score** |
| ------------------------------------------- | ----------------------------------------------------------- | -------------- | ---------- | ------------------ |
| Substantial Merit                           | Contributions to major fields (science, tech, health, etc.) | 1 or 0         | 1.0        | Score \* Weight    |
| Non-Quantifiable Impact                     | Establishes value even if not purely economic               | 1 or 0         | 0.8        | Score \* Weight    |
| Prospective Scientific/Research Impact      | Potential for advancing knowledge                           | 1 or 0         | 1.0        | Score \* Weight    |
| Detailed Explanation of Merit               | Clear, well-substantiated rationale                         | 1 or 0         | 1.0        | Score \* Weight    |
| National/Global Implications                | Broad scope, beyond local/regional                          | 1 or 0         | 1.0        | Score \* Weight    |
| Potential Economic Impact                   | Prospects for job creation or economic growth               | 1 or 0         | 0.9        | Score \* Weight    |
| Focused Regional Impact but Broad Relevance | Locally rooted but with lessons/benefits of wider interest  | 1 or 0         | 0.9        | Score \* Weight    |
| Specificity of Contribution                 | Petitioner’s unique role and importance                     | 1 or 0         | 1.0        | Score \* Weight    |

- **Passing Threshold:** Calculate the weighted sum:
  $$\text{Prong 1 Score} = \sum (\text{Score}_i \times \text{Weight}_i)$$
  Prong 1 is satisfied if the weighted sum ≥ 6.0.

**Outcome:** Pass or Fail. If the petitioner passes Prong 1, proceed to Prong 2.

---

### **Prong 2: Positioning to Advance the Proposed Endeavor**

If Prong 1 is met, we consider whether the petitioner is well-positioned to realize the endeavor’s potential. Factors include the petitioner’s expertise, the feasibility of their proposed plan, prior achievements, and external support. This prong is more nuanced and benefits from a weighted scoring model that acknowledges both the quality and relevance of evidence.

#### **Mathematical Model for Prong 2:**

We use a weighted average approach. Each component receives points, then we normalize to a 100-point scale. This ensures balanced consideration of the petitioner’s qualifications and practical planning.

| **Component**                | **Weight** | **Max Points** | **Description**                                         |
| ---------------------------- | ---------- | -------------- | ------------------------------------------------------- |
| Education, Skills, Knowledge | 25%        | 25             | Degrees, specialized training, and recognized expertise |
| Record of Success            | 25%        | 25             | Publications, patents, awards, and notable achievements |
| Model or Plan                | 20%        | 20             | Detailed strategic plan outlining milestones and risks  |
| Progress Made                | 15%        | 15             | Demonstrable advancement: prototypes, trials, pilots    |
| External Validation          | 15%        | 15             | Letters of support, MOUs, endorsements, partnerships    |

Final Prong 2 score:
$$\text{Prong 2 Score} = ( \text{Educ/Skills} + \text{Record} + \text{Plan} + \text{Progress} + \text{Validation} )$$

**Normalization Example:** If all components are scored out of their respective maximums and summed to a total of 100 points, simply sum the allocated points. If fewer than 70 points are earned, the petitioner fails Prong 2.

- **Passing Threshold:** Prong 2 is satisfied if ≥ 70/100 points.

**Outcome:** Pass or Fail. If the petitioner passes Prong 2, proceed to Prong 3.

---

### **Prong 3: Balancing the National Interest**

If the petitioner passes Prongs 1 and 2, we then consider whether, on balance, granting the NIW benefits the United States. This includes showing that requiring a labor certification would be contrary to the national interest, that the petitioner’s contribution is distinct enough to override labor market protections, and that there is a compelling, often time-sensitive reason for immediate implementation.

#### **Mathematical Model for Prong 3:**

We apply a weighted scoring system focusing on three core factors, summing to 100 points:

| **Factor**                            | **Weight** | **Max Points** | **Description**                                                                                     |
| ------------------------------------- | ---------- | -------------- | --------------------------------------------------------------------------------------------------- |
| Impracticality of Labor Certification | 30%        | 30             | Difficulty in replacing or replicating petitioner’s contributions through U.S. labor market testing |
| Distinctive Contributions             | 30%        | 30             | Unique skill sets, exceptional talent, rare expertise                                               |
| Urgency of National Interest          | 40%        | 40             | Critical timing: immediate need to address pressing national objectives                             |

Sum the scores from each factor to yield a total out of 100. A robust showing in urgency or distinctiveness can offset slight shortfalls in other areas, reflecting a holistic assessment.

- **Passing Threshold:** Prong 3 is satisfied if ≥ 75/100 points.

**Outcome:** Approval (if passed) or Denial (if failed).

---

## **A Real Example: Quantified Evaluation for NIW Eligibility**

Consider **Dr. Jane Doe**, a biomedical researcher using AI-driven diagnostics to improve early detection of pancreatic cancer.

### **Prong 1: Substantial Merit and National Importance**

| **Category**                           | Score | Weight | Weighted Score |
| -------------------------------------- | ----- | ------ | -------------- |
| Substantial Merit                      | 1     | 1.0    | 1.0            |
| Non-Quantifiable Impact                | 1     | 0.8    | 0.8            |
| Prospective Scientific/Research Impact | 1     | 1.0    | 1.0            |
| Detailed Explanation of Merit          | 1     | 1.0    | 1.0            |
| National/Global Implications           | 1     | 1.0    | 1.0            |
| Potential Economic Impact              | 1     | 0.9    | 0.9            |
| Focused Regional Impact, Broad Scope   | 1     | 0.9    | 0.9            |
| Specificity of Contribution            | 1     | 1.0    | 1.0            |

> ##### PRONG 1 SCORE:
>
> **Total Weighted Score:** 1.0 + 0.8 + 1.0 + 1.0 + 1.0 + 0.9 + 0.9 + 1.0 = 7.6/8.0
>
> Prong 1 Passed (≥6.0 required).
> {: .block-blue }

---

### **Prong 2: Positioning to Advance the Proposed Endeavor**

| **Component**                         | Score |
| ------------------------------------- | ----- |
| Education, Skills, Knowledge (25 max) | 23/25 |
| Record of Success (25 max)            | 20/25 |
| Model or Plan (20 max)                | 18/20 |
| Progress Made (15 max)                | 12/15 |
| External Validation (15 max)          | 13/15 |

> ##### PRONG 2 SCORE:
>
> **Total Score:** 23+20+18+12+13 = 86/100
>
> Prong 2 Passed (≥70 required).
> {: .block-blue }

---

### **Prong 3: Balancing the National Interest**

| **Factor**                                     | Score |
| ---------------------------------------------- | ----- |
| Impracticality of Labor Certification (30 max) | 28/30 |
| Distinctive Contributions (30 max)             | 25/30 |
| Urgency of National Interest (40 max)          | 35/40 |

> ##### PRONG 3 SCORE:
>
> **Total Score:** 28+25+35 = 88/100
>
> Prong 3 Passed (≥75 required).
> {: .block-blue }

### **Final Decision:** Dr. Doe qualifies for the National Interest Waiver.

---

## **Conclusion: A Structured, Quantifiable Approach**

This refined model uses a staged, mathematically grounded methodology that mirrors the Dhanasar framework’s sequential logic. Prong 1’s foundational threshold ensures that only nationally significant endeavors proceed. Prong 2’s weighted scoring underscores the petitioner’s readiness and capability. Finally, Prong 3 balances these findings against the broader national interest, offering a transparent, consistent, and data-driven decision process. By integrating clear criteria, conditional logic, and numerical thresholds, this model enhances fairness, reduces subjectivity, and provides a roadmap for systematic NIW adjudication.

---
