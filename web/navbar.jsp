<%@ page contentType="text/html; charset=utf-8"%>
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a id="username" class="navbar-brand" href="login.jsp">请登录</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                    <ul class="nav navbar-nav hidden" id="nav_admin">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                               aria-expanded="false">搜索用户 <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a onclick="searchByUid()">根据学号或工号</a></li>
                                <li><a href="#">根据姓名</a></li>
                            </ul>

                        </li>
                        <li>
                            <a href="admin_newuser.jsp">新建用户</a>
                        </li>
                        <li>
                            <a href="admin_resetpw.jsp">为其他用户重置密码</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                               aria-expanded="false">设置师生关系 <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="admin_setmd.jsp">为学生指定盲审老师</a></li>
                                <li><a href="admin_setds.jsp">为学生指定指导老师</a></li>
                            </ul>

                        </li>
                    </ul>
                   

                    <ul class="nav navbar-nav navbar-right">
                        <%--<li>--%>
                        <%--<form class="navbar-form navbar-left" role="search">--%>
                        <%--<div class="form-group">--%>
                        <%--<input type="text" class="form-control" placeholder="">--%>
                        <%--</div>--%>
                        <%--<button type="submit" class="btn btn-default">搜索</button>--%>
                        <%--</form>--%>
                        <%--</li>--%>
                            <li id="nav_change_password" class="hidden"><a href="changepassword.jsp">更改密码</a></li>
                            <li id="nav_exit" class="hidden"><a onclick="logout()">退出</a></li>

                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>