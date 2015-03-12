<%--
需要一个查询开题报告状态的servlet
url ktbgquery.do
根据当前sesseion判断是哪个学生登陆
无输入参数

返回参数：

status
true 查询成功
false 出错

massage
出错原因，如未登陆，数据库异常等

name_en
英文名

name_cn
中文名

type
lw：毕业论文
sj：毕业设计

teacher_pass

true通过，否则false
teacher_comment

教师评论
grade
得分

施朝浩于2015.3.9完成
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
                    <form role="form" action="ktbgquery.do">
                        
                         <div class="form-group">
                             <label for="name_en">毕业设计名称（英文）</label>
                             <input class="form-control" id="name_en" type="text" disabled>
                        </div>
                         <div class="form-group">
                             <label for="name_cn">毕业设计名称（中文）</label>
                             <input class="form-control" id="name_cn" type="text" disabled>
                        </div>
                        <div class="form-group">
                            <label>类别</label>
                            <fieldset disabled>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="ktbg-type" value="lw">
                                        毕业论文
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="ktbg-type" id="sj" value="sj">
                                        毕业设计
                                    </label>
                                </div>
                            </fieldset >
                        </div>
                        <div class="form-group">
                            <label>老师审核状态</label>

                            <p id="teacher_pass">
                                <strong>通过<span class="glyphicon glyphicon-ok"></span></strong>
                            </p>
                        </div>
                        <div class="form-group">
                            <label for="teacher_comment">老师审核评语</label>
                            <textarea id="teacher_comment" class="form-control" rows="5" disabled>Good job</textarea>
                        </div>
                        <div class="form-group">
                             <label>总成绩</label>
                            <div class="progress">
                                <div class="progress-bar progress-bar-success" id="grade" role="progressbar"
                                     aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 90%">
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
            url: "ktbgquery.do",
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
                $("#name_cn").val(obj.name_cn);
                $("#name_en").val(obj.name_en);
                $('input[name="ktbg-type"][value="' + obj.type + '"]').prop('checked', true);
                //$("#description").text(obj.description);
                $("#teacher_comment").val(obj.teacher_comment);
                $("#grade").text(obj.grade).attr("style", "width: " + obj.grade + "%");

                if (obj.teacher_pass) {
                    $("#teacher_pass").text("已通过");
                }
                else {
                    $("#teacher_pass").text("未通过");
                }

            }
        })
    })
</script>

<%@include file="footer.jsp" %>