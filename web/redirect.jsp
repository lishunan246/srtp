<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/9
  Time: 19:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <title>正在跳转</title>

</head>

<body>
<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        $.ajax({
            type: "GET",
            url: "currentuser.do",
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
            if (obj.status) {
                if (obj.type == "admin") {
                    window.location.href = "../admin.jsp";
                }
                else if (obj.type == "student") {
                    window.location.href = "../index.jsp";
                }
                else if (obj.type == "teacher") {
                    window.location.href = "../teacher.jsp";
                }
                else {
                    alert(obj.message);
                    window.location.href = "../login.jsp";
                }
            }
            else
            {
                alert(obj.message);
                window.location.href = "../login.jsp";
            }
        });
    });

</script>

</body>
</html>
