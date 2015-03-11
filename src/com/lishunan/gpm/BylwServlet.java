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
public class BylwServlet extends HttpServlet {
    public HttpSession session;
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        if (!JudgePeopleType.judge(request, response).equals("student")){
            builder.add("status", false)
                    .add("message", "权限不足");
            out.print(builder.build());
            return;
        }
        String saccount = request.getSession().getAttribute("username").toString();
        String intro = request.getParameter("intro");
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql = "select * from bylw where saccount = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, saccount);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()){
                String sql3 = "update bylw set paperintro = ? where saccount = ?";
                PreparedStatement pstmt3 = conn.prepareStatement(sql3);
                pstmt3.setString(1, intro);
                pstmt3.setString(2, saccount);
                int value = pstmt3.executeUpdate();
                if (value > 0){
                    builder.add("status", true)
                            .add("message", "success");
                }else{
                    builder.add("status", false)
                            .add("message", "update fail");
                }
                pstmt3.close();
            } else{
                String sql2 = "insert into bylw(saccount,paperintro) values (?,?)";
                PreparedStatement pstmt2 = conn.prepareStatement(sql2);
                pstmt2.setString(1, saccount);
                pstmt2.setString(2, intro);
                int value = pstmt2.executeUpdate();
                if (value > 0){
                    builder.add("status", true)
                            .add("message", "success");
                }else{
                    builder.add("status", false)
                            .add("message", "insert fail");
                }
                pstmt2.close();
            }
            out.print(builder.build());
            pstmt.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }
}
