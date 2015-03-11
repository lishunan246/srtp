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
import java.util.ArrayList;

/**
 * Created by Administrator on 2015/3/9.
 */
public class KTBGqueryServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        if (!JudgePeopleType.judge(request, response).equals("student")){
            builder.add("status", false)
                    .add("message", "权限不足");
            out.print(builder.build());
            return;
        }
        String saccount = (String)request.getSession().getAttribute("username");
        Connection conn;
        try {
            conn = DB.getConn();
            String sql;
            sql = "select * from ktbg where saccount = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, saccount);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()){
                /*System.out.println(rs.getString(2));
                System.out.println(rs.getString(3));
                System.out.println(rs.getString(4));
                System.out.println(rs.getString(6));
                System.out.println(rs.getString(7));
                System.out.println(rs.getString(8));*/
                builder.add("status",true)
                        .add("name_en", rs.getString(2) == null ? "" : rs.getString(2))
                        .add("name_cn", rs.getString(3) == null ? "" : rs.getString(3))
                        .add("type", rs.getString(4) == null ? "" : rs.getString(4))
                        .add("description", rs.getString(5)  == null ? "" : rs.getString(5))
                        .add("teacher_pass", rs.getString(6) == null ? "" : rs.getString(6))
                        .add("teacher_comment", rs.getString(7) == null ? "" : rs.getString(7))
                        .add("grade", rs.getString(8) == null ? "" : rs.getString(8));
            }else{
                builder.add("status",true)
                        .add("name_en", "")
                        .add("name_cn", "")
                        .add("type", "")
                        .add("description", "")
                        .add("teacher_pass", "")
                        .add("teacher_comment", "")
                        .add("grade", "");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            builder.add("status", false)
                    .add("message", "未知错误");
        } catch (SQLException e) {
            e.printStackTrace();
            builder.add("status", false)
                    .add("message", "未知错误");
        }
        out.print(builder.build());
    }

    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
    {
        doPost(request,response);
    }
}
