package com.lishunan.gpm;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Created by asus on 2015/3/9.
 */
public class AddUserTest {
    public static void main(String[] args){
        String user="3120103637";
        String password="kaola123";
        try{
            Connection conn =DB.getConn();
            String sql="insert into people(account, password, name, type,salt) VALUES (?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user);
            String salt=GetSaltHashPwd.getSalt();
            pstmt.setString(2, GetSaltHashPwd.getSecurePassword(password, salt));
            pstmt.setString(3,"chenxin");
            pstmt.setString(4, "student");
            pstmt.setString(5, salt);
            if(pstmt.execute())
                System.out.println("success");

        }
            catch (Exception e){e.printStackTrace();};

    }
}
