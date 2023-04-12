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
            ['-', '-', '-'],
            ['-', '-', '-'],
            ['-', '-', '-']
        ];

        function isBoardFull(board) {
            let isFull = true;
            for (let i = 0; i < 3; i++) {
                for (let j = 0; j < 3; j++) {
                    if (board[i][j] === '-') {
                        isFull = false;
                    }
                }
            }
            return isFull;
        }

        function checkWin(board, player) {
            for (let i = 0; i < 3; i++) {
                if (board[i][0] === player && board[i][1] === player && board[i][2] === player) {
                    return true;
                }
                if (board[0][i] === player && board[1][i] === player && board[2][i] === player) {
                    return true;
                }
            }
            if (board[0][0] === player && board[1][1] === player && board[2][2] === player) {
                return true;
            }
            if (board[0][2] === player && board[1][1] === player && board[2][0] === player) {
                return true;
            }
            return false;
        }

        function gameOver(board, computer, user, checkWin, isBoardFull) {
            return (checkWin(board, user) || checkWin(board, computer) || isBoardFull(board));
        }

        function scoreValue(board, computer, user) {
            let score = 0;

            // Check rows
            for (let i = 0; i < board.length; i++) {
                if (board[i][0] === board[i][1] && board[i][1] === board[i][2]) {
                    if (board[i][0] === computer) {
                        score = score + 10;
                        break;
                    } else {
                        score = score - 10;
                        break;
                    }
                }
            }

            // Check columns
            for (let i = 0; i < board.length; i++) {
                if (board[0][i] === board[1][i] && board[1][i] === board[2][i]) {
                    if (board[0][i] === computer) {
                        score = score + 10;
                        break;
                    } else if (board[0][i] === user) {
                        score = score - 10;
                        break;
                    }
                }
            }

            // Check diagonals
            if (board[0][0] === board[1][1] && board[1][1] === board[2][2]) {
                if (board[0][0] === computer) {
                    score = score + 10;
                } else {
                    score = score - 10;
                }
            }

            if (board[0][2] === board[1][1] && board[1][1] === board[2][0]) {
                if (board[0][2] === computer) {
                    score = score + 10;
                } else {
                    score = score - 10;
                }
            }

            return score;
        }

        function minmax(isMaximizing, board, computer, user, scoreValue) {
            const result = scoreValue(board, computer, user);
            if (result !== 0) {
                return result;
            }
            if (isBoardFull(board)) {
                return 0;
            }

            if (isMaximizing) {
                let bestScore = -Infinity;
                for (let i = 0; i < board.length; i++) {
                    for (let j = 0; j < board.length; j++) {
                        if (board[i][j] === '-') {
                            board[i][j] = computer;
                            let score = minmax(false, board, computer, user, scoreValue);
                            bestScore = Math.max(score, bestScore);
                            board[i][j] = '-';
                        }
                    }
                }
                return bestScore;
            } else {
                let bestScore = Infinity;
                for (let i = 0; i < board.length; i++) {
                    for (let j = 0; j < board.length; j++) {
                        if (board[i][j] === '-') {
                            board[i][j] = user;
                            let score = minmax(true, board, computer, user, scoreValue);
                            bestScore = Math.min(score, bestScore);
                            board[i][j] = '-';
                        }
                    }
                }
                return bestScore;
            }
        }

        function bestMove(board, computer, user, minmax, isBoardFull, gameOver) {
            let bestScore = -Infinity;
            let row = -1;
            let col = -1;
            for (let i = 0; i < board.length; i++) {
                for (let j = 0; j < board.length; j++) {
                    if (board[i][j] === '-') {
                        board[i][j] = computer;
                        let score = minmax(false, board, computer, user, scoreValue);
                        board[i][j] = '-';
                        if (score > bestScore) {
                            bestScore = score;
                            row = i;
                            col = j;
                        }
                    }
                }
            }
            if (!isBoardFull(board) && !gameOver(board, computer, user, checkWin, isBoardFull)) {
                board[row][col] = computer;
                className = "box" + row + col;
                $('.' + className).html(computer);
                $('.position').append('<p class="communicat">AI clicked :' + row + ',' + col + '</p>');
            }
        }

        $('.box').click(function () {
            runUser($(this), function () {
                if (checkWin(box, user)) {
                    userWon();
                } else if (!gameOver(box, computer, user, checkWin, isBoardFull)) {
                    bestMove(box, computer, user, minmax, isBoardFull, gameOver);
                    if (checkWin(box, computer)) {
                        computerWon();
                    }
                } else {
                    $('.position').append('<p>Game End</p>');
                    nobodyWon();
                }
            });
        });

        function runUser($user, callback) {
            x = parseInt($user.data('x'));
            y = parseInt($user.data('y'));
            if ('-' == box[x][y]) {
                box[x][y] = user;

                className = "box" + x + y;
                $('.' + className).html(user);
                $('.position').append('<p class="communicat">${username} clicked :' + x + ',' + y + '</p>');
                callback();
            } else {
                alert("This is already used");
            }
        }

        var x = document.getElementById("myAudio");
        var sliderLevel = document.querySelector('#volume-slider')
        x.volume = sliderLevel.value / 100
        sliderLevel.addEventListener("change", function (e) {
            x.volume = e.currentTarget.value / 100;
        })

        function nobodyWon() {
            if (confirm("Nobody won") == true) {
                window.location.href = "/app/medium";
            } else {
                window.location.href = "/app/medium";
            }
        }

        function computerWon() {
            if (confirm("Computer won") == true) {
                window.location.href = "/app/medium";
            } else {
                window.location.href = "/app/medium";
            }
        }

        function userWon() {
            if (confirm("User won") == true) {
                window.location.href = "/app/medium";
            } else {
                window.location.href = "/app/medium";
            }
        }
    });
</script>

</body>
</html>
