<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="header.jsp" %>

<section class="dashboard-section">
    <div class="container pt-4 pb-4">
        <div class="border-dashed view-height">
            <div class="container w-25">

                <form class="padding-small text-center" method="post">
                    <%--                    <form:form method="post" modelAttribute="user">--%>
                    <div>
                        If you don't have an account go to <a href="<c:url value="/login/register"/>">Registration
                        page</a>
                    </div>
                    <h1 class="text-color-darker">Sign in to Training Recorder</h1>
                    <div class="form-group">
                        <input type="text" class="form-control" id="userName" name="userName" placeholder="name">
                        <%--                        <form:input path="userName" placeholder="first name"/>--%>
                        <%--                                <form:errors path="userName"/>--%>

                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" id="password" name="password"
                               placeholder="password">
                        <%--                                <form:password path="password" placeholder="password"/>--%>
                        <%--                                <form:errors path="password"/>--%>
                    </div>
                    <button class="btn btn-color rounded-0" type="submit">Sign in</button>
                    <%--                </form:form>--%>
                </form>
                <c:if test="${param.error == true}">
                    <p>Login failed</p>
                </c:if>
            </div>

        </div>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
</body>
</html>