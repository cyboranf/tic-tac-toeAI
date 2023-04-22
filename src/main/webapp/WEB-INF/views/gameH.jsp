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
                    <div>
                        <span style="color: white">Who should start?:</span>
                        <a href="/app/hard">
                            <button style="width: 102px" type="button" id="user-start">User</button>
                        </a>
                        <a href="/app/hardB">
                            <button style="width: 102px" type="button" id="computer-start">Computer</button>
                        </a>
                    </div>
                    <a href="/app/table">
                        <button style="width: 118px" type="submit">Game's history</button>
                    </a>
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

        //user move in second part of game
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
                        $('.selected').html('').removeClass('selected');
                        $user.html(user);
                        moveCount++;
                        $('.position').append('<p class="communicat">${username} moved from (' + prevX + ',' + prevY + ') to (' + x + ',' + y + ')</p>');

                        if (!gameOver(box, user, computer, checkWin(box, user), isBoardFull(box))) {
                            $('.box[data-x="' + x + '"][data-y="' + y + '"]').on('click', function () {
                                runUserSwap($(this));
                            });
                        } else {
                            setTimeout(function () {
                                checkGameOver(board);
                            }, 2000); // Add a 2-second delay
                        }

                        setTimeout(function () {
                            bestMoveSwap(box, computer, user);
                            moveCount++;
                        }, 2000); // Add a 2-second delay
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

        //AI move in second part of game
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
                $('.' + fromClass).html('');
                $('.' + toClass).html(computer);
                $('.position').append('<p class="communicat">AI moved from (' + bestMove.from.x + ',' + bestMove.from.y + ') to (' + bestMove.to.x + ',' + bestMove.to.y + ')</p>');
            }

            // Call checkGameOver function with a 2-second delay
            setTimeout(function () {
                checkGameOver(board);
            }, 2000);
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

        //function check is it end
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

        //function to show info about a winner
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

        //function which help minmax algorithm do the best move
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

        //First version of minMax algorithm
        //The issue stems from the fact that the minMax function is designed
        // to work with the first part of the game and not the second part, where swapping is allowed.

        // function minMax(isMaximizing, board, computer, user) {
        //     let winner = checkWin(board, computer) ? computer : checkWin(board, user) ? user : null;
        //
        //     if (winner !== null) {
        //         return winner === computer ? 10 : -10;
        //     }
        //
        //     if (isBoardFull(board)) {
        //         return 0;
        //     }
        //
        //     if (isMaximizing) {
        //         let bestScore = -Infinity;
        //         for (let i = 0; i < board.length; i++) {
        //             for (let j = 0; j < board.length; j++) {
        //                 if (board[i][j] === '-') {
        //                     board[i][j] = computer;
        //                     let score = minMax(false, board, computer, user);
        //                     bestScore = Math.max(score, bestScore);
        //                     board[i][j] = '-';
        //                 }
        //             }
        //         }
        //         return bestScore;
        //     } else {
        //         let bestScore = Infinity;
        //         for (let i = 0; i < board.length; i++) {
        //             for (let j = 0; j < board.length; j++) {
        //                 if (board[i][j] === '-') {
        //                     board[i][j] = user;
        //                     let score = minMax(true, board, computer, user);
        //                     bestScore = Math.min(score, bestScore);
        //                     board[i][j] = '-';
        //                 }
        //             }
        //         }
        //         return bestScore;
        //     }
        // }

        //New minmax algorithm
        function minMax(isMaximizing, board, computer, user, depth = 0, maxDepth = 3) {
            const result = scoreValue(board, computer, user);
            if (result !== 0) {
                return result;
            }
            if (isBoardFull(board) || depth === maxDepth) {
                return 0;
            }

            if (isMaximizing) {
                let bestScore = -Infinity;
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
                                    let score = minMax(false, board, computer, user, depth + 1, maxDepth);
                                    board[x][y] = '-';
                                    board[i][j] = temp;
                                    bestScore = Math.max(score, bestScore);
                                }
                            }
                        }
                    }
                }
                return bestScore;
            } else {
                let bestScore = Infinity;
                for (let i = 0; i < board.length; i++) {
                    for (let j = 0; j < board.length; j++) {
                        if (board[i][j] === user) {
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
                                    board[x][y] = user;
                                    let score = minMax(true, board, computer, user, depth + 1, maxDepth);
                                    board[x][y] = '-';
                                    board[i][j] = temp;
                                    bestScore = Math.min(score, bestScore);
                                }
                            }
                        }
                    }
                }
                return bestScore;
            }
        }

        //AI move in first part of game
        function bestMove(board, computer, user) {
            let bestScore = -Infinity;
            let move;

            for (let i = 0; i < board.length; i++) {
                for (let j = 0; j < board.length; j++) {
                    if (board[i][j] === '-') {
                        board[i][j] = computer;
                        // Increase the depth of the minMax algorithm to improve the AI performance
                        let score = minMax(false, board, computer, user, 1, 3);
                        board[i][j] = '-';
                        if (score > bestScore) {
                            bestScore = score;
                            move = { i, j };
                        }
                    }
                }
            }

            board[move.i][move.j] = computer;
            let className = "box" + move.i + move.j;
            $('.' + className).html(computer);
            $('.position').append('<p class="communicat">AI clicked :' + move.i + ',' + move.j + '</p>');

            if (gameOver(board, computer, user)) {
                setTimeout(function () {
                    checkGameOver(board);
                }, 2000); // Add a 2-second delay
            }
        }

        //users move
        function runUser($user, callback) {
            x = parseInt($user.data('x'));
            y = parseInt($user.data('y'));
            if ('-' == box[x][y]) {
                box[x][y] = user;

                className = "box" + x + y;
                $('.' + className).html(user);
                $('.position').append('<p class="communicat">${username} clicked :' + x + ',' + y + '</p>');

                if (!gameOver(box, computer, user)) {
                    setTimeout(function () {
                        callback();
                    }, 2000); // Add a 2-second delay
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
