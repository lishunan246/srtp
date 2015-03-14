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

<div class="modal fade" id="modal_uid">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">根据学号、工号搜索用户</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <div class="input-group">
                        <input type="text" id="uid" class="form-control" placeholder="输入学号">

                    </div>
                    <!-- /input-group -->

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="doSearchByUid()" data-dismiss="modal">搜索</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<div class="row">
    <div class="col-md-6 col-md-offset-3">
        <form id="query-form" role="form">
            <div class="form-group">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="输入学号">
                <span class="input-group-btn">
                    <button class="btn btn-primry" type="button">搜索</button>
                </span>
                </div>
                <!-- /input-group -->

            </div>

            <%--<div class="form-group">--%>
            <%--<div class="input-group">--%>
            <%--<input type="text" id="uname" class="form-control" placeholder="输入姓名">--%>
            <%--<span class="input-group-btn">--%>
            <%--<button class="btn btn-primry" type="button">搜索</button>--%>
            <%--</span>--%>
            <%--</div>--%>
            <%--<!-- /input-group -->--%>
            <%--</div>--%>

        </form>
    </div>
    <%--<div class="col-md-7">--%>
    <%--<div class="container" id="right-part">--%>
    <%--<dl class="dl-horizontal">--%>
    <%--<dt>姓名</dt>--%>
    <%--<dd>施潮浩</dd>--%>
    <%--<dt>学号/工号</dt>--%>
    <%--<dd>3120102119</dd>--%>
    <%--<dt>账号类型</dt>--%>
    <%--<dd>学生</dd>--%>
    <%--<dt>操作</dt>--%>
    <%--<dd><a href="#">重设密码为用户id</a></dd>--%>
    <%--</dl>--%>


    <%--</div>--%>
    <%--</div>--%>
</div>

<script>
    function searchByUid() {
        $("#modal_uid").modal('toggle');
    }

    function doSearchByUid() {
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

            }
        })

    }
</script>

<%@include file="footer.jsp" %>
