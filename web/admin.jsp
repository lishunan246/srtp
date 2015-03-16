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
    <div class="col-md-6 col-md-offset-3">
        <form id="form_search" role="form">
            <div class="form-group">
                <div class="input-group">
                    <input type="text" id="uid" class="form-control" placeholder="输入学号">
                <span class="input-group-btn">
                    <button class="btn btn-primry" type="submit">搜索</button>
                </span>
                </div>
                <!-- /input-group -->

            </div>

            <table id="table_search_result" class="table">
                <tr>
                    <td>学工号</td>
                    <td>姓名</td>
                    <td>类型</td>
                    <td>操作</td>
                </tr>
            </table>

        </form>
    </div>

</div>

<script>
    $("#form_search").submit(function () {
        $(".result").remove();
        var data = {
            "uid": $("#uid").val()
        };

        $.ajax({
            type: "POST",
            url: "queryUser.do",
            data: data,
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
                if (obj.count == 0) {
                    alert("无符合的结果");
                    return false;
                }
                for (var i = 0; i < obj.count; i++) {
                    $("#table_search_result").append('<tr class="result"><td>' + obj.user[i].account + '</td><td>' + obj.user[i].name + '</td><td>' + obj.user[i].type + '</td></tr>');
                }
            }
        });
        return false;
    })
</script>

<%@include file="footer.jsp" %>
