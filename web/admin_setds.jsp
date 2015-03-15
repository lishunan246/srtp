<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/15
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!-- Begin page content -->
<div class="row">
    <div class="col-md-6 col-md-offset-2">
        <form id="form_set_ds" role="form">
            <div class="form-group">
                <label for="dsaccount">导师工号</label>
                <input class="form-control" id="dsaccount" type="text" placeholder="">
            </div>
            <div class="form-group">
                <label for="saccount">学生学号</label>
                <input class="form-control" id="saccount" type="text" placeholder="">
            </div>

            <button type="submit" class="btn btn-primary">提交</button>
        </form>
    </div>
</div>

<script>
    $("#form_set_ds").submit(function () {
        var url = "addDaoshi.do";
        var data = {
            saccount: $("#saccount").val(),
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
                alert("修改成功！");
            }
        });
        return false;
    });
</script>

<%@include file="footer.jsp" %>