<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.shenzhoufu.pay.payinterface.version3.utils.mer.ServerConnSzxUtils" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.net.URLEncoder" %>
<%
    String orderId = request.getParameter("orderId");
    String payMoney = request.getParameter("payMoney");
    String cardMoney = request.getParameter("cardMoney");
    String sn = request.getParameter("sn");
    String password = request.getParameter("password");

    String szfurl = "http://pay3.shenzhoufu.com/interface/version3/serverconnszx/entry-noxml.aspx";   //神州行充值卡服务器直连接口入口
    String returnUrl = "http://localhost/serverReceive.jsp"; //服务器返回地址

    String version = "3"; //接口版本号
    String merId = "151525"; //商户ID
    String merUserName = "";  //商户用户 名
    String merUserMail = "";  //商户用户 Email
    String privateField = ""; //商户私有数据
    String verifyType = "1";//MD5 校验
    String desKey = "fNCrhSynUm4=";
    String privateKey = "123456";
    String cardTypeCombine = "0"; //0：移动 1：联通 2：电信
    String cardInfo = ServerConnSzxUtils.getDesEncryptBase64String(cardMoney, sn, password, desKey);   //充值卡加密信息
    String combineString = version + merId + payMoney + orderId + returnUrl + cardInfo + privateField + verifyType + privateKey;
    String md5String = DigestUtils.md5Hex(combineString); //md5加密串
    System.out.println("md5加密前拼窜：" + combineString);
    //构造 url 请求数据
    String urlRequestData = szfurl + "?version=" + version
            + "&merId=" + merId
            + "&payMoney=" + payMoney
            + "&orderId=" + orderId
            + "&returnUrl=" + returnUrl
            + "&cardInfo=" + URLEncoder.encode(cardInfo, "utf-8")
            + "&merUserName=" + merUserName
            + "&merUserMail=" + merUserMail
            + "&privateField=" + privateField
            + "&verifyType=" + verifyType
            + "&cardTypeCombine=" + cardTypeCombine
            + "&md5String=" + md5String
            + "&signString=";
    System.out.println("构造 url 请求数据：" + urlRequestData);
    //服务器建立连接
    HttpURLConnection httpConnection;
    URL url;
    int code;
    int szfResponseCode;
    try {
        url = new URL(urlRequestData);
        httpConnection = (HttpURLConnection) url.openConnection();
        httpConnection.setRequestMethod("GET");
        httpConnection.setDoOutput(true);
        httpConnection.setDoInput(true);
        code = httpConnection.getResponseCode();
        System.out.println("连接神州付服务器：" + szfurl + "，HTTP响应代码：" + code);
        if (code == HttpURLConnection.HTTP_OK) {
            try {
                String strCurrentLine;
                BufferedReader reader;
                reader = new BufferedReader(new InputStreamReader(httpConnection.getInputStream(), "UTF-8"));
                //当正确响应时处理数据
                szfResponseCode = httpConnection.getHeaderFieldInt("szfResponseCode", 0);
                System.out.println("连接神州付服务器：" + szfurl + "，SZF响应代码：" + szfResponseCode);
                //数据通过校验
                if (szfResponseCode == 200) {
                    out.print("<html>\n" +
                            "<head><title></title>\n" +
                            "</head>\n" +
                            "<body>\n" +
                            "支付处理中,请稍候...\n" +
                            "</body>\n" +
                            "</html>");
                }
            } catch (IOException e) {
                System.out.println("连接神州付服务器：" + szfurl + "异常，e=" + e);
            }
        }
    } catch (Exception e) {
        System.out.println("连接神州付服务器：" + szfurl + "异常，e=" + e);
    }
%>