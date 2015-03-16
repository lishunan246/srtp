<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/15
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!-- Begin page content -->
<div class="row">
    <div class="col-md-6 col-md-offset-2">
        <form id="form_reset_pw" role="form">
            <div class="form-group">
                <label for="account">学工号</label>
                <input class="form-control" id="account" type="text" placeholder="">
            </div>

            <button type="submit" class="btn btn-primary">重置密码为学工号</button>
        </form>
    </div>
</div>

<script>
    $("#form_reset_pw").submit(function () {
        var url = "resetPwd.do";
        var data = {
            account: $("#account").val()
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
                alert("重置成功！");
            }
        });
        return false;
    });
</script>

<%@include file="footer.jsp" %>