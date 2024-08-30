---
layout: page
title: Playground
permalink: /playground/
---

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cookie Clicker Game</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            text-align: center;
        }
        #cookie {
            cursor: pointer;
            border: 2px solid #333;
            border-radius: 10px;
            width: 150px;
            transition: transform 0.1s;
        }
        #cookie:active {
            transform: scale(0.9);
        }
        button {
            margin: 10px;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
        }
        #store {
            margin-top: 20px;
        }
        #achievement {
            font-size: 18px;
            color: green;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Cookie Clicker Game</h1>
    <p><a href="https://nighthawkcoders.github.io/portfolio_2025/javascript/project/play">Link to page about site</a></p>
    <div>
        <img src="https://upload.wikimedia.org/wikipedia/commons/f/f1/2ChocolateChipCookies.jpg" alt="Two Chocolate Chip Cookies" id="cookie"/>
        <p id="counter">cookies: 1000</p>
        <button id="multiplier">1.1x cookies, 10 cookies</button>
        <button id="passive">passive cookie collection, 100 cookies</button>
        <div id="store"></div>
        <p id="achievement"></p>
    </div>
    <audio id="clickSound" src="https://www.soundjay.com/button/beep-07.wav"></audio>
   <audio id="upgradeSound" src="https://www.soundjay.com/button/beep-09.wav"></audio>
    <script>
        var count = 1000;
        var mult = 1;
        var passiveCount = 0;
        var cost = 10;
        var cost1 = 100;
        var upgrades = [
            { name: "Double Click", cost: 50, effect: () => mult *= 2 },
            { name: "Triple Click", cost: 200, effect: () => mult *= 3 }
        ];

        function checkAchievements() {
            if (count >= 10000 && !document.getElementById("achievement").innerText) {
                document.getElementById("achievement").innerText = "Achievement Unlocked: 10,000 Cookies!";
            }
        }

        function renderUpgrades() {
            var store = document.getElementById("store");
            store.innerHTML = '';
            upgrades.forEach(upgrade => {
                var button = document.createElement("button");
                button.innerText = `${upgrade.name} (${upgrade.cost} cookies)`;
                button.addEventListener("click", function() {
                    if (count >= upgrade.cost) {
                        count -= upgrade.cost;
                        upgrade.effect();
                        renderUpgrades();
                        document.getElementById("counter").innerText = "cookies: " + count.toFixed(0);
                    }
                });
                store.appendChild(button);
            });
        }

        document.getElementById("cookie").addEventListener("click", function() {
            count += 1 * mult;
            document.getElementById("counter").innerText = "cookies: " + count.toFixed(0).toString();
            document.getElementById("clickSound").play();
            checkAchievements();
        });

        document.getElementById("multiplier").addEventListener("click", function() {
            if (count >= cost) {
                count = Math.floor(count - cost);
                cost = cost * 1.5;
                mult = mult * 1.1;
                this.innerText = "1.1x cookies, " + Math.ceil(cost).toString() + " cookies";
                document.getElementById("counter").innerText = "cookies: " + Math.ceil(count).toString();
                document.getElementById("upgradeSound").play();
            }
        });

        document.getElementById("passive").addEventListener("click", function() {
            if (count >= cost1) {
                count = Math.floor(count - cost1);
                passiveCount += 1;
                cost1 = cost1 * 1.5;
                this.innerText = "passive cookie collection, " + Math.ceil(cost1).toString() + " cookies";
                document.getElementById("counter").innerText = "cookies: " + Math.ceil(count).toString();
            }
        });

        // Remove the automatic cookie increment
        // setInterval(function() {
        //     count += passiveCount;
        //     document.getElementById("counter").innerText = "cookies: " + Math.ceil(count).toString();
        // }, 1000);

        function saveGame() {
            localStorage.setItem("cookieCount", count);
            localStorage.setItem("cookieMultiplier", mult);
            localStorage.setItem("passiveCount", passiveCount);
        }

        function loadGame() {
            count = parseFloat(localStorage.getItem("cookieCount")) || 1000;
            mult = parseFloat(localStorage.getItem("cookieMultiplier")) || 1;
            passiveCount = parseInt(localStorage.getItem("passiveCount")) || 0;
            document.getElementById("counter").innerText = "cookies: " + count.toFixed(0);
            renderUpgrades();
        }

        window.addEventListener("beforeunload", saveGame);
        window.addEventListener("load", loadGame);
    </script>
</body>
</html>



