import com.alibaba.fastjson.JSON;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GetBatchNum extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String planname = req.getParameter("planname");
        int pageCur = Integer.parseInt(req.getParameter("pageCur"));
        int pageMax = Integer.parseInt(req.getParameter("pageMax"));
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        try {
            con = DbUtil.getCon();
            String sql = "select a.user_name,a.date,a.batch_id, b.num from (select user_name,date,batch_id from batch where planname = ?) a left join (select count(*) num,batch_id from preproduct where isdelete = 0 group by batch_id) b on a.batch_id = b.batch_id  order by a.date";
            String sql2 = "select count(*) as num from (select user_name,date,batch_id from batch where planname = ?) a left join (select count(*) num,batch_id from preproduct where isdelete = 0 group by batch_id) b on a.batch_id = b.batch_id order by a.date";
            sql += " limit ?,?";
            ps = con.prepareStatement(sql);
            ps.setString(1, planname);
            ps.setInt(3, pageMax);
            ps.setInt(2, (pageCur - 1) * pageMax);
            ps2 = con.prepareStatement(sql2);
            ps2.setString(1, planname);
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                int num = rs2.getInt("num");
                result.put("cnt", num);
                int res_num;
                if (num % pageMax == 0) {
                    res_num = num / pageMax;
                } else {
                    res_num = num / pageMax + 1;
                }
                result.put("pageAll", res_num);
            }
            ResultSet rs = ps.executeQuery();
            int index = (pageCur - 1) * pageMax + 1;
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("user_name", rs.getString("user_name"));
                map.put("batch_id", rs.getString("batch_id"));
                map.put("date", rs.getString("date"));
                map.put("index", index);
                map.put("num", rs.getString("num"));
                list.add(map);
                index++;
            }
            result.put("data", list);
            out.write(JSON.toJSONString(result));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
            try {
                if (con != null)
                    con.close();
                if (ps != null)
                    ps.close();
                if (ps2 != null)
                    ps2.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
