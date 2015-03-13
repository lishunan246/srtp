<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/5
  Time: 19:59
  提交论文摘要
  servlet url bylw.do

  输入见form

  输出

  status
  true 成功
  false 失败

  message
  额外信息，如失败原因

  施朝浩于2015.3.9完成
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
                    <textarea id="intro" name="intro" class="form-control" rows="10"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">提交</button>
            </form>
        </div>
    </div>

    <%@include file="footer.jsp" %>

    <script>
        $(document).ready(function () {
            $.ajax({
                type: "GET",
                url: "bylwquery.do",
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
                    $("#intro").text(obj.intro);
                }
            })
        });

        $("#bylw-form").submit(function () {
            var url = "bylw.do";
            var data = {
                intro: $("#intro").val(),
            };
            console.log(JSON.stringify(data));
            $.ajax({
                type: "POST",
                url: url,
                data: data
            }).done(function (msg) {
                console.log(msg);
                var obj = JSON.parse(msg);
                if (!obj.status) {
                    showError(obj.message);
                }
                else {
                    alert("修改成功！");
                }
            });
            return false;
        });
    </script>

