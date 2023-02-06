import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.example.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class AddBuildUpload extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String str = req.getParameter("str");
        String planname = req.getParameter("planname");
        String user_name = req.getParameter("user_name");
        JSONArray arrayList = JSON.parseArray(str);
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        try {
            con = DbUtil.getCon();
            String sql1 = "insert into batch(batch_id,planname,user_name,date,is_delete) values(?,?,?,NOW(),0 )";
            String sql2 = "insert into preproduct(materialcode,materialname,standard,drawing_no,build_type,building_no,floor_no,batch_id,planname,isdelete) values(?,?,?,?,?,?,?,?,?,0)";
            String sql3 = "select count(*) num from planname where planname = ? and isdelete = 0";
            String sql4 = "select count(*) num from preproduct where materialcode = ? and isdelete = 0";
            PreparedStatement ps = con.prepareStatement(sql3);
            ps.setString(1, planname);
            ResultSet rs = ps.executeQuery();
            int num = 0;
            while (rs.next()) {
                num = rs.getInt("num");
            }
            rs.close();
            if (num == 0) {
                result.put("flag", false);
                result.put("message", "项目名称不存在");
                out.write(JSON.toJSONString(result));
                return;
            }
            ps = con.prepareStatement(sql4);
            for (Object o : arrayList) {
                int num1 = 0;
                JSONObject jsonObject = (JSONObject) o;
                ps.setString(1, jsonObject.getString("materialcode"));
                ResultSet res = ps.executeQuery();
                while (res.next()) {
                    num1 = res.getInt("num");
                }
                if (num1 != 0) {
                    result.put("flag", false);
                    result.put("message", "物料编码为：" + jsonObject.getString("materialcode") + " 的构建已存在存在！");
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            PreparedStatement ps1 = con.prepareStatement(sql1);
            String batch_id = UUID.randomUUID().toString().toLowerCase().replace("-", "");
            ps1.setString(1, batch_id);
            ps1.setString(2, planname);
            ps1.setString(3, user_name);
            int res = ps1.executeUpdate();
            if (res < 1) {
                result.put("flag", false);
                result.put("message", "录入失败");
                out.write(JSON.toJSONString(result));
                return;
            }
            PreparedStatement ps2 = con.prepareStatement(sql2);
            for (Object o : arrayList) {
                JSONObject jsonObject = (JSONObject) o;
                ps2.setString(1, jsonObject.getString("materialcode"));
                ps2.setString(2, jsonObject.getString("materialname"));
                ps2.setString(3, jsonObject.getString("standard"));
                ps2.setString(4, jsonObject.getString("drawing_no"));
                ps2.setString(5, jsonObject.getString("build_type"));
                ps2.setString(6, jsonObject.getString("building_no"));
                ps2.setString(7, jsonObject.getString("floor_no"));
                ps2.setString(8, batch_id);
                ps2.setString(9, planname);
                ps2.addBatch();
            }
            int[] rs2 = ps2.executeBatch();
            if (rs2.length < 1) {
                result.put("flag", false);
                result.put("message", "录入失败");
                out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "录入成功");
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            }
            ps1.close();
            ps2.close();
        } catch (Exception e) {
            e.printStackTrace();
            result.put("flag", false);
            result.put("message", "录入失败");
            out.write(JSON.toJSONString(result));
        } finally {
            out.close();
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }
    }
}
