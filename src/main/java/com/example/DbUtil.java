package com.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DbUtil {
    static final String jdbcDriver = "com.mysql.cj.jdbc.Driver";
    static final String url = "jdbc:mysql://8.142.26.93:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
    static final String user = "root";
    static final String pwd = "123456";

    public static Connection getCon() throws ClassNotFoundException, SQLException {
        //        1.注册驱动，将mysql驱动包加载到内存
        Class.forName(jdbcDriver);
        //          2.通过驱动管理获得连接对象
        return DriverManager.getConnection(url,user,pwd);
    }

    public static void main(String[] args) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println(sdf.parse(null));
    }

}
