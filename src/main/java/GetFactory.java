import com.alibaba.fastjson.JSON;
import com.example.DbUtil;
import domain.Warehouse;

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
import java.util.stream.Collectors;

public class GetFactory extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        Connection con = null;
        PreparedStatement ps = null;
        try (PrintWriter out = response.getWriter()) {
            Map<String, Object> result = new HashMap<>();
            String type = request.getParameter("type");
            String pid = request.getParameter("pid");
            String id = request.getParameter("id");
            String planname = request.getParameter("planname");
            String factoryId = request.getParameter("factoryId");
            String regionId = request.getParameter("regionId");
            String locationId = request.getParameter("locationId");
            int pageCur = 0, pageMax = 0;
            if (request.getParameter("pageCur") != null) {
                pageCur = Integer.parseInt(request.getParameter("pageCur"));
                pageMax = Integer.parseInt(request.getParameter("pageMax"));
            }
            con = DbUtil.getCon();
            int i = 0;
            int j = 0;
            String sql1 = "select id,pid,name,type,path from warehouse where is_delete = '0' ";
            String sql2 = "select count(*) num from warehouse where is_delete = '0' ";
            List<Warehouse> list = new ArrayList<>();
            if (factoryId != null && !factoryId.equals("")) {
                sql1 += " and id in (with recursive temp as (\n" +
                        "select id,pid from warehouse p where  id= ?\n" +
                        "union \n" +
                        " select t.id,t.pid from warehouse t inner join temp t2 on t2.id = t.pid \n" +
                        ") select id from temp )";
                i++;
            }

            if (type != null && !type.equals("")) {
                sql1 += " and type = ?";
                sql2 += " and type = ?";
                i++;
                if (planname != null && !planname.equals("")) {
                    sql1 += " and name like ?";
                    sql2 += " and name like ?";
                    i++;
                }
            }
            if (pid != null && !pid.equals("")) {
                sql1 += " and pid = ?";
                sql2 += " and pid = ?";
                i++;
            }
            if (id != null && !id.equals("")) {
                sql1 += " and id = ?";
                sql2 += " and id = ?";
                i++;
            }
            if (type != null && !type.equals("")) {
                j = i;
                sql1 += " limit ?,?";
                i += 2;
            }
            ps = con.prepareStatement(sql1);
            if (type != null && !type.equals("")) {
                ps.setInt(i--, pageMax);
                ps.setInt(i--, (pageCur - 1) * pageMax);

            }
            if (id != null && !id.equals("")) {
                ps.setString(i--, id);
            }
            if (pid != null && !pid.equals("")) {
                ps.setString(i--, pid);
            }
            if (type != null && !type.equals("")) {
                if (planname != null && !planname.equals("")) {
                    ps.setString(i--, '%' + planname + '%');
                }
                ps.setString(i--, type);
            }
            if (factoryId != null && !factoryId.equals("")) {
                ps.setString(i, factoryId);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Warehouse warehouse = new Warehouse();
                warehouse.setId(rs.getString("id"));
                warehouse.setPid(rs.getString("pid"));
                warehouse.setName(rs.getString("name"));
                warehouse.setText(rs.getString("name"));
                warehouse.setType(rs.getString("type"));
                warehouse.setPath(rs.getString("path"));
                list.add(warehouse);
            }
            if (type != null && !type.equals("")) {

                ps = con.prepareStatement(sql2);
                if (id != null && !id.equals("")) {
                    ps.setString(j--, id);
                }
                if (pid != null && !pid.equals("")) {
                    ps.setString(j--, pid);
                }
                if (type != null && !type.equals("")) {
                    if (planname != null && !planname.equals("")) {
                        ps.setString(j--, '%' + planname + '%');
                    }
                    ps.setString(j, type);
                }
                rs = ps.executeQuery();
                while (rs.next()) {
                    int num = rs.getInt("num");
                    int res_num;
                    if (num % pageMax == 0) {
                        res_num = num / pageMax;
                    } else {
                        res_num = num / pageMax + 1;
                    }
                    result.put("cnt", num);
                    result.put("pageAll", res_num);
                }
                result.put("data", list);
            } else {
                List<Warehouse> list1 = Warehouse.build(list, "0");
                if ((factoryId != null && !factoryId.equals("")) && (regionId != null && !regionId.equals(""))) {
                    List<Warehouse> temp = list1.get(0).getChildren().stream().filter(s -> regionId.equals(s.getId())).collect(Collectors.toList());
                    list1.get(0).getChildren().clear();
                    list1.get(0).getChildren().addAll(temp);
                    if (locationId != null && !locationId.equals("")) {
                        temp = list1.get(0).getChildren().get(0).getChildren().stream().filter(s -> locationId.equals(s.getId())).collect(Collectors.toList());
                        list1.get(0).getChildren().get(0).getChildren().clear();
                        list1.get(0).getChildren().get(0).getChildren().addAll(temp);
                    }
                }
                result.put("data", list1);
            }
            out.write(JSON.toJSONString(result));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                assert con != null;
                con.close();
                assert ps != null;
                ps.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
