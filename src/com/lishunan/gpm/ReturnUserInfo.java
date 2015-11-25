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
 * Created by Administrator on 2015/2/2.
 */
public class ReturnUserInfo  extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String account = (String)request.getSession().getAttribute("username");
        Connection conn = null;
        JsonObjectBuilder builder= Json.createObjectBuilder();
        PreparedStatement pstmt;
        ResultSet rs = null;
        PrintWriter out = out = response.getWriter();

        try {
            conn = DB.getConn();
            String sql="select * from people where account = ?";
            pstmt = conn.prepareStatement(sql);
           // pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account);
            rs = pstmt.executeQuery();
            rs.next();
            //response.setContentType("text/html; charset=utf-8");

            //System.out.println(rs.getString(3));
            builder.add("status",true)
                    .add("account", rs.getString(1))
                    .add("name", rs.getString(3))
                    .add("type", rs.getString(4));
        } catch (ClassNotFoundException e) {
            //e.printStackTrace();
            System.out.println(0);
            builder.add("status",false)
                    .add("account", "null")
                    .add("name", "null")
                    .add("type", "null");
        } catch (SQLException e) {
            //e.printStackTrace();
            //System.out.println(1);
            builder.add("status",false)
                    .add("account", "null")
                    .add("name", "null")
                    .add("type", "null");
        }finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.print(builder.build());
        }
    }

    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
    {
        doPost(request,response);
    }
}

