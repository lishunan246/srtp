package com.lishunan.gpm;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
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
 * Created by Administrator on 2015/3/11.
 */
public class KtbgMangdaoListServlet extends HttpServlet {
    public void doPost (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        JsonArrayBuilder mdmess = Json.createArrayBuilder();
        if (!JudgePeopleType.judge(request, response).equals("teacher")){
            builder.add("status", false)
                    .add("message", "权限不足");
            out.print(builder.build());
            out.print (builder.build());
            return;
        }
        String taccount = request.getSession().getAttribute("username").toString();
        Connection conn = null;
        try {
            conn = DB.getConn();
            String sql = "select association.saccount,people.name, ktbg.titleeng, ktbg.titlechi, ktbg.titletype, ktbg.titlereq, ktbg.supervisorpass, ktbg.supervisorcomment, ktbg.anonymouscomment, ktbg.anonymouscomment,ktbg.grade " +
                    "from association, ktbg, people " +
                    "where association.mdaccount=? and association.saccount=ktbg.saccount and ktbg.saccount=people.account";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, taccount);
            ResultSet rs = pstmt.executeQuery();
            int count = 0;
            while(rs.next())
                count++;
            rs.first();
            rs.previous();
            if (rs.next()){
                do{
                    mdmess.add(Json.createObjectBuilder()
                            .add("sid", rs.getString(1) == null ? "" : rs.getString(1))
                            .add("sname", rs.getString(2) == null ? "" : rs.getString(2))
                            .add("name_en", rs.getString(3) == null ? "" : rs.getString(3))
                            .add("name_cn", rs.getString(4) == null ? "" : rs.getString(4))
                            .add("type", rs.getString(5) == null ? "" : rs.getString(5))
                            .add("description", rs.getString(6) == null ? "" : rs.getString(6))
                            .add("ds_pass", rs.getString(7) == null ? "" : rs.getString(7))
                            .add("ds_comment", rs.getString(8) == null ? "" : rs.getString(8))
                            .add("md_pass", rs.getString(9) == null ? "" : rs.getString(9))
                            .add("md_comment", rs.getString(10) == null ? "" : rs.getString(10))
                            .add("grade", rs.getString(11) == null ? "" : rs.getString(11)));
                }while(rs.next());
                builder.add("status", true)
                        .add("count", count)
                        .add("student",mdmess);
                out.print(builder.build());
            }else{
                mdmess.add(Json.createObjectBuilder()
                        .add("sid", "")
                        .add("sname","")
                        .add("name_en", "")
                        .add("name_cn", "")
                        .add("type", "")
                        .add("description", "")
                        .add("ds_pass", "")
                        .add("ds_comment", "")
                        .add("md_pass", "")
                        .add("md_comment", "")
                        .add("grade", ""));
                builder.add("status",true)
                        .add("count", 0)
                        .add("student", mdmess);
                out.print(builder.build());
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
    {
        doPost(request,response);
    }
}
