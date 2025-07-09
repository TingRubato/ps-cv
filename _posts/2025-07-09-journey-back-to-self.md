---
layout: distill
title: The Journey Back to Self
description: You don't have to become someone new. You just have to become someone honest.
date: 2025-07-09
thumbnail: assets/img/TMC09685.jpg
toc:
    sidebar: left
bibliography: journey.bib
---


<style>
.childhood-room {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    //
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
    //
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
    //
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
    //
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
    //
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
    //
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


<div class="childhood-room">
## The Journey Back to Self
We spend so much of our lives striving to become *someone*—  
**Someone impressive.**  
**Someone capable.**  
**Someone the world will respect.**
But somewhere along the way, we start to drift—  
Not just from our fears or failures,  
But from the person we once were.  
Not the polished adult version,  
but the original one—  
*The one who dreamed freely, felt deeply, and believed without needing proof.*
<aside>This isn't a story about becoming someone new. It's about remembering someone old. Someone honest.</aside>
Because sometimes, growth isn't about going forward at all.  
It's about turning back—  
To the one who never stopped believing in you.  
And here's the thing:  
That person was always
</div>

<hr>

<div class="memory-card">
### Unpacking memory_arxiv.zip…
Unpacked,  
Output:  
> There's this image that's been stuck in my head for years.

I must have been three or four, sitting on a tiny bench outside my preschool, watching the sky slowly turn dark.  
One by one, the other children had been picked up. It was just me, a tired teacher on duty, and the quiet sound of evening settling in.  
I was clutching my little backpack like it was the only thing I could hold onto, eyes fixed on the entrance—waiting for someone to take me home.  
*I didn't know it then, but that bench would become a recurring image in my life.*  
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

Even then, it wasn't a "follow your dreams" moment.  
It was something deeper—like being loyal to a version of myself that hadn't yet been edited, rationalized, or "corrected" by the world.
</div>

<div class="memory-card">
### The Resilience of Emotional Memory
**Most people think emotions make you weak.** When I tell people about these childhood moments, I constantly hear things like:
- "How do you still remember this stuff?"
- "That was so long ago, don't overthink it."
- "You're being too sensitive."
But here's the thing – people who remember details aren't weak. They're just living with their hearts wide open.
</div>

<div class="memory-card">
### The Power of Emotional Memory
Emotional memory is the one thing that survived when life hit me with its storms. Later, when I felt completely lost in a foreign country with no idea who I was supposed to become, my depression got worse and I had to increase my dose of Trintellix. That was the moment I started to look for myself, and it was that kid on the little bench who reminded me,  
*do you still remember what really matters?*
So that little kid helped me realize that:
- You didn’t grow up learning music professionally does not cancel you from being a “musician”.
- You have one thing that even musicians constantly looking for, a pair of response-sensitive ears that can differentiate more frequencies
- There’s a program called music technology, and they have phd programs that WANTS engineering background student
- Even if I never became a "traditional musician," I could still use the technical language I'd learned to create and play the melodies in my heart.
- I need to take care of this body; I've neglected it for too long—without it, I'd lose my ability to make music and connect with sound. Because that ear doesn't just hear music—it hears the love inside me that I haven't yet put into words.
So having those stuff figured out, I felt like I am ripped off by pharmaceutical companies again. Because I don’t think I need to double my dose anymore but now I’m on 20mg and withdrawing takes time now. Uffff  
This is how amazing that little kid was, suicidal attempt?  
<div class="creative-highlight">
$$\tan(\frac{\pi}{2}) !$$
</div>
Wanna figure out what nerdy card I’m playing? Try use ChatGPT!
</div>
<div class="creative-highlight">
<h3>Creativity is About “Responding”</h3>
</div>

<div class="memory-card">
<h3>My Engineering Journey</h3>
Later, I studied engineering—not with passion but not with hatred either. I approached it pragmatically, as a tool that might help me express myself. After coming here for grad school, I rebelled. And that was the most rebellious act I have ever committed in my life: <br>
I signed up for a few courses in music school, which—hmm—added around $10,000 to my tuition bill that went straight to my parents. I knew they wouldn't question anything about it since it was just another tuition bill! My friends thought I'd lost my mind.<br>
<blockquote>"I don’t understand, you could’ve just went to those “music school” that teaches piano, but why would you spend that much money especially the they charge a ridiculous amount of tuition just for your a few music course."</blockquote>
But honestly, it wasn't rebellion. It was me knowing that this was the last chance to let that little kid version of me—who was waiting for me to keep my promise—experience and feel it so he wouldn't destroy himself internally.<br>
And I was right. If I hadn't done that, if I hadn't had music during those 18 months—working various jobs and often being treated poorly—I don't know how I would have survived until finally meeting Jim.<br>
I was right. That one semester finally colored my memory. I can still feel the sunny afternoons—the yellow leaves and blue skies. I even remember Professor William Lehman always wearing dark grey or blue Crocs with his suits, perpetually holding a paper espresso cup. It was a wonderful semester where I finally didn't have to struggle at night just to look smart in class. I simply came straight in with crazy but amazing ideas. You can never imagine how I felt when the girl who sat in front of me all the time said, "I would love to play this piece on my viola. I don't know how you made it, but this song is so beautiful." <br>
What truly matters is that now I can finally utilize music theory to write my side of the story. It opened another channel for me to express my emotions and feelings—to articulate the way I see this world. <br>
Being the cool guy in class felt good, but deep down I knew it was temporary. I was looking for something more profound—a way to master the language of musical notes. This universal language could be felt and understood by people from diverse backgrounds and cultures. Think about all the foreign language music you know—you can still feel if it's sad or happy, what kind of story it's telling. Is it a woman crying over a breakup?<br>
Even when I didn't understand the lyrics to Edith Piaf's "Non, Je Ne Regrette Rien" or Mercedes Sosa's passionate ballads, their emotions transcended language barriers. That's the real power of music—it speaks directly to the soul.<br>
Music was the one true international passport. While struggling to express myself in English during those early days in a new country, I could still communicate perfectly through rhythm and melody. When words failed me, musical phrases never did.<br>
I wanted to develop this ability further—to express complex emotions through sound, to tell stories that couldn't be captured in conversation. I wasn't just pursuing technical skills; I was seeking a deeper form of human connection that existed beyond the limitations of spoken language.<br>
This whole process taught me:
<blockquote><em>The best kind of innovation is realizing those little fantasies that the kid inside of you has—whether him, her, or them, well, let's just not ruin this moment by being politically correct.</em></blockquote>
</div>

<div class="creative-highlight">
<h3>The Creative Breakthrough</h3>
People often say that emotion makes you weak. But for me, emotion became the most powerful force behind everything I’ve been able to create. I learned that creativity isn’t some elusive gift—it’s actually quite simple. All you really need is:
<ul>
<li>A spark of inspiration</li>
<li>A foundation of solid theory</li>
</ul>
It wasn’t until that final semester that I truly understood what education meant to me—not just a fancy piece of paper written in legalistic English that I had to feed into ChatGPT to figure out why it was so unnecessarily abstract.<br>
But let’s go back to music.<br>
Since college, I’d always written little musical phrases—improvised clips on the keyboard that felt meaningful but never became full pieces. Just fragments. That finally changed in Dr. Matthew Pace’s classical theory class. That’s when it clicked: inspiration will come, but you have to know how to dance with it when it does.<br>
It’s bittersweet that only in the last year of my program at WashU did I begin to truly grasp the essence of learning. Up until then, I treated education as something practical—something with data points and outcomes—without understanding what it actually meant to <em>me</em>.<br>
<blockquote>Learning music theory won’t make you Mozart, but when inspiration arrives, it gives you a roadmap for expression.</blockquote>
And when the inspiration fades—when the page stays blank and the melody won’t come—music theory becomes your library. A quiet, powerful archive of timeless, proven musical languages that still move people. I came to realize that many of my creative ideas didn’t appear out of thin air—they emerged from fragments. “Incomplete phrases” that were waiting to grow into something whole. So, here, I would like to say a 
</div>

<div class="memory-card">
<h3>A Special Thanks</h3>
to Dr. Pace. Dr. Matthew Pace wasn't just my classical theory professor—he showed me how to manipulate  music, this universal human language, to express what's inside. In one semester, I wrote "Wowtz For Lunatics," something I never expected to create. <br>
Dr. Pace is an extraordinary educator—someone whose mastery of music theory is so complete that he teaches with unwavering clarity. There’s no hesitation in his voice, no performance in his presence—just calm, grounded confidence. I admire that deeply. It’s a kind of quiet strength I hope to embody one day myself. If I ever stand at the podium, I want to speak with the same steady assurance he so effortlessly radiates.<br>
But what Dr. Pace gave me went far beyond lectures, slides, or harmonic analysis. I still remember one particular afternoon after class, when I stayed behind to ask him why counterpoint frustrated me so much. I couldn’t quite articulate the disconnect I felt. He paused thoughtfully, then said:<br>
<blockquote>It’s about how you place the notes so they behave well. You want your music to be well-behaving.</blockquote>
At first, I smiled politely—it sounded almost too simple. But the more I thought about it, the more it reshaped how I saw everything.<br>
The idea of “well-behaving” notes felt like a new testament written over the old one. It wasn’t about blindly obeying the rules someone else laid down centuries ago. It was about listening closely to the logic and emotion behind those rules—to find the underlying integrity. It meant that musical choices aren’t just right or wrong; they’re ethical, emotional, intentional.<br>
Dr. Pace introduced me to a new emotional language—one that speaks across cultures and bypasses the limitations of words. Through his class, I began to realize that music isn’t just a system. It’s a form of communication, a way to feel <em>with</em> others when speaking <em>to</em> them isn’t enough.<br>
I finally translated that realization into sound in a piece called <em>Waltz for Lunatics</em>, which you can find <a href="https://music.apple.com/us/album/wowtz-for-lunatics/1659269832?i=1659269833">here</a>. It’s my attempt to let something I once kept guarded speak freely, in a language Dr. Pace helped me rediscover.<br>
<blockquote>Thank you, Dr. Pace, for allowing me to step outside the strict boundaries of classical form in my final project. You gave me the freedom to create on my own terms—while still honoring the emotional truths I had long kept guarded. Through that project, I found a way to reconnect with the earliest memories of my musical self, the child in me who once learned to feel through sound before words even made sense.</blockquote>
</div>


Later, Misha told me something about Evonne that struck me deeply: that she once had a tumor in her brain, and for nearly a decade, lost the ability to feel empathy or sympathy. Knowing that, I began to understand her compulsion to write everything down, to scatter memo notes everywhere like breadcrumbs. It wasn’t just a habit—it was a form of recovery. To me, it was about reclaiming the humanity she had once been disconnected from. She wasn’t a workaholic; she was rebuilding her inner compass.

That helped me make sense of something in myself too—why I always seem to be in a rush, why I cling to ideas as if they might slip away. I think, in some way, I’m trying to make up for all the years I wasn’t chasing what truly set me on fire. Maybe we’re all just trying to return to the place where we first felt joy, even if we have to build the road ourselves.

---

### **I Chose to Gamble, But It Wasn’t Reckless**

One of the earliest truths I had to confront after graduation was this: being a student had shielded me far more than I realized. Once school ended, that protection vanished—and I was left to face a brutal gap between academia and real life.

You think I didn’t know that when I threw my parents’ lifetime savings into this ridiculously expensive program?

Of course I did.

I saw it coming from miles away.

And still—I chose to gamble.

I chose to believe that once I graduated, I’d earn in USD, that I could finally live life on my own terms, fund the things I care about, build something that felt like *mine*.

I chose to believe that the game was fair, or at the very least—standardized. That if I worked hard, played by the rules, I’d land somewhere solid.

But I was wrong.

And with my background—rooted in China, sharpened by years of watching people across different cultures—I should’ve known better. We’re all cut from the same cloth: ambition and fear, dreams and compromise, light and shadow. The ugliest parts of human nature? They aren’t regional—they’re universal.

So here begins the darkest 18 months of my life.

### Facing the Post-Graduation Reality

When I graduated, I had no job.

My visa was expiring.

And honestly? No one was sticking around for me.

No safety net. No sponsorship. No path.

- No chance at the H-1B lottery
- No solid job offer
- OPT days vanishing, one by one

And no, I didn’t take the easy way out.

I didn’t marry some random guy for a green card.

You wouldn’t *believe* how many Grindr messages I got from men who thought I’d swap my soul for a USCIS receipt.

Painfully dull men with dead eyes and half-baked plans, who genuinely thought I’d trade a lifetime of potential for paperwork.

Like—**bruh. Really?**

No thanks.

I’m many things, but desperate isn’t one of them.

My gut instinct?

It’s razor-sharp.

It’s saved me more times than I can count. And these days, it doesn’t just whisper—it screams. The moment someone locks in on me with that subtle predatory stare, I feel it before it even happens. My internal radar flares: alert, calculating, already three moves ahead, already defending. Not because I’m paranoid—because I’ve had to be, since I really don’t believe that people will have my back.

### Standing My Ground

### Standing Up For My Worth

There’s a particular conversation I’ll never forget.

An employer from my own hometown assumed he could lowball me—
—just because of my visa situation.

He looked at my resume, heard my circumstances, and said,

"Your family must've spoiled you. I mean, you're still surviving here without income, right?"

But here's the thing:

You can't offer a salary that doesn't even cover rent in LA and expect me to say yes out of fear.

That's not resilience. That's settling.

And I didn't come this far just to shrink into survival.

Then, as if doubling down, he added:

"Sorry to be blunt, but I've never heard of WashU. It's probably not that great of a school."

That's when I knew—I wasn't just being undervalued.

I was being erased.
</div>

And that day was my 25th birthday—in lunar calendar, at least—when he essentially poured a bucket of ice water over my head. I told myself, no big deal, we celebrate the Western way anyway. The lunar calendar is just something my mom usually uses to track my birthday.

I wasn't angry that he hadn't heard of WashU. I was angry that he thought his ignorance justified exploitation. If you don't know anything about it, use **Google**. If you do know and still act that way, then it's just **ego**.

As if not knowing my background gave him the right to decide my worth—and worse, this came from someone from my own country. The very people I thought would have my back while I was alone in a foreign land.

And that's why I'm especially grateful to be working for someone like Jim.

I'm usually more than happy to share insider insights on which Chinese products are reliable and which ones aren't. I genuinely enjoy helping people make better decisions when it comes to sourcing and quality.

Sometimes, I even intentionally choose materials from China—especially when the value-to-price ratio is unbeatable.

To be honest, in the embedded systems industry, China is already incredibly mature. In fact, I'd argue that in many areas, it's ahead of the U.S.

Take PCB manufacturing, for example. To this day, I still haven't found a single U.S.-based alternative that can compete with JLCPCB—not just in terms of turnaround time, but in price. It's so goddamn affordable and efficient that nothing else even comes close.

I take pride in showcasing the best of what we make. But I'd feel genuinely embarrassed to show anyone poor-quality items that misrepresent Chinese manufacturing—especially because, more often than not, it was my own people who let me down here in the States.

### The Real Gamble

Let's go back to that moment—the real turning point.

By then, I already knew staying in the U.S. would be hard. The system isn't built for people like me to just "blend in." But *staying*—and still choosing to stand for something? That was the real gamble.

I wasn't about to shrink myself just to be tolerated. If I was going to stay, it had to mean something.

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

I remember the exact spot where we sat. I remember I even forgot that you didn't have a drink during the entire conversation. I remember what I said—and what I couldn't say.

I remember how Jim just sat there, quietly fidgeting with his fingers, picking at his nails in that unmistakably Jim way. His voice was soft, steady, unrushed. He said, <em>"Kelly's excited about it. Bill's excited about it. Everyone's excited about it."</em>

It wasn't some corporate pep talk. It was the way he said it—as if trying to reach a part of me that words don't usually reach.
</div>

And in that moment, I realized: he wasn't calming me like an adult talks down a crisis. He was comforting me the way you'd soothe a child. Because maybe he sensed what I couldn't say out loud—at that particular moment, I *had* regressed. I wasn't standing tall in my adult self. I was a scared, exhausted version of me, curled up emotionally, just trying to hold it together.

That's when it hit me:

He wasn't just being polite. He wasn't waiting to reply. He was *fully there*—no judgment, no solutions, just presence.

As he spoke with that calm clarity, I felt something shift. It wasn't about answers. It was about being seen.

Someone had finally *noticed* the quiet storm I had been carrying in silence.

<div class="courage-section">
<h3>In that moment, I wasn't just an employee.</h3>
<p>I wasn't just a visa-holder.</p>
<p>I wasn't even just a musician clawing to stay afloat.</p>
<p>I was a <strong>whole person</strong>—full of contradictions, complicated emotions, and a story I couldn't carry by myself anymore.</p>
<p>And for the first time since arriving in America, I genuinely believed: <em>I didn't have to</em>.</p>
</div>

*(Also—Jim, if you're reading this… boss, please stop picking at your nails like that. Keep it up and I'll make Misha drag you to a manicure appointment. Consider this a friendly threat.)*

### Bridging the Generation Gap

Speaking of Evonne—she's 82 years old.

At first, I worried about the generation gap. I mean, what could someone like me possibly have in common with someone who's lived through so much more?

<div class="creative-highlight">
But now, I get what Jim meant when he said:<br>
"It's not about generations—it's about approach and methodology."
</div>

The evidence speaks for itself:
- Misha had no issue with me
- Evonne had no issue with me  
- Kelly had no issue with me

So clearly, this isn't about age.

Unless... Joe is just that rare breed of human who can bridge communism and capitalism and generational divides in one lifetime? (Still trying to figure that one out, just saying he couldn't be that complicated that I can't figure out.)

*(FYI: Misha and I do have one weirdly specific thing in common—wanna guess? No, not that. Keep trying.)*

But jokes aside—I've come to realize something deeper: **I choose to feel the world with my heart and bring it to life through engineering.**

And Evonne, with her 82 years of life wisdom, saw that in me. She truly saw it.

<div class="reflection-quote">
So if you're reading this—I want you to know: Your presence means more to me than you probably realize. Your support has been more than kind—it's been healing.
</div>

It helped me break free from those intrusive flashbacks that chased me all the way from my hometown to the States... the kind that used to hijack my days out of nowhere with thoughts of his ignorant face.

**Now? I'm still here. But I'm not haunted anymore ❤️ And I don't even have to think about that**

"it was such a shame that I helped him make that much money while he was still choking me on my sponsorship"

So, if my problem is not about generation, what is it really about?

---

## Finding Your Childhood Room

I began writing this after discovering a book on shadow work. The first worksheet inspired this entire reflection. (And honestly, I'm not sure if I'm mentally prepared for the second worksheet!)

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

You don't have to write music like I do. You don't have to tell stories like someone else.

But I deeply believe—at some point in your life—you've felt that one crystal-clear moment:

---

## Redefining Success — Not by Forgetting Childhood, but by Honoring It

### Growing Beyond Childhood vs. Honoring It

We live in a world that constantly demands we "grow up"—a world that tells us to let go of our fantasies, to toughen up, to be realistic.

In that world, dreams are downgraded to hobbies, curiosity is replaced by caution, and desire is filtered through what's practical, profitable, or acceptable.

<blockquote style="border-left: 4px solid #f093fb; padding-left: 20px; font-style: italic; color: #f093fb;">
To most people, growing up means being rational—shelving anything that sounds "unrealistic."
</blockquote>

It means compromising before we even try, and quietly accepting beliefs that never truly resonated with our hearts.

But is that what we really want?

### What Real Growth Means

I understand that the childhood version of yourself might seem foolish or embarrassing to recall now. You wanna grow out of it, I get it. But real growth doesn't mean forgetting your childhood.

**It means honoring it.**

- It means remembering the promises you once made to yourself, even if no one else ever heard them.
- It means carrying that pure, unfiltered self into an adult world—and finding ways to make it real without losing what made it magical.

<div class="innovation-card">
<strong>Maturity isn't about trading dreams for stability.</strong><br>
It's about learning how to hold both.<br><br>

And walking forward without betraying the kid who once dared to believe you could.
</div>

Because the version of success I believe in? It's the one where the grown-up and the child in me both get to say: **We did it.**

On my journey, I didn't abandon engineering to pursue music out of pressure from reality, nor did I give up music to focus solely on engineering just because it felt safer or more "acceptable."

This wasn't an either-or decision. When we don't have many options, we consider thinking out of the box. In this specific moment, we are greedy. So we decided to have them all.

It was about finding a path that could hold both truths—one that could let these two worlds breathe together rather than cancel each other out.

- **Integration**: After years of searching, experimenting, and stumbling forward, I found my own way to let these seemingly opposite forces nourish one another.
- **Creation**: This isn't just peaceful coexistence—it's a kind of chemical reaction, a creative fusion that sparks new possibilities neither side could've produced alone.

Like two rivers meeting, reality gives ideals the soil, the structure, the pathways they need to take root. Ideals, in turn, give reality meaning—depth, direction, and the courage to ask why.

When we live in that blend, we're no longer lost in the clouds of idealism, nor stuck in the mud of pragmatism. Instead, we carve out a new way of being—one that's true to our hearts, yet in rhythm with the world around us.

---

## Redefining Courage

When people talk about courage, they usually picture someone standing alone—facing every challenge head-on, never flinching, never asking for help.

We glorify the lone warrior, the "self-made" hero. We're taught that real strength means carrying the weight of everything on your own.

But that's just one story. And it's incomplete.

### True courage runs deeper.

- It's the kind of strength that allows you to say, *"I can't do this alone."*
- It's the wisdom to recognize that you're not an isolated island—and that asking for support isn't a sign of weakness, but of clarity.
- It's the quiet bravery of wanting to be seen, to be understood, and to have your efforts recognized—not for applause, but because we all need to feel real in someone else's eyes.

<div class="courage-section">
<h3>This kind of courage isn't about enduring silently.</h3>
<p>It's about surviving wisely.</p>
<p>It's about choosing connection over isolation, and honesty over performance.</p>
<p>And maybe—just maybe—that's the kind of strength the world needs more of, while I haven't got the chance to build up my safety bubbles yet, so I am really sorry that I may still sometimes bug them for some extra courage to face my fear. Bruh.</p>
</div>

### Feasibility

There were times when it was hard for me to open up and ask for help.

But it was in those exact moments—when I allowed myself to be seen and supported—that I came to understand something essential:

**Your value doesn't need to be proven in isolation, over and over again.**

But it does need to be met—by people with vision, wisdom, and the willingness to recognize it.

Acknowledging this isn't weakness. It's maturity. It's accepting something real about life:

<div class="creative-highlight">
You don't grow by hiding—you grow by being met.
</div>

That's why it meant so much to me when Jim chose to "un-handcuff" me—by letting me use my own computer.

But more than that, he took time out of his day to meet me at a coffee shop, just to calm my nerves and walk me through the team dynamics.

He didn't have to. He's busy. But he showed up—fully—and stayed for hours, simply because I was feeling uneasy.

It may sound small, but to me, it was a powerful gesture.

Especially in contrast to many of the workplaces I've seen in China, where employment might end via a cold text message with no conversation at all.

Unlike the "I want it all, I want it now, and I want it perfect" mindset I've encountered before, Jim and the team understand that while my mind runs fast, it also needs space—not to slow down, but to stay clear.

By trusting me with autonomy, they've shown a rare kind of leadership: **The kind that sees who someone is—not just what they produce.**

---

## Return to the Room: Reclaiming the True Meaning of Creativity

The reason I'm writing this is because I recently stumbled upon a book on shadow work. The very first worksheet completely derailed me—and somehow led me here.

Uff. I'm honestly not even sure I'm ready for the second one. It sounds like a whole mental workout.

But it got me thinking about something I've never said out loud:

<div class="childhood-room">
<strong>Innovation and creativity aren't just for the gifted or chosen few.</strong><br>
And to truly create, we often have to return to a place most of us have long forgotten.<br><br>

<strong>We have to find our childhood room.</strong>
</div>

Yes, that room—the one that still exists somewhere deep inside, even if we haven't stepped into it for years. The door was never locked. Life just got loud. Growing up got heavy. And it's probably been far too long since anyone gently pushed that door open and walked inside.

<blockquote style="border-left: 4px solid #4CAF50; padding-left: 20px; font-style: italic; color: #4CAF50;">
But everything in that room is still there, quietly waiting.
</blockquote>

If you're reading this, I want to ask:

**Do you remember that dusty, forgotten room tucked away in your heart? That private space where your earliest dreams and purest joys still live?**

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

## Overcoming Hesitation

<blockquote style="border-left: 4px solid #FF9800; padding-left: 20px; font-style: italic; color: #FF9800;">
"But I'm scared. I'm afraid pursuing those things will make me lose what I have now."
</blockquote>

I understand that fear. I've stood at that crossroads too.

<div class="creative-highlight">
What's truly scary isn't failure – it's regret.
</div>

It's lying there when my legs don't work anymore, still thinking "what if I had…"

<blockquote style="border-left: 4px solid #f44336; padding-left: 20px; font-style: italic; color: #f44336;">
The biggest risk isn't chasing your dreams – it's never trying at all.
</blockquote>

You don't need to change everything at once. You just need to take the first step.

---

## You're Not Alone

As you begin this journey, something magical happens:

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

These people will become your support system. They'll recognize your worth, even on the days when you can't see it yourself.

And when you falter, they'll remind you:

<div class="courage-section">
<h3>You deserve to be here. You deserve to be cherished.</h3>
</div>

---

## Back to the Beginning

So now, let's return to that little bench.

If tonight, just for a moment, you're willing to sit beside your younger self—not for nostalgia, but to ask honestly:

<div class="reflection-quote">
"Are you still waiting for me?"
</div>

I believe that child will look up, maybe a little teary-eyed, and whisper:

<div class="reflection-quote">
"I've been waiting for you all along. I always knew you'd come back."
</div>

Because creativity isn't just a skill. **It's a response.**

A response to the part of you that once sparkled without needing permission. The part of you that never asked, "Am I good enough?"—because they were too busy being alive.

And when you begin to respond to that part again…

You'll realize:

<div class="final-message">
<strong>You were never alone.</strong><br><br>

We've all waited on little benches.<br>
We've all longed to be picked up, seen, and taken home.<br><br>

And now—maybe—it's time.
</div>

