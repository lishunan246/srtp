<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/9
  Time: 19:56
  To change this template use File | Settings | File Templates.
--%>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8"%>
<!-- Begin page content -->
<div class="row">
    <div class="col-md-3 col-md-offset-1">
        <form id="query-form" role="form">
            <div class="form-group">
                <div class="input-group">
                    <input type="text" id="uid" class="form-control" placeholder="输入学号">
                <span class="input-group-btn">
                    <button class="btn btn-primry" type="button">搜索</button>
                </span>
                </div>
                <!-- /input-group -->

            </div>

            <div class="form-group">
                <div class="input-group">
                    <input type="text" id="uname" class="form-control" placeholder="输入姓名">
                <span class="input-group-btn">
                    <button class="btn btn-primry" type="button">搜索</button>
                </span>
                </div>
                <!-- /input-group -->
            </div>

        </form>
    </div>
    <div class="col-md-7">
        <div class="container" id="right-part">
            <dl class="dl-horizontal">
                <dt>姓名</dt>
                <dd>施潮浩</dd>
                <dt>学号/工号</dt>
                <dd>3120102119</dd>
                <dt>账号类型</dt>
                <dd>学生</dd>
                <dt>操作</dt>
                <dd><a href="#">重设密码为用户id</a></dd>
            </dl>


        </div>
    </div>
</div>


<%@include file="footer.jsp" %>
