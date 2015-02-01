package com.lishunan.gpm;

/**
 * Created by Administrator on 2015/1/30.
 */

import java.sql.*;

public class DB {
    private static Connection conn;
    private Statement stm;
    private ResultSet rs;
    private PreparedStatement pstmt;
    private static String classname = "com.mysql.jdbc.Driver";
    private static String url = "jdbc:mysql://localhost/gims";
    private static String user = "root";
    private static String pwd = "";

    public static Connection getConn() throws ClassNotFoundException, SQLException {
        Class.forName(classname);
        conn = DriverManager.getConnection(url, user, pwd);
        return conn;
    }
    /*public ResultSet getPartRs(String account,String psd) throws Exception
    {
        Class.forName ("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection
                ("jdbc:mysql://localhost/gims","root","");
        stm = con.createStatement();
        if(account==null)
            account="";
        if(psd==null)
            psd="";
        //String sql="select * from  student where sid = ? and spassword = ?";
        //pstmt = con.prepareStatement(sql);
        //pstmt.setString(1, account);
        //pstmt.setString(2, psd);
        String sql="select * from  student where sid = ? and spassword = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, account);
        pstmt.setString(2, psd);
        rs = pstmt.executeQuery();
        return rs;
    }*/
}

