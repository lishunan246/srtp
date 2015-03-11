<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/9
  Time: 15:47
  To change this template use File | Settings | File Templates.
  需要一个servlet返回该老师旗下所有学生开题报告的信息
  输入
  根据session判断老师

  返回操作是否成功
  成功返回所有开题报告的信息，输出参数名自定

  失败说明原因

  施朝浩于2015.3.11完成

--%>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!-- Begin page content -->
<div class="row">
    <div class="col-md-3 col-md-offset-1">
        <%@include file="teacher_panels.jsp" %>
    </div>
    <div class="col-md-7">
        <div class="container" id="right-part">
            <table class="table table-hover table-bordered">
                <tr class="info">
                    <td>学号</td>
                    <td>姓名</td>
                    <td>毕业论文/设计</td>
                </tr>
                <tr>
                    <td>学号</td>
                    <td>姓名</td>
                    <td>毕业论文/设计</td>
                </tr>
                <tr>
                    <td>学号</td>
                    <td>姓名</td>
                    <td>毕业论文/设计</td>
                </tr>
                <tr>
                    <td>学号</td>
                    <td>姓名</td>
                    <td>毕业论文/设计</td>
                </tr>
            </table>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>
