import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GetPlan extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        resp.setContentType("text/html;charset=UTF-8");
        String startDate = req.getParameter("startDate");
        String endDate = req.getParameter("endDate");
        String planname = req.getParameter("planname");
        String line = req.getParameter("line");
        String materialcode = req.getParameter("materialcode");
        String materialname = req.getParameter("materialname");
        String preproductid = req.getParameter("preproductid");
        String productState = req.getParameter("productState");
        String printstate = req.getParameter("printstate");
        String on_or_off = req.getParameter("on_or_off");
        int pageCur = Integer.parseInt(req.getParameter("pageCur"));
        int pageMax = Integer.parseInt(req.getParameter("pageMax"));
        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2;
        ResultSet rs = null;
        PrintWriter out = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int i = 0;
        int j = 0;
        try {
            out = resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select plannumber,plant,plantime,line,liner,planname,build,tasksqure,tasknum,updatedate,CASE ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.product_delete = 0 AND preproduct.inspect = 1 ) WHEN tasknum THEN 1 ELSE 0 END AS checkstate," +
                    "CASE ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.product_delete = 0 AND preproduct.pourmade = 1 ) WHEN tasknum THEN 1 ELSE 0 END AS pourmadestate ," +
                    " printstate " +
                    "from plan where isdelete = 0 ";
            String sql2 = "select count(1) as num from plan where isdelete = 0";
            if (!"".equals(startDate) && startDate != null) {
                sql += " and plantime >= ?";
                sql2 += " and plantime >= ?";
                i++;
            }
            if (!"".equals(endDate) && endDate != null) {
                sql += " and plantime <= ?";
                sql2 += " and plantime <= ?";
                i++;
            }
            if (!"".equals(planname) && planname != null) {
                sql += " and planname like ?";
                sql2 += " and planname like ?";
                i++;
            }
            if (!"".equals(materialcode) && materialcode != null) {
                sql += " and plannumber in (select plannumber from preproduct where materialcode = ?)";
                sql2 += " and plannumber in (select plannumber from preproduct where materialcode = ?)";
                i++;
            }
            if (!"".equals(materialname) && materialname != null) {
                sql += " and plannumber in (select plannumber from preproduct where materialname like ?)";
                sql2 += " and plannumber in (select plannumber from preproduct where materialname like ?)";
                i++;
            }
            if (!"".equals(preproductid) && preproductid != null) {
                sql += " and plannumber in (select plannumber from preproduct where preproductid like ?)";
                sql2 += " and plannumber in (select plannumber from preproduct where preproductid like ?)";
                i++;
            }
            if (!"".equals(line) && line != null) {
                sql += " and line like ?";
                sql2 += " and line like ?";
                i++;
            }
            if ("0".equals(productState)) {
                if ("1".equals(on_or_off)) {
                    sql += " and ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.pourmade = 1 and preproduct.inspect = 1 and covert_test = 1) !=tasknum";
                    sql2 += " and ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.pourmade = 1 AND preproduct.inspect = 1 and covert_test = 1)!=tasknum";
                } else {
                    sql += " and ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.pourmade = 1 and preproduct.inspect = 1) !=tasknum";
                    sql2 += " and ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.pourmade = 1 AND preproduct.inspect = 1)!=tasknum";
                }
            }
            if ("1".equals(productState)) {
                if ("1".equals(on_or_off)) {
                    sql += " and ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.pourmade = 1 and preproduct.inspect = 1 and covert_test = 1) =tasknum";
                    sql2 += " and ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.pourmade = 1 AND preproduct.inspect = 1 and covert_test = 1) =tasknum";
                } else {
                    sql += " and ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.pourmade = 1 and preproduct.inspect = 1) =tasknum";
                    sql2 += " and ( SELECT count( 1 ) FROM preproduct WHERE preproduct.plannumber = plan.plannumber AND preproduct.pourmade = 1 and preproduct.inspect = 1) =tasknum";
                }
            }
            if (!"".equals(printstate) && printstate != null) {
                sql += " and printstate = ?";
                sql2 += " and printstate = ?";
                i++;
            }
            j = i;
            sql += " order by printstate,plantime desc,planname  limit ?,?";
            i += 2;
            ps = con.prepareStatement(sql);
            ps.setInt(i--, pageMax);
            ps.setInt(i--, (pageCur - 1) * pageMax);

            if (!"".equals(printstate) && printstate != null) {
                ps.setInt(i--, Integer.parseInt(printstate));
            }

            if (!"".equals(line) && line != null) {
                ps.setString(i--, "%" + line.trim() + "%");
            }

            if (!"".equals(preproductid) && preproductid != null) {
                ps.setString(i--, "%" + preproductid.trim() + "%");
            }

            if (!"".equals(materialname) && materialname != null) {
                ps.setString(i--, "%" + materialname.trim() + "%");
            }

            if (!"".equals(materialcode) && materialcode != null) {
                ps.setString(i--, materialcode.trim());
            }
            if (!"".equals(planname) && planname != null) {
                ps.setString(i--, "%" + planname.trim() + "%");
            }
            if (!"".equals(endDate) && endDate != null) {
                ps.setDate(i--, new Date(sdf.parse(endDate).getTime()));
            }
            if (!"".equals(startDate) && startDate != null) {
                ps.setDate(i, new Date(sdf.parse(startDate).getTime()));
            }
            rs = ps.executeQuery();
            Map<String, Object> data = new HashMap<>();
            List<Map<String, Object>> list = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("plannumber", rs.getString("plannumber"));
                map.put("printstate", rs.getInt("printstate"));
                map.put("plant", rs.getString("plant"));
                map.put("plantime", rs.getDate("plantime"));
                map.put("line", rs.getString("line"));
                map.put("liner", rs.getString("liner"));
                map.put("planname", rs.getString("planname"));
                map.put("build", rs.getString("build"));
                map.put("tasksqure", rs.getString("tasksqure"));
                map.put("tasknum", rs.getString("tasknum"));
                map.put("updatedate", rs.getDate("updatedate"));
                map.put("pourmadestate", rs.getInt("pourmadestate"));
                map.put("checkstate", rs.getInt("checkstate"));
                list.add(map);
            }
            ps2 = con.prepareStatement(sql2);

            if (!"".equals(printstate) && printstate != null) {
                ps2.setInt(j--, Integer.parseInt(printstate));
            }

            if (!"".equals(line) && line != null) {
                ps2.setString(j--, "%" + line.trim() + "%");
            }
            if (!"".equals(preproductid) && preproductid != null) {
                ps2.setString(j--, "%" + preproductid.trim() + "%");
            }

            if (!"".equals(materialname) && materialname != null) {
                ps2.setString(j--, "%" + materialname.trim() + "%");
            }
            if (!"".equals(materialcode) && materialcode != null) {
                ps2.setString(j--, materialcode.trim());
            }
            if (!"".equals(planname) && planname != null) {
                ps2.setString(j--, "%" + planname.trim() + "%");
            }
            if (!"".equals(endDate) && endDate != null) {
                ps2.setDate(j--, new Date(sdf.parse(endDate).getTime()));
            }
            if (!"".equals(startDate) && startDate != null) {
                ps2.setDate(j, new Date(sdf.parse(startDate).getTime()));
            }
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                int num = rs2.getInt("num");
                data.put("cnt", num);
                data.put("pageAll", Math.ceil((double) num / pageMax));
            }
            data.put("data", list);
            out.write(JSON.toJSONString(data));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null)
                    con.close();
                if (rs != null)
                    rs.close();
                if (ps != null)
                    ps.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            if (out != null) {
                out.close();
            }
        }
    }
}
