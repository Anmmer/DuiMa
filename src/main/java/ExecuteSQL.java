import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

public class ExecuteSQL extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 传入 UserId
        // 返回JSON
        // 		- 功能权限编号,功能权限名
        // 		- 工序权限编号,工序权限名
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 获取、转换参数
        String sqlStr = new String(request.getParameter("sqlStr"));
        String id = new String(request.getParameter("id"));
        String name = new String(request.getParameter("name"));
        String message = new String(request.getParameter("message"));
        // 需要返回的数据
        HashMap<String, String> ret = new HashMap<String, String>();
        // 连接数据库查询
        Connection conn = null;
        Statement stmt = null;
        try {
            conn = DbUtil.getCon();
            stmt = conn.createStatement();
            stmt.execute(sqlStr);
            ret.put("result", "true");
            ret.put("message", "数据库已执行该操作!");
            out.print(JSON.toJSONString(ret));
            SystemLog.log(name + "(工号为" + id + ")执行操作[" + sqlStr + "],信息:" + message);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
