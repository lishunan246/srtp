<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
        
    <!-- Begin page content -->
        <div class="container">

            <form class="form-signin" role="form" onsubmit="login_submit()">
                <h2 class="form-signin-heading">请登录</h2>
                <input type="text" class="form-control" placeholder="学号" required autofocus>
                <input type="password" class="form-control" placeholder="密码" required>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" value="remember-me"> 记住我
                    </label>
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit" >登录</button>
            </form>

        </div> <!-- /container -->  

        <div id="login-validate" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-sm">
            <div class="modal-content">
              ...
            </div>
          </div>
        </div>              
<%@include file="footer.jsp" %>