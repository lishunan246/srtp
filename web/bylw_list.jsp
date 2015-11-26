<%--
  Created by IntelliJ IDEA.
  User: Li Shunan
  Date: 2015/3/9
  Time: 15:47
  To change this template use File | Settings | File Templates.
  需要一个servlet返回该老师旗下所有学生开题报告的信息
  输入
  根据session判断老师

  返回操作是否成功
  成功返回所有开题报告的信息，输出参数名自定

  失败说明原因

  施朝浩于2015.3.11完成

--%>
<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!-- Begin page content -->


<div class="row">
    <div class="col-md-3 col-md-offset-1">
        <%@include file="teacher_panels.jsp" %>
    </div>
    <script type="text/ng-template" id="BYLWzhidao.html">
        <div class="modal-header">
            <h3 class="modal-title">评估毕业论文</h3>
        </div>
        <div class="modal-body">

            <form style="position: relative;top:-20px;" method="post" action="bylwdownload.do">
                <input  class="hidden" type="text" name="saccount" ng-model="id"/><br/>
                <button class="btn btn-default" type="submit" value="下载开题报告">下载文件</button>
            </form>

            <form>
                <div class="form-group">
                    <label for="grade">分数</label>
                    <input type="number" id="grade" ng-model="grade">
                </div>
                <div class="form-group">
                    <label for="comment">评论</label>
                    <input type="text" id="comment" ng-model="comment">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" ng-model="pass"> 予以通过
                    </label>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="button" ng-click="okBYLWzhidao()">提交</button>
            <button class="btn btn-warning" type="button" ng-click="cancel()">关闭</button>
        </div>
    </script>
    <script type="text/ng-template" id="BYLWmangdao.html">
        <div class="modal-header">
            <h3 class="modal-title">评估毕业论文(盲审)</h3>

        </div>
        <div class="modal-body">
            <form style="position: relative;top:-20px;" method="post" action="bylwdownload.do">
                <input  class="hidden" type="text" name="saccount" ng-model="id"/><br/>
                <button class="btn btn-default" type="submit" value="下载开题报告">下载文件</button>
            </form>
            <form>
                <div class="form-group">
                    <label for="grade">分数</label>
                    <input type="number" id="grade" ng-model="grade">
                </div>
                <div class="form-group">
                    <label for="comment">评论</label>
                    <input type="text" id="comment" ng-model="comment">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" ng-model="pass"> 予以通过
                    </label>
                </div>
            </form>
        </div>
        <div class="modal-footer">

            <button class="btn btn-primary" type="button" ng-click="okBYLWmangdao()">提交</button>
            <button class="btn btn-warning" type="button" ng-click="cancel()">关闭</button>
        </div>
    </script>
    <div ng-controller="bylwListController" class="col-md-7">
        <div class="container" id="right-part">
            <table class="table table-hover table-bordered">
                <tr class="info">
                    <td>学号</td>
                    <td>姓名</td>
                    <td>是否通过</td>
                    <td>类型</td>
                </tr>
                <tr ng-repeat="x in z" ng-click="openZhidao(x.sid)">
                    <td>{{x.sid}}</td>
                    <td>{{x.sname}}</td>
                    <td>{{x.supervisorpass=="1"?"是":"否"}}</td>
                    <td>指导</td>
                </tr>
            </table>

            <table class="table table-hover table-bordered">
                <tr class="info">
                    <td>学号</td>
                    <td>姓名</td>
                    <td>是否通过</td>
                    <td>类型</td>
                </tr>
                <tr ng-repeat="x in m" ng-click="openMangdao(x.sid)">
                    <td>{{x.sid}}</td>
                    <td>{{x.sname}}</td>
                    <td>{{x.anonymouspass=="1"?"是":"否"}}</td>
                    <td>盲审</td>
                </tr>
            </table>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>
