import com.alibaba.fastjson.JSON;
import com.example.DbUtil;
import domain.FailContent;

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

public class GetFailContent extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String classification = req.getParameter("classification");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "select id,pid,classification,defect_name from inspect_fail_content where isdelete = '0' ";
            int i = 0;
            if (classification != null && !"".equals(classification)) {
                sql += " and classification = ?";
                i++;
            }
            sql += " order by pid ";
            ps = con.prepareStatement(sql);
            if (classification != null && !"".equals(classification)) {
                ps.setString(i, classification);
            }
            ResultSet rs = ps.executeQuery();
            List<FailContent> list = new ArrayList<>();
            Map<String, Object> data = new HashMap<>();
            while (rs.next()) {
                FailContent failContent = new FailContent();
                failContent.setId(rs.getInt("id"));
                failContent.setPid(rs.getInt("pid"));
                failContent.setClassification(rs.getString("classification"));
                failContent.setDefect_name(rs.getString("defect_name"));
                list.add(failContent);
            }
            List<FailContent> failContentList = FailContent.build(list,0);
            data.put("data", failContentList);
            out.write(JSON.toJSONString(data));
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
