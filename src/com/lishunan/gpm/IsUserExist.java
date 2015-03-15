package com.lishunan.gpm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by asus on 2015/3/15.
 */
public class IsUserExist {
    public static boolean check(String account,String type){
        boolean isExist=false;
        Connection conn=null;
        try{
            conn=DB.getConn();
            String sql ="";
            if(type.equals("student"))
                sql="SELECT * FROM  student WHERE sid=?";
            else if(type.equals("teacher"))
                sql="SELECT * FROM  teacher WHERE tid=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, account);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next())
                isExist=true;
            pstmt.close();
            conn.close();
        }catch (Exception e){e.printStackTrace();}
       return isExist;
    }

}
