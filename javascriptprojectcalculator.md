---
layout: post
title: Javascript Calculator
description: A common way to become familiar with a language is to build a calculator.  This calculator shows off button with actions.
categories: [Javascript]
permalink: /javascript/project/calculator
toc: true
comments: false
---
<html>
<head>
<style>
        .calculator-output {
            grid-column: span 4;
            grid-row: span 1;
            border-radius: 10px;
            padding: 0.25em;
            font-size: 20px;
            border: 5px solid black;
            display: flex;
            align-items: center;
            justify-content: flex-end; /* Right justify the result */
        }
        .calculator-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1px;
            width: 200px;
            margin: 0 auto;
        }
        .calculator-number, .calculator-operation, .calculator-clear, .calculator-equals {
            display: flex;
            justify-content: center;
            align-items: center;
            border: 1px solid #ddd;
            height: 50px;
            font-size: 24px;
            cursor: pointer;
            user-select: none;
        }
        .calculator-clear {
            grid-column: span 2;
        }
    </style>
</head>
<body>
    <div id="animation">
        <div class="calculator-container">
            <!--result-->
            <div class="calculator-output" id="output">0</div>
            <!--row 1-->
            <div class="calculator-number">1</div>
            <div class="calculator-number">2</div>
            <div class="calculator-number">3</div>
            <div class="calculator-operation">+</div>
            <!--row 2-->
            <div class="calculator-number">4</div>
            <div class="calculator-number">5</div>
            <div class="calculator-number">6</div>
            <div class="calculator-operation">-</div>
            <!--row 3-->
            <div class="calculator-number">7</div>
            <div class="calculator-number">8</div>
            <div class="calculator-number">9</div>
            <div class="calculator-operation">*</div>
            <!--row 4-->
            <div class="calculator-clear">A/C</div>
            <div class="calculator-number">0</div>
            <div class="calculator-number">.</div>
            <div class="calculator-equals">=</div>
            <!-- Additional row for SQRT button -->
            <div class="calculator-operation">√</div>
            <div class="calculator-operation">^</div> <!-- Exponentiation button -->
        </div>
    </div>
    <script>
        // initialize important variables to manage calculations
        var firstNumber = null;
        var operator = null;
        var nextReady = true;
        //Build objects containing key elements
        const output = document.getElementById("output");
        const numbers = document.querySelectorAll(".calculator-number");
        const operations = document.querySelectorAll(".calculator-operation");
        const clear = document.querySelectorAll(".calculator-clear");
        const equals = document.querySelectorAll(".calculator-equals");

        // Number buttons listener
        numbers.forEach(button => {
            button.addEventListener("click", function() {
                number(button.textContent);
            });
        });

        // Number action
        function number(value) { // function to input numbers into the calculator
            if (value != ".") {
                if (nextReady == true) { // nextReady is used to tell the computer when the user is going to input a completely new number
                    output.innerHTML = value;
                    if (value != "0") { // if statement to ensure that there are no multiple leading zeroes
                        nextReady = false;
                    }
                } else {
                    output.innerHTML = output.innerHTML + value; // concatenation is used to add the numbers to the end of the input
                }
            } else { // special case for adding a decimal; can't have two decimals
                if (output.innerHTML.indexOf(".") == -1) {
                    output.innerHTML = output.innerHTML + value;
                    nextReady = false;
                }
            }
        }

        // Operation buttons listener
        operations.forEach(button => {
            button.addEventListener("click", function() {
                operation(button.textContent);
            });
        });

        // Operator action
        function operation(choice) { // function to input operations into the calculator
            if (choice === "√") { // Handle square root operation
                firstNumber = Math.sqrt(parseFloat(output.innerHTML));
                output.innerHTML = firstNumber.toString();
                nextReady = true;
                return;
            }

            if (choice === "^") { // Handle exponentiation operation
                firstNumber = parseFloat(output.innerHTML);
                operator = choice;
                nextReady = true;
                return;
            }

            if (firstNumber == null) { // once the operation is chosen, the displayed number is stored into the variable firstNumber
                firstNumber = parseInt(output.innerHTML);
                nextReady = true;
                operator = choice;
                return; // exits function
            }
            // occurs if there is already a number stored in the calculator
            firstNumber = calculate(firstNumber, parseFloat(output.innerHTML)); 
            operator = choice;
            output.innerHTML = firstNumber.toString();
            nextReady = true;
        }

        // Calculator
        function calculate(first, second) { // function to calculate the result of the equation
            let result = 0;
            switch (operator) {
                case "+":
                    result = first + second;
                    break;
                case "-":
                    result = first - second;
                    break;
                case "*":
                    result = first * second;
                    break;
                case "/":
                    result = first / second;
                    break;
                case "^": // Add support for exponentiation
                    result = Math.pow(first, second);
                    break;
                default: 
                    break;
            }
            return result;
        }

        // Equals button listener
        equals.forEach(button => {
            button.addEventListener("click", function() {
                equal();
            });
        });

        // Equal action
        function equal() { // function used when the equals button is clicked; calculates equation and displays it
            firstNumber = calculate(firstNumber, parseFloat(output.innerHTML));
            output.innerHTML = firstNumber.toString();
            nextReady = true;
        }

        // Clear button listener
        clear.forEach(button => {
            button.addEventListener("click", function() {
                clearCalc();
            });
        });

        // A/C action
        function clearCalc() { // clears calculator
            firstNumber = null;
            output.innerHTML = "0";
            nextReady = true;
        }
    </script>
</body>
</html>
