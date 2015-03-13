<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/9
  Time: 15:31
  To change this template use File | Settings | File Templates.
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
            <div class="tabbable" id="tabs-874202">
                <ul class="nav nav-pills">
                    <li class="active">
                        <a href="#panel-877184" data-toggle="tab">您指导的学生 <span id="ds_count"
                                                                               class="badge">...</span></a>
                    </li>
                    <li>
                        <a href="#panel-832086" data-toggle="tab">您盲审的学生 <span id="md_count"
                                                                               class="badge">...</span></a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane" id="panel-877184">
                        <table id="ds_table" class="table table-hover table-bordered">
                            <tr class="info">
                                <td>学号</td>
                                <td>姓名</td>
                                <td>毕业论文/设计</td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane active" id="panel-832086">
                        <table id="ms_table" class="table table-hover table-bordered">
                            <tr class="info">
                                <td>学号</td>
                                <td>姓名</td>
                                <td>毕业论文/设计</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $.ajax({
            type: "GET",
            url: "ktbgmangdaolist.do",
            timeout: 500,
            statusCode: {
                500: function () {
                    alert(" 500 data still loading");
                    console.log('500 ');
                }
            },
            error: function (request, status, err) {
                if (status == "timeout") {
                    showError("服务器无响应");
                }
                else {
                    alert(request + status + err);
                }
            }
        }).done(function (msg) {
            console.log(msg);
            var obj = JSON.parse(msg);
            if (!obj.status) {
                alert(obj.message);
            }
            else {
                if (obj.count) {
                    for (var i = 0; i < obj.count; i++) {
                        $("#ms_table").append('<tr><td>' + obj.student[i].sid + '</td> <td>' + obj.student[i].sname + '</td> <td>' + obj.student[i].name_cn + '</td> </tr>');
                    }
                } else {
                    alert("no one");
                }
            }
        })
    })
</script>

<%@include file="footer.jsp" %>
