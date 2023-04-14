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
                        <button style="width: 118px" type="button">Easy Level</button>
                    </a>
                    <a href="/app/medium">
                        <button style="width: 118px" type="button">Medium Level</button>
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
        var moveCount = 0;
        var box = [
            ['-', '-', '-'],
            ['-', '-', '-'],
            ['-', '-', '-']
        ];

        function runUserSwap($user) {
            x = parseInt($user.data('x'));
            y = parseInt($user.data('y'));

            if ('-' !== box[x][y] && box[x][y] === user) {
                $user.addClass('selected');
                $('.box').not($user).removeClass('selected');
            } else if ($('.selected').length > 0) {
                let selected = $('.selected');
                let prevX = parseInt(selected.data('x'));
                let prevY = parseInt(selected.data('y'));

                let diffX = Math.abs(x - prevX);
                let diffY = Math.abs(y - prevY);

                if ((diffX === 1 && diffY === 0) || (diffX === 0 && diffY === 1)) {
                    if (box[x][y] === '-') {
                        box[prevX][prevY] = '-';
                        box[x][y] = user;
                        $('.selected').html('-').removeClass('selected');
                        $user.html(user);
                        moveCount++;
                        $('.position').append('<p class="communicat">${username} moved from (' + prevX + ',' + prevY + ') to (' + x + ',' + y + ')</p>');
                        if (!gameOver(box, computer, user, checkWin(box,user), isBoardFull(box))) {
                            bestMoveSwap(box, computer, user);
                            moveCount++;
                        } else {
                            checkGameOver(box);
                        }
                    }
                }
            }
        }


        $('.box').click(function () {
            if (moveCount < 6) {
                runUser($(this), function () {
                    moveCount++;
                    if (!gameOver(box, computer, user)) {
                        bestMove(box, computer, user, minMax(false, box, computer, user), isBoardFull(box), gameOver(box, computer, user));
                        moveCount++;
                    } else {
                        gameEndMessage();
                    }
                });
            } else {
                runUserSwap($(this));
            }
        });


        function bestMoveSwap(board, computer, user) {
            let bestScore = -Infinity;
            let bestMove = {from: {x: -1, y: -1}, to: {x: -1, y: -1}};
            for (let i = 0; i < board.length; i++) {
                for (let j = 0; j < board.length; j++) {
                    if (board[i][j] === computer) {
                        let possibleMoves = [
                            {x: i - 1, y: j}, // up
                            {x: i + 1, y: j}, // down
                            {x: i, y: j - 1}, // left
                            {x: i, y: j + 1}  // right
                        ];

                        for (let move of possibleMoves) {
                            let x = move.x;
                            let y = move.y;
                            if (x >= 0 && x < board.length && y >= 0 && y < board.length && board[x][y] === '-') {
                                let temp = board[i][j];
                                board[i][j] = '-';
                                board[x][y] = computer;
                                let score = minMax(false, board, computer, user);
                                board[x][y] = '-';
                                board[i][j] = temp;
                                if (score > bestScore) {
                                    bestScore = score;
                                    bestMove = {from: {x: i, y: j}, to: {x, y}};
                                }
                            }
                        }
                    }
                }
            }
            if (!isBoardFull(board) && !gameOver(board, computer, user, checkWin, isBoardFull)) {
                board[bestMove.from.x][bestMove.from.y] = '-';
                board[bestMove.to.x][bestMove.to.y] = computer;
                let fromClass = "box" + bestMove.from.x + bestMove.from.y;
                let toClass = "box" + bestMove.to.x + bestMove.to.y;
                $('.' + fromClass).html('-');
                $('.' + toClass).html(computer);
                $('.position').append('<p class="communicat">AI moved from (' + bestMove.from.x + ',' + bestMove.from.y + ') to (' + bestMove.to.x + ',' + bestMove.to.y + ')</p>');
            }

            // Call checkGameOver function
            checkGameOver(board);
        }

        function gameEndMessage() {
            $('.position').append('<p>Game End</p>');
            nobodyWon();
        }


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

        function gameOver(board, computer, user) {
            if (checkWin(board, user)) {
                return user;
            } else if (checkWin(board, computer)) {
                return computer;
            } else if (isBoardFull(board)) {
                return '-';
            } else {
                return null;
            }
        }

        function checkGameOver(board) {
            let result = gameOver(board, computer, user);
            if (result === 'X') {
                userWon();
            } else if (result === 'O') {
                computerWon();
            } else if (result === '-') {
                nobodyWon();
            }
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

        function minMax(isMaximizing, board, computer, user) {
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
                            let score = minMax(false, board, computer, user);
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
                            let score = minMax(true, board, computer, user);
                            bestScore = Math.min(score, bestScore);
                            board[i][j] = '-';
                        }
                    }
                }
                return bestScore;
            }
        }

        function bestMove(board, computer, user, minMax, isBoardFull, gameOver) {
            let bestScore = -Infinity;
            let row = -1;
            let col = -1;
            for (let i = 0; i < board.length; i++) {
                for (let j = 0; j < board.length; j++) {
                    if (board[i][j] === '-') {
                        board[i][j] = computer;
                        let score = minMax;
                        board[i][j] = '-';
                        if (score > bestScore) {
                            bestScore = score;
                            row = i;
                            col = j;
                        }
                    }
                }
            }
            if (!isBoardFull && !gameOver) {
                board[row][col] = computer;
                className = "box" + row + col;
                $('.' + className).html(computer);
                $('.position').append('<p class="communicat">AI clicked :' + row + ',' + col + '</p>');
            }else {
                checkGameOver(box);
            }
        }

        function runUser($user, callback) {
            x = parseInt($user.data('x'));
            y = parseInt($user.data('y'));
            if ('-' == box[x][y]) {
                box[x][y] = user;

                className = "box" + x + y;
                $('.' + className).html(user);
                $('.position').append('<p class="communicat">${username} clicked :' + x + ',' + y + '</p>');

                if (!gameOver(box, computer, user)) {
                    callback();
                } else {
                    checkGameOver(box);
                }
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
                window.location.href = "/app/hard";
            } else {
                window.location.href = "/app/hard";
            }
        }

        function computerWon() {
            if (confirm("Computer won") == true) {
                window.location.href = "/app/hard";
            } else {
                window.location.href = "/app/hard";
            }
        }

        function userWon() {
            if (confirm("User won") == true) {
                window.location.href = "/app/hard";
            } else {
                window.location.href = "/app/hard";
            }
        }
    });
</script>


</body>
</html>
