---
layout: post
title: USCIS Stability?
date: 2024-10-01 16:40:16
thumbnail: assets/img/lyapunov/image.png
description: Lyapunov Stability Analysis on USCIS Petitions.
tags: law analysis
categories: informal
pretty_table: true
# toc:
#   sidebar: left
chart:
  echarts: true
---

> ##### WARNING
>
> For entertainment purposes only.  
> Feel free to judge, but please be kind.  
> {: .block-danger }

Hello, everyone! Let’s discuss how vital NIW (National Interest Waiver) applications are in U.S. immigration. This special option under the EB-2 category essentially provides a “backdoor” to a Green Card for highly skilled professionals who can make major contributions to the United States.

Today, we’ll apply Lyapunov stability theory to examine how the NIW application processing system operates. Why Lyapunov stability theory? Because it helps us assess whether a system (in this case, the USCIS NIW application process) can return to equilibrium after being disturbed—something I’ve wanted to understand better since I never fully grasped system identification basics during the pandemic.

We’ll analyze NIW application data from 2019 to 2023 to see how the system responds to surges in applications or policy changes. By applying Lyapunov analysis, we can gain deeper insight into the system’s stability, adaptability, and long-term sustainability. This not only helps us understand current NIW processing better, but it can also offer a strategic advantage for applicants.

Sound interesting? Let’s begin by looking at the NIW application data trends, build a Lyapunov stability model, and then dive into a detailed discussion of the system’s stability.

---

| Year     | Receipts | Completions | New Incomplete | Cumulative Backlog |
| -------- | -------- | ----------- | -------------- | ------------------ |
| **2019** | 12,510   | 7,390       | 5,120          | 5,120              |
| **2020** | 14,310   | 10,520      | 3,790          | 8,910              |
| **2021** | 14,610   | 11,210      | 3,400          | 12,310             |
| **2022** | 21,990   | 21,230      | 760            | 13,070             |
| **2023** | 39,810   | 39,840      | -30            | 13,040             |

**Table 1: EB-2 Category NIW Total Receipts, Completions, and Approvals, FY 2023 USCIS[2]**  
**Note: The cumulative backlog does not include cases pending before 2018.**

---

## Key Data Points

### I. In-Depth Analysis of Backlog Trends

#### A. 2019–2021: Backlog Increased Year by Year

- **Steady Increase in Receipts**: From 12,510 in 2019 to 14,610 in 2021 (up 16.8%).
- **Slower Growth in Completions**: From 7,390 in 2019 to 11,210 in 2021 (up 51.7%, but not enough to offset the growth in receipts).
- **Cumulative Backlog Effect**: From 5,120 in 2019 to 12,310 in 2021 (a 2.4-fold increase).
- **Pandemic Impact**: USCIS office closures, staffing shortages, and remote work led to fewer completions.

```echarts
{
   "title": {
      "text": "Backlog and Case Processing Trends (2019-2021)",
      "left": "center"
   },
   "tooltip": {
      "trigger": "axis",
      "axisPointer": {
         "type": "shadow"
      }
   },
   "legend": {
      "top": "10%",
      "data": ["Receipts", "Completions", "Backlog"]
   },
   "xAxis": {
      "type": "category",
      "data": ["2019", "2020", "2021"]
   },
   "yAxis": {
      "type": "value",
      "name": "Counts",
      "min": 0
   },
   "series": [
      {
         "name": "Receipts",
         "type": "bar",
         "data": [12510, 13890, 14610],
         "itemStyle": {
            "color": "rgba(54, 162, 235, 0.8)"
         }
      },
      {
         "name": "Completions",
         "type": "bar",
         "data": [7390, 9100, 11210],
         "itemStyle": {
            "color": "rgba(75, 192, 192, 0.8)"
         }
      },
      {
         "name": "Backlog",
         "type": "bar",
         "data": [5120, 8790, 12310],
         "itemStyle": {
            "color": "rgba(255, 159, 64, 0.8)"
         }
      }
   ]
}
```

#### B. 2022: Significant Improvement in Processing Efficiency

- **Surge in Receipts**: 21,990 (50.5% increase over 2021)
- **Major Increase in Completions**: 21,230 (up 89.4% from 2021)
- **Backlog Growth Slows**: Only 760 new incomplete cases
- **Possible Reasons**: More staffing, introduction of automation, streamlined processes

```echarts
{
   "title": {
      "text": "Case Processing Trends (2022)",
      "left": "center"
   },
   "tooltip": {
      "trigger": "axis",
      "axisPointer": {
         "type": "shadow"
      }
   },
   "legend": {
      "top": "10%",
      "data": ["Receipts", "Completions", "Backlog Growth"]
   },
   "xAxis": {
      "type": "category",
      "data": ["2022"]
   },
   "yAxis": {
      "type": "value",
      "name": "Counts",
      "min": 0
   },
   "series": [
      {
         "name": "Receipts",
         "type": "bar",
         "data": [21990],
         "itemStyle": {
            "color": "rgba(54, 162, 235, 0.8)"
         }
      },
      {
         "name": "Completions",
         "type": "bar",
         "data": [21230],
         "itemStyle": {
            "color": "rgba(75, 192, 192, 0.8)"
         }
      },
      {
         "name": "Backlog Growth",
         "type": "bar",
         "data": [760],
         "itemStyle": {
            "color": "rgba(255, 159, 64, 0.8)"
         }
      }
   ]
}
```

#### C. 2023: System Enters a New Equilibrium

- **Receipts and Completions Nearly Equal**: 39,810 vs. 39,840
- **Negative New Incompletes**: -30, reducing some backlog
- **Slight Decrease in Cumulative Backlog**: From 13,070 to 13,040
- **Increased Processing Capacity**: Completions are 5.4 times the figure in 2019.

```echarts
{
   "title": {
      "text": "Case Processing Trends (2023)",
      "left": "center"
   },
   "tooltip": {
      "trigger": "axis",
      "axisPointer": {
         "type": "shadow"
      }
   },
   "legend": {
      "top": "10%",
      "data": ["Receipts", "Completions", "Backlog Change"]
   },
   "xAxis": {
      "type": "category",
      "data": ["2023"]
   },
   "yAxis": {
      "type": "value",
      "name": "Counts",
      "min": -50
   },
   "series": [
      {
         "name": "Receipts",
         "type": "bar",
         "data": [39810],
         "itemStyle": {
            "color": "rgba(54, 162, 235, 0.8)"
         }
      },
      {
         "name": "Completions",
         "type": "bar",
         "data": [39840],
         "itemStyle": {
            "color": "rgba(75, 192, 192, 0.8)"
         }
      },
      {
         "name": "Backlog Change",
         "type": "bar",
         "data": [-30],
         "itemStyle": {
            "color": "rgba(255, 159, 64, 0.8)"
         }
      }
   ]
}
```

### II. In-Depth Exploration of System Stability

#### A. Backlog Remains Stable or Even Decreases

- **Backlog Under Control**: Despite a big increase in receipts during 2022-2023, backlog did not rise significantly
- **Enhanced Adaptability**: USCIS shows stable processing capability under high application volumes
- **Potential Risk**: Persistent rapid growth in receipts could lead to new backlog issues

#### Matching Growth in Completions to Growth in Receipts

- **Completions Grow Faster**: From 2022 to 2023, completions grew faster than receipts
- **Sustained Increase in Completions**: From 2019 to 2023, completions grew at an average rate of 53.2% annually, compared to 34.8% for receipts
- **Contribution to Stability**: The rapid increase in completions is key to system stability

### III. In-Depth Analysis of Application Volume Changes

#### A. Reasons Behind the Application Surge

- **Policy Changes**: Possible easing of NIW requirements in 2022
- **Employment Environment**: Big tech companies halting PERM applications and layoffs push STEM talent toward NIW
- **International Factors**: Global political conditions and the pandemic lead overseas talent to choose U.S. immigration

```echarts
{
    "title": {
        "text": "Receipts vs. Completions (2019-2023)",
        "left": "center"
    },
    "tooltip": {
        "trigger": "axis"
    },
    "legend": {
        "top": "10%",
        "data": ["Receipts", "Completions"]
    },
    "xAxis": {
        "type": "category",
        "data": ["2019", "2020", "2021", "2022", "2023"]
    },
    "yAxis": {
        "type": "value",
        "name": "Counts"
    },
    "series": [
        {
            "name": "Receipts",
            "type": "line",
            "data": [12510, 13890, 14610, 21990, 39810],
            "itemStyle": {
                "color": "rgba(54, 162, 235, 0.8)"
            }
        },
        {
            "name": "Completions",
            "type": "line",
            "data": [7390, 9100, 11210, 21230, 39840],
            "itemStyle": {
                "color": "rgba(75, 192, 192, 0.8)"
            }
        }
    ]
}
```

#### B. Application Growth Trend

- **Significant Growth in 2022**: 50.5% increase over 2021
- **Further Growth in 2023**: 39,810 cases, up 81% over 2022, 3.18 times 2019’s figure
- **Future Outlook**: USCIS must further increase capacity to handle potential continued growth

  ```echarts
  {
     "title": {
        "text": "Annual Growth Rates: Receipts vs. Completions",
        "left": "center"
     },
     "tooltip": {
        "trigger": "axis",
        "axisPointer": {
           "type": "line"
        }
     },
     "legend": {
        "top": "10%",
        "data": ["Receipts Growth", "Completions Growth"]
     },
     "xAxis": {
        "type": "category",
        "data": ["2019-2020", "2020-2021", "2021-2022", "2022-2023"]
     },
     "yAxis": {
        "type": "value",
        "name": "Growth Rate (%)"
     },
     "series": [
        {
           "name": "Receipts Growth",
           "type": "line",
           "data": [11.0, 5.2, 50.5, 81.0],
           "itemStyle": {
              "color": "rgba(54, 162, 235, 0.8)"
           }
        },
        {
           "name": "Completions Growth",
           "type": "line",
           "data": [23.1, 23.0, 89.4, 87.6],
           "itemStyle": {
              "color": "rgba(75, 192, 192, 0.8)"
           }
        }
     ]
  }
  ```

### IV. Other Noteworthy Data Points

#### A. Changes in Annual Backlog Increases

- **Reduced Backlog Increases**: 3,400 in 2021 → 760 in 2022 → -30 in 2023.

#### **2. Significant Improvement in Processing Efficiency**

- **Improved Completion Rate**: From 59% in 2019 to 100.1% in 2023

#### **3. Changes in System Load**

- **Absolute Values of Receipts and Completions Increased**: Around 40,000 each in 2023
- **Matching Capacity and Load**: The system remained efficient under high load

---

## Lyapunov Stability Model

To analyze this system, we define our state variable as the **backlog of unprocessed NIW cases**.

> ##### Why choose **backlog** as the system’s **state variable**?
>
> 1. Direct Reflection of System Load: Backlog measures the gap between receipts and completions.
> 2. Core State of the Dynamic System: Continuous backlog increase indicates potential instability.
> 3. Clear Definition of Equilibrium: Equilibrium means the backlog approaches zero (the rate of new cases vs. completions is balanced).
>    {: .block-blue }

To analyze the system more accurately, we split the state into **two parts**:

1. Backlog $$B(t)$$: Represents the current number of uncompleted cases in the system
2. Backlog Rate of Change $$\frac{dB(t)}{dt}$$: Describes how the backlog changes over time

Thus we have:

$$\frac{dB(t)}{dt} = R(t) - C(t)+\eta(t)$$

- $$B(t)$$: NIW backlog at time t.
- $$R(t)$$: Annual receipt volume
- $$C(t)$$: Annual completion volume
- $$\eta(t)$$: External disturbances, such as policy changes or international events

This state equation shows **how backlog changes over time**, with receipts, completions, and external factors all influencing the backlog dynamics.

### Defining the Lyapunov Function

$$V(B,\dot{B})=\alpha(B(t))^2+\beta(\frac{dB(t)}{dt})^2$$

1. $$B(t)^2$$: Reflects the current magnitude of the backlog (system load).
2. $$(\frac{dB(t)}{dt})^2$$: Measures the rate of change of backlog, capturing system dynamics.
3. $$\alpha, \beta>0$$: Weighting factors to balance the influence of backlog magnitude and its rate of change.

This Lyapunov function not only **measures the backlog itself** but also **captures the rate of change**, enabling a more comprehensive stability analysis.

## Dissect the Equation

1. **Calculating the Derivative of the Lyapunov Function $$V(B,\dot{B})$$:**

$$\dot{V}(B, \dot{B}) = 2 \alpha B(t) \frac{dB(t)}{dt} + 2 \beta \frac{dB(t)}{dt} \cdot \frac{d^2 B(t)}{dt^2}$$

2. **Substituting the State Equation:**

$$\dot{V}(B, \dot{B}) = 2 \alpha B(t) \cdot (R(t) - C(t) + \eta(t)) + 2 \beta \left( R{\prime}(t) - C{\prime}(t) + \eta{\prime}(t) \right)$$

## Stability Analysis:

### **1. Without External Disturbance ($$\eta(t)=0$$):**

The equation simplifies to:

$$\frac{dB(t)}{dt} = R(t) - C(t)$$

The Lyapunov function’s derivative becomes:

$$\dot{V}(B, \dot{B}) = 2 \alpha B(t) \cdot (R(t) - C(t)) + 2 \beta \frac{dB(t)}{dt} \cdot ( R{\prime}(t) - C{\prime}(t) )$$

#### **Case 1: If $$R(t) < C(t)$$, i.e., completions exceed receipts,**

$$R(t)-C(t)<0$$ and $$B(t)(R(t)-C(t))<0$$

1. The first term $$2 \alpha B(t)(R(t)-C(t))$$ is negative.
2. The second term $$2 \beta \frac{dB(t)}{dt}(R^{\prime}(t)-C^{\prime}(t))$$ depends on the rate of change, but if $$\frac{dB(t)}{dt}<0$$, this term also tends to be negative.

- Conclusion: $$\dot{V}(B,\dot{B})<0$$ indicates **the backlog is decreasing**, showing **asymptotic stability**. Even if there’s initial backlog, the system will **gradually return to zero backlog**.

#### **Case 2: $$R(t) > C(t)$$, i.e., completions exceed receipts,**

If $$R(t)-C(t)>0$$ and thus $$B(t)(R(t)-C(t))>0$$

1. The first term $$2 \alpha B(t)(R(t)-C(t))$$ is positive, indicating **backlog is increasing**.
2. The sign of the second term $$2 \beta \frac{dB(t)}{dt}(R^{\prime}(t)-C^{\prime}(t))$$ depends on the rate of change. If **receipts grow faster** ($$R^{\prime}(t)>C^{\prime}(t)$$), it’s also positive.

- Conclusion: $$\dot{V}(B,\dot{B})>0$$ shows backlog keeps rising and the system is **unstable**. Without increasing completions or reducing receipts, the backlog will continue to grow.

### **2. Considering External Disturbances $$\eta(t)\neq0$$**

In reality, external disturbances (policy shifts, economic crises, etc.) can have unpredictable effects on the system.

Now the state equation is: $$\frac{dB(t)}{dt}=R(t)-C(t)+\eta(t)$$

#### **Case 1: Large, Sustained External Disturbance**

If $$\eta(t)$$ is large and positive for a sustained period, the system’s dynamics are strongly affected.

Even if $$C(t)>R(t)$$ would normally reduce backlog, due to the external disturbance:

$$\frac{dB(t)}{dt} = R(t) - C(t) + \eta(t)$$

If $$\eta(t)$$ is large and positive, it’s possible that $$\frac{dB(t)}{dt}>0$$.

This means **backlog $$B(t)$$ still increases** even if the system’s processing capacity $$C(t)$$ surpasses $$R(t)$$.

At this point, the Lyapunov function derivative is:

$$\dot{V}(B, \dot{B}) = 2\alpha B(t) [R(t) - C(t) + \eta(t)] + 2\beta \frac{dB(t)}{dt} [R{\prime}(t) - C{\prime}(t) + \eta{\prime}(t)]$$

- **First Term**: $$2\alpha B(t)[R(t)-C(t)+\eta(t)]$$ might be positive because of the large $$\eta(t)$$, increasing backlog.
- **Second Term**: $$2\beta \frac{dB(t)}{dt}[R^{\prime}(t)-C^{\prime}(t)+\eta^{\prime}(t)]$$ can also be positive if $$\eta^{\prime}(t)>0$$.

**Interpretation:**

- **System Instability**: $$\dot{V}(B,\dot{B})>0$$ indicates instability, backlog keeps rising.
- **Real-World Example**: A sudden easing of immigration policies causing a surge in applications. Even if USCIS increases completions, backlog still grows.
- **Long-Term Impact**: If disturbances persist, the system can’t recover on its own, requiring further intervention.

#### **Case 2: External Disturbance Small and Non-Continuous**

If $$\eta(t)$$ is small and temporary:

Once the disturbance ends, it returns to $$\frac{dB(t)}{dt}=R(t)-C(t)$$.

As long as $$C(t)>R(t)$$, $$R(t)-C(t)<0$$:

- The Lyapunov function derivative $$\dot{V}(B,\dot{B})<0$$, the system regains asymptotic stability, and the backlog decreases.

**Interpretation:**

- **Self-Recovery**: The system can return to stability after small, short-lived disturbances.
- **Real Example**: Seasonal spikes in applications that USCIS can handle without significant backlog build-up.

### Comprehensive Analysis:

1. **With External Disturbances**:
   - Large, sustained disturbances → Hard for system to recover
   - Small, short-lived disturbances → System returns to stability after they fade
2. **Without External Disturbances**:
   - If $$R(t)<C(t)$$, backlog decreases, system stable
   - If $$R(t)>C(t)$$, backlog grows, system unstable

## **Interpretation of Results:**

### **System Stability Analysis**

#### 1. Evidence of Asymptotic Stability

2023 data shows the system is stabilizing:

- Receipts and completions nearly equal (39,810 vs 39,840)
- Backlog decreased slightly (-30 cases)
- Cumulative backlog down to 13,040

These indicators show the system has reached a new equilibrium, demonstrating good asymptotic stability.

#### 2. Significant Improvement in Processing Capacity

USCIS has greatly improved efficiency over the past five years:

- Completions rose from 7,390 in 2019 to 39,840 in 2023
- Over a fourfold increase, narrowing the $$R(t)$$ and $$C(t)$$ gap

```echarts
{
   "title": {
      "text": "Improved Processing Capacity (2019-2023)",
      "left": "center"
   },
   "tooltip": {
      "trigger": "axis"
   },
   "xAxis": {
      "type": "category",
      "data": ["2019", "2020", "2021", "2022", "2023"]
   },
   "yAxis": {
      "type": "value",
      "name": "Completions"
   },
   "series": [
      {
         "name": "Completions",
         "type": "line",
         "data": [7390, 9100, 11210, 21230, 39840],
         "itemStyle": { "color": "rgba(75, 192, 192, 0.8)" },
         "lineStyle": { "width": 3 }
      }
   ]
}
```

#### 3. Enhanced Stress Resistance

Faced with a surge in applications (2022-2023), the system performed well:

- Maintained high completion volume
- Remained efficient under heavy load

```echarts
{
   "title": {
      "text": "Stress Resistance: High Volume Handling (2022-2023)",
      "left": "center"
   },
   "tooltip": {
      "trigger": "axis",
      "axisPointer": { "type": "shadow" }
   },
   "legend": {
      "top": "10%",
      "data": ["Receipts", "Completions"]
   },
   "xAxis": {
      "type": "category",
      "data": ["2022", "2023"]
   },
   "yAxis": {
      "type": "value",
      "name": "Counts"
   },
   "series": [
      {
         "name": "Receipts",
         "type": "bar",
         "stack": "Receipts",
         "data": [21990, 39810],
         "itemStyle": { "color": "rgba(54, 162, 235, 0.8)" },
         "label": {
            "show": true,
            "position": "inside",
            "formatter": "{c}"
         }
      },
      {
         "name": "Completions",
         "type": "bar",
         "stack": "Completions",
         "data": [21230, 39840],
         "itemStyle": { "color": "rgba(75, 192, 192, 0.8)" },
         "label": {
            "show": true,
            "position": "inside",
            "formatter": "{c}"
         }
      }
   ]
}
```

#### 4. Impact of Policy Changes

Policy shifts significantly affect the system:

- In 2022, big tech firms paused PERM, causing NIW receipts to surge to 21,990
- USCIS responded quickly, completing 21,230 and adding only 760 to backlog

Uncertainty in future policies remains:

- The 2024 presidential election may alter immigration policies[1]
- Tightening policy may cause a short-term spike in $$R(t)$$
- Easing policy could sustain high application volumes

These changes are sources of external disturbance $$\eta(t)$$.

```echarts
{
   "title": {
      "text": "Impact of Policy Changes",
      "left": "center"
   },
   "tooltip": {
      "trigger": "item"
   },
   "legend": {
      "top": "10%",
      "left": "center"
   },
   "series": [
      {
         "name": "Factors",
         "type": "pie",
         "radius": "50%",
         "data": [
            { "value": 40, "name": "Policy Shifts" },
            { "value": 35, "name": "Economic Changes" },
            { "value": 25, "name": "Geopolitical Factors" }
         ],
         "itemStyle": {
            "emphasis": {
               "shadowBlur": 10,
               "shadowOffsetX": 0,
               "shadowColor": "rgba(0, 0, 0, 0.5)"
            }
         }
      }
   ]
}
```

#### 5. Influence of External Environment

**Pandemic Impact**: The backlog rose in 2020-2021 due to the pandemic, impact lessened after 2022.

**Economic Fluctuations**:

- Tech layoffs increase NIW applications
- Economic recovery may restart PERM, easing NIW pressure

**Geopolitical Factors**: International tensions can spur surges in high-skilled immigration.

USCIS must adapt to maintain Lyapunov stability.

```echarts
{
   "title": {
      "text": "Backlog Evolution Under External Pressures",
      "left": "center"
   },
   "tooltip": {
      "trigger": "axis",
      "axisPointer": { "type": "shadow" }
   },
   "xAxis": {
      "type": "category",
      "data": ["2019", "2020", "2021", "2022", "2023"]
   },
   "yAxis": {
      "type": "value",
      "name": "Backlog"
   },
   "series": [
      {
         "name": "Backlog",
         "type": "line",
         "data": [5120, 8790, 12310, 13070, 13040],
         "areaStyle": { "color": "rgba(255, 159, 64, 0.3)" },
         "itemStyle": { "color": "rgba(255, 159, 64, 0.8)" }
      }
   ]
}
```

### Summary:

- **Without Disturbances**, stability depends on $$R(t)$$ and $$C(t)$$. Ensuring $$C(t)\ge R(t)$$ is key.
- **With Disturbances**, the magnitude and duration of $$\eta(t)$$ matter. Anticipating and strategizing help maintain stability.

## **Future Potential Disturbances and Stability Risks in the EB2-NIW System**

### **I. Policy and Election Influences**

#### 1. Uncertainty of the 2024 Presidential Election Outcome

Latest polls show the election between Harris and Trump, affecting immigration policy:

- **Easing Policy (Harris)**: EB2-NIW surge, $$R(t)$$ soars, potentially outstripping USCIS capacity.
- **Tightening Policy (Trump)**: Stricter scrutiny, $$C(t)$$ falls, short-term spike in $$R(t)$$.

If $$\eta(t)\gg0$$ and $$R(t)>C(t)$$, $$\dot{V}(B,\dot{B})>0$$, instability occurs. USCIS must plan ahead.

#### **II. Ripple Effects of Big Tech Companies Pausing PERM**

**Amazon and Google Pausing PERM until 2025[3]**:

- Talent shifts to NIW, $$R(t)$$ surges
- If $$C(t)$$ doesn’t rise, $$B(t)$$ grows

#### **III. Economic Fluctuations and Labor Market Shocks**

**Mass Layoffs**:

- PERM gets harder, more NIW applications
- With $$R(t)>C(t)$$ and $$\eta(t)>0$$, $$\dot{V}(B,\dot{B})>0$$ means instability

**Economic Recovery**:

- PERM resumes, $$R(t)$$ drops, aiding stability

USCIS should monitor economic indicators and optimize resources.

#### **IV. Technological and Automated Support**

Automation boosts $$C(t)$$:

- If $$C(t)\gg R(t)$$, $$\dot{V}(B,\dot{B})<0$$, system stable

#### **V. Spillover Effects of Geopolitical Tensions**

International conflicts push STEM talent to the U.S., $$R(t)$$ spikes:

- If $$R(t)\gg C(t)$$, $$\dot{V}(B,\dot{B})>0$$, temporary measures needed to boost $$C(t)$$

> #### **Summary**
>
> Recent discussions with immigration attorneys highlight the urgent need for clearer, more detailed coordination between USCIS and the Department of Labor (DOL). The surge in NIW petition filings is closely tied to factors such as big tech companies (e.g., Google and Amazon) halting PERM applications and the commencement of EB-2 Premium Processing in 2023, both of which have propelled NIW filings to new heights.
>
> To address this, USCIS and DOL should refine their division of responsibilities and share the workload more effectively, potentially allowing large tech employers to resume at least some PERM filings. After all, NIW petitions are self-petitions, intended to be initiated by the individuals themselves, rather than by companies treating employees as beneficiaries. Without reform, large tech–driven NIW submissions risk creating an unfair disadvantage for genuine self-petitioners and straining system capacity. Collaboration between USCIS and DOL is therefore vital to maintain both the integrity of the NIW process and a balanced workflow.
> {: .block-danger }

# References

1. "2024 Presidential Election Polls: Harris vs. Trump," _270toWin_, Oct. 2024. [Online]. Available: [https://www.270towin.com](https://www.270towin.com/). [Accessed: 15-Oct-2024].
2. "STEM-Related Petition Trends: EB-2 and O-1A Categories Fact Sheet FY23," _U.S. Citizenship and Immigration Services (USCIS)_, Oct. 2023. [Online]. Available: [USCIS.gov](http://uscis.gov/). [Accessed: 15-Oct-2024].
3. "Green card: Decoding why Amazon & Google suspended green card applications," _The Economic Times_, May 2024. [Online]. Available: [https://economictimes.indiatimes.com](https://economictimes.indiatimes.com/). [Accessed: 15-Oct-2024].
