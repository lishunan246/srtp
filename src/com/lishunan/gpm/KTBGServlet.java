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
 * Created by Li Shunan on 2015/3/5.
 */
public class KTBGServlet extends HttpServlet {
    public HttpSession session;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String saccount = request.getSession().getAttribute("username").toString();
        String titleeng = request.getParameter("name-en");
        String titlechi = request.getParameter("name-cn");
        String titletype = request.getParameter("ktbg-type");
        String titlereq = request.getParameter("description");
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql = "select * from ktbg where saccount = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, saccount);
            ResultSet rs = pstmt.executeQuery();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            JsonObjectBuilder builder = Json.createObjectBuilder();

            if (rs.next()){
                String sql3 = "update ktbg set titleeng = ?, titlechi = ?, titletype = ?, titlereq = ? where saccount = ?";
                PreparedStatement pstmt3 = conn.prepareStatement(sql3);
                pstmt3.setString(1, titleeng);
                pstmt3.setString(2, titlechi);
                pstmt3.setString(3, titletype);
                pstmt3.setString(4, titlereq);
                pstmt3.setString(5, saccount);
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
                String sql2 = "insert into ktbg(saccount,titleeng,titlechi,titletype,titlereq) values (?,?,?,?,?)";
                PreparedStatement pstmt2 = conn.prepareStatement(sql2);
                pstmt2.setString(1, saccount);
                pstmt2.setString(2, titleeng);
                pstmt2.setString(3, titlechi);
                pstmt2.setString(4, titletype);
                pstmt2.setString(5, titlereq);
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
        }finally {
            if (conn != null)
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
        }

        /*System.out.println(saccount);
        System.out.println(titleeng);
        System.out.println(titlechi);
        System.out.println(titletype);
        System.out.println(titlereq);*/
        /*Connection conn = null;
        try {
            conn = DB.getConn();
            String sql = "select * from people where account = ? and password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            JsonObjectBuilder builder = Json.createObjectBuilder();
            if (rs.next()) {
                //request.getRequestDispatcher("index.jsp").forward(request, response);
                session = request.getSession();
                session.setAttribute("username", rs.getString(1));
                builder.add("status", true)
                        .add("message", "success");
            } else {
                //request.getRequestDispatcher("login.jsp").forward(request, response);
                builder.add("status", false)
                        .add("message", "failed");
            }
            out.print(builder.build());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }*/
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }
}
