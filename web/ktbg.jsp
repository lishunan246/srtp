<%@include file="header.jsp" %>
<%@include file="navbar.jsp" %>
<%@ page contentType="text/html; charset=utf-8"%>
    <!-- Begin page content -->
        <div class="row">
            <div class="col-md-3 col-md-offset-1">
                <%@include file="panels.jsp" %>
            </div>
            <div class="col-md-7">
                <div class="container" id="right-part">
                    <form id="ktbg-form" role="form">
                         <div class="form-group">
                            <label for="name-en">毕业设计名称（英文）</label>
                            <input class="form-control" id="name-en" type="text" placeholder="" >
                         </div>
                         <div class="form-group">
                            <label for="name-cn">毕业设计名称（中文）</label>
                            <input class="form-control" id="name-cn" type="text" placeholder="" >
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
                            <textarea id="description" class="form-control" rows="5"></textarea>
                        </div>
                        <button type="submit" class="btn btn-default">提交</button>
                    </form>
                    <input class="btn-default" id="fileupload" type="file" name="ktbg-file" data-url="" accept="application/zip">
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>