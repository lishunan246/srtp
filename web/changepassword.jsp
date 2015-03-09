<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/8
  Time: 22:08
  To change this template use File | Settings | File Templates.

  修改密码
  changepassword.do

  输入见form

  输出

  status
  是否成功

  message
  额外信息

  施朝浩于2015.3.9日完成
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>

<!-- Begin page content -->
<div class="container">
    <form class="form-horizontal" action="changepassword.do" id="change-password-form">
        <div class="form-group">
            <label for="old-password" class="col-sm-2 control-label">旧密码</label>

            <div class="col-sm-10">
                <input type="text" class="form-control" id="old-password" name="old-password" placeholder="请输入旧密码">
            </div>
        </div>
        <div class="form-group">
            <label for="new-password" class="col-sm-2 control-label">新密码</label>

            <div class="col-sm-10">
                <input type="password" class="form-control" id="new-password" name="new-password" placeholder="请输入新密码">
            </div>
        </div>

        <div class="form-group">
            <label for="confirm" class="col-sm-2 control-label">重复输入</label>

            <div class="col-sm-10">
                <input type="password" class="form-control" id="confirm" name="confirm" placeholder="再次输入新密码">
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-primary">更改密码</button>
            </div>
        </div>
    </form>
</div>
<!-- /container -->

<%@include file="footer.jsp" %>
