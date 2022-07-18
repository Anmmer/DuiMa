import com.alibaba.fastjson.JSON;
import com.example.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
        String preproductid = req.getParameter("preproductid");
        String productState = req.getParameter("productState");
        String on_or_off = req.getParameter("on_or_off");
        String pourState = req.getParameter("pourState");
        String inspectState = req.getParameter("inspectState");
        String testState = req.getParameter("testState");
        String covert_test_user = req.getParameter("covert_test_user");
        String covert_test_startDate = req.getParameter("covert_test_startDate");
        String covert_test_endDate = req.getParameter("covert_test_endDate");
        String pourmade_user = req.getParameter("pourmade_user");
        String pourmade_startDate = req.getParameter("pourmade_startDate");
        String pourmade_endDate = req.getParameter("pourmade_endDate");
        String inspect_startDate = req.getParameter("inspect_startDate");
        String inspect_endDate = req.getParameter("inspect_endDate");
        String inspect_user = req.getParameter("inspect_user");
        String line = req.getParameter("line");
        String isPour = req.getParameter("isPour");
        String isPrint = req.getParameter("isPrint");
        String isTest = req.getParameter("isTest");
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
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String sql = "select pid,materialcode,preproductid,standard,materialname,weigh,qc,fangliang,build,preproduct.plannumber,print,concretegrade,pourmade,inspect,covert_test,covert_test_time,covert_test_failure_reason,failure_reason,patch_library,pourtime,checktime,line,inspect_remark,inspect_user,covert_test_remark,covert_test_user,pourmade_user from preproduct,plan where preproduct.isdelete = 0 and preproduct.plannumber = plan.plannumber";
            String sql2 = "select count(*) as num from preproduct where isdelete = 0 ";
            if (plannumber != null && !"".equals(plannumber)) {
                sql += " and preproduct.plannumber = ?";
                sql2 += " and preproduct.plannumber = ?";
                i++;
            }
            if (materialcode != null && !"".equals(materialcode)) {
                sql += " and materialcode like ?";
                sql2 += " and materialcode like ?";
                i++;
            }
            if (materialname != null && !"".equals(materialname)) {
                sql += " and materialname like ?";
                sql2 += " and materialname like ?";
                i++;
            }
            if (preproductid != null && !"".equals(preproductid)) {
                sql += " and preproductid like ?";
                sql2 += " and preproductid like ?";
                i++;
            }
            if ("1".equals(on_or_off)) {
                if ("1".equals(productState)) {
                    sql += " and covert_test = 0";
                    sql2 += " and covert_test = 0";
                }
                if ("2".equals(productState)) {
                    sql += " and covert_test = 2";
                    sql2 += " and covert_test = 2";
                }
                if ("3".equals(productState)) {
                    sql += " and pourmade = 0 and inspect = 0 and covert_test = 1 ";
                    sql2 += " and pourmade = 0 and inspect = 0 and covert_test = 1 ";
                }
                if ("4".equals(productState)) {
                    sql += " and pourmade = 1 and inspect = 0 and covert_test = 1 ";
                    sql2 += " and pourmade = 1 and inspect = 0 and covert_test = 1 ";
                }
                if ("5".equals(productState)) {
                    sql += " and pourmade = 1 and inspect = 1 and covert_test = 1 ";
                    sql2 += " and pourmade = 1 and inspect = 1 and covert_test = 1 ";
                }
                if ("6".equals(productState)) {
                    sql += " and pourmade = 1 and inspect = 2 and covert_test = 1 ";
                    sql2 += " and pourmade = 1 and inspect = 2 and covert_test = 1 ";
                }
            } else {
                if ("1".equals(productState)) {
                    sql += " and pourmade = 0 and inspect = 0";
                    sql2 += " and pourmade = 0 and inspect = 0";
                }
                if ("2".equals(productState)) {
                    sql += " and pourmade = 1 and inspect = 0";
                    sql2 += " and pourmade = 1 and inspect = 0";
                }
                if ("3".equals(productState)) {
                    sql += " and pourmade = 1 and inspect = 1 ";
                    sql2 += " and pourmade = 1 and inspect = 1 ";
                }
                if ("4".equals(productState)) {
                    sql += " and pourmade = 1 and inspect = 2 ";
                    sql2 += " and pourmade = 1 and inspect = 2 ";
                }
            }

            if ("true".equals(isPrint)) {
                sql += " and print > 0";
                sql2 += " and print > 0";
            }
            if ("true".equals(isPour)) {
                sql += " and pourmade > 0";
                sql2 += " and pourmade > 0";
            }
            if ("true".equals(isTest)) {
                sql += " and covert_test = 1";
                sql2 += " and covert_test = 1";
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
            if ("2".equals(inspectState)) {
                sql += " and inspect = 2";
                sql2 += " and inspect = 2";
            }
            if ("0".equals(testState)) {
                sql += " and covert_test = 0";
                sql2 += " and covert_test = 0";
            }
            if ("1".equals(testState)) {
                sql += " and covert_test = 1";
                sql2 += " and covert_test = 1";
            }
            if ("2".equals(testState)) {
                sql += " and covert_test = 2";
                sql2 += " and covert_test = 2";
            }

            if (!"".equals(covert_test_startDate) && covert_test_startDate != null) {
                sql += " and covert_test_time >= ?";
                sql2 += " and covert_test_time >= ?";
                i++;
            }
            if (!"".equals(covert_test_endDate) && covert_test_endDate != null) {
                sql += " and covert_test_time <= ?";
                sql2 += " and covert_test_time <= ?";
                i++;
            }

            if (covert_test_user != null && !"".equals(covert_test_user)) {
                sql += " and covert_test_user like ?";
                sql2 += " and covert_test_user like ?";
                i++;
            }

            if (!"".equals(pourmade_startDate) && pourmade_startDate != null) {
                sql += " and pourtime >= ?";
                sql2 += " and pourtime >= ?";
                i++;
            }
            if (!"".equals(pourmade_endDate) && pourmade_endDate != null) {
                sql += " and pourtime <= ?";
                sql2 += " and pourtime <= ?";
                i++;
            }

            if (pourmade_user != null && !"".equals(pourmade_user)) {
                sql += " and pourmade_user like ?";
                sql2 += " and pourmade_user like ?";
                i++;
            }
            if (!"".equals(inspect_startDate) && inspect_startDate != null) {
                sql += " and checktime >= ?";
                sql2 += " and checktime >= ?";
                i++;
            }
            if (!"".equals(inspect_endDate) && inspect_endDate != null) {
                sql += " and checktime <= ?";
                sql2 += " and checktime <= ?";
                i++;
            }

            if (inspect_user != null && !"".equals(inspect_user)) {
                sql += " and inspect_user like ?";
                sql2 += " and inspect_user like ?";
                i++;
            }

            if (line != null && !"".equals(line)) {
                sql += " and line = ?";
                sql2 += " and line = ?";
                i++;
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
            if (line != null && !"".equals(line)) {
                ps.setString(i--, line.trim());
            }
            if (inspect_user != null && !"".equals(inspect_user)) {
                ps.setString(i--, "%" + inspect_user.trim() + "%");
            }
            if (!"".equals(inspect_endDate) && inspect_endDate != null) {
                ps.setDate(i--, new Date(sdf.parse(inspect_endDate).getTime()));
            }
            if (!"".equals(inspect_startDate) && inspect_startDate != null) {
                ps.setDate(i--, new Date(sdf.parse(inspect_startDate).getTime()));
            }
            if (pourmade_user != null && !"".equals(pourmade_user)) {
                ps.setString(i--, "%" + pourmade_user.trim() + "%");
            }
            if (!"".equals(pourmade_endDate) && pourmade_endDate != null) {
                ps.setDate(i--, new Date(sdf.parse(pourmade_endDate).getTime()));
            }
            if (!"".equals(pourmade_startDate) && pourmade_startDate != null) {
                ps.setDate(i--, new Date(sdf.parse(pourmade_startDate).getTime()));
            }
            if (covert_test_user != null && !"".equals(covert_test_user)) {
                ps.setString(i--, "%" + covert_test_user.trim() + "%");
            }
            if (!"".equals(covert_test_endDate) && covert_test_endDate != null) {
                ps.setDate(i--, new Date(sdf.parse(covert_test_endDate).getTime()));
            }
            if (!"".equals(covert_test_startDate) && covert_test_startDate != null) {
                ps.setDate(i--, new Date(sdf.parse(covert_test_startDate).getTime()));
            }
            if (preproductid != null && !"".equals(preproductid)) {
                ps.setString(i--, "%" + preproductid.trim() + "%");
            }
            if (materialname != null && !"".equals(materialname)) {
                ps.setString(i--, "%" + materialname.trim() + "%");
            }
            if (materialcode != null && !"".equals(materialcode)) {
                ps.setString(i--, "%" + materialcode.trim() + "%");
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
                map.put("covert_test", rs.getInt("covert_test"));
                map.put("covert_test_time", rs.getString("covert_test_time"));
                map.put("covert_test_failure_reason", rs.getString("covert_test_failure_reason"));
                map.put("failure_reason", rs.getString("failure_reason"));
                map.put("patch_library", rs.getString("patch_library"));
                map.put("pourtime", rs.getString("pourtime"));
                map.put("checktime", rs.getString("checktime"));
                map.put("line", rs.getString("line"));
                map.put("build", rs.getString("build"));
                map.put("inspect_remark", rs.getString("inspect_remark"));
                map.put("inspect_user", rs.getString("inspect_user"));
                map.put("covert_test_remark", rs.getString("covert_test_remark"));
                map.put("covert_test_user", rs.getString("covert_test_user"));
                map.put("pourmade_user", rs.getString("pourmade_user"));
                list.add(map);
            }
            if (pageCur != 0 && pageMax != 0) {
                PreparedStatement ps2 = con.prepareStatement(sql2);

                if (line != null && !"".equals(line)) {
                    ps2.setString(j--, line.trim());
                }
                if (inspect_user != null && !"".equals(inspect_user)) {
                    ps2.setString(j--, "%" + inspect_user.trim() + "%");
                }
                if (!"".equals(inspect_endDate) && inspect_endDate != null) {
                    ps2.setDate(j--, new Date(sdf.parse(inspect_endDate).getTime()));
                }
                if (!"".equals(inspect_startDate) && inspect_startDate != null) {
                    ps2.setDate(j--, new Date(sdf.parse(inspect_startDate).getTime()));
                }
                if (pourmade_user != null && !"".equals(pourmade_user)) {
                    ps2.setString(j--, "%" + pourmade_user.trim() + "%");
                }
                if (!"".equals(pourmade_endDate) && pourmade_endDate != null) {
                    ps2.setDate(j--, new Date(sdf.parse(pourmade_endDate).getTime()));
                }
                if (!"".equals(pourmade_startDate) && pourmade_startDate != null) {
                    ps2.setDate(j--, new Date(sdf.parse(pourmade_startDate).getTime()));
                }

                if (covert_test_user != null && !"".equals(covert_test_user)) {
                    ps2.setString(j--, "%" + covert_test_user.trim() + "%");
                }
                if (!"".equals(covert_test_endDate) && covert_test_endDate != null) {
                    ps2.setDate(j--, new Date(sdf.parse(covert_test_endDate).getTime()));
                }
                if (!"".equals(covert_test_startDate) && covert_test_startDate != null) {
                    ps2.setDate(j, new Date(sdf.parse(covert_test_startDate).getTime()));
                }
                if (preproductid != null && !"".equals(preproductid)) {
                    ps2.setString(j--, "%" + preproductid.trim() + "%");
                }
                if (materialname != null && !"".equals(materialname)) {
                    ps2.setString(j--, "%" + materialname.trim() + "%");
                }
                if (materialcode != null && !"".equals(materialcode)) {
                    ps2.setString(j--, "%" + materialcode.trim() + "%");
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
        } catch (ClassNotFoundException | SQLException | ParseException e) {
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
