package com.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class DbUtil {
    static final String jdbcDriver = "com.mysql.cj.jdbc.Driver";
    static final String url = "jdbc:mysql://localhost:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
    static final String user = "root";
    static final String pwd = "123456";

    public static Connection getCon() throws ClassNotFoundException, SQLException {
        //        1.注册驱动，将mysql驱动包加载到内存
        Class.forName(jdbcDriver);
        //          2.通过驱动管理获得连接对象
        return DriverManager.getConnection(url,user,pwd);
    }

    public static void main(String[] args) throws Exception {
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        DateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        System.out.println(sdf.format(new Date()).substring(2));
        System.out.println(new java.sql.Date(new Date().getTime()));
        System.out.println(UUID.randomUUID().toString().toUpperCase().replace("-",""));

    }

}
