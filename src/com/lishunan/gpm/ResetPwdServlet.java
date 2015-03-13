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
 * 传入参数：account（账户）
 * 返回参数：status：true  message：success
 */
public class ResetPwdServlet extends HttpServlet {
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
        String account = request.getParameter("account");
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql = "SELECT * FROM  people WHERE  account = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                String salt=rs.getString("salt");
                String resetPwd=GetSaltHashPwd.getSecurePassword(account,salt);
                sql="update people set password = ? where account = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,resetPwd);
                pstmt.setString(2,account);
                if (pstmt.executeUpdate()> 0){
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
