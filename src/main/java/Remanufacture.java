import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.example.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class Remanufacture extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String materialcodes = req.getParameter("materialcodes");    //新
        String materialcode_zs = req.getParameter("materialcode_zs");//旧
        String user = req.getParameter("user");
        JSONArray jsonArray = JSON.parseArray(materialcodes);
        JSONArray jsonArray_z = JSON.parseArray(materialcode_zs);
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            int i = 0;
            con = DbUtil.getCon();
            String sql = "update preproduct set covert_test = 1,inspect = 1,pourmade=1,stock_status='2' where materialcode = ? and isdelete = 0";
            String sql2 = "update preproduct set covert_test = 1,inspect = 1,pourmade=1,product_delete=0,checktime = now(),weigh=?,fangliang=?,qc=?,print=?,plannumber=?,concretegrade=?,inspect_user=? where materialcode = ?";
            String sql3 = "select weigh,fangliang,qc,print,plannumber,concretegrade from preproduct where materialcode = ?";
            String sql4 = "insert into  warehouse_info_log(warehouse_info_id,create_date,user_name,type,in_warehouse_id,out_warehouse_id,materialcode,method) values(?,now(),?,?,?,?,?,?)";

            for (int j = 0; j < jsonArray.size(); j++) {
                String materialcode = jsonArray.getString(j);
                String materialcode_z = jsonArray_z.getString(j);
                ps = con.prepareStatement(sql);
                ps.setString(1, materialcode_z.trim());
                i = ps.executeUpdate() + i;
                ps = con.prepareStatement(sql3);
                ps.setString(1, materialcode_z);
                ResultSet rs = ps.executeQuery();
                Map<String, String> map = new HashMap<>();
                while (rs.next()) {
                    map.put("weigh", rs.getString("weigh"));
                    map.put("fangliang", rs.getString("fangliang"));
                    map.put("qc", rs.getString("qc"));
                    map.put("print", rs.getString("print"));
                    map.put("plannumber", rs.getString("plannumber"));
                    map.put("concretegrade", rs.getString("concretegrade"));
                }
                ps = con.prepareStatement(sql2);
                ps.setString(1, map.get("weigh"));
                ps.setString(2, map.get("fangliang"));
                ps.setString(3, map.get("qc"));
                ps.setString(4, map.get("print"));
                ps.setString(5, map.get("plannumber"));
                ps.setString(6, map.get("concretegrade"));
                ps.setString(7, user);
                ps.setString(8, materialcode);
                ps.executeUpdate();
                ps = con.prepareStatement(sql4);
                ps.setString(1, UUID.randomUUID().toString().toLowerCase().replace("-", ""));
                ps.setString(2, user);
                ps.setString(3, "2");
                ps.setString(4, null);
                ps.setString(5, "000000002");
                ps.setString(6, materialcode_z);
                ps.setString(7, "再制造出库");
                ps.executeUpdate();
            }
            if (i > 0) {
                result.put("message", "操作成功");
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "操作失败");
                result.put("flag", false);
                out.write(JSON.toJSONString(result));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
            try {
                if (con != null)
                    con.close();
                if (ps != null)
                    ps.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}