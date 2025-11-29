package org.example.jspcrud22.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
    private static Connection con = null;

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        if (con == null) {
            Class.forName("org.mariadb.jdbc.Driver");
            con= DriverManager.getConnection("jdbc:mariadb://walab.handong.edu:3306/W25_22200494","W25_22200494","shaoJ6");
        }
        return con;
    }

//    public static void main(String[] args) throws SQLException, ClassNotFoundException {
//        Connection con = JDBCUtil.getConnection();
//        if (con != null) {
//            System.out.println("DB 연결 성공!");
//        }
//    }
}