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
import java.sql.SQLException;

/**
 * Created by chenxin on 2015/3/14.
 * 传入参数：type(类型，teacher或student) name(名字）account（学号或工号）
 *          major（专业） major2（老师才有的项，是？？？）
 * 返回参数：status：true/false   message：success/权限不足/添加失败/信息不完整
 */
public class AddUserServlet extends HttpServlet {
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
        String account= request.getParameter("account");
        String name=request.getParameter("name");
        String type = request.getParameter("type");
        String major=request.getParameter("major");
//        String major2=request.getParameter("major2");
        String salt= GetSaltHashPwd.getSalt();
        String password=GetSaltHashPwd.getSecurePassword(account, salt);

        Connection conn = null;
        try {
            conn = DB.getConn();
            if(type.equals("teacher")){
                if(name.equals("")||major.equals("")||account.equals("")){
                    builder.add("status", false)
                            .add("message", "信息不完整！");
                    out.print(builder.build());
                    return;
                }
                String sql="INSERT INTO teacher VALUES (?,?,?,?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,account);
                pstmt.setString(2,password);
                pstmt.setString(3,major);
                pstmt.setString(4,"");
                int result1 = pstmt.executeUpdate();
                sql="INSERT INTO people VALUES (?,?,?,?,?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,account);
                pstmt.setString(2,password);
                pstmt.setString(3,name);
                pstmt.setString(4,type);
                pstmt.setString(5,salt);
                int result2 = pstmt.executeUpdate();
                if(result1>0&&result2>0){
                    builder.add("status",true)
                            .add("message", "success");
                }
                else{
                    builder.add("status", false)
                            .add("message", "添加失败");
                }
                pstmt.close();
            }
            else if(type.equals("student")){
                if(name.equals("")||major.equals("")||account.equals("")){
                    builder.add("status", false)
                            .add("message", "信息不完整！");
                    out.print(builder.build());
                    return;
                }
                String sql="INSERT INTO student VALUES (?,?,NULL ,NULL ,NULL,NULL ,?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,account);
                pstmt.setString(2,password);
                pstmt.setString(3,major);
                int result1 = pstmt.executeUpdate();

                sql="INSERT INTO people VALUES (?,?,?,?,?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,account);
                pstmt.setString(2,password);
                pstmt.setString(3,name);
                pstmt.setString(4,type);
                pstmt.setString(5,salt);
                int result2 = pstmt.executeUpdate();
                if(result1>0&&result2>0){
                    builder.add("status",true)
                            .add("message", "success");
                }
                else{
                    builder.add("status", false)
                            .add("message", "添加失败");
                }

                pstmt.close();
            }




        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            builder.add("status", false)
                    .add("message", "添加失败");
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
