---
layout: distill
title: The Journey Back to Self
description: You don't have to become someone new. You just have to become someone honest.
date: 2025-07-09
thumbnail: assets/img/TMC09685.jpg
toc:
  sidebar: left
---

<style>
  /* Base Definitions using Theme Variables */
  :root {
    --card-bg: var(--global-card-bg-color, #ffffff);
    --text-color: var(--global-text-color, #333333);
    --shadow-color: rgba(0,0,0,0.1);
    --accent-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --piano-white: #ffffff;
    --piano-black: #333333;
    --piano-white-hover: #f0f8ff;
    --piano-black-hover: #555555;
  }

  html[data-theme="dark"] {
    --shadow-color: rgba(0,0,0,0.4);
    --accent-gradient: linear-gradient(135deg, #4b5fa7 0%, #5b3a7d 100%);
    --piano-white: #e0e0e0;
    --piano-white-hover: #d0d8e0;
    --piano-black: #222222;
  }

  /* Childhood Room */
  .childhood-room {
      background: var(--accent-gradient);
      color: white; /* Keep text white on the gradient background */
      padding: 30px;
      border-radius: 15px;
      margin: 20px 0;
      box-shadow: 0 10px 30px var(--shadow-color);
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

  /* Memory Card */
  .memory-card {
      background: var(--card-bg);
      color: var(--text-color);
      padding: 25px;
      border-radius: 12px;
      margin: 20px 0;
      box-shadow: 0 8px 25px var(--shadow-color);
      border-left: 5px solid #4CAF50;
      transition: all 0.3s ease;
  }

  .memory-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px var(--shadow-color);
  }

  /* Piano Keys */
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
      background: var(--piano-white);
      border: 1px solid #ccc;
      border-radius: 0 0 5px 5px;
  }

  html[data-theme="dark"] .white-key {
    border-color: #555;
  }

  .black-key {
      width: 20px;
      height: 35px;
      background: var(--piano-black);
      border-radius: 0 0 3px 3px;
      margin-left: -10px;
      margin-right: -10px;
      z-index: 2;
      position: relative;
  }

  .white-key:hover {
      background: var(--piano-white-hover);
      transform: translateY(2px);
  }

  .black-key:hover {
      background: var(--piano-black-hover);
      transform: translateY(1px);
  }

  /* Quotes */
  .reflection-quote {
      font-style: italic;
      font-size: 1.2em;
      text-align: center;
      margin: 30px 0;
      padding: 20px;
      background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%);
      color: white; /* Ensure text is readable on gradient */
      border-radius: 10px;
      position: relative;
  }

  .reflection-quote::before, .reflection-quote::after {
      content: '"';
      font-size: 4em;
      position: absolute;
      opacity: 0.3;
      color: white;
  }
  .reflection-quote::before { top: -10px; left: 20px; }
  .reflection-quote::after { bottom: -40px; right: 20px; }

  /* Courage Section */
  .courage-section {
      background: var(--accent-gradient);
      color: white;
      padding: 40px;
      border-radius: 20px;
      margin: 30px 0;
      text-align: center;
  }

  .courage-section h3 {
      margin-bottom: 20px;
      font-size: 2em;
      color: white;
  }

  /* Timeline */
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

  .timeline-item:nth-child(odd) { text-align: right; padding-right: 60%; }
  .timeline-item:nth-child(even) { text-align: left; padding-left: 60%; }

  .timeline-item::before {
      content: '';
      position: absolute;
      top: 20px;
      width: 15px;
      height: 15px;
      background: #667eea;
      border-radius: 50%;
      border: 3px solid var(--global-bg-color); /* Match page background */
      box-shadow: 0 0 0 3px #667eea;
  }

  .timeline-item:nth-child(odd)::before { right: calc(50% - 7px); }
  .timeline-item:nth-child(even)::before { left: calc(50% - 7px); }

  /* Creative Highlight */
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

  /* Question Box */
  .question-box {
      background: rgba(76, 175, 80, 0.1);
      border-left: 4px solid #4CAF50;
      padding: 20px;
      margin: 20px 0;
      border-radius: 5px;
      color: var(--text-color);
  }
  
  html[data-theme="dark"] .question-box {
      background: rgba(76, 175, 80, 0.2); /* Slightly more visible in dark mode */
  }

  .question-box h4 {
      color: #4CAF50;
      margin-bottom: 10px;
  }

  /* Innovation Card */
  .innovation-card {
      background: var(--accent-gradient);
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

  /* Support Network */
  .support-network {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 20px;
      margin: 30px 0;
  }

  .support-card {
      background: var(--card-bg);
      color: var(--text-color);
      padding: 25px;
      border-radius: 15px;
      box-shadow: 0 5px 15px var(--shadow-color);
      border-top: 4px solid #667eea;
      transition: transform 0.3s ease;
  }

  .support-card:hover { transform: translateY(-5px); }
  .support-card h4 { color: #667eea; margin-bottom: 15px; }

  /* Final Message */
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

  /* Improved Memory Card (Custom) */
  .improved-memory-card {
    background: linear-gradient(135deg, #f8fafc 60%, #e0e7ef 100%);
    border-radius: 1.2em;
    box-shadow: 0 4px 24px rgba(60, 72, 100, 0.10), 0 1.5px 6px rgba(60, 72, 100, 0.08);
    padding: 2.2em 2em 1.5em 2em;
    margin: 2.5em 0;
    border-left: 6px solid #6c8cff;
    color: #2a3142;
  }

  html[data-theme="dark"] .improved-memory-card {
    background: linear-gradient(135deg, #2c3237 60%, #1c1c1d 100%);
    color: #e0e0e0;
    box-shadow: 0 4px 24px rgba(0, 0, 0, 0.3);
  }
  
  html[data-theme="dark"] .improved-memory-card span,
  html[data-theme="dark"] .improved-memory-card p,
  html[data-theme="dark"] .improved-memory-card ul {
      color: #e0e0e0 !important;
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
    if(window.AudioContext || window.webkitAudioContext) {
        keys.forEach((key, index) => {
            key.addEventListener('click', function() {
                try {
                    const AudioContext = window.AudioContext || window.webkitAudioContext;
                    const audioContext = new AudioContext();
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
                } catch(e) {
                    console.log("Audio context blocked or not supported");
                }
            });
        });
    }

    // Animate timeline items on scroll
    const timelineItems = document.querySelectorAll('.timeline-item');
    if('IntersectionObserver' in window) {
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
    } else {
        // Fallback for browsers without IntersectionObserver
        timelineItems.forEach(item => {
            item.style.opacity = '1';
        });
    }
});
</script>

<div class="childhood-room">
  <h2 style="margin-top:0; color:white;">The Journey Back to Self</h2>
  <p>
    We spend so much of our lives striving to become someone—<br>
    <span style="display:block; margin-left:1em;">Someone <strong>impressive</strong>.<br>
    Someone <strong>capable</strong>.<br>
    Someone the world will respect.</span>
  </p>
  <p>
    But somewhere along the way, we start to drift—<br>
    Not just from our fears or failures,<br>
    But from the person we once were.<br>
    Not the polished adult version,<br>
    <span style="font-style:italic;">but the original one—</span>
  </p>
  <p style="font-style:italic; margin-left:1em;">
    The one who dreamed freely, felt deeply, and believed without needing proof.
  </p>
  <aside style="padding:10px 16px; margin:16px 0; border-left:4px solid; background: rgba(255,255,255,0.2);">
    This isn't a story about becoming someone new. It's about remembering someone old. Someone honest.
  </aside>
  <p>
    Because sometimes, growth isn't about going forward at all.<br>
    It's about turning back—<br>
    To the one who never stopped believing in you.<br>
    <span style="display:block; margin-top:1em;">And here's the thing:</span>
    <span style="font-weight:bold;">That person was always</span>
  </p>
</div>

<hr>

<div class="memory-card">
  <h3 style="margin-top:0; font-size:1.4em; letter-spacing:0.02em;">Unpacking <span style="font-family:monospace; background:rgba(0,0,0,0.1); padding:2px 6px; border-radius:4px;">memory_arxiv.zip</span>…</h3>
  <div style="margin-bottom:0.5em;">
    <span style="font-weight:bold;">Unpacked,</span><br>
    <span style="font-style:italic;">Output:</span>
  </div>
  <blockquote style="border-left:4px solid; margin:0 0 1em 0; padding:0.5em 1em; background:rgba(0,0,0,0.05);">
    <span>There's this image that's been stuck in my head for years.</span>
  </blockquote>
  <p style="margin-bottom:0.7em;">
    I must have been <span style="font-weight:bold;">three or four</span>, sitting on a tiny bench outside my preschool, watching the sky slowly turn dark.
  </p>
  <p style="margin-bottom:0.7em;">
    One by one, the other children had been picked up. It was just me, a tired teacher on duty, and the quiet sound of evening settling in.
  </p>
  <p style="margin-bottom:0.7em;">
    I was clutching my little backpack like it was the only thing I could hold onto, eyes fixed on the entrance—<span>waiting for someone to take me home</span>.
  </p>
  <p style="font-style:italic; margin-bottom:0.7em;">
    I didn't know it then, but that bench would become a recurring image in my life.
  </p>
  <p style="margin-bottom:0.7em;">
    <span>It was before music. Before ambition. Before I knew anything about how the world would try to shape me.</span>
  </p>
  <p style="font-weight:bold;">
    It was just that kid on the bench—<span>waiting, feeling, hoping.</span>
  </p>
</div>

<h3>The Piano Bench</h3>

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

<div class="memory-card">
<h3>The Resilience of Emotional Memory</h3>
<p><strong>Most people think emotions make you weak.</strong> When I tell people about these childhood moments, I constantly hear things like:</p>
<ul>
  <li>"How do you still remember this stuff?"</li>
  <li>"That was so long ago, don't overthink it."</li>
  <li>"You're being too sensitive."</li>
</ul>
<p>But here's the thing &ndash; people who remember details aren't weak. They're just living with their hearts wide open.</p>
</div>

<div class="memory-card">
<h3>The Power of Emotional Memory</h3>
<p>
  Emotional memory is the one thing that survived when life hit me with its storms. Later, when I felt completely lost in a foreign country with no idea who I was supposed to become, my depression got worse and I had to increase my dose of Trintellix. That was the moment I started to look for myself, and it was that kid on the little bench who reminded me,<br>
  <em>do you still remember what really matters?</em>
</p>
<p>
  So that little kid helped me realize that:
</p>
<ul>
  <li>You didn’t grow up learning music professionally does not cancel you from being a “musician”.</li>
  <li>You have one thing that even musicians are constantly looking for: a pair of response-sensitive ears that can differentiate more frequencies.</li>
  <li>There’s a program called music technology, and they have PhD programs that WANT engineering background students.</li>
  <li>Even if I never became a "traditional musician," I could still use the technical language I'd learned to create and play the melodies in my heart.</li>
  <li>I need to take care of this body; I've neglected it for too long—without it, I'd lose my ability to make music and connect with sound. Because that ear doesn't just hear music—it hears the love inside me that I haven't yet put into words.</li>
</ul>
<p>
  So having those things figured out, I felt like I am ripped off by pharmaceutical companies again. Because I don’t think I need to double my dose anymore but now I’m on 20mg and withdrawing takes time now. Uffff
</p>
<p>
  This is how amazing that little kid was, suicidal attempt?
</p>
<div class="creative-highlight">
  $$\tan(\frac{\pi}{2}) !$$ 
</div>
<p>
  Wanna figure out what nerdy card I’m playing? Try use ChatGPT!
</p>
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

<h3>A Special Thanks</h3>
to Dr. Pace. Dr. Matthew Pace wasn't just my classical theory professor—he showed me how to manipulate  music, this universal human language, to express what's inside. In one semester, I wrote "Wowtz For Lunatics," something I never expected to create. <br>
Dr. Pace is an extraordinary educator—someone whose mastery of music theory is so complete that he teaches with unwavering clarity. There’s no hesitation in his voice, no performance in his presence—just calm, grounded confidence. I admire that deeply. It’s a kind of quiet strength I hope to embody one day myself. If I ever stand at the podium, I want to speak with the same steady assurance he so effortlessly radiates.<br>
But what Dr. Pace gave me went far beyond lectures, slides, or harmonic analysis. I still remember one particular afternoon after class, when I stayed behind to ask him why counterpoint frustrated me so much. I couldn’t quite articulate the disconnect I felt. He paused thoughtfully, then said:
<blockquote>It’s about how you place the notes so they behave well. You want your music to be well-behaving.</blockquote>
At first, I smiled politely—it sounded almost too simple. But the more I thought about it, the more it reshaped how I saw everything.<br>
The idea of “well-behaving” notes felt like a new testament written over the old one. It wasn’t about blindly obeying the rules someone else laid down centuries ago. It was about listening closely to the logic and emotion behind those rules—to find the underlying integrity. It meant that musical choices aren’t just right or wrong; they’re ethical, emotional, intentional.<br>
Dr. Pace introduced me to a new emotional language—one that speaks across cultures and bypasses the limitations of words. Through his class, I began to realize that music isn’t just a system. It’s a form of communication, a way to feel <em>with</em> others when speaking <em>to</em> them isn’t enough.<br>
I finally translated that realization into sound in a piece called <em>Waltz for Lunatics</em>, which you can find <a href="https://music.apple.com/us/album/wowtz-for-lunatics/1659269832?i=1659269833">here</a>. It’s my attempt to let something I once kept guarded speak freely, in a language Dr. Pace helped me rediscover.<br>
<blockquote>Thank you, Dr. Pace, for allowing me to step outside the strict boundaries of classical form in my final project. You gave me the freedom to create on my own terms—while still honoring the emotional truths I had long kept guarded. Through that project, I found a way to reconnect with the earliest memories of my musical self, the child in me who once learned to feel through sound before words even made sense.</blockquote>
---

Later, Misha told me something about Evonne that struck me deeply: that she once had a tumor in her brain, and for nearly a decade, lost the ability to feel empathy or sympathy. Knowing that, I began to understand her compulsion to write everything down, to scatter memo notes everywhere like breadcrumbs. It wasn’t just a habit—it was a form of recovery. To me, it was about reclaiming the humanity she had once been disconnected from. She wasn’t a workaholic; she was rebuilding her inner compass.

That helped me make sense of something in myself too—why I always seem to be in a rush, why I cling to ideas as if they might slip away. I think, in some way, I’m trying to make up for all the years I wasn’t chasing what truly set me on fire. Maybe we’re all just trying to return to the place where we first felt joy, even if we have to build the road ourselves.

---

<h3>I Chose to Gamble, But It Wasn’t Reckless</h3>

One of the earliest truths I had to confront after graduation was this: being a student had shielded me far more than I realized. Once school ended, that protection vanished—and I was left to face a brutal gap between academia and real life.

You think I didn’t know that when I threw my parents’ lifetime savings into this ridiculously expensive program?

Of course I did.

I saw it coming from miles away.

And still—I chose to gamble.

I chose to believe that once I graduated, I’d earn in USD, that I could finally live life on my own terms, fund the things I care about, build something that felt like mine.

I chose to believe that the game was fair, or at the very least—standardized. That if I worked hard, played by the rules, I’d land somewhere solid.

But I was wrong.

And with my background—rooted in China, sharpened by years of watching people across different cultures—I should’ve known better. We’re all cut from the same cloth: ambition and fear, dreams and compromise, light and shadow. The ugliest parts of human nature? They aren’t regional—they’re universal.

So here begins the darkest 18 months of my life.

<h3> Facing the Post-Graduation Reality</h3>

When I graduated, I had no job.

My visa was expiring.

And honestly? No one was sticking around for me.

No safety net. No sponsorship. No path.

<ul style="margin-bottom:1.2em;"> 
  <li>No chance at the <span style="font-weight:bold;"> H-1B lottery </span></li>
  <li>No solid job offer</li>
  <li>OPT days vanishing, one by one</li>
</ul>

<p>
  And no, I didn’t take the easy way out.
</p>
<p>
  I didn’t marry some random guy for a green card.
</p>

<p>
  <span style="font-style:italic;">You wouldn’t <strong>believe</strong> how many Grindr messages I got from men who thought I’d swap my soul for a USCIS receipt.</span>
</p>

<p>
  Painfully dull men with dead eyes and half-baked plans, who genuinely thought I’d trade a lifetime of potential for paperwork.
</p>

<p style="font-weight:bold; font-size:1.1em;">
  Like—<span style="font-size:1.2em;">bruh. Really?</span>
</p>

No thanks.

I’m many things, but desperate isn’t one of them.

My gut instinct?

It’s razor-sharp.

It’s saved me more times than I can count. And these days, it doesn’t just whisper—it screams. The moment someone locks in on me with that subtle predatory stare, I feel it before it even happens. My internal radar flares: alert, calculating, already three moves ahead, already defending. Not because I’m paranoid—because I’ve had to be, since I really don’t believe that people will have my back.

<h3>Standing My Ground</h3>

<h3 style="margin-top:1.5em; letter-spacing:0.01em;">Standing Up For My Worth</h3>

<p>
  There’s a particular conversation I’ll never forget.
</p>

<div style="background:linear-gradient(90deg, rgba(249,246,255,0.5) 80%, rgba(255,251,231,0.5) 100%); border-left:5px solid #764ba2; border-radius:8px; padding:18px 22px; margin:20px 0;">
  <p style="margin-bottom:0.7em;">
    <span style="font-weight:bold;">An employer from my own hometown</span> assumed he could <span style="font-style:italic;">lowball me</span>—<br>
    <span style="margin-left:1.2em; display:block;">just because of my visa situation.</span>
  </p>
  <p style="margin-bottom:0.7em;">
    He looked at my resume, heard my circumstances, and said,
  </p>
  <blockquote style="border-left:4px solid var(--global-text-color-light); margin:0 0 1em 0; padding:0.5em 1em; background:rgba(0,0,0,0.05); font-size:1.05em;">
    "Your family must've spoiled you. I mean, you're still surviving here without income, right?"
  </blockquote>
</div>
<p style="font-weight:bold; margin-top:1em; font-size:1.08em;">
  But here's the thing:
</p>
<p>
  You can't offer a salary that doesn't even cover rent in LA and expect me to say yes out of fear.
</p>
<p style="font-style:italic; margin-bottom:0.7em;">
  That's not resilience. That's settling.
</p>
<p>
  And I didn't come this far just to shrink into survival.
</p>
<div style="background:linear-gradient(90deg, rgba(255,251,231,0.5) 80%, rgba(249,246,255,0.5) 100%); border-left:5px solid #ffd89b; border-radius:8px; padding:16px 20px; margin:20px 0;">
  <p style="margin-bottom:0.7em;">
    Then, as if doubling down, he added:
  </p>
  <blockquote style="border-left:4px solid var(--global-text-color-light); margin:0 0 1em 0; padding:0.5em 1em; background:rgba(0,0,0,0.05); font-size:1.05em;">
    "Sorry to be blunt, but I've never heard of WashU. It's probably not that great of a school."
  </blockquote>
</div>
<style>
  .erased-container {
    /* Add margin or padding as needed */
  }
  .erased-main {
    font-weight: bold;
    color: #b23a48;
    font-size: 1.13em;
    letter-spacing: 0.01em;
  }
  .erased-highlight {
    color: #764ba2;
    background: rgba(118,75,162,0.1);
    border-radius: 4px;
    padding: 2px 6px;
  }
</style>
<div class="erased-container">
  <p class="erased-main">
    That's when I knew—I wasn't just being undervalued.<br>
    <span class="erased-highlight">I was being erased.</span>
  </p>
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

<h3> The Real Gamble</h3>

Let's go back to that moment—the real turning point.

By then, I already knew staying in the U.S. would be hard. The system isn't built for people like me to just "blend in." But _staying_—and still choosing to stand for something? That was the real gamble.

I wasn't about to shrink myself just to be tolerated. If I was going to stay, it had to mean something.

---

<h2> Finding My Support Network</h2>

Along the way, I've been lucky—truly lucky—to cross paths with people who didn't just support me, but _saw_ me.

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

<div class="improved-memory-card">
  <p style="font-size: 1.13em; line-height: 1.7; margin-bottom: 1.1em;">
    <span style="font-weight: 600; color: #4b5fa7;">I'll never forget</span> the day Jim swung by <span style="color: #7a869a;">Kaldi's Coffee</span>
    <aside style="display: inline; font-size: 0.93em; color: #9ba6b8;">(the Ladue location<sup><a href="https://kaldiscoffee.com/pages/kaldis-coffee-at-ladue" target="_blank" style="color: #b3c6f7; text-decoration: none;">[1]</a></sup>)</aside>
    just to talk me down from a spiral.
  </p>
  <ul style="list-style: disc inside; margin: 0 0 1.1em 0.5em; padding: 0;">
    <li>I remember the exact spot where we sat.</li>
    <li>I even forgot that you didn't have a drink during the entire conversation.</li>
    <li>I remember what I said—and what I couldn't say.</li>
  </ul>
  <p style="margin-bottom: 1em;">
    I remember how Jim just sat there, quietly fidgeting with his fingers, picking at his nails in that unmistakably Jim way.
    <br>
    <span style="color: #5a6bb7; font-style: italic; font-size: 1.08em;">
      His voice was soft, steady, unrushed.
    </span>
    <br>
    He said,
    <span style="display: block; margin: 0.7em 0 0.7em 1.2em; padding-left: 0.7em; border-left: 3px solid #b3c6f7; font-style: italic; font-size: 1.08em;">
      "Kelly's excited about it. Bill's excited about it. Everyone's excited about it."
    </span>
  </p>
  <p style="color: #4b5fa7; font-weight: 500; margin-bottom: 0;">
    It wasn't some corporate pep talk. It was the way he said it—as if trying to reach a part of me that words don't usually reach.
  </p>
</div>

And in that moment, I realized: he wasn't calming me like an adult talks down a crisis. He was comforting me the way you'd soothe a child. Because maybe he sensed what I couldn't say out loud—at that particular moment, I <em>had</em> regressed. I wasn't standing tall in my adult self. I was a scared, exhausted version of me, curled up emotionally, just trying to hold it together.

That's when it hit me:

He wasn't just being polite. He wasn't waiting to reply. He was <em>fully there</em>—no judgment, no solutions, just presence.

As he spoke with that calm clarity, I felt something shift. It wasn't about answers. It was about being heard.

Someone had finally <em>noticed</em> the quiet storm I had been carrying in silence.

<div class="courage-section">
<h3>In that moment, I wasn't just an employee.</h3>
<p>His not trying to push me to do anything that I was not comfortable.</p>
<p>I was not some cheap labor on a temporary visa.</p>
<p>I wasn't even just a musician clawing to stay afloat.</p>
<p>You know for the first time that I felt, we could work something out together and you dont have to do that all alone. </p>
<p>I was a <strong>whole person</strong>—full of contradictions, complicated emotions, and a story I couldn't carry by myself anymore.</p>
<p>And for the first time since arriving in America, I genuinely believed: <em>I didn't have to</em>.</p>
</div>

<p style="font-style: italic; color: #5a6bb7; margin-top: 1.2em;">
  (Also—Jim, if you're reading this… boss, please stop picking at your nails like that. Keep it up and I'll make Misha drag you to a manicure appointment. Consider this a friendly threat.)
</p>

<h3>Bridging the Generation Gap</h3>

Speaking of Evonne—she's 82 years old.

At first, I worried about the generation gap. I mean, what could someone like me possibly have in common with someone who's lived through so much more?

<div class="creative-highlight">
But now, I get what Jim meant when he said:
"It's not about generations—it's about approach and methodology."
</div>

The evidence speaks for itself:

<ul>
  <li>Misha had no issue with me</li>
  <li>Evonne had no issue with me</li>
  <li>Kelly had no issue with me</li>
</ul>
So clearly, this isn't about age.

Unless... Joe is just that rare breed of human who can bridge communism and capitalism and generational divides in one lifetime? (Still trying to figure that one out, just saying he couldn't be that complicated that I can't figure out.)

_(FYI: Misha and I do have one weirdly specific thing in common—wanna guess? No, not that. Keep trying.)_

But jokes aside—I've come to realize something deeper: I choose to feel the world with my heart and bring it to life through engineering.

And Evonne, with her 82 years of life wisdom, saw that in me. She truly saw it.

<div class="reflection-quote">
So if you're reading this—I want you to know: Your presence means more to me than you probably realize. Your support has been more than kind—it's been healing.
</div>

It helped me break free from those intrusive flashbacks that chased me all the way from my hometown to the States... the kind that used to hijack my days out of nowhere with thoughts of his ignorant face.

Now? I'm still here. But I'm not haunted anymore ❤️ And I don't even have to think about that

"it was such a shame that I helped him make that much money while he was still choking me on my sponsorship"

So, if my problem is not about generation, what is it really about?

---

<h2>Finding Your Childhood Room</h2>

I began writing this after discovering a book on shadow work. The first worksheet inspired this entire reflection. (And honestly, I'm not sure if I'm mentally prepared for the second worksheet!)

<div class="childhood-room">
<strong>I want to share something important about innovation and creativity: you need to find your childhood room.</strong>
That childhood room of yours still exists, and the door isn't locked. Life got busy and growing up became stressful, so it's been far too long since anyone pushed open that door and walked in. Everything in that room is quietly waiting for you to come back.
</div>

<div class="question-box">
<h4>If you're reading this right now, do you also have one of those dusty, forgotten rooms deep in your heart?</h4>
<p>A private space that holds your earliest dreams and passions?</p>
</div>

<h2>What's in your room?</h2>

<ul>
  <li>Maybe a set of paintbrushes that colored your imagination</li>
  <li>A notebook full of messy, magical stories</li>
  <li>A soccer ball that once gave you wings</li>
  <li>A pile of building blocks that held a whole universe</li>
  <li>Or just a beautiful daydream you never dared to share</li>
</ul>

You don't have to write music like I do. You don't have to tell stories like someone else.

But I deeply believe—at some point in your life—you've felt that one crystal-clear moment:

---

<h2>Redefining Success — Not by Forgetting Childhood, but by Honoring It</h2>

<h3>Growing Beyond Childhood vs. Honoring It</h3>

We live in a world that constantly demands we "grow up"—a world that constantly tells us to let go of our fantasies, to toughen up, to be realistic.

In that world, dreams are downgraded to hobbies, curiosity is replaced by caution, and desire is filtered through what's practical, profitable, or acceptable.

<blockquote style="border-left: 4px solid #f093fb; padding-left: 20px; font-style: italic; color: #f093fb;">
To most people, growing up means being rational—shelving anything that sounds "unrealistic."
</blockquote>

It means compromising before we even try, and quietly accepting beliefs that never truly resonated with our hearts.

But is that what we really want?

<h3>What Real Growth Means</h3>

<p>I understand that the childhood version of yourself might seem foolish or embarrassing to recall now. You want to grow out of it, I get it. But real growth doesn't mean forgetting your childhood.</p>

<p><strong>It means honoring it.</strong></p>

<ul>
  <li>It means remembering the promises you once made to yourself, even if no one else ever heard them.</li>
  <li>It means carrying that pure, unfiltered self into an adult world—and finding ways to make it real without losing what made it magical.</li>
</ul>

<div class="innovation-card">
<strong>Growing up isn't about trading dreams for a life.</strong><br>
<br>
It's about learning how to hold both.<br>
And walking forward without betraying the kid who once dared to believe you could.
</div>

<p>Because the version of success I believe in? It's the one where the grown-up and the child in me both get to say: <strong>We did it.</strong></p>

<p>On my journey, I didn't abandon engineering to pursue music out of pressure from reality, nor did I give up music to focus solely on engineering just because it felt safer or more "acceptable."</p>

<p>This wasn't an either-or decision. When we don't have many options, we consider thinking out of the box. In this specific moment, we are greedy. So we decided to have them all.</p>

<p>It was about finding a path that could hold both truths—one that could let these two worlds breathe together rather than cancel each other out.</p>

<ul>
  <li><strong>Integration</strong>: After years of searching, experimenting, and stumbling forward, I found my own way to let these seemingly opposite forces nourish one another.</li>
  <li><strong>Creation</strong>: This isn't just peaceful coexistence—it's a kind of chemical reaction, a creative fusion that sparks new possibilities neither side could've produced alone.</li>
</ul>

<p>Like two rivers meeting, reality gives ideals the soil, the structure, the pathways they need to take root. Ideals, in turn, give reality meaning—depth, direction, and the courage to ask why.</p>

<p>When we live in that blend, we're no longer lost in the clouds of idealism, nor stuck in the mud of pragmatism. Instead, we carve out a new way of being—one that's true to our hearts, yet in rhythm with the world around us.</p>

---

<h2>Redefining Courage</h2>

<p>When people talk about courage, they usually picture someone standing alone—facing every challenge head-on, never flinching, never asking for help.</p>

<p>We glorify the lone warrior, the "self-made" hero. We're taught that real strength means carrying the weight of everything on your own.</p>

<p>But that's just one story. And it's incomplete.</p>

<h3>True courage runs deeper.</h3>

<ul>
  <li>It's the kind of strength that allows you to say, <em>"I can't do this alone."</em></li>
  <li>It's the wisdom to recognize that you're not an isolated island—and that asking for support isn't a sign of weakness, but of clarity.</li>
  <li>It's the quiet bravery of wanting to be seen, to be understood, and to have your efforts recognized—not for applause, but because we all need to feel real in someone else's eyes.</li>
</ul>

<div class="courage-section">
<h3>This kind of courage isn't about enduring silently.</h3>
<p>It's about surviving wisely.</p>
<p>It's about choosing connection over isolation, and honesty over performance.</p>
<p>And maybe—just maybe—that's the kind of strength the world needs more of, while I haven't got the chance to build up my safety bubbles yet, so I am really sorry that I may still sometimes bug them for some extra courage to face my fear. Bruh.</p>
</div>

<h3>Feasibility</h3>

<p>There were times when it was hard for me to open up and ask for help.</p>

<p>But it was in those exact moments—when I allowed myself to be seen and supported—that I came to understand something essential:</p>

<p><strong>Your value doesn't need to be proven in isolation, over and over again.</strong></p>

<p>But it does need to be met—by people with vision, wisdom, and the willingness to recognize it.</p>

<p>Acknowledging this isn't weakness. It's growing up. It's accepting something real about life:</p>
<div class="creative-highlight">
You don't grow by hiding—you grow by being met.
</div>

<div>
  <p>That's why it meant so much to me when Jim chose to <span style="font-style: italic;">"un-handcuff"</span> me—by letting me use my own computer.</p>

  <p>But more than that, he took time out of his day to meet me at a coffee shop, just to calm my nerves and walk me through the team dynamics.</p>

  <p>He didn't have to. He's busy. But he showed up—fully—and stayed for hours, simply because I was feeling uneasy.</p>

  <p>It may sound small, but to me, it was a powerful gesture.</p>

  <p>Especially in contrast to many of the workplaces I've seen in China, where employment might end via a cold text message with no conversation at all.</p>

  <p>Unlike the <span style="font-style: italic;">"I want it all, I want it now, and I want it perfect"</span> mindset I've encountered before, Jim and the team understand that while my mind runs fast, it also needs space—not to slow down, but to stay clear.</p>

  <p>By trusting me with autonomy, they demonstrated a rare kind of leadership—the kind that sees a person not just for what they produce, but for who they are: imperfect, in need of support, and still worthy of trust.</p>
</div>

---

<h2>Return to the Room: Reclaiming the True Meaning of Creativity</h2>

<p>
  The reason I'm writing this is because I recently stumbled upon a book on shadow work. The very first worksheet completely derailed me—and somehow led me here.
</p>

<p>
  Uff. I'm honestly not even sure I'm ready for the second one. It sounds like a whole mental workout.
</p>

<p>
  But it got me thinking about something I've never said out loud:
</p>

<div class="childhood-room">
<strong>Innovation and creativity aren't just for the gifted or chosen few.</strong><br>
And to truly create, we often have to return to a place most of us have long forgotten.<br><br>

<strong>We have to find our childhood room.</strong>

</div>

Yes, that room—the one that still exists somewhere deep inside, even if we haven't stepped into it for years. The door was never locked. Life just got busy. Growing up got heavy. And it's probably been far too long since anyone gently pushed that door open and walked inside.

<blockquote style="border-left: 4px solid #4CAF50; padding-left: 20px; font-style: italic; color: #4CAF50;">
But everything in that room is still there, quietly waiting.
</blockquote>

If you're reading this, I want to ask:

<p><strong>Do you remember that dusty, forgotten room tucked away in your heart? That private space where your earliest dreams and purest joys still live?</strong></p>

---

<h2>Reflection Questions for Your Journey</h2>

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

<section class="overcoming-hesitation" style="margin: 2.5em 0;">
  <h2 style="color: #e65100; font-size: 2em; font-weight: 700; margin-bottom: 1em;">Overcoming Hesitation</h2>

  <blockquote style="border-left: 4px solid #FF9800; padding: 1em 1.5em; background: rgba(255, 152, 0, 0.1); font-style: italic; color: #b26a00; border-radius: 6px; margin-bottom: 1.5em;">
    "But I'm scared. I'm afraid pursuing those things will make me lose what I have now."
  </blockquote>

  <p style="font-size: 1.08em; margin-bottom: 1.1em;">
    I understand that fear. I've stood at that crossroads too.
  </p>

  <div class="creative-highlight" style="background: rgba(142, 36, 170, 0.1); border-left: 5px solid #8e24aa; border-radius: 7px; padding: 1em 1.5em; margin-bottom: 1.2em; color: #4a148c; font-weight: 500;">
    What really scares me isn’t the impossible—it’s regret.
  </div>

  <p style="margin-bottom: 1.1em;">
    It’s lying there when my hands don’t work anymore, still thinking, <span style="color:#8e24aa; font-style:italic;">“What if I hadn’t hesitated to enroll in MUS121C?”</span>
  </p>

  <blockquote style="border-left: 4px solid #f44336; padding: 1em 1.5em; background: rgba(244, 67, 54, 0.1); font-style: italic; color: #b71c1c; border-radius: 6px; margin-bottom: 1.5em;">
    The biggest risk isn’t chasing your dreams—it’s never trying at all.
  </blockquote>

  <p style="font-size: 1.08em; margin-bottom: 1.2em;">
    You don’t need to change everything at once. You just need to take the first step. As you begin this journey, something magical happens:
  </p>

  <section class="support-network" style="margin: 2em 0 2.5em 0;">
    <div class="connection-card" style="background: rgba(76, 175, 80, 0.1); border-left: 5px solid #4CAF50; border-radius: 7px; padding: 1.2em 1.5em 1.1em 1.5em; margin-bottom: 1.1em;">
      <div class="connection-title" style="font-weight: 600; color: #388e3c; font-size: 1.13em; margin-bottom: 0.3em;">
        When you begin to move toward what you truly want,
      </div>
      <div class="connection-body" style="font-size: 1.04em;">
        you’ll notice others quietly stepping out too—drawn by the same longing.
      </div>
    </div>
    <div class="connection-card" style="background: rgba(76, 175, 80, 0.1); border-left: 5px solid #4CAF50; border-radius: 7px; padding: 1.2em 1.5em 1.1em 1.5em; margin-bottom: 1.1em;">
      <div class="connection-title" style="font-weight: 600; color: #388e3c; font-size: 1.13em; margin-bottom: 0.3em;">
        You’ll realize
      </div>
      <div class="connection-body" style="font-size: 1.04em;">
        you were never the only one waiting on that little bench.
      </div>
    </div>
    <div class="connection-card" style="background: rgba(76, 175, 80, 0.1); border-left: 5px solid #4CAF50; border-radius: 7px; padding: 1.2em 1.5em 1.1em 1.5em;">
      <div class="connection-title" style="font-weight: 600; color: #388e3c; font-size: 1.13em; margin-bottom: 0.3em;">
        You’ll find
      </div>
      <div class="connection-body" style="font-size: 1.04em;">
        so many people—gentle, brave—searching for their own way to be seen, to be heard, to be real.
      </div>
    </div>
    <div class="support-message" style="margin: 1.7em 0 1.2em 0; font-size: 1.07em;">
      These people become your support system. They’ll see your worth, even on days you can’t.
    </div>
    <div class="courage-section" style="background: rgba(255, 152, 0, 0.15); border-left: 5px solid #FF9800; border-radius: 7px; padding: 1.1em 1.5em 1em 1.5em; margin-bottom: 1.2em;">
      <h3 style="margin: 0; color: #e65100; font-size: 1.18em; font-weight: 600;">
        You deserve to be here.<br>
        You deserve to be cherished.
      </h3>
    </div>
  </section>

  <h2 style="color: #6a4cff; font-size: 2em; font-weight: 700; margin-bottom: 1em;">Back to the Beginning</h2>
  <p style="font-size: 1.08em; margin-bottom: 1.1em;">
    So now, let’s return to that little bench.
    <br>
    If tonight, just for a moment, you’re willing to sit beside your younger self—not for nostalgia, but to ask honestly:
  </p>
  <div class="reflection-quote" style="font-style: italic; color: #6a4cff; background: rgba(106, 76, 255, 0.1); border-radius: 6px; padding: 1em 1.5em; margin: 1.2em 0;">
    "Are you still waiting for me?"
  </div>
  <p style="font-size: 1.08em; margin-bottom: 1.1em;">
    I believe that child will look up, maybe a little teary-eyed, and whisper:
  </p>
  <div class="reflection-quote" style="font-style: italic; color: #e67e22; background: rgba(230, 126, 34, 0.1); border-radius: 6px; padding: 1em 1.5em; margin: 1.2em 0;">
    "I've been waiting for you all along. I always knew you'd come back."
  </div>

  <p class="creativity-explanation" style="margin-bottom: 1.5em; font-size: 1.12em; line-height: 1.7;">
    Because creativity isn’t just a skill. It’s a
    <span style="font-weight: bold; color: #6a4cff;">response</span>—an emotional impulse, a resonance waiting for the right signal.
  </p>

  <p class="sparkle-explanation" style="margin-bottom: 1.2em; font-size: 1.1em;">
    A response to the part of you that once
    <span style="color: #e67e22; font-style: italic;">sparkled</span>—without needing permission. The part that never asked,
    <span style="color: #888;">“Am I good enough?”</span> because it was too busy simply being alive.
  </p>

  <p class="shift-explanation" style="margin-bottom: 1.2em; font-size: 1.1em;">
    And when you start responding to that part again…<br>
    <span style="color: #888;">something begins to shift.</span> Quietly at first—<br>
    but undeniably, the signal returns.
  </p>

  <p class="realization" style="margin-top: 2em;">
    <span style="font-size: 1.1em; color: #6a4cff;"><em>You’ll realize:</em></span>
  </p>

  <div class="final-message" style="background: rgba(106, 76, 255, 0.05); border-left: 5px solid #6a4cff; border-radius: 8px; padding: 1.5em 1.5em 1.2em 1.5em; margin-top: 1.2em;">
    <strong style="color: #6a4cff; font-size: 1.25em;">You were never alone.</strong><br><br>
    <span style="color: var(--text-color);">We’ve all waited on little benches.<br>
    We’ve all longed to be picked up, seen, and taken home.</span><br><br>
    <span style="font-weight: bold; color: #e67e22;">And now—maybe—it’s time.</span>
  </div>
</section>
