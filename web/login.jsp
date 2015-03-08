<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>

<!-- Begin page content -->
<div class="container">
    <form id="login-form" class="form-signin" role="form">
        <h2 class="form-signin-heading">请登录</h2>
        <input type="text" id="user" class="form-control" placeholder="学号" onfocus="hideAlertBox()" required autofocus>
        <input type="password" id="password" class="form-control" placeholder="密码" onfocus="hideAlertBox()" required>

        <div class="checkbox">
            <label>
                <input type="checkbox" id="remember-me"> 记住我
            </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
    </form>
</div>
<!-- /container -->

<%@include file="footer.jsp" %>