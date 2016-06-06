<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
     String version = "3";        //神州付支付接口版本号 *
    String merId = request.getParameter("merId") == null ? "151525" : request.getParameter("merId");        //商户ID *
    String payMoney = "5000";        //订单金额 (单位：分) *
    String orderId = request.getParameter("orderId") == null ? "20000201-151525-888888888810" : request.getParameter("orderId");//商户订单号 （必须按照文档里面的订单规范组织订单） *
//    String pageReturnUrl = "http://" + request.getHeader("Host") + "/demo/version3/common/receive.jsp";        //页面返回地址
//    String serverReturnUrl = "http://" + request.getHeader("Host") + "/demo/version3/common/serverReceive.jsp";        //服务器返回地址
    String pageReturnUrl = "http://pay3.shenzhoufu.com/demo/version3/common/receive.jsp";        //页面返回地址
    String serverReturnUrl = "http://pay3.shenzhoufu.com/demo/version3/common/serverReceive.jsp";        //服务器返回地址
    String merUserName = "merUserName";        //商户的用户姓名
    String merUserMail = "";        //商户的用户Email
    String itemName = "";        //商品名称
    String itemDesc = "";        //商品描述
    String bankId = "";         //平台银行ID
    String privateField = "";        //商户的私有数据
    String privateKey = "123456";    //商户在神州付支付平台里设置的密钥值
    String gatewayId = request.getParameter("gatewayId") == null ? "0" : request.getParameter("gatewayId");//支付方式ID （默认 神州行支付）
    // VERSION 3 BEGIN
    String verifyType = ""; //数据校验方式 （默认 MD5）
    String returnType = ""; //返回结果方式(默认:页面和服务器返回)
    String isDebug = request.getParameter("isDebug") == null ? "0" : request.getParameter("isDebug"); //是否调试(默认:非调试)
    String cardTypeCombine = "0"; //移动充值卡（神州行卡）支付
    // VERSION 3 END

    ///组织 MD5 加密串,注意顺序

    String combineString = version+"|" + merId+"|" + payMoney+"|" + orderId+"|" + pageReturnUrl+"|" + serverReturnUrl+"|" + privateField+"|" + privateKey+"|" + verifyType+"|" + returnType+"|" + isDebug;
    //生成 MD5校验串
    String md5String = DigestUtils.md5Hex(combineString);
    //todo...如果 verifyType=2时， 生成 证书签名
    String signString = "";
%>
<html>
<head><title>DEMO</title></head>
<body>
<div>
    您提交的测试数据如下：<br/>
    <li><%="version=" + version%>
    </li>
    <li><%="merId =" + merId %>
    </li>
    <li><%="payMoney =" + payMoney %>
    </li>
    <li><%="orderId =" + orderId %>
    </li>
    <li><%="pageReturnUrl =" + pageReturnUrl %>
    </li>
    <li><%="serverReturnUrl =" + serverReturnUrl %>
    </li>
    <li><%="merUserName =" + merUserName %>
    </li>
    <li><%="merUserMail =" + merUserMail %>
    </li>
    <li><%="itemDesc =" + itemDesc %>
    </li>
    <li><%="itemName =" + itemName %>
    </li>
    <li><%="bankId =" + bankId %>
    </li>
    <li><%="privateField =" + privateField %>
    </li>
    <li><%="gatewayId =" + gatewayId%>
    </li>
    <li><%="verifyType =" + verifyType%>
    </li>
    <li><%="returnType =" + returnType%>
    </li>
    <li><%="isDebug =" + isDebug%>
    </li>
    <li><%="combineString =" + combineString%>
    </li>
    <li><%="md5String =" + md5String%>
    </li>
    <li><%="signString =" + signString%>
    </li>
</div>

<p>&nbsp;</p>

<form method="post" action="http://pay3.shenzhoufu.com/interface/version3/entry.aspx">

    <input name="version" type="hidden" value="<%=version%>">
    <input name="merId" type="hidden" value="<%=merId%>">
    <input name="payMoney" type="hidden" value="<%=payMoney%>">
    <input name="orderId" type="hidden" value="<%=orderId%>">
    <input name="pageReturnUrl" type="hidden" value="<%=pageReturnUrl%>">
    <input name="serverReturnUrl" type="hidden" value="<%=serverReturnUrl%>">
    <input name="merUserName" type="hidden" value="<%=merUserName%>">
    <input name="merUserMail" type="hidden" value="<%=merUserMail%>">
    <input name="itemName" type="hidden" value="<%=itemName%>">
    <input name="itemDesc" type="hidden" value="<%=itemDesc%>">
    <input name="bankId" type="hidden" value="<%=bankId%>">
    <input name="privateField" type="hidden" value="<%=privateField%>">
    <input name="gatewayId" type="hidden" value="<%=gatewayId%>">
    <input name="verifyType" type="hidden" value="<%=verifyType%>">
    <input name="returnType" type="hidden" value="<%=returnType%>">
    <input name="isDebug" type="hidden" value="<%=isDebug%>">
    <input name="md5String" type="hidden" value="<%=md5String%>">
    <input name="signString" type="hidden" value="<%=signString%>">

    <input type="submit" name="pay" value="神州付支付">
</form>
</body>
</html>