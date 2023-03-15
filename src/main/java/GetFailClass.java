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

/**
 * @description:
 * @author:
 * @createDate: 2022/5/9
 */
public class GetFailClass extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        Connection con = null;
        PreparedStatement ps = null;
        String index = req.getParameter("index");//查询顶层分类标志
        String pid = req.getParameter("pid");
        try {
            con = DbUtil.getCon();
            String sql = "select id,classification,defect_name from inspect_fail_content where isdelete = '0' ";
            if ("0".equals(index)) {
                sql += " and pid = 0";
            } else {
                sql += " and pid = ?";
            }
            ps = con.prepareStatement(sql);
            if (!"0".equals(index)) {
                ps.setInt(1, Integer.parseInt(pid));
            }
            ResultSet rs = ps.executeQuery();
            List<FailContent> list = new ArrayList<>();
            Map<String, Object> data = new HashMap<>();
            while (rs.next()) {
                FailContent failContent = new FailContent();
                failContent.setId(rs.getInt("id"));
                failContent.setClassification(rs.getString("classification"));
                failContent.setDefect_name(rs.getString("defect_name"));
                list.add(failContent);
            }
            data.put("data", list);
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
