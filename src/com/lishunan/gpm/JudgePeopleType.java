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
public class JudgePeopleType extends HttpServlet {
    public HttpSession session;
    public static String judge (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        if (request.getSession().getAttribute("username") == null){
            return "No";
        }
        String account = (String)request.getSession().getAttribute("username");
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql = "select type from people where account = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()){
                if (rs.getString(1).toString().equals("admin"))
                    return "admin";
                else if (rs.getString(1).toString().equals("teacher"))
                    return "teacher";
                else if (rs.getString(1).toString().equals("student"))
                    return "student";
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "No";
    }
}
