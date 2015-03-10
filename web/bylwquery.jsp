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
  supervisorcommment
    导师评论
  anonymouspass
  bool 是否通过盲审
  anonymouscomment
  盲审评论

    grade
    得分

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

                    <p>完成<span class="glyphicon glyphicon-ok"></span></p>
                </div>

                <div class="form-group">
                    <label>盲审老师审核状态</label>

                    <p>通过<span class="glyphicon glyphicon-ok"></span></p>
                </div>
                <div class="form-group">
                    <label for="ms_comment">盲审老师审核评语</label>
                    <textarea id="ms_comment" class="form-control" rows="5" disabled>Good job</textarea>
                </div>

                <div class="form-group">
                    <label>导师审核状态</label>

                    <p>通过<span class="glyphicon glyphicon-ok"></span></p>
                </div>
                <div class="form-group">
                    <label for="ds_comment">导师审核评语</label>
                    <textarea class="form-control" id="ds_comment" rows="5" disabled>Good job</textarea>
                </div>
                <div class="form-group">
                    <label>总成绩</label>

                    <div class="progress">
                        <div class="progress-bar" role="progressbar" aria-valuenow="40"
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

<%@include file="footer.jsp" %>