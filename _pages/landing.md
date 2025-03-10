---
layout: landing
permalink: /landing.html
title: "Loading..."
---

<style>
@import url(https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap);
.card,
.content,
body {
  overflow: hidden;
}

body {
  width: 100vw;
  height: 100vh;
  padding: 0;
  margin: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: black;
}

.card,
.container {
  display: flex;
  align-items: center;
}

.card {
  width: 1280px;
  height: 720px;
  margin: 0;
  justify-content: center;
}

.container-full,
.content {
  width: 1000px;
  height: 562px;
}

.backgroundImage {
  position: absolute;
  width: 1000px;
}

.boyImage {
  position: absolute;
  width: 1000px;
  z-index: 2;
  animation: 200s linear infinite blur;
}

.content {
  border-radius: 40px;
  animation: 200s linear infinite brightness;
}

.container {
  justify-content: center;
}

.container-full,
.face {
  display: flex;
  align-items: center;
  overflow: hidden;
}

.container-full {
  margin: 0;
  justify-content: center;
  transform: scale(1);
  animation: 200s linear infinite zoom-in;
}

.cube,
.face {
  width: 870px;
  height: 190px;
}

.cube {
  position: relative;
  transform-style: preserve-3d;
  perspective: 480px;
  transform-style: preserve-3d;
  perspective-origin: 51% 70%;
}

.face,
.hue {
  position: absolute;
}

.face {
  background: 0 0;
  border: 0 solid #000;
  opacity: 0.5;
}

.bottom,
.top {
  width: 870px;
  height: 870px;
}

p {
  white-space: nowrap;
  overflow: hidden;
  font-family: "Bebas Neue", sans-serif;
  font-weight: 400;
  font-size: calc(6em + (190px / 10) * 0.7);
  padding-top: 20px;
  color: #fff;
}

span {
  color: red;
}

.front {
  transform: translateZ(435px);
  display: none;
}

.back {
  transform: translateZ(-435px) rotateY(180deg) scaleX(-1);
}

.left {
  transform: translateX(-435px) rotateY(-90deg) scaleX(-1);
}

.right {
  transform: translateX(435px) rotateY(90deg) scaleX(-1);
}

.top {
  transform: translateY(-435px) rotateX(90deg) scaleY(-1);
}

.bottom {
  transform: translateY(-245px) rotateX(-90deg) scaleY(-1);
}

.left p {
  margin-left: 480px;
  animation: 200s linear infinite left;
}

.back p {
  margin-left: -390px;
  animation: 200s linear infinite back;
}

.right p {
  margin-left: -1260px;
  animation: 200s linear infinite right;
}

@keyframes left {
  100% {
    margin-left: -54000px;
  }
}
@keyframes back {
  100% {
    margin-left: -54870px;
  }
}
@keyframes right {
  100% {
    margin-left: -55740px;
  }
}
.hue {
  top: 0;
  left: 0;
  z-index: 3;
  width: 100%;
  height: 100%;
  mix-blend-mode: overlay;
  background: #1e5799;
  background: radial-gradient(ellipse at center, #1e5799 0, #7db9e8 100%);
  opacity: 1;
}

.hue.animated {
  -webkit-animation: 8s infinite filter-animation;
  animation: 8s infinite filter-animation;
}

.container-reflect {
  position: absolute;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 380px;
  filter: blur(10px);
}

.container-reflect .cube {
  perspective-origin: 51% -30%;
}

.container-reflect .back {
  transform: translateZ(-435px) rotateY(180deg) scaleX(-1) scaleY(-1);
}

.container-reflect .left {
  transform: translateX(-435px) rotateY(-90deg) scaleX(-1) scaleY(-1);
}

.container-reflect .right {
  transform: translateX(435px) rotateY(90deg) scaleX(-1) scaleY(-1);
}

.container-reflect p {
  transform: scaleY(70%);
}

@keyframes filter-animation {
  0%, 100% {
    filter: hue-rotate(0deg);
  }
  50% {
    filter: hue-rotate(100deg);
  }
}
@keyframes zoom-in {
  0% {
    transform: scale(1);
  }
  100% {
    transform: scale(2.5);
  }
}
@keyframes blur {
  0% {
    filter: blur(0px);
  }
  100% {
    filter: blur(3px);
  }
}
@keyframes brightness {
  0% {
    filter: brightness(1) contrast(1);
  }
  100% {
    filter: brightness(0.8) contrast(1.3);
  }
}
#load {
  position:absolute;
  width:600px;
  height:36px;
  left:50%;
  top:85%;
  margin-left:-300px;
  overflow:visible;
  -webkit-user-select:none;
  -moz-user-select:none;
  -ms-user-select:none;
  user-select:none;
  cursor:default;
}

#load div {
  position:absolute;
  width:20px;
  height:36px;
  opacity:0;
  font-family:Helvetica, Arial, sans-serif;
  animation:move 2s linear infinite;
  -o-animation:move 2s linear infinite;
  -moz-animation:move 2s linear infinite;
  -webkit-animation:move 2s linear infinite;
  transform:rotate(180deg);
  -o-transform:rotate(180deg);
  -moz-transform:rotate(180deg);
  -webkit-transform:rotate(180deg);
  color:#35C4F0;
}

#load div:nth-child(2) {
  animation-delay:0.2s;
  -o-animation-delay:0.2s;
  -moz-animation-delay:0.2s;
  -webkit-animation-delay:0.2s;
}
#load div:nth-child(3) {
  animation-delay:0.4s;
  -o-animation-delay:0.4s;
  -webkit-animation-delay:0.4s;
  -webkit-animation-delay:0.4s;
}
#load div:nth-child(4) {
  animation-delay:0.6s;
  -o-animation-delay:0.6s;
  -moz-animation-delay:0.6s;
  -webkit-animation-delay:0.6s;
}
#load div:nth-child(5) {
  animation-delay:0.8s;
  -o-animation-delay:0.8s;
  -moz-animation-delay:0.8s;
  -webkit-animation-delay:0.8s;
}
#load div:nth-child(6) {
  animation-delay:1s;
  -o-animation-delay:1s;
  -moz-animation-delay:1s;
  -webkit-animation-delay:1s;
}
#load div:nth-child(7) {
  animation-delay:1.2s;
  -o-animation-delay:1.2s;
  -moz-animation-delay:1.2s;
  -webkit-animation-delay:1.2s;
}

@keyframes move {
  0% {
    left:0;
    opacity:0;
  }
	35% {
		left: 41%; 
		-moz-transform:rotate(0deg);
		-webkit-transform:rotate(0deg);
		-o-transform:rotate(0deg);
		transform:rotate(0deg);
		opacity:1;
	}
	65% {
		left:59%; 
		-moz-transform:rotate(0deg); 
		-webkit-transform:rotate(0deg); 
		-o-transform:rotate(0deg);
		transform:rotate(0deg); 
		opacity:1;
	}
	100% {
		left:100%; 
		-moz-transform:rotate(-180deg); 
		-webkit-transform:rotate(-180deg); 
		-o-transform:rotate(-180deg); 
		transform:rotate(-180deg);
		opacity:0;
	}
}

@-moz-keyframes move {
	0% {
		left:0; 
		opacity:0;
	}
	35% {
		left:41%; 
		-moz-transform:rotate(0deg); 
		transform:rotate(0deg);
		opacity:1;
	}
	65% {
		left:59%; 
		-moz-transform:rotate(0deg); 
		transform:rotate(0deg);
		opacity:1;
	}
	100% {
		left:100%; 
		-moz-transform:rotate(-180deg); 
		transform:rotate(-180deg);
		opacity:0;
	}
}

@-webkit-keyframes move {
	0% {
		left:0; 
		opacity:0;
	}
	35% {
		left:41%; 
		-webkit-transform:rotate(0deg); 
		transform:rotate(0deg); 
		opacity:1;
	}
	65% {
		left:59%; 
		-webkit-transform:rotate(0deg); 
		transform:rotate(0deg); 
		opacity:1;
	}
	100% {
		left:100%;
		-webkit-transform:rotate(-180deg); 
		transform:rotate(-180deg); 
		opacity:0;
	}
}

@-o-keyframes move {
	0% {
		left:0; 
		opacity:0;
	}
	35% {
		left:41%; 
		-o-transform:rotate(0deg); 
		transform:rotate(0deg); 
		opacity:1;
	}
	65% {
		left:59%; 
		-o-transform:rotate(0deg); 
		transform:rotate(0deg); 
		opacity:1;
	}
	100% {
		left:100%; 
		-o-transform:rotate(-180deg); 
		transform:rotate(-180deg); 
		opacity:0;
	}
}

</style>

<div class="container">
	<div class="content" style="display:block;width:1000px;height:562px">
		<div class="container-full">
			<div class="animated hue"></div>
      <img class="backgroundImage" src="assets/img/empty-room.jpg"> <img class="boyImage" src="assets/img/boy.png">
			<div class="container">
				<div class="cube">
					<div class="face top"></div>
					<div class="face bottom"></div>
					<div class="face left text"></div>
					<div class="face right text"></div>
					<div class="face front"></div>
					<div class="face back text"></div>
				</div>
			</div>
			<div class="container-reflect">
				<div class="cube">
					<div class="face top"></div>
					<div class="face bottom"></div>
					<div class="face left text"></div>
					<div class="face right text"></div>
					<div class="face front"></div>
					<div class="face back text"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="load">
  <div>G</div>
  <div>N</div>
  <div>I</div>
  <div>D</div>
  <div>A</div>
  <div>O</div>
  <div>L</div>
</div>

<script>
const kiplingPoem = `<p>One final point should be made here about the <span>social distribution of knowledge.</span> I encounter knowledge in everyday life as <span>socially distributed,</span> that is, as possessed differently by different individuals and types of individuals. I do not share my knowledge equally with all my fellowmen, and there may be some knowledge that I share with no one. I share my <span>professional expertise</span> with colleagues, but not with my family, and I may share with nobody my knowledge of how to cheat at cards. The social distribution of knowledge of certain elements of everyday reality can become highly complex and even confusing to the outsider. I not only do not possess the knowledge supposedly required to cure me of a physical ailment, I may even lack the knowledge of which one of a bewildering variety of <span>medical specialists</span> claims jurisdiction over what ails me. In such cases, I require not only the advice of experts, but the prior advice of <span>experts on experts</span>. The social distribution of knowledge thus begins with the simple fact that I do not know everything known to my fellowmen, and vice versa, and culminates in exceedingly complex and esoteric systems of expertise. Knowledge of how the socially available stock of knowledge is distributed, at least in outline, is an important element of that same stock of knowledge. In everyday life, I know, at least roughly, what I can hide from whom, whom I can turn to for information on what I do not know, and generally which types of individuals may be expected to have which types of knowledge.</p>`;

// Function to insert poem into divs
function insertPoemIntoDivs() {
  // Get all .text divs
  const textDivs = document.querySelectorAll(".text");

  // Insert poem into all .text divs
  textDivs.forEach((div) => {
    div.innerHTML = kiplingPoem;
  });
}

// Call the function when the DOM is fully loaded
document.addEventListener("DOMContentLoaded", insertPoemIntoDivs);

const contentDiv = document.querySelector(".content");
function adjustContentSize() {
  const viewportWidth = window.innerWidth;
  const baseWidth = 1000;
  const scaleFactor =
    viewportWidth < baseWidth ? (viewportWidth / baseWidth) * 0.8 : 1;
  contentDiv.style.transform = `scale(${scaleFactor})`;
}
window.addEventListener("load", adjustContentSize);
window.addEventListener("resize", adjustContentSize);

// Set a timer for 15 seconds and then redirect to the relative path /
setTimeout(() => {
  window.location.href = "/";
}, 15000);

</script>