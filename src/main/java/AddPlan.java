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
            String sql1 = "insert into plan(planname,company,plant) values(?,?,?)";
            String sql2 = "insert into preproduct(projectname,materialcode,preproductid,size,volume,weigh,qc,build,time,print,planid) values(?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps1 = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
            ps1.setString(1, plan.getString("planname"));
            ps1.setString(2, plan.getString("company"));
            ps1.setString(3, plan.getString("plant"));
            ps1.execute();
            ResultSet res1 = ps1.getGeneratedKeys();
            if (!res1.next()) {
                System.err.println("获取ID失败");
                result.put("message", "获取ID失败");
                out.write(JSON.toJSONString(result));
                return;
            }
            final int CUSTOMER_ID_COLUMN_INDEX = 1;
            int index = res1.getInt(CUSTOMER_ID_COLUMN_INDEX);
            PreparedStatement ps2 = con.prepareStatement(sql2);
            for (Object o : preProduct) {
                JSONObject jsonObject = (JSONObject) o;
                ps2.setString(1, jsonObject.getString("projectname"));
                ps2.setString(2, jsonObject.getString("materialcode"));
                ps2.setString(3, jsonObject.getString("preproductid"));
                ps2.setString(4, jsonObject.getString("size"));
                ps2.setDouble(5, Double.parseDouble(jsonObject.getString("volume")));
                ps2.setDouble(6, Double.parseDouble(jsonObject.getString("weigh")));
                ps2.setString(7, jsonObject.getString("qc"));
                ps2.setString(8, jsonObject.getString("build"));
                ps2.setDate(9, "".equals(jsonObject.getString("time")) ? null : (Date) sdf.parse(jsonObject.getString("time")));
                ps2.setInt(10, 0);
                ps2.setInt(11, index);
                ps2.addBatch();
            }
            int[] rs2 = ps2.executeBatch();
            if (rs2.length < 1) {
            result.put("flag", false);
            result.put("message", "录入失败");
            out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "录入成功");
                out.write(JSON.toJSONString(result));
            result.put("flag", false);
            }
            ps1.close();
            ps2.close();
        } catch (Exception e) {
            e.printStackTrace();
            result.put("flag",false);
            result.put("message", "录入失败");
            out.write(JSON.toJSONString(result));
        } finally {
            out.close();
        }
    }
}
