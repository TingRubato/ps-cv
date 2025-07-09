---
layout: distill
title: The Journey Back to Self
description: You don't have to become someone new. You just have to become someone honest.
date: 2025-07-09 00:00:00
thumbnail: assets/img/TMC09685.jpg
toc:
    sidebar: left
bibliography: journey.bib

---

<style>
.childhood-room {
    background: linear-gradient(135deg, #667eea 0%,rgb(233, 232, 235) 100%);
    color: white;
    padding: 30px;
    border-radius: 15px;
    margin: 20px 0;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    position: relative;
    overflow: hidden;
}

.childhood-room::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -50%;
    width: 100%;
    height: 100%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
    animation: float 6s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    50% { transform: translateY(-20px) rotate(180deg); }
}

.memory-card {
    background: rgba(255, 255, 255, 0.95);
    color: #333;
    padding: 25px;
    border-radius: 12px;
    margin: 20px 0;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    border-left: 5px solid #4CAF50;
    transition: all 0.3s ease;
}

.memory-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.2);
}

.piano-keys {
    display: flex;
    justify-content: center;
    margin: 30px 0;
    height: 60px;
}

.white-key, .black-key {
    display: inline-block;
    margin: 0 1px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.white-key {
    width: 30px;
    height: 60px;
    background: white;
    border: 1px solid #ccc;
    border-radius: 0 0 5px 5px;
}

.black-key {
    width: 20px;
    height: 35px;
    background: #333;
    border-radius: 0 0 3px 3px;
    margin-left: -10px;
    margin-right: -10px;
    z-index: 2;
    position: relative;
}

.white-key:hover {
    background: #f0f8ff;
    transform: translateY(2px);
}

.black-key:hover {
    background: #555;
    transform: translateY(1px);
}

.reflection-quote {
    font-style: italic;
    font-size: 1.2em;
    text-align: center;
    margin: 30px 0;
    padding: 20px;
    background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%);
    color: white;
    border-radius: 10px;
    position: relative;
}

.reflection-quote::before {
    content: '"';
    font-size: 4em;
    position: absolute;
    top: -10px;
    left: 20px;
    opacity: 0.3;
}

.reflection-quote::after {
    content: '"';
    font-size: 4em;
    position: absolute;
    bottom: -40px;
    right: 20px;
    opacity: 0.3;
}

.courage-section {
    background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 40px;
    border-radius: 20px;
    margin: 30px 0;
    text-align: center;
}

.courage-section h3 {
    margin-bottom: 20px;
    font-size: 2em;
}

.timeline {
    position: relative;
    margin: 40px 0;
    padding: 20px 0;
}

.timeline::before {
    content: '';
    position: absolute;
    left: 50%;
    top: 0;
    bottom: 0;
    width: 2px;
    background: linear-gradient(to bottom, #667eea, #764ba2);
    transform: translateX(-50%);
}

.timeline-item {
    position: relative;
    margin: 30px 0;
    padding: 0 20px;
}

.timeline-item:nth-child(odd) {
    text-align: right;
    padding-right: 60%;
}

.timeline-item:nth-child(even) {
    text-align: left;
    padding-left: 60%;
}

.timeline-item::before {
    content: '';
    position: absolute;
    top: 20px;
    width: 15px;
    height: 15px;
    background: #667eea;
    border-radius: 50%;
    border: 3px solid white;
    box-shadow: 0 0 0 3px #667eea;
}

.timeline-item:nth-child(odd)::before {
    right: calc(50% - 7px);
}

.timeline-item:nth-child(even)::before {
    left: calc(50% - 7px);
}

.creative-highlight {
    background: linear-gradient(45deg, #ffd89b 0%, #19547b 100%);
    color: white;
    padding: 25px;
    border-radius: 15px;
    margin: 20px 0;
    text-align: center;
    font-weight: bold;
    animation: pulse 3s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.02); }
    100% { transform: scale(1); }
}

.question-box {
    background: rgba(76, 175, 80, 0.1);
    border-left: 4px solid #4CAF50;
    padding: 20px;
    margin: 20px 0;
    border-radius: 5px;
}

.question-box h4 {
    color: #4CAF50;
    margin-bottom: 10px;
}

.innovation-card {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 30px;
    border-radius: 20px;
    margin: 30px 0;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.innovation-card::before {
    content: '💡';
    font-size: 4em;
    position: absolute;
    top: 10px;
    right: 20px;
    opacity: 0.2;
    animation: twinkle 2s infinite;
}

@keyframes twinkle {
    0%, 100% { opacity: 0.2; }
    50% { opacity: 0.6; }
}

.support-network {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
    margin: 30px 0;
}

.support-card {
    background: white;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    border-top: 4px solid #667eea;
    transition: transform 0.3s ease;
}

.support-card:hover {
    transform: translateY(-5px);
}

.support-card h4 {
    color: #667eea;
    margin-bottom: 15px;
}

.final-message {
    background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%);
    color: white;
    padding: 40px;
    border-radius: 25px;
    text-align: center;
    margin: 40px 0;
    font-size: 1.1em;
    line-height: 1.6;
}

@media (max-width: 768px) {
    .timeline-item:nth-child(odd),
    .timeline-item:nth-child(even) {
        text-align: left;
        padding-left: 40px;
        padding-right: 20px;
    }
    
    .timeline::before {
        left: 20px;
    }
    
    .timeline-item::before {
        left: 13px !important;
    }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add piano key sound effects
    const keys = document.querySelectorAll('.white-key, .black-key');
    keys.forEach((key, index) => {
        key.addEventListener('click', function() {
            // Create a simple beep sound
            const audioContext = new (window.AudioContext || window.webkitAudioContext)();
            const oscillator = audioContext.createOscillator();
            const gainNode = audioContext.createGain();
            
            oscillator.connect(gainNode);
            gainNode.connect(audioContext.destination);
            
            oscillator.frequency.value = 261.63 * Math.pow(2, index / 12); // Musical note frequencies
            oscillator.type = 'sine';
            
            gainNode.gain.setValueAtTime(0.3, audioContext.currentTime);
            gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.5);
            
            oscillator.start(audioContext.currentTime);
            oscillator.stop(audioContext.currentTime + 0.5);
        });
    });
    
    // Animate timeline items on scroll
    const timelineItems = document.querySelectorAll('.timeline-item');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    });
    
    timelineItems.forEach(item => {
        item.style.opacity = '0';
        item.style.transform = 'translateY(30px)';
        item.style.transition = 'all 0.6s ease';
        observer.observe(item);
    });
});
</script>

<div class="reflection-quote">
You don't have to become someone new. You just have to become someone honest.
</div>

## The Journey Back to Self

We spend so much of our lives trying to become someone—

**Someone impressive.**  
**Someone capable.**  
**Someone the world will take seriously.**

But somewhere along the way, we start to drift—not just from our fears or failures, but from the person we once were.

Not the polished adult version, but the original one—the one who dreamed freely, felt deeply, and believed without needing proof.

<div class="childhood-room">
<strong>This isn't a story about becoming someone new.</strong><br>
It's about remembering someone old.<br>
Someone honest.<br><br>

Because sometimes, growth isn't about going forward at all.<br><br>

It's about turning back—<br>
To the one who never stopped believing in you.
</div>

---

## Unpacking memory_arxiv.zip…

<div class="memory-card">
<strong>There's this image that's been stuck in my head for years.</strong>

I must have been three or four, sitting on a tiny bench outside my preschool, watching the sky slowly turn dark.

One by one, the other children had been picked up. It was just me, a tired teacher on duty, and the quiet sound of evening settling in.

I was clutching my little backpack like it was the only thing I could hold onto, eyes fixed on the entrance—waiting for someone to take me home.

<em>I didn't know it then, but that bench would become a recurring image in my life.</em>

It was before music. Before ambition. Before I knew anything about how the world would try to shape me.

It was just that kid on the bench—waiting, feeling, hoping.
</div>

### The Piano Bench

Later, I was transferred to a different preschool. That's where the prelude began.

While other children played with Legos, I sat alone in another classroom, practicing piano.

<div class="piano-keys">
    <div class="white-key"></div>
    <div class="black-key"></div>
    <div class="white-key"></div>
    <div class="black-key"></div>
    <div class="white-key"></div>
    <div class="white-key"></div>
    <div class="black-key"></div>
    <div class="white-key"></div>
    <div class="black-key"></div>
    <div class="white-key"></div>
    <div class="black-key"></div>
    <div class="white-key"></div>
</div>

<div class="memory-card">
And strangely, for a kid with severe ADHD, the piano bench became the one bench I could actually sit on.

I didn't realize it then, but I had found something that anchored me—not because I was told to, but because my body and mind quietly said: <strong>this feels right.</strong>

It wasn't until much later that I began to believe I might've been born to do this.
</div>

---

## The Resilience of Emotional Memory

**Most people think emotions make you weak.** When I tell people about these childhood moments, I constantly hear things like:

- "How do you still remember this stuff?"
- "That was so long ago, don't overthink it."
- "You're being too sensitive."

But here's the thing – **people who remember details aren't weak. They're just living with their hearts wide open.**

<div class="creative-highlight">
Emotional memory is the one thing that survived when life hit me with its storms.
</div>

<div class="timeline">
    <div class="timeline-item">
        <h4>The Discovery</h4>
        <p>When I felt completely lost in a foreign country, my depression worsened and I had to increase my dose of Trintellix. That was the moment I started to look for myself.</p>
    </div>
    
    <div class="timeline-item">
        <h4>The Realization</h4>
        <p>It was that kid on the little bench who reminded me: <em>do you still remember what really matters?</em></p>
    </div>
    
    <div class="timeline-item">
        <h4>The Understanding</h4>
        <p>That little kid helped me realize that not growing up with professional music training doesn't cancel you from being a "musician".</p>
    </div>
    
    <div class="timeline-item">
        <h4>The Gift</h4>
        <p>I have something even professional musicians are constantly looking for: a pair of response-sensitive ears that can differentiate more frequencies.</p>
    </div>
</div>

---

## Creativity is About "Responding"

### My Engineering Journey

Later, I studied engineering—not with passion but not with hatred either. I approached it pragmatically, as a tool that might help me express myself. 

After coming here for grad school, I rebelled. And that was the most rebellious act I have ever committed in my life: **I signed up for a few courses in music school.**

<div class="memory-card">
This added around $10,000 to my tuition bill that went straight to my parents. I knew they wouldn't question anything about it since it was just another tuition bill! My friends thought I'd lost my mind.

<blockquote>
"I don't understand, you could've just went to those 'music school' that teaches piano, but why would you spend that much money especially when they charge a ridiculous amount of tuition just for a few music courses."
</blockquote>

But honestly, it wasn't rebellion. It was me knowing that this was the last chance to let that little kid version of me—who was waiting for me to keep my promise—experience and feel it so he wouldn't destroy himself internally.
</div>

### The Creative Breakthrough

<div class="innovation-card">
I learned that creativity isn't some elusive gift—it's actually quite simple. All you really need is:

<ul>
<li><strong>A spark of inspiration</strong></li>
<li><strong>A foundation of solid theory</strong></li>
</ul>

<p><em>Learning music theory won't make you Mozart, but when inspiration arrives, it gives you a roadmap for expression.</em></p>
</div>

### A Special Thanks

<div class="memory-card">
<strong>To Dr. Matthew Pace.</strong> Dr. Pace wasn't just my classical theory professor—he showed me how to manipulate music, this universal human language, to express what's inside.

I still remember one particular afternoon after class, when I stayed behind to ask him why counterpoint frustrated me so much. He paused thoughtfully, then said:

<blockquote>
"It's about how you place the notes so they behave well. You want your music to be well-behaving."
</blockquote>

At first, I smiled politely—it sounded almost too simple. But the more I thought about it, the more it reshaped how I saw everything.
</div>

---

## I Chose to Gamble, But It Wasn't Reckless

One of the earliest truths I had to confront after graduation was this: being a student had shielded me far more than I realized. Once school ended, that protection vanished—and I was left to face a brutal gap between academia and real life.

<div class="question-box">
<h4>You think I didn't know that when I threw my parents' lifetime savings into this ridiculously expensive program?</h4>

Of course I did. I saw it coming from miles away. And still—I chose to gamble.

I chose to believe that once I graduated, I'd earn in USD, that I could finally live life on my own terms, fund the things I care about, build something that felt like <em>mine</em>.
</div>

### Facing the Post-Graduation Reality

When I graduated, I had no job. My visa was expiring. And honestly? No one was sticking around for me.

- No chance at the H-1B lottery
- No solid job offer  
- OPT days vanishing, one by one

**And no—I didn't take the easy way out.**

I didn't marry some random guy for a green card. You wouldn't *believe* how many Grindr messages I got from men who thought I'd swap my soul for a USCIS receipt.

<div class="courage-section">
<h3>My gut instinct? It's razor-sharp.</h3>

<p>It's saved me more times than I can count. The moment someone locks in on me with that subtle predatory stare, I feel it before it even happens. My internal radar flares: alert, calculating, already three moves ahead, already defending.</p>
</div>

---

## Finding My Support Network

Along the way, I've been lucky—truly lucky—to cross paths with people who didn't just support me, but *saw* me.

<div class="support-network">
    <div class="support-card">
        <h4>Jim Huber</h4>
        <p>Not just my boss, but a mentor who looked beyond my immigration status and saw my worth as a thinker, a builder, a human being.</p>
    </div>
    
    <div class="support-card">
        <h4>Evonne Weinhaus</h4>
        <p>The warm, intuitive soul who recognized my potential and made the bridge to Jim happen in the first place.</p>
    </div>
</div>

<div class="memory-card">
I'll never forget the day Jim swung by Kaldi's Coffee just to talk me down from a spiral.

I remember the exact spot where we sat. I remember how Jim just sat there, quietly fidgeting with his fingers, picking at his nails in that unmistakably Jim way. His voice was soft, steady, unrushed. He said, <em>"Kelly's excited about it. Bill's excited about it. Everyone's excited about it."</em>

It wasn't some corporate pep talk. It was the way he said it—as if trying to reach a part of me that words don't usually reach.

<strong>In that moment, I wasn't just an employee. I wasn't just a visa-holder. I wasn't even just a musician clawing to stay afloat.</strong>

I was a whole person—full of contradictions, complicated emotions, and a story I couldn't carry by myself anymore.
</div>

### Bridging the Generation Gap

Speaking of Evonne—she's 82 years old. At first, I worried about the generation gap. I mean, what could someone like me possibly have in common with someone who's lived through so much more?

<div class="creative-highlight">
But now, I get what Jim meant when he said:<br>
"It's not about generations—it's about approach and methodology."
</div>

---

## Finding Your Childhood Room

<div class="childhood-room">
<strong>I want to share something important about innovation and creativity: you need to find your childhood room.</strong>

That childhood room of yours still exists, and the door isn't locked. Life got busy and growing up became stressful, so it's been far too long since anyone pushed open that door and walked in. Everything in that room is quietly waiting for you to come back.
</div>

<div class="question-box">
<h4>If you're reading this right now, do you also have one of those dusty, forgotten rooms deep in your heart?</h4>
<p>A private space that holds your earliest dreams and passions?</p>
</div>

### What's in your room?

- Maybe a set of paintbrushes that colored your imagination
- A notebook full of messy, magical stories  
- A soccer ball that once gave you wings
- A pile of building blocks that held a whole universe
- Or just a beautiful daydream you never dared to share

---

## Redefining Success — Not by Forgetting Childhood, but by Honoring It

We live in a world that constantly demands we "grow up"—a world that tells us to let go of our fantasies, to toughen up, to be realistic.

<div class="reflection-quote">
To most people, growing up means being rational—shelving anything that sounds "unrealistic."
</div>

### What Real Growth Means

I understand that the childhood version of yourself might seem foolish or embarrassing to recall now. You wanna grow out of it, I get it. But real growth doesn't mean forgetting your childhood.

**It means honoring it.**

<div class="innovation-card">
<strong>Maturity isn't about trading dreams for stability.</strong><br>
It's about learning how to hold both.<br><br>

And walking forward without betraying the kid who once dared to believe you could.
</div>

---

## Redefining Courage

When people talk about courage, they usually picture someone standing alone—facing every challenge head-on, never flinching, never asking for help.

<div class="courage-section">
<h3>But that's just one story. And it's incomplete.</h3>

<p><strong>True courage runs deeper:</strong></p>
<ul>
<li>It's the kind of strength that allows you to say, <em>"I can't do this alone."</em></li>
<li>It's the wisdom to recognize that you're not an isolated island</li>
<li>It's the quiet bravery of wanting to be seen, to be understood</li>
</ul>
</div>

---

## Reflection Questions for Your Journey

<div class="question-box">
<h4>If you've been moved by what I've shared today, take a moment to consider these three questions:</h4>

<p><strong>1. What moment did your childhood self look forward to most?</strong><br>
Maybe it was weekend cartoons, playing with friends, quietly drawing, or helping mom cook in the kitchen.</p>

<p><strong>2. In that moment, what did you feel?</strong><br>
Was it freedom? Focus? Being needed? Pure joy?</p>

<p><strong>3. Can you still find similar feelings now?</strong><br>
If yes, that's your direction. If no, that's what you need to search for.</p>
</div>

---

## You're Not Alone

<div class="support-network">
    <div class="support-card">
        <h4>When you start honestly pursuing what you truly want</h4>
        <p>You'll begin to meet others who are doing the same.</p>
    </div>
    
    <div class="support-card">
        <h4>You'll realize</h4>
        <p>You're not the only one who sat on a little bench, waiting.</p>
    </div>
    
    <div class="support-card">
        <h4>You'll find</h4>
        <p>So many people—quietly, bravely—have been searching for their own way to be seen, to be heard, to be real.</p>
    </div>
</div>

---

## Back to the Beginning

<div class="final-message">
So now, let's return to that little bench.

If tonight, just for a moment, you're willing to sit beside your younger self—not for nostalgia, but to ask honestly:

<strong>"Are you still waiting for me?"</strong>

I believe that child will look up, maybe a little teary-eyed, and whisper:

<em>"I've been waiting for you all along. I always knew you'd come back."</em>

<br><br>

<strong>Because creativity isn't just a skill. It's a response.</strong>

A response to the part of you that once sparkled without needing permission. The part of you that never asked, "Am I good enough?"—because they were too busy being alive.

<br><br>

<strong>You were never alone.</strong><br>
We've all waited on little benches.<br>
We've all longed to be picked up, seen, and taken home.<br>
And now—maybe—it's time.
</div>