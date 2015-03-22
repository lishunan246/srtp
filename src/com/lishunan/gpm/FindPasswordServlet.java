package com.lishunan.gpm;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

/**
 * Created by chenxin on 2015/3/22.
 * 传入参数：account  token  newpwd1 newpwd2
 * 返回参数:status  message:验证码不匹配，验证码过期，输入密码不一致，未知错误，账号不存在
 */
public class FindPasswordServlet extends HttpServlet {

    public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset = utf-8");

        String account=request.getParameter("account");
        String token=request.getParameter("token");
        JsonObjectBuilder builder = Json.createObjectBuilder();
        try {
            Connection conn = DB.getConn();
            String sql = "SELECT * FROM people WHERE account=? ";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()){
                if(!token.equals(rs.getString("token"))){
                    builder.add("status", false)
                            .add("message", "验证码不匹配!");
                    return;
                }
                Timestamp now=new Timestamp(System.currentTimeMillis());
                Timestamp expiretime=rs.getTimestamp("expiretime");
                if(expiretime.before(now)){
                    builder.add("status", false)
                            .add("message", "验证码过期!");
                    return;
                }
                String newpwd1=request.getParameter("newpwd1");
                String newpwd2=request.getParameter("newpwd2");
                if(newpwd1==null||newpwd2==null){
                    builder.add("status", false)
                            .add("message", "未知错误!");
                    return;
                }
                if(!newpwd1.equals(newpwd2)){
                    builder.add("status", false)
                            .add("message", "输入密码不一致!");
                    return;
                }

                String salt=rs.getString("salt");
                String resetpwd=GetSaltHashPwd.getSecurePassword(newpwd1,salt);
                sql="UPDATE people SET password=? WHERE account=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,resetpwd);
                pstmt.setString(2,account);
                pstmt.executeUpdate();
                builder.add("status", true)
                        .add("message","重置成功" );
            }else{
                builder.add("status", false)
                        .add("message", "账号不存在!");
            }
            conn.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            builder.add("status", false)
                    .add("message", "未知错误");
        } catch (SQLException e) {
            e.printStackTrace();
            builder.add("status", false)
                    .add("message", "未知错误");
        } finally{
            PrintWriter out = response.getWriter();
            out.println(builder.build());
        }
    }

    @Override
    public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost (request, response);
    }
}


