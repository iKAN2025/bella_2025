---
layout: base
title: Bella's CSA Blog
hide: true
comments: true
---

{%  include nav/index.html %}




<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="styles.css">
</head>
<body>




    <div id="draggable-container">
        <!-- Draggable items will be added here by JavaScript -->
    </div>
    <div id="magic-box">
        <!-- Dropped items will transform here -->
    </div>
<script>
    document.addEventListener('DOMContentLoaded', () => {
    const draggableContainer = document.getElementById("draggable-container");
    const magicBox = document.getElementById("magic-box");

    // Define only 4 draggable items
    const items = [
      {
    "name": "Red",
    "color": "#E57373" // Light Coral
},
{
    "name": "Green",
    "color": "#66CDAA" // Medium Aquamarine
},
{
    "name": "Blue",
    "color": "#64B5F6" // Light Blue
},
{
    "name": "Yellow",
    "color": "#FFEB3B" // Light Yellow
}

    ];

    items.forEach((item) => {
        const draggableItem = document.createElement("div");
        draggableItem.className = "draggable-item";
        draggableItem.textContent = item.name;
        draggableItem.style.backgroundColor = item.color; // Set initial color
        draggableItem.draggable = true;

        draggableItem.addEventListener("dragstart", function(event) {
            event.dataTransfer.setData("text/plain", item.color);
        });

        draggableContainer.appendChild(draggableItem);
    });

    magicBox.addEventListener("dragover", function(event) {
        event.preventDefault();
    });

    magicBox.addEventListener("drop", function(event) {
        event.preventDefault();
        
        // Function to generate a random color
        function getRandomColor() {
            const letters = '0123456789ABCDEF';
            let color = '#';
            for (let i = 0; i < 6; i++) {
                color += letters[Math.floor(Math.random() * 16)];
            }
            return color;
        }

        const randomColor = getRandomColor();
        const transformedItem = document.createElement("div");
        transformedItem.className = "transformed-item";
        transformedItem.style.backgroundColor = randomColor; // Set random color
        transformedItem.textContent = "Dropped";
        transformedItem.style.top = `${Math.random() * (magicBox.clientHeight - 50)}px`;
        transformedItem.style.left = `${Math.random() * (magicBox.clientWidth - 50)}px`;

        magicBox.appendChild(transformedItem);
    });
});
</script>
</body>
</html>




## Color Box 
Items start out as their assigned colors before they are dragged into the box, where they are randomly assigned a color. The text changes to `Dropped1. Here is the [Documentation For Color Box]({{site.baseurl}}/indexdocumententation) and the [Ideation For Color Box]({{site.baseurl}}/indexideation)