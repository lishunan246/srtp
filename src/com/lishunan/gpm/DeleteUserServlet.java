package com.lishunan.gpm;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by chenxin on 2015/3/14.
 * 传入参数：type（student或teacher） account（账号）
 * 返回参数：status：true/false   message：success/权限不足/删除失败
 */
public class DeleteUserServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        if (!JudgePeopleType.judge(request, response).equals("admin")) {
            builder.add("status", false)
                    .add("message", "权限不足");
            out.print(builder.build());
            return;
        }
        String account= request.getParameter("account");
        String type = request.getParameter("type");
        Connection conn = null;
        try {
            conn = DB.getConn();
            if(type.equals("teacher")){

                String sql="DELETE FROM teacher WHERE tid=?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,account);
                int result1 = pstmt.executeUpdate();
                sql="DELETE FROM people WHERE account=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,account);
                int result2 = pstmt.executeUpdate();
                if(result1>0&&result2>0){
                    builder.add("status",true)
                            .add("message", "success");
                }
                else{
                    builder.add("status", false)
                            .add("message", "删除失败");
                }
                pstmt.close();
            }
            else if(type.equals("student")){
                String sql="DELETE FROM student WHERE sid=?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,account);
                int result1 = pstmt.executeUpdate();

                sql="DELETE FROM people WHERE account=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,account);

                int result2 = pstmt.executeUpdate();
                if(result1>0&&result2>0){
                    builder.add("status",true)
                            .add("message", "success");
                }
                else{
                    builder.add("status", false)
                            .add("message", "删除失败");
                }

                pstmt.close();
            }




        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            builder.add("status", false)
                    .add("message", "删除失败");
            e.printStackTrace();
        } finally {
            out.print(builder.build());
            if (conn != null)
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

