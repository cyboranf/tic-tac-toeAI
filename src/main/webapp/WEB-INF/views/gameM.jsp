<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tic Tac Toe</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href='<c:url value='/css/game.css'/>'>
</head>
<body>

<button class="btn btn-primary" onclick="playAudio(this)" type="button">Play Music</button>
<input type="range" id="volume-slider">

<audio id="myAudio" class="audio">
    <source src="/css/music.mp3" type="audio/ogg">
</audio>

<script>
    var x = document.getElementById("myAudio");
    var sliderLevel = document.querySelector('#volume-slider')
    x.volume = sliderLevel.value / 100
    sliderLevel.addEventListener("change", function (e) {
        x.volume = e.currentTarget.value / 100;
    })

    function playAudio(btn) {
        if (x.paused) {
            x.play();
            document.querySelector(".btn-primary").innerHTML = "Pause Music";
        } else {
            x.pause();
            document.querySelector(".btn-primary").innerHTML = "Play Music";
        }
    }
</script>


<section class="dashboard-section">
    <div class="container pt-4 pb-4">
        <div class="border-dashed view-height">
            <div class="box-wrapper">
                <div>
                    <button style="width: 118px" type="submit">Game's history</button>
                    <a href="/app/game">
                        <button style="width: 118px" type="button">Easy level</button>
                    </a>
                    <a href="/app/hard">
                        <button style="width: 118px" type="button">Hard level</button>
                    </a>
                </div>
                <div class="row">
                    <div class="box box00" data-x="0" data-y="0"></div>
                    <div class="box box01" data-x="0" data-y="1"></div>
                    <div class="box box02" data-x="0" data-y="2"></div>
                </div>
                <div class="row">
                    <div class="box box10" data-x="1" data-y="0"></div>
                    <div class="box box11" data-x="1" data-y="1"></div>
                    <div class="box box12" data-x="1" data-y="2"></div>
                </div>
                <div class="row">
                    <div class="box box20" data-x="2" data-y="0"></div>
                    <div class="box box21" data-x="2" data-y="1"></div>
                    <div class="box box22" data-x="2" data-y="2"></div>
                </div>
            </div>
            <div></div>
            <div class="position">
            </div>
        </div>

    </div>
</section>

<script type="text/javascript">
    $(document).ready(function () {
        var user = "X", computer = "O";
        box = [
            [1, 1, 1],
            [1, 1, 1],
            [1, 1, 1]
        ]

        $('.box').click(function () {
            runUser($(this), function () {
                // check if game ends
                if (!isGameEnd()) {
                    runAI(computer, user);
                } else {
                    $('.position').append('<p>Game End</p>');
                    nobodyWon();
                }

            });
        });

        // checking if the game ends
        function isGameEnd() {
            count = 0;
            for (i = 0; i < 3; i++) {
                for (j = 0; j < 3; j++) {
                    if (box[i][j] == "1") {
                        count++;
                    }
                }
            }
            if (count == 0) {
                return true;
            } else {
                return false;
            }
        }

        function runUser($user, callback) {
            x = parseInt($user.data('x'));
            y = parseInt($user.data('y'));
            if ("1" == box[x][y]) {
                box[x][y] = user;

                className = "box" + x + y;
                $('.' + className).html(user);
                $('.position').append('<p class="communicat">${username} clicked :' + x + ',' + y + '</p>');
                checkIfWins();
                callback();
            } else {
                alert("This is already used");
            }
        }

        function runAI(computer, user) {
            bestScore = Number.MIN_VALUE;
            let row = -1;
            let col = -1;
            for (let i = 0; i < box.length; i++) {
                for (let j = 0; j < box.length; j++) {
                    // sprawdza czy pole jest wolne
                    if (box[i][j] == 1) {
                        box[i][j] = computer;
                        let score = minmax(false, box, computer, user);
                        box[i][j] = 1;
                        if (score > bestScore) {
                            bestScore = score;
                            row = i;
                            col = j;
                        }
                    }
                }
            }


                console.log("Jestem w runAI i mam stawiać znaczek")
                box[row][col] = computer;

                className = "box" + row + col;
                $('.' + className).html(computer);
                $('.position').append('<p>AI clicked :' + row + ',' + col + '</p>');
                checkIfWins();


        }

        function checkIfWins() {
            let x = 0;
            if (box[0][0] == "X" && box[0][1] == "X" && box[0][2] == "X") {
                x = 1;
                userWon();
            } else if (box[1][0] == "X" && box[1][1] == "X" && box[1][2] == "X") {
                x = 1;
                userWon();
            } else if (box[2][0] == "X" && box[2][1] == "X" && box[2][2] == "X") {
                x = 1;
                userWon()
            } else if (box[0][0] == "X" && box[1][0] == "X" && box[2][0] == "X") {
                x = 1;
                userWon()
            } else if (box[0][1] == "X" && box[1][1] == "X" && box[2][1] == "X") {
                x = 1;
                userWon()
            } else if (box[0][2] == "X" && box[1][2] == "X" && box[2][2] == "X") {
                x = 1;
                userWon()
            } else if (box[0][0] == "X" && box[1][1] == "X" && box[2][2] == "X") {
                x = 1;
                userWon()
            } else if (box[0][2] == "X" && box[1][1] == "X" && box[2][0] == "X") {
                x = 1;
                userWon()
            }

            if (box[0][0] == "O" && box[0][1] == "O" && box[0][2] == "O") {
                x = 1;
                aiWon()
            } else if (box[1][0] == "O" && box[1][1] == "O" && box[1][2] == "O") {
                x = 1;
                aiWon()
            } else if (box[2][0] == "O" && box[2][1] == "O" && box[2][2] == "O") {
                x = 1;
                aiWon()
            } else if (box[0][0] == "O" && box[1][0] == "O" && box[2][0] == "O") {
                x = 1;
                aiWon()
            } else if (box[0][1] == "O" && box[1][1] == "O" && box[2][1] == "O") {
                x = 1;
                aiWon()
            } else if (box[0][2] == "O" && box[1][2] == "O" && box[2][2] == "O") {
                x = 1;
                aiWon()
            } else if (box[0][0] == "O" && box[1][1] == "O" && box[2][2] == "O") {
                x = 1;
                aiWon()
            } else if (box[0][2] == "O" && box[1][1] == "O" && box[2][0] == "O") {
                x = 1;
                aiWon()
            }

        }
    });

    function scoreValue(computer,user) {
        let score = 0;

        // sprawdza rzędy
        for (let i = 0; i < box.length; i++) {
            if (box[i][0] === box[i][1] && box[i][1] === box[i][2]) {
                if (box[i][0] == computer) {
                    score = score - 10;
                    break;
                } else if (box[i][0] == user) {
                    score = score + 10;
                    break;
                }
            }
        }

        // sprwdza kolumny
        for (let i = 0; i < box.length; i++) {
            if (box[0][i] === box[1][i] && box[1][i] === box[2][i]) {
                if (box[0][i] === computer) {
                    score = score - 10;
                    break;
                } else if (box[0][i] === user) {
                    score = score + 10;
                    break;
                }
            }
        }

        // sprawdza przekątne
        if (box[0][0] === box[1][1] && box[1][1] === box[2][2]) {
            if (box[0][0] === computer) {
                score = score - 10;
            } else if (box[0][0] === user) {
                score = score + 10;
            }
        }

        if (box[0][2] === box[1][1] && box[1][1] === box[2][0]) {
            if (box[0][2] === computer) {
                score = score - 10;
            } else if (box[0][2] === user) {
                score = score + 10;
            }
        }

        return score;
    }

    function isBoardFull() {
        let isFull = true;
        for (let i = 0; i < 3; i++) {
            for (let j = 0; j < 3; j++) {
                if (box[i][j] == 1) {
                    isFull = false;
                }
            }
        }
        return isFull;
    }

    function minmax(isMaximizing, box, computer, user) {
        let result = scoreValue(computer,user);
        // zwraca wynik sytuacji na planszy
        if (result !== 0) {
            return result;
        }
        if (isBoardFull()) {
            return 0;
        }

        // jeżeli komputer maksyamlizuje wynik
        if (isMaximizing) {
            let bestScore = -Infinity;
            for (let i = 0; i < box.length; i++) {
                for (let j = 0; j < box.length; j++) {
                    // sprawdza czy pole jest wolne
                    if (box[i][j] === 1) {
                        box[i][j] = computer;
                        let score = minmax(false, box,computer,user);
                        bestScore = Math.max(score, bestScore);
                        box[i][j] = 1;
                    }
                }
                console.log("Jestem w max")
            }
            return bestScore;
        } else {
            console.log("Jestem w min")
            let bestScore = Infinity;
            for (let i = 0; i < box.length; i++) {
                for (let j = 0; j < box.length; j++) {
                    // sprawdza czy pole jest wolne
                    if (box[i][j] === 1) {
                        box[i][j] = user;
                        let score = minmax(true, box, computer, user);
                        bestScore = Math.min(score, bestScore);
                        box[i][j] = 1;
                    }
                }
            }
            return bestScore;
        }
    }


    var x = document.getElementById("myAudio");
    var sliderLevel = document.querySelector('#volume-slider')
    x.volume = sliderLevel.value / 100
    sliderLevel.addEventListener("change", function (e) {
        x.volume = e.currentTarget.value / 100;
    })

    function userWon() {
        if (confirm("${username} is a winner") == true) {
            window.location.href = "/app/medium";
        } else {
            window.location.href = "/app/medium"
        }
    }

    function aiWon() {
        if (confirm("AI is a winner") == true) {
            window.location.href = "/app/medium";
        } else {
            window.location.href = "/app/medium"
        }
    }

    function nobodyWon() {
        if (confirm("Nobody won") == true) {
            window.location.href = "/app/medium";
        } else {
            window.location.href = "/app/medium"
        }
    }
</script>

</body>
</html>
