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
import java.sql.SQLException;

/**
 * Created by Administrator on 2015/3/13.
 */
public class KtbgMangdaoSubmitServlet extends HttpServlet{
    private HttpSession session;

    @Override
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        if (!JudgePeopleType.judge(request, response).equals("teacher")){
            builder.add ("status", false)
                    .add ("message", "权限不足");
            out.print(builder.build());
            return;
        }
        String saccount = request.getParameter("saccount");
        String pass = request.getParameter("pass");
        String comment = request.getParameter("comment");
        String md_grade = request.getParameter("grade");
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql = "update ktbg set anonymouspass = ?, anonymouscomment = ?, md_grade = ? where saccount = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString (1, "true".equals(pass) ? "1":"0");
            pstmt.setString (2, comment);
            pstmt.setString (3, md_grade);
            pstmt.setString (4, saccount);
            int rs = pstmt.executeUpdate();
            if (rs > 0){
                builder.add("status", true)
                        .add("message", "success");
            }else{
                builder.add("status", false)
                        .add("message", "update fail");
            }
            pstmt.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            builder.add("status", false)
                    .add("message", "未知错误");
        } catch (SQLException e) {
            e.printStackTrace();
            builder.add("status", false)
                    .add("message", "未知错误");
        }finally {
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
