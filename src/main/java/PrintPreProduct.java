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
import java.util.HashMap;
import java.util.Map;

/**
 * @description:
 * @author:
 * @createDate: 2021/12/21
 */
public class PrintPreProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String preProductIds = req.getParameter("productIds");
        String plannumber = req.getParameter("plannumber");
        JSONArray jsonArray = JSONObject.parseArray(preProductIds);
        Connection con = null;
        PreparedStatement ps1 = null;
        PrintWriter out = resp.getWriter();
        String sql1 = "update preproduct set print = print +1 where pid = ?";
        Map<String, Object> map = new HashMap<>();
        try {
            con = DbUtil.getCon();
            ps1 = con.prepareStatement(sql1);
            for (Object o : jsonArray) {
                JSONObject jsonObject = (JSONObject) o;
                ps1.setInt(1, Integer.parseInt(jsonObject.getString("pid")));
                ps1.addBatch();
            }
            int[] is = ps1.executeBatch();

            if (is.length < 1)
                map.put("flag", false);
            else
                map.put("flag", true);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null)
                    con.close();
                if (ps1 != null)
                    ps1.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    public static boolean getPrintState(String plannumber) {
        Connection con = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        String sql1 = "select count(print) print from preproduct where plannumber = ? and isdelete = 0 and print>0";
        String sql2 = "select tasknum from plan where plannumber = ? and isdelete = 0";
        try {
            con = DbUtil.getCon();
            ps1 = con.prepareStatement(sql1);
            ps1.setString(1,plannumber);
            ResultSet rs1 = ps1.executeQuery();
            Integer print = null;
            while (rs1.next()){
                print = rs1.getInt("print");
            }
            ps2 = con.prepareStatement(sql2);
            ps2.setString(1,plannumber);
            ResultSet rs2 = ps2.executeQuery();
            Integer num = null;
            while (rs2.next()){
                num = rs2.getInt("tasknum");
            }
            if(print.equals(num)){
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null)
                    con.close();
                if (ps1 != null)
                    ps1.close();
                if (ps2 != null)
                    ps2.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        return false;
    }
}
