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

/**
 * @description:
 * @author:
 * @createDate: 2022/5/15
 */
public class ConcealedProcess extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String pids = req.getParameter("pids");
        String covert_test_failure_reason = req.getParameter("covert_test_failure_reason");
        String covert_test = req.getParameter("covert_test");
        String covert_test_remark = req.getParameter("covert_test_remark");
        String covert_test_user = req.getParameter("covert_test_user");
        String index = req.getParameter("index");//是否合格
        JSONArray list = JSON.parseArray(pids);
        Connection con = null;
        PreparedStatement ps = null;
        Map<String, Object> map = new HashMap<>();
        StringBuilder sql = null;
        if ("0".equals(index)) {
            sql = new StringBuilder("update preproduct set covert_test = 2,covert_test_failure_reason = ?,covert_test_remark= ? ,covert_test_user = ? ,covert_test_time = date_format(now(),'%Y-%m-%d') where pid in (");
        } else {
            sql = new StringBuilder("update preproduct set covert_test = ? ,covert_test_user = ? ,covert_test_time = date_format(now(),'%Y-%m-%d') where pid in (");
        }
        if (list.size() == 1) {
            sql.append("?)");
        } else {
            for (int j = 0; j < list.size() - 1; j++) {
                sql.append("? , ");
            }
            sql.append("?)");
        }
        try {
            con = DbUtil.getCon();
            ps = con.prepareStatement(sql.toString());
            if ("0".equals(index)) {
                ps.setString(1, covert_test_failure_reason);
                ps.setString(2, covert_test_remark);
                ps.setString(3, covert_test_user);
                for (int j = 0; j < list.size(); j++) {
                    ps.setString(j + 4, list.getString(j));
                }
            } else {
                ps.setInt(1, Integer.parseInt(covert_test));
                ps.setString(2, covert_test_user);
                for (int j = 0; j < list.size(); j++) {
                    ps.setString(j + 3, list.getString(j));
                }
            }
            int i = ps.executeUpdate();
            if (i <= 0) {
                map.put("flag", false);
                map.put("message", "检验失败");
            } else {
                map.put("flag", true);
                map.put("message", "检验成功");
            }
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                con.close();
                out.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
