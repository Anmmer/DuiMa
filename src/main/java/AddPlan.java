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
import java.math.BigDecimal;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class AddPlan extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String str = request.getParameter("str");
        Map<String, Object> map = JSON.parseObject(str, Map.class);
        Map<String, Object> result = new HashMap<>();
        JSONObject plan = (JSONObject) map.get("plan");
        JSONArray preProduct = (JSONArray) map.get("preProduct");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String plannumber = sdf1.format(new java.util.Date()).substring(2);
        Connection con = null;
        try {
            con = DbUtil.getCon();
            String sql1 = "insert into plan(plannumber,printstate,plant,plantime,line,liner,planname,build,tasksqure,tasknum,isdelete) values(?,0,?,?,?,?,?,?,?,?,0)";
            String sql2 = "insert into preproduct(preproductid,materialcode,weigh,fangliang,standard,materialname,qc,print,plannumber,concretegrade,isdelete) values(?,?,?,?,?,?,?,0,?,?,0)";
            PreparedStatement ps1 = con.prepareStatement(sql1);
            ps1.setString(1, plannumber);
            ps1.setString(2, plan.getString("plant"));
            ps1.setDate(3, "".equals(plan.getString("plantime")) ? null : new Date(sdf.parse(plan.getString("plantime")).getTime()));
            ps1.setString(4, plan.getString("line"));
            ps1.setString(5, plan.getString("liner"));
            ps1.setString(6, plan.getString("planname"));
            ps1.setString(7, plan.getString("build"));
            ps1.setBigDecimal(8, plan.getBigDecimal("tasksqure"));
            ps1.setInt(9, Integer.parseInt(plan.getString("tasknum")));
            int res = ps1.executeUpdate();
            if (res < 1) {
                result.put("flag", false);
                result.put("message", "录入失败");
                out.write(JSON.toJSONString(result));
                return;
            }
            PreparedStatement ps2 = con.prepareStatement(sql2);
            for (Object o : preProduct) {
                JSONObject jsonObject = (JSONObject) o;
                ps2.setString(1, jsonObject.getString("preproductid"));
                ps2.setString(2, jsonObject.getString("materialcode"));
                ps2.setBigDecimal(3, jsonObject.getBigDecimal("weigh"));
                ps2.setBigDecimal(4, jsonObject.getBigDecimal("fangliang"));
                ps2.setString(5, jsonObject.getString("standard"));
                ps2.setString(6, jsonObject.getString("materialname"));
                ps2.setString(7, plan.getString("qc"));
                ps2.setString(8, plannumber);
                ps2.setString(9, jsonObject.getString("concretegrade"));
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
