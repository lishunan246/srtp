package com.lishunan.gpm;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Administrator on 2015/3/17.
 */
public class BylwDownloadServlet extends HttpServlet {
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset = utf-8");
        String saccount = request.getParameter("saccount");
        //PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        if (!JudgePeopleType.judge(request, response).equals("teacher")){
            builder.add("status", false)
                    .add("message", "权限不足");
            PrintWriter out = response.getWriter();
            out.print(builder.build());
            out.close();
            return;
        }
        try {
            Connection conn = DB.getConn();
            String sql = "select filepath from bylw where saccount = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, saccount);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()){
                if (rs.getString(1) == null){
                    builder.add("status", false)
                            .add("message", "数据库里没有唉");
                }else{
                    String path = new String (rs.getString(1).getBytes("gbk"));
                    //System.out.println(path);
                    String fileName = path.substring(path.lastIndexOf("\\"));
                    File file = new File(path);
                    InputStream in = new FileInputStream(file);
                    OutputStream os = response.getOutputStream();
                    response.addHeader("Content-Disposition","attachment;filename=" + new String(file.getName().getBytes("gbk"),"iso-8859-1"));
                    response.addHeader("Content-Length", file.length() + "");
                    response.setContentType("application/x-msdownload");
                    int data = 0;
                    while ((data = in.read()) != -1) {
                        os.write(data);
                    }
                    os.close();
                    in.close();
                }
            }else{
                builder.add("status", false)
                        .add("message", "数据库里没有唉");
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
        }finally {
            PrintWriter out = response.getWriter();
            out.println(builder.build());
        }
    }

    @Override
    public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost (request, response);
    }
}

