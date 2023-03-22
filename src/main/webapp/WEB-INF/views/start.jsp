<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="header.jsp"%>

<section class="padding-large bg-light">
    <div id="carouselExampleControls" class="carousel slide main-slider" data-ride="carousel">
        <div class="carousel-inner container">
            <div class="carousel-item active">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.1 of instruction: This is a game board. It is 3x3</h2>
                        <img src="<c:url value="/css/images/ttt.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.2: The first move belongs to X</h2>
                        <img src="<c:url value="/css/images/ttt1.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.2: The second move belongs to O</h2>
                        <img src="<c:url value="/css/images/ttt2.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.3: Until both players make 3 moves...</h2>
                        <img src="<c:url value="/css/images/ttt3.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.4: ...The game is on</h2>
                        <img src="<c:url value="/css/images/ttt4.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.5: The exception is when 3 identical characters will be...</h2>
                        <img src="<c:url value="/css/images/ttt5.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.6: ...in one line: vertical/horizontal/diagonal</h2>
                        <img src="<c:url value="/css/images/ttt6.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.7: If both players make 3 moves and no one has won yet, the rules change</h2>
                        <img src="<c:url value="/css/images/ttt6.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.8: From now you can move previously placed marks, but only vertical/horizontal!</h2>
                        <img src="<c:url value="/css/images/ttt7.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Step no.9: So X can do this:</h2>
                        <img src="<c:url value="/css/images/ttt8.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Finally step no.10: and get a point for Win!</h2>
                        <img src="<c:url value="/css/images/ttt9.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container w-75 d-flex">
                    <div class="carousel-caption d-block">
                        <h2 class="pb-3">Sign up and enjoy! :D</h2>
                        <img src="<c:url value="/css/images/me.jpg"/>" alt="" width="600" height="400">
                    </div>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</section>

<section class="section-more padding-small">
    <div class="container d-flex justify-content-between">
        <div class="mr-4">
            <h1 class="pb-3">You can enjoy and play this awesome game! </h1>
            <h4 class="pt-1">Sign in/Sign up to play</h4>
        </div>
        <div class="ml-4 align-self-center">
            <button class="btn btn-color rounded-0 mt-4 pl-4 pr-4">
                <a href="/login">Play</a>
            </button>
        </div>
    </div>
</section>

<%@include file="footer.jsp"%>