<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tic Tac Toe</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href='<c:url value='/css/game.css'/>'>
    <style>
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }

        th, td {
            border: 1px solid white;
            color: white;
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
<div style="text-align: right; padding-bottom: 20px;">
    <a href="/app/logout">
        <button type="button">Log out</button>
    </a>
</div>

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

<table>
    <thead>
    <tr>
        <th>Username</th>
        <th>User Points</th>
        <th>AI Points</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="item">
        <tr>
            <td>${item.userName}</td>
            <td>${item.score}</td>
            <c:if test="${item == list[0]}">
                <td rowspan="${fn:length(list)}">${aiScore}</td>
            </c:if>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>