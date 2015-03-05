<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/5
  Time: 19:59
  To change this template use File | Settings | File Templates.
--%>

<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!-- Begin page content -->
<div class="row">
    <div class="col-md-3 col-md-offset-1">
        <%@include file="panels.jsp" %>
    </div>
    <div class="col-md-7">
        <div class="container" id="right-part">
            <form id="bylw-form" role="form" action="bylw.do" method="post">

                <div class="form-group">
                    <label for="intro">论文摘要</label>
                    <textarea id="intro" name="intro" class="form-control" rows="5"></textarea>
                </div>
                <button type="submit" class="btn btn-default">提交</button>
            </form>
        </div>
    </div>

    <%@include file="footer.jsp" %>
