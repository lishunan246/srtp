package com.lishunan.gpm;

import javax.json.Json;
import javax.json.JsonArray;
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
 * 传入参数：uid（账号）或者uname（姓名）中的一个（不可同时）
 * 返回参数：account（账号），name（姓名），type（用户类型）
 */
public class QueryUserServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();

        if (!JudgePeopleType.judge(request, response).equals("admin")) {
            builder.add("status", false)
                    .add("message","权限不够!");
            System.out.println(JudgePeopleType.judge(request,response));
            out.print(builder.build());
            return;
        }
        String account = request.getParameter("uid");
        String name = request.getParameter("uname");
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql = "select * from people where ";
            String queryBy="";
            if(account!=null&&account!="") {
                queryBy="queryById";
                sql += "account = ? ";
            }
            if(name!=null&name!="") {
                queryBy="queryByName";
                sql += "name LIKE ?";
            }
            if(!queryBy.equals("")){
                PreparedStatement pstmt = conn.prepareStatement(sql);
                if(queryBy.equals("queryById"))
                    pstmt.setString(1, account);
                if(queryBy.equals("queryByName"))
                    pstmt.setString(1, name);
                ResultSet rs = pstmt.executeQuery();
                while(rs.next()) {

                    builder.add("account",rs.getString("account"))
                            .add("name",rs.getString("name"))
                            .add("type",rs.getString("type"));
                }
                builder.add("status", true)
                        .add("message", "success");

                pstmt.close();
            }
            else {
                builder.add("status", false)
                        .add("message", "参数不能为空");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
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
