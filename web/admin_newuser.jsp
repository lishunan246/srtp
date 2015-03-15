<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/15
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!-- Begin page content -->
<div class="row">
    <div class="col-md-6 col-md-offset-2">
        <form id="form_add_user" role="form">
            <div class="form-group">
                <label for="account">学工号</label>
                <input class="form-control" id="account" type="text" placeholder="">
            </div>
            <div class="form-group">
                <label for="name">姓名</label>
                <input class="form-control" id="name" type="text" placeholder="">
            </div>
            <div class="form-group">
                <label>类别</label>

                <div class="radio">
                    <label>
                        <input type="radio" name="type" value="student" checked>
                        学生
                    </label>
                </div>
                <div class="radio">
                    <label>
                        <input type="radio" name="type" value="teacher">
                        老师
                    </label>
                </div>
                <div class="radio">
                    <label>
                        <input type="radio" name="type" value="admin">
                        管理员
                    </label>
                </div>

            </div>
            <div class="form-group">
                <label for="major">专业方向</label>
                <input class="form-control" id="major">
            </div>
            <button type="submit" class="btn btn-primary">提交</button>
        </form>
    </div>
</div>

<script>
    $("#form_add_user").submit(function () {
        var url = "addUser.do";
        var data = {
            account: $("#account").val(),
            name: $("#name").val(),
            type: $('input[name="type"]:checked').val(),
            major: $("#major").val()
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

<%@include file="footer.jsp" %>