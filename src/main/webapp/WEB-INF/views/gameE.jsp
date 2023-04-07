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
                    <a href="/app/medium">
                        <button style="width: 118px" type="button">Medium level</button>
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
                    runComputer();
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

        function runComputer() {
            loop = true;
            var x, y;
            while (loop) {
                x = getRandomNumber();
                y = getRandomNumber();
                if (box[x][y] == "1") {
                    break;
                }
            }
            box[x][y] = computer;
            className = "box" + x + y;
            $('.' + className).html(computer);
            $('.position').append('<p>AI clicked :' + x + ',' + y + '</p>');
            checkIfWins();
        }

        function checkIfWins() {
            let x=0;
            if (box[0][0] == "X" && box[0][1] == "X" && box[0][2] == "X") {
                x=1;
                userWon();
            } else if (box[1][0] == "X" && box[1][1] == "X" && box[1][2] == "X") {
                x=1;
                userWon();
            } else if (box[2][0] == "X" && box[2][1] == "X" && box[2][2] == "X") {
                x=1;
                userWon()
            } else if (box[0][0] == "X" && box[1][0] == "X" && box[2][0] == "X") {
                x=1;
                userWon()
            } else if (box[0][1] == "X" && box[1][1] == "X" && box[2][1] == "X") {
                x=1;
                userWon()
            } else if (box[0][2] == "X" && box[1][2] == "X" && box[2][2] == "X") {
                x=1;
                userWon()
            } else if (box[0][0] == "X" && box[1][1] == "X" && box[2][2] == "X") {
                x=1;
                userWon()
            } else if (box[0][2] == "X" && box[1][1] == "X" && box[2][0] == "X") {
                x=1;
                userWon()
            }

            if (box[0][0] == "O" && box[0][1] == "O" && box[0][2] == "O") {
                x=1;
                aiWon()
            } else if (box[1][0] == "O" && box[1][1] == "O" && box[1][2] == "O") {
                x=1;
                aiWon()
            } else if (box[2][0] == "O" && box[2][1] == "O" && box[2][2] == "O") {
                x=1;
                aiWon()
            } else if (box[0][0] == "O" && box[1][0] == "O" && box[2][0] == "O") {
                x=1;
                aiWon()
            } else if (box[0][1] == "O" && box[1][1] == "O" && box[2][1] == "O") {
                x=1;
                aiWon()
            } else if (box[0][2] == "O" && box[1][2] == "O" && box[2][2] == "O") {
                x=1;
                aiWon()
            } else if (box[0][0] == "O" && box[1][1] == "O" && box[2][2] == "O") {
                x=1;
                aiWon()
            } else if (box[0][2] == "O" && box[1][1] == "O" && box[2][0] == "O") {
                x=1;
                aiWon()
            }

        }
    });

    function getRandomNumber() {
        min = 0;
        max = 3;
        return Math.floor(Math.random() * (max - min) + min);
    }

    var x = document.getElementById("myAudio");
    var sliderLevel = document.querySelector('#volume-slider')
    x.volume = sliderLevel.value / 100
    sliderLevel.addEventListener("change", function (e) {
        x.volume = e.currentTarget.value / 100;
    })

    function userWon() {
        if (confirm("${username} is a winner") == true) {
            window.location.href = "/app/game";
        } else {
            window.location.href = "/app/game"
        }
    }

    function aiWon() {
        if (confirm("AI is a winner") == true) {
            window.location.href = "/app/game";
        } else {
            window.location.href = "/app/game"
        }
    }
    function nobodyWon() {
        if (confirm("Nobody won") == true) {
            window.location.href = "/app/game";
        } else {
            window.location.href = "/app/game"
        }
    }
</script>

</body>
</html>
