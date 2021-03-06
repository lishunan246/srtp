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
public class BylwMangdaoQueryServlet extends HttpServlet {
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
            String sql = "select * from bylw where saccount = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            //System.out.println(saccount);
            pstmt.setString(1, saccount);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()){
                builder.add("status", "true")
                        .add("intro", rs.getString(2) == null ? "" : rs.getString(2))
                        .add("uploaded", rs.getString(3) == null ? "" : rs.getString(3))
                        .add("supervisorpass", rs.getString(5) == null ? "" : rs.getString(5))
                        .add("supervisorcomment", rs.getString(6) == null ? "" : rs.getString(6))
                        .add("ds_grade", rs.getString(7) == null ? "" : rs.getString(7))
                        .add("anonymouspass", rs.getString(8) == null ? "" : rs.getString(8))
                        .add("anonymouscomment", rs.getString(9) == null ? "" : rs.getString(9))
                        .add("mdgrade", rs.getString(10) == null ? "" : rs.getString(10));
            }else{
                builder.add("status",true)
                        .add("intro", "")
                        .add("uploaded", "")
                        .add("supervisorpass", "")
                        .add("supervisorcomment", "")
                        .add("ds_grade", "")
                        .add("anonymouspass", "")
                        .add("anonymouscomment", "")
                        .add("mdgrade", "");
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
