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
        <form id="query-form" role="form" action="manageUser.do" method="post">
            <div class="form-group">
                <label for="uid">学号（工号）</label>
                <input class="form-control" name="uid" id="uid" type="text" placeholder="">
            </div>
            <div class="form-group">
                <label for="uname">姓名</label>
                <input class="form-control" name="uname" id="uname" type="text" placeholder="">
            </div>
            <button type="submit" class="btn btn-primary">搜索</button>
        </form>
    </div>
    <div class="col-md-7">
        <div class="container" id="right-part">
        <tr><td>账号</td><td>姓名</td><td>类型</td><td>详情</td></tr>


        </div>
    </div>
</div>


<%@include file="footer.jsp" %>
