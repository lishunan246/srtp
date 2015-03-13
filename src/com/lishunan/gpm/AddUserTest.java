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
        String user[]={"3120103637","10000","1234567"};
        String password[]={"kaola123","admin","123456"};
        String name[]={"陈鑫","管理员","白老师"};
        String type[]={"student","admin","teacher"};
        try{
            Connection conn =DB.getConn();
            String sql="insert into people(account, password, name, type,salt) VALUES (?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            for(int i=0;i<user.length;i++){
                pstmt.setString(1, user[i]);
                String salt=GetSaltHashPwd.getSalt();
                pstmt.setString(2, GetSaltHashPwd.getSecurePassword(password[i], salt));
                pstmt.setString(3,name[i]);
                pstmt.setString(4, type[i]);
                pstmt.setString(5, salt);
                pstmt.execute();
            }

        }
            catch (Exception e){e.printStackTrace();};

    }
}