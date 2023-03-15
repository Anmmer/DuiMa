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
 * @createDate: 2022/6/7
 */
public class GetPreProductMaterialcode extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        Connection con = null;
        String json = req.getParameter("materialcodes");
        JSONArray jsonArray = JSON.parseArray(json);
        try {
            PrintWriter out = resp.getWriter();
            con = DbUtil.getCon();
            String sql = "select count(*) num from preproduct where materialcode = ? and isdelete = 0";
            String sql2 = "select count(*) num from preproduct where materialcode = ? and product_delete = 0";
            PreparedStatement ps = con.prepareStatement(sql);
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ResultSet res = null;
            Map<String, Object> result = new HashMap<>();
            for (Object o : jsonArray) {
                int num1 = 0;
                int num2 = 0;
                String jsonObject = (String) o;
                ps.setString(1, jsonObject);
                ps2.setString(1,jsonObject);
                res = ps.executeQuery();
                while (res.next()) {
                    num1 = res.getInt("num");
                }
                if (num1 == 0) {
                    result.put("flag", false);
                    result.put("message", "物料编码为：" + jsonObject + " 的构件不存在，请在生产管理->构件上传功能中上传！");
                    out.write(JSON.toJSONString(result));
                    return;
                }
                res = ps2.executeQuery();
                while (res.next()) {
                    num2 = res.getInt("num");
                }
                if (num2 > 0) {
                    result.put("flag", false);
                    result.put("message", "物料编码为：" + jsonObject + " 的构件已经上传计划单，不能重复上传！");
                    out.write(JSON.toJSONString(result));
                    return;
                }
            }
            result.put("flag", true);
            out.write(JSON.toJSONString(result));
            ps.close();
            res.close();
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
