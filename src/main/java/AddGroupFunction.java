import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.example.DbUtil;

public class AddGroupFunction extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 传入 userName
        // 传入 groupId
        // 返回 true 或者 错误信息 或者 false
        response.setContentType("text/javascript;charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 获取、转换参数
        String groupId = request.getParameter("groupId");
        String groupIds = request.getParameter("groupIds");
        JSONArray jsonArray = JSONObject.parseArray(groupIds);
        // 需要返回的数据
        HashMap<String, String> ret = new HashMap<String, String>();
        // 连接数据库查询
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DbUtil.getCon();
            String sql = "insert into gp_function_authority(gp_id,fa_id) values(?,?)";
            String sql2 = "delete from gp_function_authority where gp_id =?";
            ps = conn.prepareStatement(sql2);
            ps.setInt(1, Integer.parseInt(groupId));
            ps.executeUpdate();
            ps = conn.prepareStatement(sql);
            conn.setAutoCommit(false);
            for (int i = 0; i < jsonArray.size(); i++) {
                ps.setInt(1, Integer.parseInt(groupId));
                ps.setInt(2, jsonArray.getInteger(i));
                ps.addBatch();
            }
            ps.executeBatch();
            conn.commit();
            ps.clearBatch();
            ret.put("result", "true");
            ret.put("message", "新增成功!");
            out.print(JSON.toJSONString(ret));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
