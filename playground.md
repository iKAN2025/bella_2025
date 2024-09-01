---
layout: page
title: Playground
permalink: /playground/
---

[Link to page about site](https://nighthawkcoders.github.io/portfolio_2025/javascript/project/play)

# Changes from Trystan's Original Version
- Changed layout from page to post
- Added Styling
- Organized Code/Kept Capitalizing Consistent
- Add features like sound, achievements, golden cookies etc:

Enjoy!








<div style="text-align: center; margin-top: 20px;">
    <img src="https://upload.wikimedia.org/wikipedia/commons/f/f1/2ChocolateChipCookies.jpg" alt="Two Chocolate Chip Cookies" id="cookie" style="width: 200px; cursor: pointer; position: relative;"/>
    <p id="counter" style="font-size: 24px; font-weight: bold; margin: 20px 0;">Cookies: 0</p>
    <button id="multiplier" class="cookie-button">1.1x Cookies, 10 Cookies</button>
    <button id="passive" class="cookie-button">Passive Cookie Collection, 100 Cookies</button>
    <button id="sacrifice" class="cookie-button">SACRIFICE THE COOKIES!, 3000 Cookies</button>
    <p id="achievement" style="margin-top: 20px; font-size: 18px; font-weight: bold;"></p>
</div>

<style>
    .cookie-button {
        padding: 10px 20px;
        margin: 10px;
        font-size: 16px;
        font-weight: bold;
        color: #fff;
        background-color: #ff8c00;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .cookie-button:hover {
        background-color: #ffa500;
    }
    #goldenCookie {
        display: none;
        position: absolute;
        top: -20px;
        left: 50%;
        transform: translateX(-50%);
        width: 50px;
        cursor: pointer;
        z-index: 1000;
    }
</style>

<script>
    let count = parseFloat(localStorage.getItem('count')) || 0;
    let bigMult = parseFloat(localStorage.getItem('bigMult')) || 1;
    let mult = parseFloat(localStorage.getItem('mult')) || 1;
    let passiveCount = parseFloat(localStorage.getItem('passiveCount')) || 0;
    let cost = parseFloat(localStorage.getItem('cost')) || 10;
    let cost1 = parseFloat(localStorage.getItem('cost1')) || 100;
    let cost2 = parseFloat(localStorage.getItem('cost2')) || 3000;

    const updateCounter = () => {
        document.getElementById("counter").innerText = `Cookies: ${Math.ceil(count)}`;
        localStorage.setItem('count', count);
    };

    const playClickSound = () => {
        const clickSound = new Audio('https://www.soundjay.com/button/sounds/button-16.mp3');
        clickSound.play();
    };

    const checkAchievements = () => {
        const achievement = document.getElementById("achievement");
        if (count >= 100 && !localStorage.getItem('achievement1')) {
            achievement.innerText = "Achievement Unlocked: 100 Cookies!";
            localStorage.setItem('achievement1', true);
            setTimeout(() => achievement.innerText = "", 3000);
        }
        if (count >= 500 && !localStorage.getItem('achievement2')) {
            achievement.innerText = "Achievement Unlocked: 500 Cookies!";
            localStorage.setItem('achievement1', true);
            setTimeout(() => achievement.innerText = "", 3000);
        }
        if (count >= 1000 && !localStorage.getItem('achievement3')) {
            achievement.innerText = "Achievement Unlocked: 1000 Cookies!";
            localStorage.setItem('achievement2', true);
            setTimeout(() => achievement.innerText = "", 3000);
        }
    };

    document.getElementById("cookie").addEventListener("click", function() {
        count += 1 * mult * bigMult;
        updateCounter();
        playClickSound();
        checkAchievements();
        showClickAnimation();
    });

    const multButton = document.getElementById("multiplier");
    multButton.addEventListener("click", function() {
        if (count >= cost) {
            count = Math.floor(count - cost);
            cost = cost * 1.5;
            mult = mult * 1.1;
            multButton.innerText = `1.1x Cookies, ${Math.ceil(cost)} Cookies`;
            updateCounter();
            localStorage.setItem('cost', cost);
            localStorage.setItem('mult', mult);
        }
    });

    const passiveButton = document.getElementById("passive");
    passiveButton.addEventListener("click", function() {
        if (count >= cost1) {
            count = Math.floor(count - cost1);
            passiveCount += 1;
            cost1 = cost1 * 1.5;
            passiveButton.innerText = `Passive Cookie Collection, ${Math.ceil(cost1)} Cookies`;
            updateCounter();
            localStorage.setItem('cost1', cost1);
            localStorage.setItem('passiveCount', passiveCount);
        }
    });

    const sacrificeButton = document.getElementById("sacrifice");
    sacrificeButton.addEventListener("click", function() {
        if (count >= cost2) {
            count = 0;
            cost = 10;
            cost1 = 100;
            passiveCount = 0;
            mult = 1;
            bigMult = bigMult * 1.8;
            cost2 = cost2 * 2;
            multButton.innerText = `1.1x Cookies, ${Math.ceil(cost)} Cookies`;
            passiveButton.innerText = `Passive Cookie Collection, ${Math.ceil(cost1)} Cookies`;
            sacrificeButton.innerText = `SACRIFICE THE COOKIES!, ${Math.ceil(cost2)} Cookies`;
            updateCounter();
            localStorage.clear();
        }
    });

    const showClickAnimation = () => {
        const cookie = document.getElementById("cookie");
        cookie.style.transform = "scale(0.9)";
        setTimeout(() => cookie.style.transform = "scale(1)", 100);
    };

    const goldenCookie = document.createElement('img');
    goldenCookie.src = 'https://upload.wikimedia.org/wikipedia/commons/8/89/Gold_Star_%28Yellow%29.png';
    goldenCookie.id = 'goldenCookie';
    document.querySelector('div').appendChild(goldenCookie);

    const showGoldenCookie = () => {
        if (Math.random() < 0.4) {  // 40% chance to show golden cookie
            goldenCookie.style.display = 'block';
            setTimeout(() => goldenCookie.style.display = 'none', 5000);
        }
    };

    goldenCookie.addEventListener("click", function() {
        count += 500;
        updateCounter();
        goldenCookie.style.display = 'none';
    });

    setInterval(function() {
        count += passiveCount * bigMult;
        updateCounter();
        showGoldenCookie();
    }, 1000);
</script>


