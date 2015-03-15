<%--
servlet ktbg.do

输入值见form

需要的返回值
status
    true ：成功提交
    false：提交失败

 message
    额外信息，如失败的具体原因

 施朝浩于2015.3.9日完成
        --%>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8"%>
    <!-- Begin page content -->
        <div class="row">
            <div class="col-md-3 col-md-offset-1">
                <%@include file="panels.jsp" %>
            </div>
            <div class="col-md-7">
                <form id="ktbg-form" role="form" action="ktbg.do" method="post">
                    <div class="form-group">
                        <label for="name-en">毕业设计名称（英文）</label>
                        <input class="form-control" name="name-en" id="name-en" type="text" placeholder="">
                    </div>
                    <div class="form-group">
                        <label for="name-cn">毕业设计名称（中文）</label>
                        <input class="form-control" name="name-cn" id="name-cn" type="text" placeholder="">
                    </div>
                    <div class="form-group">
                        <label>类别</label>

                        <div class="radio">
                            <label>
                                <input type="radio" name="ktbg-type" value="lw" checked>
                                毕业论文
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="ktbg-type" value="sj">
                                毕业设计
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="description">文献综述和开题报告要求</label>
                        <textarea name="description" id="description" class="form-control" rows="5"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">提交</button>
                </form>
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
                $("#name-cn").val(obj.name_cn);
                $("#name-en").val(obj.name_en);
                $('input[name="ktbg-type"][value="' + obj.type + '"]').prop('checked', true);
                $("#description").text(obj.description);
            }
        })
    });

    $("#ktbg-form").submit(function () {
        var url = "ktbg.do";
        var data = {
            name_en: $("#name-en").val(),
            name_cn: $("#name-cn").val(),
            type: $('input[name="ktbg-type"]:checked').val(),
            description: $("#description").val()
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