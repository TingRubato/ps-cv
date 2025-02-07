---
layout: distill
title: Labels, Self-Fulfilling Prophecy 
description: Do people embrace labels to seek identity, or just use them as an often-exploited excuse?
date: 2025-03-06 00:00:00
thumbnail: assets/img/self-labelling.jpg
toc:
sidebar: left
bibliography: label.bib

---

<style>
.reveal {
  color: #0000;
  background:
    linear-gradient(90deg,#03a9f4,#f441a5,#ffeb3b,#03a9f4) no-repeat,
    linear-gradient(var(--global-text-color) 0 0) no-repeat;
  background-size: 0% 100%; /* we start at 0% 100% */
  -webkit-background-clip: padding-box;
          background-clip: padding-box,text;
    cursor: pointer;
    animation: hover 8s linear infinite
  /* animation: 
    t 1.2s .5s both,
    b 1.2s 1.3s both; */
    
}

.reveal:before {
    content: '';
    position: relative;
    top: -5px;
    left: -5px;
    bottom: -5px;
    right: -5px;
    z-index: -1;
    background: linear-gradient(90deg,#03a9f4,#f441a5,#ffeb3b,#03a9f4);
    /* background-size: 400%; */
    border-radius: 40px;
    opacity: 0;
    transition: 1s;
    animation: hover 8s linear infinite;
}

@keyframes t{
  to {background-size: 150% 100%} /* we animate to 150% instead of 100%*/
}
@keyframes b {
  to {background-position:-200% 0,0 0} /* we update the position of only the first layer */
}

.glow-button {
    width: 300px;
    border-radius: 30px; 
    position: relative;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
    text-align: center;
    color: #fff;
    text-transform: uppercase;
    text-decoration: none;
    font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
    box-sizing: border-box;
    background: linear-gradient(90deg,#03a9f4,#f441a5,#ffeb3b,#03a9f4);
    background-size: 400%;
    cursor: pointer;
    animation: hover 8s linear infinite;
}

@keyframes hover {
    0% {
        background-position: 0%;
    }
    100% {
        background-position: 400%;
    }
    
}

.glow-button:before {
    content: '';
    position: absolute;
    top: -5px;
    left: -5px;
    bottom: -5px;
    right: -5px;
    z-index: -1;
    background: linear-gradient(90deg,#03a9f4,#f441a5,#ffeb3b,#03a9f4);
    background-size: 400%;
    border-radius: 40px;
    opacity: 0;
    transition: 1s;
}

.glow-button:hover:before {
    filter: blur(20px);
    opacity: 1;
    animation: hover 8s linear infinite;    
}

</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.reveal').forEach(function(element) {
            element.style.animation = 't 1.2s .5s both';
        });

        document.querySelector('.glow-button').addEventListener('click', function() {
            document.querySelectorAll('.reveal').forEach(function(element) {
                element.style.animation = 't 1.2s .5s both, b 1.2s 1.3s both';
            });
        });
    });
</script>

They say there are two types of people in this world: those trapped by mental health labels and those watching others get trapped. Getting stamped with *"anxiety disorder"* or *"depression"* is like getting a disability pass that grants you extra exam time? Sorry, but no. You’re just giving yourself a self-imposed debuff. There’s a fancy term in psychology called Neuroplasticity.<d-footnote>Neuroplasticity, also known as neural plasticity or brain plasticity, refers to the brain’s ability to adjust and reorganize itself throughout life by forming new neural connections<d-cite key="mateos-aparicioImpactStudyingBrain2019,rWhatNeuralPlasticity2017"></d-cite>. This dynamic property enables the nervous system to adapt and respond to various stimuli, including new experiences, learning, environmental changes, and injuries.<d-cite key="mateos-aparicioImpactStudyingBrain2019,WhatNeuroplasticityWhy"></d-cite></d-footnote>

In plain English, your brain isn’t a hard drive you can format, but <u>you can rewrite the data</u><d-cite key="puderbaughNeuroplasticity2025"></d-cite>. The real issue? Some folks cling to their diagnosis like it’s a lifetime membership card to a club they never wanted to join, proudly declaring to the world:

> *"Look! This is me! Don’t expect me to change!"*
>
> {: .block-blue }

But here’s the truth: anxiety, depression, and many other psychological conditions are **temporary states**, <u>not permanent personality traits.</u>

These labels often work like the **“honor student”** and **“troublemaker”** badges in school, except they carry way more weight than a teacher’s comment. When you got called a bad student, at least you knew that acing the final might change your reputation. But a mental health label? Once it’s on, it can feel like an irreversible tattoo—one that convinces you it’s permanent, leaving you feeling powerless to fight it.

So ask yourself:

1. **Does a label define who you are?**
   <span class="reveal">Are you an anxious person, or are you a person experiencing anxiety? The difference is key. You are not HOT!—you just feel HOT.</span>
    
2. **Does a label dictate your fate?**
   <span class="reveal">Anxiety and depression aren’t life sentences. Your mental state is more like a revolving door—you can step in or out.</span>
    
3. **Does a label excuse everything?**
   <span class="reveal">Can’t communicate in an argument? Instead of admitting you need to improve, it’s "I have avoidant personality disorder, I can’t help it." Relationship problems? Instead of fixing your communication, it’s "I was born unlucky in love." It’s like someone failing a driving test and saying, "I was just born bad at wheels!"—when, in reality, they just need more practice.</span>
<div class="glow-button">Hint</div>

Slapping a diagnosis on everything makes life seem easier, doesn’t it? It’s like blaming Mercury retrograde for all your problems instead of admitting you just made bad decisions. Bonus points if it earns you some tragic main character energy. **But at some point, ** you have to ask yourself:

> Do you spend each day trying to embrace adulthood, or are you holding on to Neverland like Peter Pan, afraid of change?
> {: .block-warning}

Staying the same might feel safe, but real life isn’t a fairytale—you don’t get to dodge growth forever. So instead of treating your label like a VIP pass to the "no-growth club," try reading a few books on mindfulness or putting in some CBT practice. Don’t let your diagnosis turn you into a “mental health martyr”—stuck in Neverland while everyone else learns to navigate the real world.

## **2. The Social Psychology of Labels: Self-Fulfilling Prophecy**

Who are you? Who do you want to be? These are cliché questions in your college application, right up there with *“Describe a time you overcame adversity”* and *“What makes you unique?”* But the real kicker is—**what do you believe about yourself?** Because if you think you're the main character, congrats—you just might be. If you think you're doomed to be an NPC, well... enjoy being stuck in the background while everyone else moves the plot forward. Just don’t be the guy who insists his *dream school* is Harvard while submitting a last-minute essay written in Google Docs at 2 AM. We should dream big, **but let’s not confuse ambition with staring at the ceiling**, waiting for success to magically happen.

There’s a *spooky* little concept in psychology called the **self-fulfilling prophecy**<d-footnote>A self-fulfilling prophecy <d-cite key="edenLeadershipExpectationsPygmalion1992"></d-cite> (also known as the interpersonal expectancy effect) refers to a phenomenon in which an individual’s or group’s expectations about another person’s behavior ultimately lead the person to act in a way that aligns with those expectations, thereby making the prophecy come true.</d-footnote> In plain terms:

> *"If you believe you're useless, then congrats, you will become useless."*
>
> {: .block-warning}

For example:

- *“I have ADHD.”* → So you start five different projects at once, forget about them, then hyperfocus on reorganizing your entire room at 3 AM—because apparently, your life can’t move forward until your sock drawer is color-coded.
- *“I suck at math.”* → So you surrender before even trying → Guess what? You really do suck at math.
- *“I have chronic procrastination.”* → So you put things off for a lifetime, until even the Grim Reaper has to chase you for overdue KPIs. (Let’s just hope *he* procrastinates, too.)

But let’s flip the script. What if, starting today, you look in the mirror and brainwash yourself with:

> *"I am a highly disciplined and productive legend."*
>
> {: .block-blue }


Sounds like the corporate world’s version of *"fake it till you make it,"* but research<d-cite key="edenLeadershipExpectationsPygmalion1992"></d-cite> shows this actually works. Your brain doesn’t have a built-in **"fact-checker"** for incoming information—it absorbs whatever you feed it. That’s why the intern who confidently calls themselves a 'strategy consultant' on LinkedIn might actually start believing it—and so might their next employer. Similarly, kids who are praised for being smart actually try harder to prove it, while kids constantly told **"you’re bad at math"** tend to avoid it altogether.

So if you’re going to brainwash yourself, at least do it for good:

1. **Adopt a Growth Mindset** – Skills can be built<d-cite key="GrowthMindsetDefinition"></d-cite>; stop treating abilities as if they’re set in stone.
2. **Base Self-Perception on Evidence** – Don’t just **feel** like you’re bad at something—check your actual progress.
3. **Change Your Environment** – Surround yourself with people who push you forward, not a group of friends who sit around accepting their fate like doomed NPCs.

## **3. Personality Traits: Set in Stone or Flexible?**

Some people think personality is as unchangeable as childhood food preferences. *"I liked sweets as a kid; I still like them now."* Okay, but you also thought superheroes were the strongest beings in the world—until you realized a corporate executive with a black Amex card holds more power, while superheroes are out here picking up DoorDash shifts between saving the city just to make rent.

Is personality really a rigid, permanent trait? The **Big Five Personality Traits** theory<d-cite key="BigFivePersonality"></d-cite> suggests traits like openness, conscientiousness, extraversion, agreeableness, and neuroticism tend to remain stable into adulthood. But stable doesn’t mean **fixed**. Maybe you’re an introvert, or maybe you just hate your job so much that even the office coffee machine gets more social interaction than you do as they all are advertizing their embedded ‘AI’.

Consider this:

- **Are personality tests misleading you?** – You took a quiz and got *“introvert”*, but if the drinks are flowing, you’re suddenly the life of the party.
- **Are you ignoring situational factors?** – The same person on *Monday morning at 8 AM* vs. *Friday night at 5 PM* is basically a different species.
- **Are you confusing habits with personality?** – Maybe you’re not *naturally* quiet—you just haven’t found the right topic to talk your head off about.

In reality, personality isn’t about what you can or can’t do—it’s about what you tend to do and how comfortable you feel doing it. Keep quiet long enough, and you don’t just *seem* reserved—you *become* reserved. But speak up just once, and you might realize people aren’t thinking, "Wow, that was awkward," but instead, "Finally! We’ve been waiting for you to say something.

So, stay adaptable—treat life like a Wi-Fi router, always scanning for the best channel to get the strongest connection—because sometimes, life’s interference is just your neighbor streaming 4K cat videos at full bandwidth.

**Ting’s Take:** Personality isn’t a released album—it’s more like your Spotify Wrapped. It evolves based on your habits, surprises you with unexpected trends, and sometimes makes you wonder, "Did I really listen to that on repeat?" What you shape it into is entirely up to you.

## **Final Thoughts:**

- Use Psychology as a Tool, Not a Cage。
- Mental health labels aren’t your destiny. Stop treating them like *get-out-of-jail-free* cards.
- Personality isn’t set in stone. You’re way more adaptable than you think.
- Psychological theories aren’t just trivia to flex on Twitter—they exist to help you **understand yourself**.
- Awareness is great, but **action is what really matters.**

At the end of the day, life is a game. What matters most isn’t your **starting stats**—it’s how you **allocate your points and play the game.** Don’t let labels write your story. **Rewrite your own script.**