---
toc: false
comments: true
layout: post
title: Assignment Calculator
permalink: /calc
toc: true
comments: true
---
<body>
    <!-- Help Message -->
    <h3>Input scores, press tab or enter to add a new score.</h3>
    <!-- Table for scores -->
    <table>
        <thead>
            <tr>
                <th>Assignment</th>
                <th>Score</th>
                <th>Maximum</th>
            </tr>
        </thead>
        <tbody id="scores">
            <!-- Initial input row -->
            <tr>
                <td><input type="text" name="assignment" placeholder="Assignment 1" style="width: 100%;"></td>
                <td><input type="number" name="score" onkeydown="calculator(event)" placeholder="0"></td>
                <td><input type="number" name="max" onkeydown="calculator(event)" placeholder="0"></td>
            </tr>
        </tbody>
        <tfoot class="tfoot">
            <tr>
                <td>Total:</td>
                <td id="total">0.0</td>
                <td id="maxTotal">0.0</td>
            </tr>
            <tr>
                <td>Count:</td>
                <td colspan="2" id="count">0.0</td>
            </tr>
            <tr>
                <td>Average:</td>
                <td colspan="2" id="average">0.0</td>
            </tr>
        </tfoot>
    </table>
    <script>
        // Function to calculate totals and averages
        function calculator(event) {
            if (event.key === "Enter" || event.key === "Tab") {
                event.preventDefault();
                var rows = document.querySelectorAll('#scores tr');
                var total = 0, maxTotal = 0, count = 0;
                rows.forEach(row => {
                    var score = parseFloat(row.querySelector('input[name="score"]').value) || 0;
                    var max = parseFloat(row.querySelector('input[name="max"]').value) || 0;
                    if (score && max) {
                        total += score;
                        maxTotal += max;
                        count++;
                    }
                });
                document.getElementById('total').innerText = total.toFixed(2);
                document.getElementById('maxTotal').innerText = maxTotal.toFixed(2);
                document.getElementById('count').innerText = count;
                document.getElementById('average').innerText = count > 0 ? (total / count).toFixed(2) : "0.0";
                if (rows.length === count) {
                    newInputRow(count + 1);
                }
                saveToLocalStorage();
            }
        }
        // Function to create a new input row
        function newInputRow(index) {
            var row = document.createElement('tr');
            var assignmentCell = document.createElement('td');
            var scoreCell = document.createElement('td');
            var maxCell = document.createElement('td');
            assignmentCell.innerHTML = `<input type="text" name="assignment" placeholder="Assignment ${index}" style="width: 100%;">`;
            scoreCell.innerHTML = `<input type="number" name="score" onkeydown="calculator(event)">`;
            maxCell.innerHTML = `<input type="number" name="max" onkeydown="calculator(event)">`;
            row.appendChild(assignmentCell);
            row.appendChild(scoreCell);
            row.appendChild(maxCell);
            document.getElementById('scores').appendChild(row);
            // Set focus on the new input field
            row.querySelector('input[name="assignment"]').focus();
        }
        // Function to save data to local storage
        function saveToLocalStorage() {
            var rows = document.querySelectorAll('#scores tr');
            var data = [];
            rows.forEach(row => {
                var assignment = row.querySelector('input[name="assignment"]').value;
                var score = row.querySelector('input[name="score"]').value;
                var max = row.querySelector('input[name="max"]').value;
                if (assignment && score && max) {
                    data.push({ assignment, score, max });
                }
            });
            localStorage.setItem('scoresData', JSON.stringify(data));
        }
        // Function to load data from local storage
        function loadFromLocalStorage() {
            var data = JSON.parse(localStorage.getItem('scoresData')) || [];
            if (data.length > 0) {
                data.forEach((item, index) => {
                    newInputRow(index + 1);
                    var row = document.querySelectorAll('#scores tr')[index];
                    row.querySelector('input[name="assignment"]').value = item.assignment;
                    row.querySelector('input[name="score"]').value = item.score;
                    row.querySelector('input[name="max"]').value = item.max;
                });
            }
        }
        // Initialize with saved data
        loadFromLocalStorage();
    </script>
</body>
</html>
