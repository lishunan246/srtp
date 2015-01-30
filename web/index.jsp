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
                    <form role="form">
                        
                         <div class="form-group">
                            <label for="sid">毕业设计名称（英文）</label>
                            <input class="form-control" id="sid" type="text" placeholder="" >
                        </div>
                         <div class="form-group">
                            <label for="sid">毕业设计名称（中文）</label>
                            <input class="form-control" id="sid" type="text" placeholder="" >
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">类别</label>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                        毕业论文
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                        毕业设计
                                    </label>
                                </div>
                        </div>
                        <div class="form-group">
                            <label>文献综述和开题报告要求</label>
                            <textarea class="form-control" rows="5"></textarea>
                        </div>
  
                        <button type="submit" class="btn btn-default">提交</button>
                    </form>

                </div>


            </div>
        </div>

        <%@include file="footer.jsp" %>