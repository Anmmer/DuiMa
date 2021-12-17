package com.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DbUtil {
    static final String jdbcDriver = "com.mysql.cj.jdbc.Driver";
    static final String url = "jdbc:mysql://8.142.26.93:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
    static final String user = "root";
    static final String pwd = "123456";

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
/**
 * 1.注册驱动
 * 2.获得连接对象
 * 3.获得执行语句对象
 * 4.执行sql
 * 5.关闭连接
 */

        //        1.注册驱动，将mysql驱动包加载到内存
        Class.forName(jdbcDriver);
        //          2.通过驱动管理获得连接对象
        Connection con= DriverManager.getConnection(url,user,pwd);
        System.out.println(con);
        //          3.通过连接对象获得执行语句对象
        Statement s=con.createStatement();
        //          4.执行sql

            System.out.println("执行成功");

        //          5.关闭连接对象
        s.close();
        con.close();

    }

}
