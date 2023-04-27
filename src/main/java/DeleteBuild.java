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
import java.util.HashMap;
import java.util.Map;

/**
 * @description:
 * @author:
 * @createDate: 2023/2/7
 */
public class DeleteBuild extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String materialcode = req.getParameter("materialcode");
        String batchId = req.getParameter("batchId");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DbUtil.getCon();
            String sql = "update preproduct set isdelete = 1 where ";
            String sql2 = "select count(*) num from preproduct where isdelete = 0 and product_delete = '0' ";
            if (materialcode != null && !"".equals(materialcode)) {
                sql += "materialcode = ? ";
                sql2 += " and materialcode = ? ";
            }
            if (batchId != null && !"".equals(batchId)) {
                sql += "batch_id = ? ";
                sql2 += " and batch_id = ? ";
            }
            ps = con.prepareStatement(sql2);
            if (materialcode != null && !"".equals(materialcode)) {
                ps.setString(1, materialcode);
            } else {
                ps.setString(1, batchId);
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                int num = rs.getInt("num");
                if (num > 0) {
                    if (materialcode != null && !"".equals(materialcode)) {
                        result.put("message", "该构建已上传计划单，不能删除");
                    } else {
                        result.put("message", "该批次存在构建已上传计划单，不能删除");
                    }
                    result.put("flag", false);
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            ps = con.prepareStatement(sql);
            if (materialcode != null) {
                ps.setString(1, materialcode);
            } else {
                ps.setString(1, batchId);
            }
            int i = ps.executeUpdate();
            if (i > 0) {
                result.put("message", "删除成功");
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            } else {
                result.put("message", "删除失败");
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
