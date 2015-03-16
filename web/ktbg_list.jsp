<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/9
  Time: 15:31
  To change this template use File | Settings | File Templates.
  施朝浩于2015.3.11完成
--%>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!-- Begin page content -->

<div class="modal fade" id="modal_ktbg">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <dl>
                    <dt>英文名</dt>
                    <dd id="name_en_ktbg"></dd>

                    <dt>中文名</dt>
                    <dd id="name_cn_ktbg"></dd>
                    <dt>类型</dt>
                    <dd id="type_ktbg"></dd>
                    <dt>描述</dt>
                    <dd id="description_ktbg"></dd>
                </dl>
            </div>
            <div class="modal-body">
                <div class="form-group">


                    <div class="form-group">
                        <label>通过</label>

                        <div class="radio">
                            <label>
                                <input type="radio" name="pass_ktbg" value="0" checked>
                                不通过
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="pass_ktbg" value="1">
                                通过
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="grade_ktbg">评分</label>
                        <input class="form-control" id="grade_ktbg" type="number" placeholder="">
                    </div>

                    <div class="form-group">
                        <label for="comment_ktbg">评语</label>
                        <textarea id="comment_ktbg" class="form-control" rows="5"></textarea>
                    </div>
                    <!-- /input-group -->

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="button_ktbg" data-dismiss="modal">保存</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- Begin page content -->

<div class="row">
    <div class="col-md-3 col-md-offset-1">
        <%@include file="teacher_panels.jsp" %>
    </div>
    <div class="col-md-7">
        <div class="container" id="right-part">
            <div class="tabbable" id="tabs-874202">
                <ul class="nav nav-tabs nav-justified">
                    <li class="active">
                        <a href="#panel-877184" data-toggle="tab">您指导的学生 <span id="ds_count"
                                                                               class="badge">...</span></a>
                    </li>
                    <li>
                        <a href="#panel-832086" data-toggle="tab">您盲审的学生 <span id="md_count"
                                                                               class="badge">...</span></a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="panel-877184">
                        <table id="ds_table" class="table">
                            <tr>
                                <td>学号</td>
                                <td>姓名</td>
                                <td>毕业论文/设计</td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="panel-832086">
                        <table id="md_table" class="table">
                            <tr>
                                <td>学号</td>
                                <td>姓名</td>
                                <td>毕业论文/设计</td>
                                <td>盲审通过</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    function get_ktbg() {
        $(".result").remove();
        $.ajax({
            type: "GET",
            url: "ktbgmangdaolist.do",
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
                $("#md_count").text(obj.count);
                if (obj.count) {

                    for (var i = 0; i < obj.count; i++) {
                        var temp;
                        if (obj.student[i].md_pass) {
                            temp = "已通过";
                        }
                        else {
                            temp = "未通过";
                        }
                        $("#md_table").append(
                                '<tr class="result" onclick="ktbg_query(' + "'" + "md" + "'" + ',' + obj.student[i].sid + ')"><td>' + obj.student[i].sid + '</td> <td>' + obj.student[i].sname + '</td> <td>' + obj.student[i].name_cn + '</td><td>' + temp + '</td></tr>'
                        );


                    }
                }
            }
        });

        $.ajax({
            type: "GET",
            url: "ktbgzhidaolist.do",
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
                $("#ds_count").text(obj.count);
                if (obj.count) {

                    for (var i = 0; i < obj.count; i++) {
                        var temp;
                        if (obj.student[i].md_pass) {
                            temp = "已通过";
                        }
                        else {
                            temp = "未通过";
                        }
                        $("#ds_table").append(
                                '<tr class="result" onclick="ktbg_query(' + "'" + "ds" + "'" + ',' + obj.student[i].sid + ')"><td>' + obj.student[i].sid + '</td> <td>' + obj.student[i].sname + '</td> <td>' + obj.student[i].name_cn + '</td><td>' + temp + '</td></tr>'
                        );


                    }
                }
            }
        })
    }

    function get_bylw() {
        $(".result").remove();
        $.ajax({
            type: "GET",
            url: "bylwmangdaolist.do",
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
                $("#md_count").text(obj.count);
                if (obj.count) {

                    for (var i = 0; i < obj.count; i++) {
                        var temp;
                        if (obj.student[i].md_pass) {
                            temp = "已通过";
                        }
                        else {
                            temp = "未通过";
                        }
                        $("#md_table").append(
                                '<tr class="result" onclick="bylw_query(' + "'" + "md" + "'" + ',' + obj.student[i].sid + ')"><td>' + obj.student[i].sid + '</td> <td>' + obj.student[i].sname + '</td> <td>' + obj.student[i].name_cn + '</td><td>' + temp + '</td></tr>'
                        );


                    }
                }
            }
        });

        $.ajax({
            type: "GET",
            url: "bylwzhidaolist.do",
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
                $("#ds_count").text(obj.count);
                if (obj.count) {

                    for (var i = 0; i < obj.count; i++) {
                        var temp;
                        if (obj.student[i].md_pass) {
                            temp = "已通过";
                        }
                        else {
                            temp = "未通过";
                        }
                        $("#ds_table").append(
                                '<tr class="result" onclick="bylw_query(' + "'" + "ds" + "'" + ',' + obj.student[i].sid + ')"><td>' + obj.student[i].sid + '</td> <td>' + obj.student[i].sname + '</td> <td>' + obj.student[i].name_cn + '</td><td>' + temp + '</td></tr>'
                        );


                    }
                }
            }
        })
    }

    $(document).ready(function () {
        get_ktbg();
    });

    function ktbg_query(type1, saccount) {
        var url;
        var postfix = "_ktbg";
        if (type1 == "ds") {
            url = "ktbgdaoshiquery.do";

        }
        else {
            url = "ktbgmangdaoquery.do";
        }

        $.ajax({
            type: "GET",
            url: url,
            data: {
                "saccount": saccount
            },
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
                $("#name_en" + postfix).text(obj.name_en);
                $("#name_cn" + postfix).text(obj.name_cn);
                var type;
                if (obj.type == "lw")
                    type = "毕业论文";
                else if ("sj" == obj.type)
                    type = "毕业设计";
                else
                    type = "?";

                var comment;
                var pass;

                if (type1 == "ds") {
                    pass = obj.ds_pass;
                    comment = obj.ds_pass;
                }
                else {
                    pass = obj.md_pass;
                    comment = obj.md_pass;
                }

                $("#type" + postfix).text(type);
                $("#description" + postfix).text(obj.description);
                $("#comment" + postfix).val(comment);
                if (pass == "")
                    pass = "0";
                $('input[name="pass' + postfix + '"][value="' + pass + '"]').prop('checked', true);
                $("#modal" + postfix).modal("toggle");

            }
        })
    }


</script>

<%@include file="footer.jsp" %>
