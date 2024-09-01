---
layout: post
title: Menu
permalink: /menu/
---

<html> 
 <h1>Menu</h1>
    <form id="orderForm">
        <label>
            <input type="checkbox" name="item" value="burger"> Burger ($3.99)
        </label><br>
        <label>
            <input type="checkbox" name="item" value="fries"> Fries ($1.99)
        </label><br>
        <label>
            <input type="checkbox" name="item" value="drink"> Drink ($0.99)
        </label><br><br>
        <input type="submit" value="Calculate Total">
    </form>
 <h2>Total: $<span id="total">0.00</span></h2>
    <script>
        var menu = {"burger": 3.99, "fries": 1.99, "drink": 0.99};
        document.getElementById('orderForm').addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent form submission
            var total = 0;
            var selectedItems = document.querySelectorAll('input[name="item"]:checked');
            selectedItems.forEach(function(item) {
                if (menu.hasOwnProperty(item.value)) {
                    total += menu[item.value];
                } else {
                    console.log(item.value + " is not on the menu.");
                }
            });
            document.getElementById('total').textContent = total.toFixed(2);
        });
    </script>
</html>
