<%@ page contentType="text/html; charset=utf-8" %>
<div ng-controller="panelController" class="container" id="left-part">

    <script type="text/ng-template" id="uploadModal.html">
        <div class="modal-header">
            <h3 class="modal-title">上传文件</h3>
        </div>
        <div class="modal-body">
            <form>
                <div class="form-group">
                    <label>请选择：</label>
                    <input type="file" file-model="myFile">
                </div>
                <button ng-click="uploadFile('/ktbgupload.do')" class="button btn-default">上传</button>
            </form>
        </div>
        <%--<div class="modal-footer">--%>
            <%--<button class="btn btn-primary" type="button" ng-click="ok()">OK</button>--%>
            <%--<button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>--%>
        <%--</div>--%>
    </script>
    <div class="panel  panel-success">
        <!-- Default panel contents -->
        <div class="panel-heading">开题报告</div>
        <div class="panel-body">
            <p>您已经上传完毕！</p>
        </div>

        <table class="table text-center">
            <tr>
                <td ng-click="open()"><a>上传</a></td>
                <td><a href="ktbg.jsp">编辑</a></td>
                <td><a href="ktbgquery.jsp">查询</a></td>
            </tr>
        </table>
    </div>

    <div class="panel  panel-primary">
        <!-- Default panel contents -->
        <div class="panel-heading">毕业论文</div>
        <div class="panel-body">
            <p>尚未开启</p>
        </div>


        <table class="table text-center">
            <tr>
                <td>上传</td>
                <td><a href="bylw.jsp">编辑</a></td>
                <td><a href="bylwquery.jsp">查询</a></td>
            </tr>
        </table>
    </div>


</div>