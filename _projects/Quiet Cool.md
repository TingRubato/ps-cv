---
layout: page
title: QuietCool
description: Charge Grandpa's Machine w/ Artificial Neural Network
img: assets/img/quietCool/image.png
importance: 3
category: tech
toc:
  sidebar: left
---

<div class="row mt-3">
    <div class="col-sm mt-3 mt-md-0">
        {% include video.liquid path="assets/img/quietCool/ANNExplanationScene.mp4" class="img-fluid rounded z-depth-1" controls=true autoplay=true %}
    </div>
</div>
<div class="caption">
    A VIDEO OF THE MAGIC BEHIND QUIET COOL
</div>

## **Prerequisites**

Before diving headlong into this GPU fan-control escapade, you’ll want to be comfortable with:

- **Basic Python & Flask**: Enough to spin up a simple web server and handle a few REST calls.
- **System Management Tools (e.g., ipmitool)**: Know how to read fan speeds or set them via your hardware interface.
- **Linux Command Line Kung Fu**: You don’t need to be a grandmaster, but some CLI familiarity never hurts.
- **A GPU in a Server**: Preferably one that can handle a bit of experimental tinkering as you dial in those fan speeds.

[Need a Python web framework refresher? Here’s a helpful Flask guide.](https://flask.palletsprojects.com/en/stable/)

---

## **Reading Time**

About as long as it takes your GPU fan to spin up to 100% and then ease back down as it ponders your newfound genius.

---

## **Introduction**

> **The Big Chill**
>
> Picture this: You've got a GPU humming away inside your old faithful Dell PowerEdge R720—hardware that's practically a fossil. Its default fan settings? Rudimentary at best. When the GPU gets hot, the fans go full throttle, threatening to turn your homelab into a wind tunnel. There's no fancy vendor-provided fan curve, no quiet mode—just a binary choice between "whisper-quiet but toasty" or "cool but screaming like a banshee."

Enter **Quiet Cool**, a Python/Flask-based microservice that reads GPU temperatures, predicts optimal fan speeds with machine learning, and commands your fans like a serene maestro conducting a gentle breeze. You get temperature sanity and acoustic tranquility—no more wind-tunnel weekends.

---

## **Why Bother? The Problem & The Vision**

### **The Problem**

Your server's default fan logic is about as subtle as a sledgehammer. You're either cooking your GPU or listening to a jet engine test run. Neither scenario is ideal.

### **The Vision**

Quiet Cool serves as the missing link—a dynamic fan control system that fine-tunes fan speeds to keep your GPU within a comfortable thermal range without making your ears bleed. Think of it as your personal HVAC technician: it juggles temperature and noise constraints to find that sweet spot of equilibrium.

---

## **Architecture Overview: Under the Hood**

### **1. Flask Server & REST API**

A lightweight Flask server listens for GPU temperature updates. POST your GPU's current temperature to `/gpu-temperature`, and the server responds with a recommended fan speed.

### **2. Temperature Monitoring Script**

A shell script (`monitor_gpu_temp.sh`) runs on the machine hosting the GPU. Every 10 seconds or so, it checks the GPU temperature and posts it to the Flask server. It's like a temperature courier, passing urgent "I'm hot" notes to the server.

### **3. Initial Control Logic**

Before machine learning enters the fray, we start simple with a piecewise function (old-fashioned if-then-else) to set fan speeds based on temperature thresholds. Under 40°C? Gentle breeze. Above 55°C? Kick it up. This baseline logic ensures we never fry the GPU while we gather training data for the ML model.

### **4. Machine Learning Model**

After collecting enough data from the baseline runs, we feed it into a machine learning model. This model predicts fan speeds and uses a custom loss function that penalizes excessive noise and unsafe temperatures. Over time, the model learns to keep the GPU cool without triggering hurricane-force fans.

---

## **The Math & The Madness: Balancing Noise & Temperature**

### **Initial Control Logic**

We start with a piecewise approach. For example:

- If $$T_{\text{GPU}} < 40°C$$ : Fan at 10% duty cycle (or a corresponding low RPM).
- If $$40°C \leq T_{\text{GPU}} < 55°C$$: Fan at 30%.
- If $$T_{\text{GPU}} \geq 55°C$$: Fan at 50%.

This ensures the GPU won't overheat while we collect data. The logged temperature-to-fan-speed pairs become training samples for our ML model.

---

## **Implementation Details**

### **Training Procedure**

1. **Data Collection**: Run the baseline piecewise logic for a while, logging (temperature, fan speed, RPM) samples. Estimate noise from RPM using the given formula and store these values.
2. **Modeling Functions**: Fit functions for $T(f_{\text{pred}})$ and $N(f_{\text{pred}})$. Even a simple regression can serve as a starting point.
3. **Integrate into Loss**: Implement the custom loss function, ensuring $T(f_{\text{pred}})$ and $N(f_{\text{pred}})$ are differentiable with respect to model parameters (if using a neural net, for example).
4. **Train the Model**: Use gradient-based optimization to minimize the combined loss. Over iterations, the model learns to set fan speeds that strike a better balance than the naive piecewise logic.

---

> ##### **Disclaimer Experimental Territory**
>
> No warranties, no promises.
> If your fan control goes haywire or your GPU gets too toasty, remember this is all very much a DIY affair.
> Monitor closely, test slowly, and proceed at your own risk.
> {: .block-warning }

---

## **Setting It Up: From Git Clone to Gentle Breeze**

### **1. Clone the Repo & Setup Environment**

```bash
git clone https://github.com/yourusername/quiet-cool.git
cd quiet-cool
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### **2. Run the Server**

```bash
python fan_control_server.py
```

### **3. Monitor GPU Temp & Post Data**

```bash
./monitor_gpu_temp.sh
```

---

## **Limitations & Future Directions**

- Improved Modeling: Current noise and temperature models are approximations. Future work could involve more accurate acoustic measurements and detailed thermal models.
- User Modes & GUIs: In the future, imagine a web interface letting you toggle “Quiet Mode” or “Performance Mode.”
- Hardware Compatibility: For now, tested on a Dell PowerEdge R720. With refinements, we could support a wide range of hardware, or even integrate sensor fusion from multiple data points.
