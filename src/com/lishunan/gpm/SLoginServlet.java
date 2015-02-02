package com.lishunan.gpm;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 * Created by Administrator on 2015/2/1.
 */
public class SLoginServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String account = request.getParameter("account");
        String password = request.getParameter("pwd");
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql="select * from student where sid = ? and spassword = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (rs.next()) {
                //request.getRequestDispatcher("index.jsp").forward(request, response);
                //response.sendRedirect("index.jsp");
                out.write("1");
            } else{
                //request.getRequestDispatcher("login.jsp").forward(request, response);
                out.write("0" );
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
    {
        doPost(request,response);
    }
}
