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
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class AddArchives extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String planname = req.getParameter("planname");
        String line = req.getParameter("line");
        String plant = req.getParameter("plant");
        String qc = req.getParameter("qc");
        Map<String, Object> result = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DbUtil.getCon();
            String sql = "insert into basicarchives(planname,line,plant,qc,isdelete) values(?,?,?,?,0)";
            ps = con.prepareStatement(sql);
            ps.setString(1,planname);
            ps.setString(2,line);
            ps.setString(3,plant);
            ps.setString(4,qc);
            int i = ps.executeUpdate();
            if(i==1){
                result.put("message", "插入成功");
                result.put("flag", true);
                out.write(JSON.toJSONString(result));
            }else{
                result.put("message", "插入失败");
                result.put("flag", false);
                out.write(JSON.toJSONString(result));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            out.close();
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
