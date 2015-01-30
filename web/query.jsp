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
                            <label for="sid">毕业设计名称（英文）</label>
                            <input class="form-control" id="sid" type="text" placeholder="Magical Masterpiece!" disabled>
                        </div>
                         <div class="form-group">
                            <label for="sid">毕业设计名称（中文）</label>
                            <input class="form-control" id="sid" type="text" placeholder="某神奇的毕业设计" disabled>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">类别</label>
                            <fieldset disabled>
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
                            </fieldset >
                        </div>
                        <div class="form-group">
                            <label>老师审核状态</label>
                            <strong><p>通过<span class="glyphicon glyphicon-ok"></span></p></strong>
                        </div>
                        <div class="form-group">
                            <label>老师审核评语</label>
                            <textarea class="form-control" rows="5" disabled>Good job</textarea>
                        </div>
                        <div class="form-group">
                             <label>总成绩</label>
                            <div class="progress">
                              <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 90%">
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