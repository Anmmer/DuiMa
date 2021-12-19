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
import java.util.Map;

public class addPlan extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String str = request.getParameter("str");
        Map<String, Object> map = JSON.parseObject(str, Map.class);
        JSONObject plan = (JSONObject) map.get("plan");
        JSONArray preProduct = (JSONArray) map.get("preProduct");
        Connection con = null;
        try {
            con = DbUtil.getCon();
            String sql = "insert into plan(planname,company,plant) values(?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, plan.getString("planname"));
            ps.setString(2, plan.getString("company"));
            ps.setString(3, plan.getString("plant"));
            ps.execute();
            ResultSet res = ps.getGeneratedKeys();
            if (!res.next()) {
                System.err.println("获取ID失败");
            }
            final int CUSTOMER_ID_COLUMN_INDEX = 1;
            int index = res.getInt(CUSTOMER_ID_COLUMN_INDEX);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
