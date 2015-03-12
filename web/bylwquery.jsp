<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/5
  Time: 20:20
  学生对毕业论文状态的查询页面
  bylwqyery.do

  无输入参数，根据session判断学生是否登陆及其id
  返回值：
  status
  true
  false
    查询是否成功

  message
    额外错误信息

  intro
    内容摘要

  uploaded
  true
  false
    文件是否已上传

  supervisorpass
  bool
  supervisorcomment
    导师评论
  anonymouspass
  bool 是否通过盲审
  anonymouscomment
  盲审评论

    grade
    得分

    施朝浩于2015.3.11完成

--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>

<!-- Begin page content -->
<div class="row">
    <div class="col-md-3 col-md-offset-1">
        <%@include file="panels.jsp" %>
    </div>
    <div class="col-md-7">
        <div class="container" id="right-part">
            <form role="form">

                <div class="form-group">
                    <label for="intro">论文摘要</label>
                    <textarea id="intro" class="form-control" rows="5" disabled>Good job</textarea>
                </div>

                <div class="form-group">
                    <label>上传状态</label>

                    <p id="uploaded"></p>
                </div>

                <div class="form-group">
                    <label>盲审老师审核状态</label>

                    <p id="ms_pass">通过<span class="glyphicon glyphicon-ok"></span></p>
                </div>
                <div class="form-group">
                    <label for="ms_comment">盲审老师审核评语</label>
                    <textarea id="ms_comment" class="form-control" rows="5" disabled>Good job</textarea>
                </div>

                <div class="form-group">
                    <label>导师审核状态</label>

                    <p id="ds_pass">通过<span class="glyphicon glyphicon-ok"></span></p>
                </div>
                <div class="form-group">
                    <label for="ds_comment">导师审核评语</label>
                    <textarea class="form-control" id="ds_comment" rows="5" disabled>Good job</textarea>
                </div>
                <div class="form-group">
                    <label>总成绩</label>

                    <div class="progress">
                        <div class="progress-bar" role="progressbar" id="grade" aria-valuenow="40"
                             aria-valuemin="0" aria-valuemax="100" style="width: 90%">
                            90分
                            <span class="sr-only">90% Complete (success)</span>
                        </div>
                    </div>
                </div>


            </form>

        </div>


    </div>
</div>

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
                $("#intro").val(obj.intro);
                if (obj.uploaded) {
                    $("#uploaded").text("已上传");
                }
                else {
                    $("#uploaded").text("未上传");
                }

                $("#ds_comment").val(obj.supervisorcomment);
                $("#ms_comment").val(obj.anonymouscomment);
                $("#grade").text(obj.grade).attr("style", "width: " + obj.grade + "%");

                if (obj.supervisorpass) {
                    $("#ds_pass").text("已通过");
                }
                else {
                    $("#ds_pass").text("未通过");
                }

                if (obj.anonymouspass) {
                    $("#ms_pass").text("已通过");
                }
                else {
                    $("#ms_pass").text("未通过");
                }
            }
        })
    })
</script>

<%@include file="footer.jsp" %>