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
 * Created by Administrator on 2015/3/13.
 */
public class KtbgMangdaoQueryServlet extends HttpServlet {
    private HttpSession session;

    @Override
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        if (!JudgePeopleType.judge(request, response).equals("teacher")){
            builder.add("status", false)
                    .add("message", "权限不足");
            out.print(builder.build());
            return;
        }
        String saccount = request.getParameter("saccount");
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql = "select * from ktbg where saccount = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            //System.out.println(saccount);
            pstmt.setString(1, saccount);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()){
                builder.add ("status", "true")
                        .add("name_en", rs.getString(2) == null ? "" : rs.getString(2))
                        .add("name_cn", rs.getString(3) == null ? "" : rs.getString(3))
                        .add("type", rs.getString(4) == null ? "" : rs.getString(4))
                        .add("description", rs.getString(5)  == null ? "" : rs.getString(5))
                        .add("ds_pass", rs.getString(7) == null ? "" : rs.getString(7))
                        .add("ds_comment", rs.getString(8) == null ? "" : rs.getString(8))
                        .add("ds_grade", rs.getString(9) == null ? "" : rs.getString(9))
                        .add("md_pass", rs.getString(10) == null ? "" : rs.getString(10))
                        .add("md_comment", rs.getString(11) == null ? "" : rs.getString(11))
                        .add("md_grade", rs.getString(12) == null ? "" : rs.getString(12));
            }else{
                builder.add("status",true)
                        .add("name_en", "")
                        .add("name_cn", "")
                        .add("type", "")
                        .add("description", "")
                        .add("ds_pass", "")
                        .add("ds_comment", "")
                        .add("ds_grade", "")
                        .add("md_pass", "")
                        .add("md_comment", "")
                        .add("md_grade", "");
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
    public void doGet (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }
}
