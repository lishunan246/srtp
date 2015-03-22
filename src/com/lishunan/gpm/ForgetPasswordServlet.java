package com.lishunan.gpm;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

/**
 * Created by chenxin on 2015/3/22.
 * 传入参数：account  mailbox
 * 返回参数:status message:邮箱与账号不匹配  已经发送重置链接到邮箱 未知错误
 */
public class ForgetPasswordServlet extends HttpServlet {

    public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset = utf-8");

        String account=request.getParameter("account");
        String mailbox=request.getParameter("mailbox");
        JsonObjectBuilder builder = Json.createObjectBuilder();
        try {
            Connection conn = DB.getConn();
            String sql = "SELECT * FROM people WHERE account=? AND mailbox=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account);
            pstmt.setString(2, mailbox);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()){
                String password=rs.getString("password");
                Timestamp expiretime = new Timestamp(System.currentTimeMillis() + 30 * 60 * 1000);
                String token=account+";"+password+";"+expiretime;
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] bytes = md.digest(token.getBytes());
                StringBuilder sb = new StringBuilder();
                for(int i=0; i< bytes.length ;i++)
                {
                    sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
                }
                token = sb.toString();
                sql="UPDATE people SET token=? ,expiretime=? WHERE account=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,token);
                pstmt.setTimestamp(2, expiretime);
                pstmt.setString(3, account);
                pstmt.executeUpdate();
                String content="http://localhost:8080/findPassword.do?token="+token+"&account="+account;
                Mail.mailTo(mailbox,content);
                builder.add("status", true)
                        .add("message","已发送重置链接到你的邮箱" );



            }else{
                builder.add("status", false)
                        .add("message", "邮箱与账号不匹配");
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
        }catch(NoSuchAlgorithmException e){
            e.printStackTrace();
            builder.add("status", false)
                    .add("message", "未知错误");
        }  finally{
            PrintWriter out = response.getWriter();
            out.println(builder.build());
        }
    }

    @Override
    public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost (request, response);
    }
}

