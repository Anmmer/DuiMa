import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import domain.HttpClient;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class GetOpenid extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String code = req.getParameter("code");
        try {
            if (!"".equals(code) && code != null) {
                JSONObject jsonObject = HttpClient.sendPost(code);
                out.write(jsonObject.toJSONString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
