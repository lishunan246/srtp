package com.lishunan.gpm;

import javax.json.*;
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
 * Created by Administrator on 2015/3/10.
 */
public class BylwZhidaoListServlet extends HttpServlet {
    public void doPost (HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        JsonObjectBuilder builder = Json.createObjectBuilder();
        JsonArrayBuilder zdmess = Json.createArrayBuilder();
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
            String sql3 = "select association.saccount, people.name, bylw.paperintro, bylw.uploaded, bylw.supervisorpass, bylw.supervisorcomment, bylw.ds_grade, bylw.anonymouspass, bylw.anonymouscomment, bylw.md_grade" +
                    " from association, bylw, people " +
                    "where association.dsaccount=? and association.saccount=bylw.saccount and bylw.saccount=people.account";

            PreparedStatement pstmt3 = conn.prepareStatement(sql3);
            pstmt3.setString(1, taccount);
            ResultSet rs3 = pstmt3.executeQuery();
            int count = 0;
            while(rs3.next())
                count++;
            rs3.first();
            rs3.previous();
            //System.out.println(rs3.next());
            if (rs3.next()){
                do{
                    zdmess.add(Json.createObjectBuilder()
                            .add("sid", rs3.getString(1) == null ? "" : rs3.getString(1))
                            .add("sname", rs3.getString(2) == null ? "" : rs3.getString(2))
                            .add("intro", rs3.getString(3) == null ? "" : rs3.getString(3))
                            .add("uploaded", rs3.getString(4) == null ? "" : rs3.getString(4))
                            .add("supervisorpass", rs3.getString(5) == null ? "" : rs3.getString(5))
                            .add("supervisorcommment", rs3.getString(6) == null ? "" : rs3.getString(6))
                            .add("ds_grade", rs3.getString(7) == null ? "" : rs3.getString(7))
                            .add("anonymouspass", rs3.getString(8) == null ? "" : rs3.getString(8))
                            .add("anonymouscomment", rs3.getString(9) == null ? "" : rs3.getString(9))
                            .add("md_grade", rs3.getString(10) == null ? "" : rs3.getString(10)));
                }while(rs3.next());
                builder.add("status", true)
                        .add("count", count)
                        .add("student",zdmess);
                out.print(builder.build());
            }else{
                zdmess.add(Json.createObjectBuilder()
                        .add("sid", "")
                        .add("sname", "")
                        .add("intro", "")
                        .add("uploaded", "")
                        .add("supervisorpass", "")
                        .add("supervisorcommment", "")
                        .add("ds_grade", "")
                        .add("anonymouspass", "")
                        .add("anonymouscomment", "")
                        .add("md_grade", ""));
                builder.add("status", true)
                        .add("count", 0)
                        .add("student", zdmess);
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
