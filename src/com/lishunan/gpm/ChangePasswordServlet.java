package com.lishunan.gpm;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Administrator on 2015/3/9.
 */
public class ChangePasswordServlet extends HttpServlet {
    public HttpSession session;
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        if (JudgePeopleType.judge(request, response) == "No"){
            builder.add("status", false)
                    .add("message", "权限不足");
            out.print(builder.build());
            return;
        }
        /*if (request.getSession().getAttribute("username") == null){
            builder.add("status", false)
                    .add("message", "用户未登录");
            out.print(builder.build());
            return;
        }*/
        String paccount = request.getSession().getAttribute("username").toString();
        String oldpd = request.getParameter("old-password");
        String newpd = request.getParameter("new-password");
        String confirm = request.getParameter("confirm");
        Connection conn = null;

        if (confirm.equals(newpd)){
            try {
                conn = DB.getConn();
                String sql2 = "select password from people where account = ?";
                PreparedStatement pstmt2 = conn.prepareStatement(sql2);
                pstmt2.setString(1, paccount);
                ResultSet rs = pstmt2.executeQuery();
                if (rs.next()){
                    if (oldpd.equals(rs.getString(1))){
                        String sql="update people set password = ? where account = ?";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, newpd);
                        pstmt.setString(2, paccount);
                        int value = pstmt.executeUpdate();
                        if (value > 0){
                            builder.add("status",true)
                                    .add("message", "success");
                        }
                        else{
                            builder.add("status", false)
                                    .add("message", "未知错误");
                        }
                        pstmt.close();
                    }else{
                        builder.add("status", false)
                                .add("message", "原密码错误");
                    }
                }
                conn.close();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
    }else{
            builder.add("status", false)
                    .add("message", "密码不一致");
        }
        out.print(builder.build());
        if (conn != null){
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
}
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }
}