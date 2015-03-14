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

<div class="modal fade" id="modal_ms">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <dl>
                    <dt>英文名</dt>
                    <dd id="name_en"></dd>

                    <dt>中文名</dt>
                    <dd id="name_cn"></dd>
                    <dt>类型</dt>
                    <dd id="type"></dd>
                    <dt>描述</dt>
                    <dd id="description"></dd>
                </dl>
            </div>
            <div class="modal-body">
                <div class="form-group">


                    <div class="form-group">
                        <label>通过</label>

                        <div class="radio">
                            <label>
                                <input type="radio" name="md_pass" value="0" checked>
                                不通过
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="md_pass" value="1">
                                通过
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="grade">评分</label>
                        <input class="form-control" id="grade" type="number" placeholder="">
                    </div>

                    <div class="form-group">
                        <label for="md_comment">盲审评语</label>
                        <textarea id="md_comment" class="form-control" rows="5"></textarea>
                    </div>
                    <!-- /input-group -->

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="ms(saccount)" data-dismiss="modal">保存</button>
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
                <ul class="nav nav-pills">
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
                        <table id="ds_table" class="table table-hover table-bordered">
                            <tr class="info">
                                <td>学号</td>
                                <td>姓名</td>
                                <td>毕业论文/设计</td>
                            </tr>
                        </table>
                    </div>
                    <div class="tab-pane" id="panel-832086">
                        <table id="md_table" class="table table-hover table-bordered">
                            <tr class="info">
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
    $(document).ready(function () {
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
                if (obj.count) {
                    $("#md_count").text(obj.count);
                    for (var i = 0; i < obj.count; i++) {
                        var temp;
                        if (obj.student[i].md_pass) {
                            temp = "已通过";
                        }
                        else {
                            temp = "未通过";
                        }
                        $("#md_table").append(
                                '<tr onclick="ms_query(' + obj.student[i].sid + ')"><td>' + obj.student[i].sid + '</td> <td>' + obj.student[i].sname + '</td> <td>' + obj.student[i].name_cn + '</td><td>' + temp + '</td></tr>'
                        );


                    }
                } else {
                    alert("no one");
                }
            }
        })
    });

    function ms_query(saccount) {
        $.ajax({
            type: "GET",
            url: "ktbgmangdaoquery.do",
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
                $("#name_en").text(obj.name_en);
                $("#name_cn").text(obj.name_cn);
                var type;
                if (obj.type == "lw")
                    type = "毕业论文";
                else if ("sj" == obj.type)
                    type = "毕业设计";
                else
                    type = "?";

                $("#type").text(type);
                $("#description").text(obj.description);
                $("#md_comment").val(obj.md_comment);
                if (obj.md_pass == "")
                    obj.md_pass = "0";
                $('input[name="md_pass"][value="' + obj.md_pass + '"]').prop('checked', true);
                $("#modal_ms").modal("toggle");

            }
        })
    }
</script>

<%@include file="footer.jsp" %>
