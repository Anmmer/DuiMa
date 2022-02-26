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

/**
 * @description:
 * @author:
 * @createDate: 2021/12/20
 */
public class GetPreProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String plannumber = req.getParameter("plannumber");
        String materialcode = req.getParameter("materialcode");
        String materialname = req.getParameter("materialname");
        String productState = req.getParameter("productState");
        String pourState = req.getParameter("pourState");
        String inspectState = req.getParameter("inspectState");
        String isPour = req.getParameter("isPour");
        String isPrint = req.getParameter("isPrint");
        String pageCur_s = req.getParameter("pageCur");
        String pageMax_s = req.getParameter("pageMax");
        int pageCur = 0;
        if (pageCur_s != null) {
            pageCur = Integer.parseInt(pageCur_s);
        }
        int pageMax = 0;
        if (pageMax_s != null) {
            pageMax = Integer.parseInt(pageMax_s);
        }
        Connection con = null;
        int i = 0;
        int j = 0;
        try {
            PrintWriter out = resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select pid,materialcode,preproductid,standard,materialname,weigh,qc,fangliang,plannumber,print,concretegrade,pourmade,inspect,pourtime,checktime from preproduct where isdelete = 0 ";
            String sql2 = "select count(*) as num from preproduct where isdelete = 0 ";
            if (plannumber != null && !"".equals(plannumber)) {
                sql += " and plannumber = ?";
                sql2 += " and plannumber = ?";
                i++;
            }
            if (materialcode != null && !"".equals(materialcode)) {
                sql += " and materialcode = ?";
                sql2 += " and materialcode = ?";
                i++;
            }
            if (materialname != null && !"".equals(materialname)) {
                sql += " and materialname = ?";
                sql2 += " and materialname = ?";
                i++;
            }
            if ("1".equals(productState)) {
                sql += " and pourmade = 0";
                sql2 += " and inspect = 0";
            }
            if ("2".equals(productState)) {
                sql += " and pourmade = 1";
                sql2 += " and inspect = 0";
            }
            if ("3".equals(productState)) {
                sql += " and pourmade = 1";
                sql2 += " and inspect = 1";
            }
            if ("true".equals(isPrint)) {
                sql += " and print > 0";
                sql2 += " and print > 0";
            }
            if ("true".equals(isPour)) {
                sql += " and pourmade > 0";
                sql2 += " and pourmade > 0";
            }
            if ("0".equals(pourState)) {
                sql += " and pourmade = 0";
                sql2 += " and pourmade = 0";
            }
            if ("1".equals(pourState)) {
                sql += " and pourmade = 1";
                sql2 += " and pourmade = 1";
            }
            if ("0".equals(inspectState)) {
                sql += " and inspect = 0";
                sql2 += " and inspect = 0";
            }
            if ("1".equals(inspectState)) {
                sql += " and inspect = 1";
                sql2 += " and inspect = 1";
            }

            j = i;

            if (pageCur != 0 && pageMax != 0) {
                sql += " limit ?,?";
                i += 2;
            }

            PreparedStatement ps = con.prepareStatement(sql);
            if (pageCur != 0 && pageMax != 0) {
                ps.setInt(i--, pageMax);
                ps.setInt(i--, (pageCur - 1) * pageMax);
            }
            if (materialname != null && !"".equals(materialname)) {
                ps.setString(i--, materialname.trim());
            }
            if (materialcode != null && !"".equals(materialcode)) {
                ps.setString(i--, materialcode.trim());
            }
            if (plannumber != null && !"".equals(plannumber)) {
                ps.setString(i, plannumber);
            }
            ResultSet rs = ps.executeQuery();
            Map<String, Object> data = new HashMap<>();
            List<Map<String, Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("pid", rs.getInt("pid"));
                map.put("materialcode", rs.getString("materialcode"));
                map.put("preproductid", rs.getString("preproductid"));
                map.put("standard", rs.getString("standard"));
                map.put("materialname", rs.getString("materialname"));
                map.put("weigh", rs.getBigDecimal("weigh"));
                map.put("qc", rs.getString("qc"));
                map.put("fangliang", rs.getBigDecimal("fangliang"));
                map.put("concretegrade", rs.getString("concretegrade"));
                map.put("print", rs.getInt("print"));
                map.put("plannumber", rs.getString("plannumber"));
                map.put("pourmade", rs.getInt("pourmade"));
                map.put("inspect", rs.getInt("inspect"));
                map.put("pourtime", rs.getString("pourtime"));
                map.put("checktime", rs.getString("checktime"));
                list.add(map);
            }
            if (pageCur != 0 && pageMax != 0) {
                PreparedStatement ps2 = con.prepareStatement(sql2);
                if (materialname != null && !"".equals(materialname)) {
                    ps2.setString(j--, materialname.trim());
                }
                if (materialcode != null && !"".equals(materialcode)) {
                    ps2.setString(j--, materialcode.trim());
                }
                if (plannumber != null && !"".equals(plannumber)) {
                    ps2.setString(j, plannumber);
                }
                ResultSet rs2 = ps2.executeQuery();
                while (rs2.next()) {
                    int num = rs2.getInt("num");
                    data.put("cnt", num);
                    data.put("pageAll", Math.ceil((double) num / pageMax));
                }
            }
            data.put("data", list);
            out.write(JSON.toJSONString(data));
            ps.close();
            rs.close();
            out.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
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
