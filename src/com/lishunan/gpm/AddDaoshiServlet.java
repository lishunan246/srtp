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
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by chenxin on 2015/3/12.
 * 传入参数：saccount（学生账号）dsaccount（导师账号）
 * 返回参数：status：true   message：success
 */
public class AddDaoshiServlet extends HttpServlet{
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
        String saccount = request.getParameter("saccount");
        String dsaccount= request.getParameter("dsaccount");
        if(!IsUserExist.check(saccount,"student")){
            builder.add("status", false)
                    .add("message", "该学生不存在！");
            out.print(builder.build());
            return;
        }
        if(!IsUserExist.check(dsaccount,"teacher")){
            builder.add("status", false)
                    .add("message", "该教师不存在！");
            out.print(builder.build());
            return;
        }
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql ="SELECT * FROM  association WHERE saccount=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, saccount);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next()){
                sql="UPDATE association SET dsaccount=? WHERE saccount=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, dsaccount);
                pstmt.setString(2, saccount);
                if( pstmt.executeUpdate()>0){
                    builder.add("status",true)
                            .add("message", "success");
                }
                else{
                    builder.add("status", false)
                            .add("message", "未知错误");
                }
            }
            else{
                sql="INSERT  INTO  association VALUES (?,?,?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, saccount);
                pstmt.setString(2, dsaccount);
                pstmt.setString(3,null);
                if( pstmt.executeUpdate()>0){
                    builder.add("status",true)
                            .add("message", "success");
                }
                else{
                    builder.add("status", false)
                            .add("message", "未知错误");
                }
            }

            out.print(builder.build());
            pstmt.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
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