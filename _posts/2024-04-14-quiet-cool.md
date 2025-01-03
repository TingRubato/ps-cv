---
layout: page
title: ML Enablement for Old Homelab
description: Charge Grandpa's Machine w/ Artificial Neural Network
date: 2024-04-14 04:30:00
thumbnail: assets/img/quietCool/image.png
tags: code IoT ML
categories: "Machine Learning"
toc:
  sidebar: left
---

## **Reading Time**

About as long as it takes your GPU fan to spin up to 100% and then ease back down as it ponders your newfound genius.

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

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/quietCool/diagram.png" title="Mechanisms" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Diagram of Adaptive Fan Speed Control: Balancing GPU Temperature and Noise with Machine Learning and Fallback Safety Mechanisms
</div>

### **Diagram Breakdown: Adaptive Fan Speed Control Logic**

The system’s adaptive fan speed control mechanism is illustrated in the diagram below. This logic leverages real-time GPU temperature data, a machine learning-based prediction model, and fallback safety mechanisms to maintain thermal stability and acoustic optimization.

#### **Key Components and Workflow**

1. GPU Machine:
   - Continuously monitors GPU temperatures and relays this data to the Fan Control Server via the sendGPUTemperature() function.
   - Serves as the primary source of real-time environmental data.
2. Fan Control Server:
   - Operates as the brain of the system, processing temperature data and orchestrating fan speed commands.
   - Implements two stages of control logic:
     - Initial Control Logic (useInitialControlLogic): Applied during the first 100 iterations to ensure basic safety and prevent overheating using predefined thresholds.
     - Prediction-Based Logic (predictFanSpeed): Once sufficient data is gathered (after 100 iterations), the server predicts optimal fan speeds using a machine learning model and validates these predictions with validateFanSpeed() to ensure reliability.
   - Logs all temperature and fan speed data into Data Storage, enabling periodic model retraining for improved accuracy.
   - Sends precise fan speed commands to the iDRAC module using sendFanSpeedCommand().
3. iDRAC Module:
   - Acts as an intermediary between the server and the physical fan hardware.
   - Receives fan speed commands and executes them by instructing the Fans Module to adjust speeds via changeFanSpeed().
4. Fans Module:
   - Physically adjusts fan speeds to regulate the GPU’s temperature based on the commands received from iDRAC.
5. Data Storage:
   - Logs operational data (e.g., temperature, fan speed, predictions) for future analysis and continuous model improvement.

#### **Safety and Adaptability**

1. If the prediction-based logic fails validation or the iteration count is below 100, a fallback mechanism (useFallbackLogic()) ensures safe fan operations, preventing system instability.
2. Machine learning models continuously adapt, balancing noise levels and thermal performance by learning from the recorded data.

### **1. Flask Server & REST API**

A lightweight Flask server listens for GPU temperature updates. POST your GPU's current temperature to `/gpu-temperature`, and the server responds with a recommended fan speed.

### **2. Temperature Monitoring Script**

A shell script (`monitor_gpu_temp.sh`) runs on the machine hosting the GPU. Every 10 seconds or so, it checks the GPU temperature and posts it to the Flask server. It's like a temperature courier, passing urgent "I'm hot" notes to the server.

### **3. Initial Control Logic**

Before machine learning enters the fray, we start simple with a piecewise function (old-fashioned if-then-else) to set fan speeds based on temperature thresholds. Under 40°C? Gentle breeze. Above 55°C? Kick it up. This baseline logic ensures we never fry the GPU while we gather training data for the ML model.

### **4. Machine Learning Model**

After collecting enough data from the baseline runs, we feed it into a machine learning model. This model predicts fan speeds and uses a custom loss function that penalizes excessive noise and unsafe temperatures. Over time, the model learns to keep the GPU cool without triggering hurricane-force fans.

---

## The Math & The Madness

### **1. Initial Control Logic**

Before we involve machine learning, we rely on a piecewise (rule-based) approach to ensure the GPU doesn’t overheat while we collect data. For example:

$$
F_{\text{init}}(T) =
\begin{cases}
10\%, & T < 40^\circ\text{C}, \\[6pt]
30\%, & 40^\circ\text{C} \le T < 55^\circ\text{C}, \\[6pt]
50\%, & T \ge 55^\circ\text{C}
\end{cases}
$$

This basic logic logs pairs of $$(T_{\text{GPU}}, \text{fan_speed})$$ . Those pairs become our initial training samples for the ML model.

### **2. Moving to a Smarter Model**

We introduce a neural network that, given a temperature , predicts an **optimal fan speed**. However, “optimal” here also depends on noise constraints, so we must include noise and temperature considerations in our training objective (loss function). The network must learn that:

1. Excessive fan speeds can mean high noise.
2. Too-low fan speeds can mean high temperatures.

**Key Insight**: The final output of our neural network is not just a single fan speed. In the code example, we produce a 3-component vector $\bigl(s, n, t\bigr)$:

- $$s$$ = predicted fan speed,

- $$v$$ = predicted noise level,

- $$n$$ = predicted temperature,

so the network can self-consistently learn to balance these outputs.

### **3. Modeling Noise From Fan Speed**

Noise often increases with fan RPM in a roughly logarithmic manner. If we know a reference noise level $N_0$ at reference $$RPM_0$$ , we can approximate noise $N_1$ at $$RPM_1$$ with:

$$N_1 \approx N_0 + K \cdot \log\!\Bigl(\frac{\text{RPM}_1}{\text{RPM}_0}\Bigr)$$

where $$K$$ is some empirical constant derived from mechanical/fan acoustic data. This gives a **differentiable** function linking fan speed to noise. Over time, you can refine this model with real measurements of noise vs. RPM.

**Note:** If you can query actual RPM via IPMI (e.g., `ipmitool sensor | grep Fan`) and measure noise directly, you can fit a more accurate function. In practice, the model can treat the predicted fan speed ($$s\%$$) as proportional to $$RPM$$ , or you can store actual readings for finer control.

### **4. Modeling Temperature From Fan Speed**

Temperature is trickier. Higher fan speeds improve cooling, but the relationship may be nonlinear, depending on system load, ambient temperature, etc. A simple approach:

1. Collect data pairs $$\bigl(f, T_{\text{GPU}}\bigr)$$
2. Fit a regression $$T(f)$$ that, for a given fan speed $$f$$ , estimates GPU temperature $$T_{GPU}$$.

Even a crude linear or polynomial model is better than nothing. As you gather more data, refine your temperature model.

### **5. Neural Network Structure**

1. **Inputs**: GPU temperature $T$.
2. **Hidden Layer**: Dense layer (size 128, ReLU activation).
3. **Outputs**: A 3-component vector $$\bigl(s, n, t\bigr)$$:

$$f(T) = \bigl(s,\,n,\,t\bigr)$$

- $$s$$ = predicted fan speed (as a percentage or a suitable scale).
- $$n$$ = predicted noise level (dB).
- $$t$$ = predicted temperature (°C).

In pseudo-math form:

$$f(T)= W_2 \,\sigma\!\bigl(W_1 \,T + b_1\bigr) \cdot b_2$$

where $\sigma$ is the ReLU activation, and $W_1, b_1, W_2, b_2$  are trainable weights.

### **6. Revised Custom Loss Function**

Our custom loss function must capture three things:

1. **Fan Speed MSE**: We compare the predicted fan speed to the _true/observed_ fan speed $$\hat{s}$$ (initially from the rule-based logic) to ensure continuity with past data:

$$\mathcal{L}_{\text{fan_speed}} = \frac{1}{N}\sum{i=1}^{N} \bigl(\hat{s}_i - s_i\bigr)^2$$

1. **Noise Penalty: We penalize noise beyond some threshold $$\text{NOISE_THRESHOLD}$$ , e.g., 80 dB:**

$$
\text{noise_penalty}_i =
\begin{cases}
\alpha_N \,\bigl(n_i - 80\bigr)^2, & n_i > 80,\\
0, & \text{otherwise}
\end{cases}
$$

This encourages predictions that keep noise under 80 dB.

1. **Temperature Penalty: We penalize predicted temperatures above some safe threshold $$\text{TEMP_THRESHOLD}$$ , e.g., 85°C:**

$$
\text{temp_penalty}_i =
\begin{cases}
\alpha_T \,\bigl(t_i - 85\bigr)^2, & t_i > 85,\\
0, & \text{otherwise}
\end{cases}
$$

Putting it all together:

$$\mathcal{L} = \underbrace{\frac{1}{N}\sum_{i=1}^{N} (\hat{s}_i - s_i)^2}_{\text{fan_speed MSE}} \;+\; \frac{1}{N}\sum_{i=1}^{N}\Bigl[\text{noise_penalty}_i + \text{temp_penalty}_i\Bigr]$$

### **7. Fan-Speed Decision Logic**

Even after training, we keep a fallback check. When a new temperature arrives:

1. **Model Prediction**: $$\bigl(s,\,n,\,t\bigr) = f(T)$$
2. **Validity Check:**

**We have a piecewise “safe range” for fan speed:**

$$
\text{is_valid_fan_speed}(T, s)=
\begin{cases}\text{True}, & \text{if } T<40 \implies 10\%\le s \le 30\%,\\\text{True}, & \text{if } 40\le T<50 \implies 30\%\le s \le 50\%,\\\dots & \dots \\\text{False}, & \text{otherwise}\end{cases}
$$

If $$s$$ is outside this range, revert to the simpler piecewise function $$F_{\text{init}}(T)$$.

1. **Set Fan Speed**: Whichever final speed we settle on gets applied via IPMI.

**Hence, the chosen fan speed is:**

$$
F(t)=
\begin{cases}
s, & \text{if is_valid_fan_speed}(T, s)=\text{True}\\
F{\text{init}}(T), & \text{otherwise}
\end{cases}
$$

### **8. Periodic Retraining**

1. **Data Collection**: Each time we set a fan speed , we log:

$$\Bigl(T(t),\,F(t),\,\text{RPM}(t),\,\text{any noise measurements}\Bigr)$$

1. **Augment**: Possibly estimate noise $\hat{n}(t)$ using the noise model, or measure it.
2. **Retrain Condition**: Every time we accumulate, say, 10 new samples (or some threshold), we update the dataset $$\{(T_i, \hat{s}_i, \hat{n}_i, \hat{t}i)\}$$ and retrain the network by minimizing:

   $$\min_{{W_1, b_1, W_2, b_2}} \mathcal{L}\Bigl(\{f(T_i)\}, \{\hat{\mathbf{y}}_i\}\Bigr)$$

3. **Iterate**: Over time, the model learns more accurate temperature/noise relationships, refining predictions.

### **Putting It All Together**

1. **Baseline**: Use a simple piecewise fan-speed logic $$\bigl(F_{\text{init}}(T)\bigr)$$ to gather initial data.
2. **Train** a neural network that outputs with a custom loss balancing fan-speed accuracy, noise penalty, and temperature penalty.
3. **Runtime**: For each new GPU temperature:
4. Predict $$\bigl(s, n, t\bigr) = f(T)$$.
5. Validate $s$ via `is_valid_fan_speed()`.
6. Either accept $s$ or fallback to the piecewise rule.
7. Log data; periodically retrain.

This architecture ensures we keep the system safe (by falling back if predictions go wild) while gradually shifting control toward an ML-driven approach. Over enough iterations, you get a **data-informed fan-speed controller** that strikes an improved balance between **noise** and **temperature** compared to naive, fixed thresholds.

## **Implementation Details**

### **Training Procedure**

1. **Data Collection**: Run the baseline piecewise logic for a while, logging (temperature, fan speed, RPM) samples. Estimate noise from RPM using the given formula and store these values.
2. **Modeling Functions**: Fit functions for $$T(f_{\text{pred}})$$ and $$N(f_{\text{pred}})$$. Even a simple regression can serve as a starting point.
3. **Integrate into Loss**: Implement the custom loss function, ensuring $$T(f_{\text{pred}})$$ and $$N(f_{\text{pred}})$$ are differentiable with respect to model parameters (if using a neural net, for example).
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

## Source Code:

### **1. monitor_gpu_temp.sh**

```bash
#!/bin/bash
# monitor_gpu_temp.sh: Script to monitor GPU temperature and send it to a remote machine

REMOTE_ADDRESS="http://your_flask_server:23333"  # Replace with your remote machine's address

get_gpu_temp() {
    nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits
}

while true; do
    TEMP=$(get_gpu_temp)
    echo "GPU Temperature: $TEMP°C"
    curl -X POST -d "temperature=$TEMP" $REMOTE_ADDRESS/gpu-temperature
    sleep 10
done
```

### **2. fan_control_server.py**

```python
import logging
import os
import pickle
import subprocess
from datetime import datetime

import numpy as np
import pandas as pd
import tensorflow as tf
from flask import Flask, jsonify, request
from tensorflow.keras.models import load_model

app = Flask(__name__)


IP_ADDRESS = "10.10.10.10"  # Replace with your iDrac address
USERNAME = "idaracusername"             # Replace with your username
PASSWORD = "idracpassword"           # Replace with your password

# Configuration files or environment variables should be used for these settings
DATA_FILE = 'gpu_fan_data.csv'
MODEL_FILE = 'fan_speed_model.h5'
LOG_FILE = 'training.log'
ITERATION_FILE = 'iteration_count.pkl'

model = None
training_status = "No training done yet"
iteration_count = 0

# Logging configuration
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(levelname)s: %(message)s', handlers=[
    logging.FileHandler(LOG_FILE),
    logging.StreamHandler(sys.stdout)
])

# Custom loss function
def custom_loss(y_true, y_pred):
    NOISE_THRESHOLD = 80.0
    TEMP_THRESHOLD = 85.0
    NOISE_PENALTY = 10.0
    TEMP_PENALTY = 20.0

    fan_speed_loss = tf.reduce_mean(tf.square(y_true[:, 0] - y_pred[:, 0]))
    noise_penalty = tf.where(y_pred[:, 1] > NOISE_THRESHOLD, NOISE_PENALTY * tf.square(y_pred[:, 1] - NOISE_THRESHOLD), 0.0)
    temp_penalty = tf.where(y_pred[:, 2] > TEMP_THRESHOLD, TEMP_PENALTY * tf.square(y_pred[:, 2] - TEMP_THRESHOLD), 0.0)

    return fan_speed_loss + tf.reduce_mean(noise_penalty + temp_penalty)

# Build model
def build_model(input_shape):
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(128, activation='relu', input_shape=(input_shape,)),
        tf.keras.layers.Dense(3)
    ])
    model.compile(optimizer='adam', loss=custom_loss)
    return model

# Load model if available
if os.path.exists(MODEL_FILE) and os.path.getsize(MODEL_FILE) > 0:
    try:
        model = load_model(MODEL_FILE, custom_objects={'custom_loss': custom_loss})
    except Exception as e:
        logging.error(f"Error loading model: {e}")

# Load data
if os.path.exists(DATA_FILE) and os.path.getsize(DATA_FILE) > 0:
    try:
        data = pd.read_csv(DATA_FILE)
    except Exception as e:
        logging.error(f"Error loading data: {e}")
        data = pd.DataFrame(columns=['timestamp', 'temperature', 'fan_speed', 'noise_level'])
else:
    data = pd.DataFrame(columns=['timestamp', 'temperature', 'fan_speed', 'noise_level'])

# Load iteration count
if os.path.exists(ITERATION_FILE) and os.path.getsize(ITERATION_FILE) > 0:
    try:
        with open(ITERATION_FILE, 'rb') as iteration_file:
            iteration_count = pickle.load(iteration_file)
    except Exception as e:
        logging.error(f"Error loading iteration count: {e}")

# Train model function
def train_model():
    global model, training_status, data
    training_status = "Training in progress"
    logging.info(training_status)

    X = data[['temperature']].values
    y = data[['fan_speed', 'noise_level', 'temperature']].values

    if model is None:
        model = build_model(1)

    model.fit(X, y, epochs=100, batch_size=10, verbose=1)
    model.save(MODEL_FILE)
    training_status = "Training completed successfully"
    logging.info(training_status)

def set_fan_speed(config, speed):
    # Convert the speed to a two-digit hexadecimal string
    hex_speed = f"{speed:02x}"

    # Create the command
    command = [
        "ipmitool",
        "-I", "lanplus",
        "-H", config["address"],
        "-U", config["username"],
        "-P", config["password"],
        "raw",
        "0x30", "0x30", "0x02", "0xff", f"0x{hex_speed}"
    ]

    # Execute the command
    subprocess.run(command, check=True)
    logging.info(f"Fan speed set to {speed}%")
    print(f"Fan speed set to {speed}%")


@app.route('/gpu-temperature', methods=['POST'])
def gpu_temperature():
    temp = int(request.form['temperature'])
    logging.info(f"Received GPU Temperature: {temp}°C")

    global model, iteration_count
    config = {
        "address": IP_ADDRESS,
        "username": USERNAME,
        "password": PASSWORD
    }

    if model:
        # Predict the fan speed using the model
        predicted_speed = model.predict(np.array([[temp]]))[0]
        fan_speed = int(predicted_speed[0])
        if not is_valid_fan_speed(temp, fan_speed):
            fan_speed = initial_control_logic(temp)
    else:
        fan_speed = initial_control_logic(temp)

    # Set fan speed
    set_fan_speed(config, fan_speed)

    # Collect and save data
    new_data = {'timestamp': datetime.now(), 'temperature': temp, 'fan_speed': fan_speed}
    global data
    data = pd.concat([data, pd.DataFrame([new_data])], ignore_index=True)
    data.to_csv(DATA_FILE, index=False)
    logging.info(f"Data saved: {new_data}")

    # Train model periodically
    if len(data) >= 10 and len(data) % 10 == 0:
        train_model()

    return "OK"

def initial_control_logic(temp):
    if temp < 40:
        return 10
    elif temp < 50:
        return 30
    elif temp < 60:
        return 50
    elif temp < 70:
        return 70
    elif temp < 80:
        return 80
    else:
        return 100

def is_valid_fan_speed(temp, fan_speed):
    if temp < 40:
        return 10 <= fan_speed <= 30
    elif temp < 50:
        return 30 <= fan_speed <= 50
    elif temp < 60:
        return 50 <= fan_speed <= 70
    elif temp < 70:
        return 70 <= fan_speed <= 80
    elif temp < 80:
        return 80 <= fan_speed <= 90
    else:
        return 90 <= fan_speed <= 100

if __name__ == '__main__':
    try:
        app.run(host='0.0.0.0', port=23333)
    except Exception as e:
        logging.error(f"Error starting Flask app: {e}")
        raise
```

## **Limitations & Future Directions**

- Improved Modeling: Current noise and temperature models are approximations. Future work could involve more accurate acoustic measurements and detailed thermal models.
- User Modes & GUIs: In the future, imagine a web interface letting you toggle “Quiet Mode” or “Performance Mode.”
- Hardware Compatibility: For now, tested on a Dell PowerEdge R720. With refinements, we could support a wide range of hardware, or even integrate sensor fusion from multiple data points.
