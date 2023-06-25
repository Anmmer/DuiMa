package domain;

import com.alibaba.fastjson.JSONObject;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class HttpClient {
    private final static CloseableHttpClient httpClient = HttpClients.createDefault();
    private static String appid = "";
    private static String secret = "";


    private void close() throws IOException {
        httpClient.close();
    }

    private void sendGet() throws Exception {
        HttpGet request = new HttpGet("你请求数据的url地址");
        request.addHeader("custom-key", "lyl");
        request.addHeader(HttpHeaders.USER_AGENT, "Googlebot");

        try (CloseableHttpResponse response = httpClient.execute(request)) {
            System.out.println(response.getStatusLine().toString());
            HttpEntity entity = response.getEntity();
            Header headers = entity.getContentType();
            System.out.println(headers);
            if (entity != null) {
                String result = EntityUtils.toString(entity);
                System.out.println(result);
            }
        }
    }

    public static JSONObject sendPost(String code) throws Exception {
        HttpPost post = new HttpPost("https://api.weixin.qq.com/sns/jscode2session");
        List<NameValuePair> urlParameters = new ArrayList<>();
        urlParameters.add(new BasicNameValuePair("appid", appid));
        urlParameters.add(new BasicNameValuePair("secret", secret));
        urlParameters.add(new BasicNameValuePair("js_code", code));
        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        try (CloseableHttpClient httpClient = HttpClients.createDefault();
             CloseableHttpResponse response = httpClient.execute(post)) {
            return (JSONObject) JSONObject.parse(EntityUtils.toString(response.getEntity()));
        }
    }
}
