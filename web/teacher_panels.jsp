<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/9
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<div class="container" id="left-part">
    <div class="panel  panel-success">
        <!-- Default panel contents -->
        <div class="panel-heading">开题报告</div>
        <div class="panel-body">
            <p>您已经上传完毕！</p>
        </div>

        <table class="table text-center">
            <tr>
                <td><a onclick="get_ktbg()">列表</a></td>
                <td><a>统计</a></td>
            </tr>
        </table>
    </div>

    <div class="panel  panel-primary">
        <!-- Default panel contents -->
        <div class="panel-heading">毕业论文</div>
        <div class="panel-body">
            <p>尚未开启</p>
        </div>


        <table class="table text-center">
            <tr>
                <td><a onclick="get_bylw()">列表</a></td>
                <td><a>统计</a></td>
            </tr>
        </table>
    </div>


</div>