import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.alibaba.fastjson.JSON;

public class QuerySQL extends HttpServlet {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/lisys?useUnicode=true&characterEncoding=utf8&useSSL=true&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "123456";

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // doPost
        // 参数为两个String
        // 		- sqlStr : 需要查询的sql语句
        // 		- fieldNames: 查询结果的各个字段名,以及对应的类型是String或者Int
        // 		- pageCur : 需要的页数
        // 		- pageMax : 一页放置的记录数
        // 返回JSON文件
        // 		- pageAll : 总共的页数
        // 		- cnt: 总共有多少记录
        // 		- data : 数据列表内放置字典
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 获取、转换参数
        String sqlStr = new String(request.getParameter("sqlStr"));
        String fieldNamesStr = new String(request.getParameter("fieldNames"));
        String pageCurStr = new String(request.getParameter("pageCur"));
        String pageMaxStr = new String(request.getParameter("pageMax"));
        int pageCur = 0;
        int pageMax = 0;
        try {
            pageCur = Integer.parseInt(pageCurStr);
            pageMax = Integer.parseInt(pageMaxStr);
        } catch (Exception e3) {
            e3.printStackTrace();
        }
        if (pageMax == 0 || pageCur == 0) {
            out.print("ERROR!");
        }
        Map<String, String> fieldNames = (Map<String, String>) JSON.parse(fieldNamesStr);
        // 需要返回的数据
        int pageAll = 0;
        int cnt = 0;
        ArrayList<HashMap<String, String>> maplist = new ArrayList<HashMap<String, String>>();
        String retStr = null;
        // 连接数据库查询
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sqlStr);
            while (rs.next()) {
                // 这是第cnt条记录
                int page = cnt / pageMax + 1;
                if (page == pageCur) {
                    // 是需要的数据
                    HashMap<String, String> map = new HashMap<String, String>();
                    for (String key : fieldNames.keySet()) {
                        String type = fieldNames.get(key);
                        String value = null;
                        if (type.equals("INT")) {
                            value = rs.getInt(key) + "";
                            map.put(key, value);
                        } else {
                            value = rs.getString(key);
                            map.put(key, value);
                        }
                    }
                    maplist.add(map);
                }
                cnt++;
            }
            pageAll = (cnt - 1) / pageMax + 1;
            HashMap<String, Object> ret = new HashMap<String, Object>();
            ret.put("pageAll", pageAll + "");
            ret.put("cnt", cnt + "");
            ret.put("data", JSON.toJSONString(maplist));
            retStr = JSON.toJSONString(ret);
            out.write(retStr);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
                if (rs != null) rs.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
            out.close();
        }

    }
}
