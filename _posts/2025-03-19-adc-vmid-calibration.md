---
layout: post
title: I Tried to Calibrate My ADC with VMID — and Ended Up Pulling VMID High
description: The author attempted to calibrate an ADC using an additional ESP32 pin to read a high-impedance midpoint voltage, but this inadvertently loaded the node, causing the voltage to drift from 1.65V to 1.95V.
date: 2025-03-19
tags: code IoT
categories: hardware
toc:
  sidebar: left
---

Sometimes the most frustrating engineering bugs are not the obvious ones—the "oh, I wired it backwards" kind.

The really maddening ones are the opposite: you think you're improving the system, and then you realize the new thing you added is the part causing the trouble.

In other words, I was trying to make the circuit smarter, and it turned out the least stable part of the whole design was the "smart" idea I had added myself.

---

## How it started: I wanted a more refined current-sensing front end

At the time, I was building a current-sensing front end with a **CT** and an **ESP32 ADC**.

Because the CT outputs an AC signal and the ESP32 ADC can only read single-supply voltages from $$0$$ to $$3.3V$$, the basic approach is pretty standard:

- Use two equal resistors as a divider
- Create a midpoint around **1.65V**
- Let the CT waveform swing around that midpoint

I called that midpoint $$V_{Mid}$$.

In theory, it was very straightforward:

$$
V_{Mid} = \frac{3.3V}{2} = 1.65V
$$

If all I wanted was "get the ADC reading the waveform," that would have been enough.

But as soon as you start wanting something a little more elegant, it becomes very easy to outsmart yourself.

My thinking at the time was basically this:

> Since $$V_{Mid}$$ is the ADC's zero reference, why not use another ESP32 pin to read $$V_{Mid}$$ directly?
> Then the software could track the real midpoint in real time instead of always assuming it was the ideal $$1.65V$$.

At the time, I honestly thought that was a pretty good idea.

It felt like I was graduating from "I got the circuit to work" to "I'm doing real calibration now."

And then the circuit gave me a very clear response:

> Yes, you are calibrating now.
> You also just created a brand-new calibration error.

---

## First, the circuit itself: on paper it looked perfectly reasonable

To make the whole failure more understandable, I should lay out the circuit first.

The funny part is that, at a glance, the schematic really did look fine.

<div class="row mt-3">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/adc-vmid/circuit-schematic.png" title="Current-sensing front end schematic" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    The current-sensing front end: CT, burden resistor, VMID divider, Schottky clamps, and RC filter into the ESP32 ADC
</div>

### 1) Sensor: CT (current transformer)

I was using a **CT, or current transformer**.

A CT does not directly give you a voltage. It gives you a **secondary current** proportional to the primary current. That means it needs a **burden resistor** to convert that current into a voltage the ADC can read.

In other words, the CT does not speak voltage by itself. You have to translate for it.

### 2) The core issue with a single-supply ADC

A CT naturally produces a signal centered around $$0V$$, but the ESP32 ADC does not read negative voltages.

Its attitude is basically:

> Anything below $$0V$$ is none of my business.

So the whole waveform has to be shifted upward and centered around a midpoint. That midpoint is $$V_{Mid}$$.

What I wanted the ADC to see was not:

$$
-0.5V \sim +0.5V
$$

but rather:

$$
1.65V - 0.5V \sim 1.65V + 0.5V
$$

which is:

$$
1.15V \sim 2.15V
$$

That keeps the entire waveform safely inside the ESP32's input range.

---

## The midpoint network looked solid enough

The core branch looked like this:

$$
3.3V \rightarrow R_1 \rightarrow V_{Mid} \rightarrow R_2 \rightarrow GND
$$

where:

- $$R_1 = 5.1k$$
- $$R_2 = 5.1k$$

With equal resistor values, the divider creates the midpoint:

$$
V_{Mid} = 1.65V
$$

To keep that midpoint from floating around too much, I also added two decoupling capacitors on $$V_{Mid}$$:

- **10uF**
- **10nF**

So that part of the circuit became:

- `3.3V -> 5.1k -> VMID -> 5.1k -> GND`
- `VMID -> 10uF -> GND`
- `VMID -> 10nF -> GND`

The job of this section was simple: create a virtual ground and make it reasonably stable.

---

## How the CT signal was connected

The CT was connected like this:

- One side to **VMID**
- One side to **RAW**

A burden resistor sat between RAW and $$V_{Mid}$$:

$$
V_{Mid} \leftrightarrow R_{burden} \leftrightarrow RAW
$$

By the time I got to final debugging, I was using:

$$
R_{burden} = 47\Omega
$$

So when the CT secondary current flowed through the burden resistor, it created a small voltage across it. That voltage was the AC signal swinging around **VMID**.

You can think of it this way:

- **VMID** is the reference midpoint
- **RAW** is the raw CT signal node

One provides the baseline, and the other carries the actual motion.

---

## I also added two things that looked pretty professional

### 1) Clamp protection

To protect the ADC in case RAW spiked too high or too low, I added two Schottky diodes:

- One to clamp RAW to **3.3V**
- One to clamp RAW to **GND**

In other words:

- `RAW -> D1 -> 3.3V`
- `GND -> D2 -> RAW`

In theory, if RAW ever went out of range, the Schottkys would step in before the ADC took the hit.

### 2) RC filtering before the ADC

RAW also did not go straight into the ADC. I put a small RC stage in front of it:

- Series resistor: **100 Ohm**
- Filter capacitor: **10nF**

So the ADC path looked like this:

- `RAW -> 100 Ohm -> ADC`
- `ADC -> 10nF -> GND`

That stage helped tame spikes and clean up some high-frequency noise.

---

## On paper, the whole design felt thoughtful

At the time, my logic looked something like this:

1. Generate **VMID** with a divider
2. Stabilize **VMID** with capacitors
3. Tie one side of the CT to **VMID**
4. Use the burden resistor to convert CT current into voltage
5. Protect RAW with Schottky diodes
6. Condition the ADC input with an RC stage
7. Use an extra ESP32 ADC pin to monitor **VMID** itself

It felt complete. It felt systematic. It felt like I was doing everything "right."

If I had shown that design to the version of myself from a few hours earlier, I probably would have said:

> Okay, this is starting to look like real engineering.

The problem is that real circuits do not care how thoughtful your schematic looks. They care whether your node is high impedance.

---

## The symptom: as soon as I connected the ESP pin, VMID started drifting

When I first measured the voltage, $$V_{Mid}$$ was not behaving the way I expected.

I thought it would sit at about:

- **1.65V**

Instead, it drifted toward:

- **1.95V**

And the most annoying part was that it did not jump there instantly.

It climbed slowly:

- It started near **1.65V**
- Then it crept upward
- Then it quietly settled around **1.95V**

That kind of bug is especially irritating because it is not obviously wrong in a dramatic way.

It is the kind of bug that makes you think:

> I know this is wrong.
> But it is wrong in such a calm, orderly way that now I'm starting to doubt myself.

That was when the real character of the bug started to emerge.

This was not a simple "the diode is backwards" failure.

It was the kind where you confidently investigate every obvious suspect, only to discover the real culprit was the helpful little feature you added yourself.

---

## I investigated it like a detective—and eventually realized the culprit was my own measurement path

What made this bug almost funny was that it really did feel like a low-budget mystery.

- There were multiple suspects
- Every suspect seemed plausible
- Every time I ruled one out, another looked even more guilty
- And in the end, the culprit was the innocent-looking "helper" I had personally invited into the design

### Phase 1: I assumed it was a routine hardware mistake

When I first saw **VMID** creeping from **1.65V** to **1.95V**, my first reaction was very practical:

> I must have wired something wrong again.

So I started checking:

- Were the divider resistors the wrong values?
- Was something wrong with the burden resistor?
- Were the Schottkys reversed?
- Was the ground bad?
- Was there a weak solder joint somewhere?
- Had I misunderstood some connection on the board?

At that point I was still calm, because I thought it was a normal bug—one I would solve with a careful review.

What actually happened was that I overestimated the power of "taking a careful look," and underestimated my own ability to create drama with a circuit board.

### Phase 2: I started suspecting the burden resistor

At one point I noticed a very misleading pattern:

- It seemed like **VMID** got weird when the burden resistor was connected
- It seemed to improve when the burden resistor was disconnected

So that ordinary little $$47\Omega$$ burden resistor suddenly became suspect number one.

In my head, it was something like:

> So it was you.
> You look like a harmless resistor, and yet somehow you're also causing midpoint drift.

But after digging further, it became clear that it was not actually the culprit.

It just happened to be present when other conditions changed.

Looking back, that phase was probably a mix of:

- Unstable contact during plugging and unplugging
- Intermittent connections
- A timing coincidence between the burden resistor and the bad behavior

So I made one of the most classic engineering mistakes there is: **I confused correlation with causation.**

### Phase 3: I started suspecting the Schottkys

Then I turned to the diodes.

That was a completely reasonable move, because Schottky diodes always seem to carry the energy of "you should probably double-check me."

<div class="row mt-3">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/adc-vmid/schottky-diodes.png" title="Schottky diode orientation check" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Checking the Schottky diode orientation during debugging
</div>

So I checked them repeatedly:

- Was the striped end of the diode tied to **3.3V** where it should be?
- Was the striped end of the other diode tied to **RAW** where it should be?

Eventually I concluded:

> They were not backwards.
> This time, at least, I had not messed up the diodes.

But even after disconnecting both D1 and D2, **VMID** still drifted toward **1.95V**.

That is the point where you enter a very specific kind of engineering frustration:

> I have seriously suspected everyone. Why is the answer still not obvious?

### Phase 4: I reached the "this makes no sense" stage

By then I had effectively ruled out:

- The divider itself
- The diode orientation
- The burden resistor as a direct cause
- The breakout board
- The CT itself

And **VMID** still rose.

What made it even worse was the way it rose:

- First it looked normal
- Then it climbed slowly
- Very politely
- Almost as if it did not want to be rude about being wrong

That "slow climb" was actually an important clue.

It told me this was not random and it was not magic. It had to be a real physical process with a time constant.

In other words:

> The circuit was not being irrational.
> I just had not understood it yet.

### Phase 5: I finally suspected the "innocent" extra ADC pin

Then I remembered the one thing I had not taken seriously enough:

> Wait. Didn't I also connect an extra ESP32 pin to read VMID directly?

That wire had felt completely harmless in my head.

It was not the power rail. Not the main signal path. Not a protection element. Not the sensor. It was just a little helper feature for "checking the midpoint while I'm at it."

In my mind, it was basically a clipboard-carrying observer standing off to the side.

What I eventually realized was this:

> It was not just observing.
> It was participating.

That was the punchline.

I had added that pin to **help calibrate** $$V_{Mid}$$, and what it actually did was disturb $$V_{Mid}$$ and then report the disturbed value back to me as if nothing had happened.

That is a very specific kind of engineering dark humor.

---

## The truth: I was not just measuring VMID—I was loading it

The key comparison was simple:

- **When VMID was not connected to the ESP32 pin, it stayed at 1.65V**
- **When I connected VMID to that pin, it started drifting upward**

At that point, the whole thing finally made sense.

The problem was not that the circuit failed to generate **1.65V**.

The problem was that the "measurement" path itself was affecting the node.

I had assumed:

> I'm only reading this point. I'm not changing it.

But what the circuit was actually telling me was:

> No—you are touching it.

That is the core of the bug.

---

## Why it happened: I treated the ADC input like an ideal multimeter

This was the classic mistake: I treated the MCU's ADC input like an ideal multimeter.

Intuitively, it is easy to think:

- The ADC input impedance is high
- So it is only reading voltage
- Therefore it should not disturb the node

But the real world is not that generous.

The ESP32 ADC input is not an infinitely high-impedance, perfectly passive observer. Internally it still has things like:

- Sample-and-hold capacitance
- Analog switches
- ESD structures
- Pin mux circuitry
- Other internal signal paths depending on configuration

So it is not just "looking" at the node. It can interact with it.

---

## And VMID itself was a soft node

Even though **VMID** was sitting at **1.65V**, it was not a buffered reference and it was not a regulator output.

It was just the midpoint of two **5.1k** resistors.

From the standpoint of the equivalent circuit, that means it was not a stiff source at all. It had a source impedance of about:

$$
5.1k \parallel 5.1k = 2.55k
$$

That means:

- It was not a low-impedance node
- It could be moved by a relatively small external load
- Even a small injected or drawn current could shift it

So the essence of the whole problem was actually very simple:

**I connected a not-very-stiff midpoint node to a measurement input that was not as passive as I imagined.**

Of course the node moved.

---

## Why it climbed slowly from 1.65V to 1.95V

This detail was actually useful, because it helped rule out a hard short.

If it had been a hard short, the voltage would have jumped immediately.

Instead, what I saw was:

- It started at the expected value
- Then it rose gradually

That told me there was a rebalancing process with a time constant.

And that made sense given the circuit already contained:

- The **10uF** capacitor on VMID
- The **10nF** capacitor on VMID
- The small capacitor in front of the ADC
- The sampling capacitor inside the ESP32 ADC

So once the ESP32 input was connected, the system found a new equilibrium.

That slow rise was not mysterious at all. It was just a very orderly physical process that I had failed to account for.

---

## What I actually got wrong

Looking back, this was not just "I picked the wrong resistor" or "I made a wiring mistake."

It was a deeper conceptual error.

I assumed that measurement was passive.

In real circuits—especially embedded ones—it usually is not.

More specifically, I made two mistakes at once:

### First, I overestimated how ideal the ADC input was

I treated it like a harmless observer.

### Second, I underestimated how fragile the midpoint node was

I treated $$V_{Mid}$$ like a solid reference.

In reality, the exact opposite was true:

- The ADC input was not perfectly harmless
- $$V_{Mid}$$ was not especially robust

Put those together, and the bug becomes almost inevitable.

---

## This was not really a dumb mistake—it was a growth-stage engineering mistake

What is interesting is that I do not actually think this was a particularly stupid mistake.

If I had taken the simplest possible approach from the start:

- Sample the ADC waveform directly
- Average the samples in software
- Treat that average as the midpoint

then I never would have fallen into this trap.

I ran into it precisely because I was trying to do something more refined:

- More precise reference measurement
- Real-time midpoint tracking
- More intentional calibration behavior

So this was not really "too clever by half."

It was more like this:

**My thinking was headed in the right direction—I had just reached the point where real components stopped behaving like ideal symbols on a schematic.**

That kind of bug is part of how engineers grow.

---

## How I handled it afterward

### Option 1: Stop measuring VMID directly

This is the approach I now prefer.

For this kind of AC sampling, the software can simply:

1. Continuously sample the ADC waveform
2. Compute the average over a window
3. Treat that average as the current **VMID**
4. Subtract that average from the instantaneous samples to recover the AC component

That is:

$$
AC[n] = ADC[n] - \mathrm{mean}(ADC)
$$

This is a very natural solution, and in practice it is more robust.

It avoids spending an extra pin on **VMID**, and it avoids letting that extra pin become a new source of error.

### Option 2: If I absolutely had to measure VMID directly

Then I would not hard-wire it straight into the ESP32 pin.

At a minimum, I would:

- Add a series isolation resistor between **VMID** and the ESP32 input
- Or buffer the node properly

If you want to observe a node like this, you first have to stop poking it so hard.

---

## If I redesigned this front end, these would be the rules

1. **VMID is a reference node, not a utility outlet**
   Do not treat it like a convenient place to connect "just one more thing."

2. **High-impedance nodes are fragile by default**
   Any midpoint created by a resistive divider should be assumed to move when loaded.

3. **ADC inputs are not ideal probes**
   Especially not MCU ADC inputs.

4. **If you need to read a reference node, isolate it or estimate it in software**
   Otherwise the measurement path itself can become the error source.

5. **Do not trust timing coincidences too quickly during debugging**
   What looks guilty may just be nearby when the real issue shows up.

---

## The biggest lesson was not that I fixed the board

The most valuable part of this was not simply learning that I should not connect that pin directly to VMID.

The real value was that I finally turned a sentence I had only seen in books into something I had experienced in my hands:

> **Measurement is not outside the circuit. Measurement is part of the circuit.**

You think you are doing something more precise, more deliberate, more engineered.

And then reality reminds you:

- Every pin has internal structure
- Every node has equivalent impedance
- Every read can alter the thing being read

That is frustrating, but it is also what makes this real engineering.

---

## The whole bug in one sentence

> **I tried to use an ESP32 ADC input to read a high-impedance VMID reference created by a 5.1k / 5.1k divider, but the ADC input itself loaded the node and pulled the midpoint from 1.65V to 1.95V.**

Or, in slightly less polite language:

> I thought I was hiring a calibration assistant, but what I actually hired was a measurement path that tampered with the evidence before reporting it back.

Or, more accurately:

> **I was not teaching the circuit anything. The circuit was teaching me.**
