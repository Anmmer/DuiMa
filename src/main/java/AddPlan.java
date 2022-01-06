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
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

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
        Connection con = null;
        try {
            con = DbUtil.getCon();
            String sql1 = "insert into plan(plannumber,printstate,plant,plantime,line,liner,planname,build,tasksqure,tasknum,isdelete) values(?,0,?,?,?,?,?,?,?,?,0)";
            String sql2 = "insert into preproduct(preproductid,materialcode,weigh,fangliang,standard,materialname,qc,print,plannumber,concretegrade,isdelete) values(?,?,?,?,?,?,?,0,?,?,0)";
            PreparedStatement ps1 = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
            ps1.setString(1, plan.getString("plannumber"));
            ps1.setString(2, plan.getString("plant"));
            ps1.setDate(3, "".equals(plan.getString("plantime")) ? null : new Date(sdf.parse(plan.getString("plantime")).getTime()));
            ps1.setString(3, plan.getString("line"));
            ps1.setString(3, plan.getString("liner"));
            ps1.setString(3, plan.getString("planname"));
            ps1.setString(3, plan.getString("build"));
            ps1.setString(3, plan.getString("tasksqure"));
            ps1.setString(3, plan.getString("tasknum"));
            boolean res = ps1.execute();
            if (!res) {
                result.put("flag", false);
                result.put("message", "录入失败");
                out.write(JSON.toJSONString(result));
                return;
            }
            final int CUSTOMER_ID_COLUMN_INDEX = 1;
            PreparedStatement ps2 = con.prepareStatement(sql2);
            for (Object o : preProduct) {
                JSONObject jsonObject = (JSONObject) o;
                ps2.setString(1, jsonObject.getString("preproductid"));
                ps2.setString(2, jsonObject.getString("materialcode"));
                ps2.setString(3, jsonObject.getString("weigh"));
                ps2.setString(4, jsonObject.getString("fangliang"));
                ps2.setDouble(5, Double.parseDouble(jsonObject.getString("standard")));
                ps2.setDouble(6, Double.parseDouble(jsonObject.getString("materialname")));
                ps2.setString(7, jsonObject.getString("qc"));
                ps2.setInt(8, Integer.parseInt(jsonObject.getString("plannumber")));
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
