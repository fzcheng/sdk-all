<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page import="com.shenzhoufu.pay.payinterface.version3.utils.mer.MerchantSignVerify" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //String szfPublicPath = "C:\\WINDOWS\\ShenzhoufuApp\\version3\\Interface\\shenzhoufu\\szfPublic.cer";  //请到 http://www.shenzhoufu.com  网站进行下载
    String szfPublicPath = "C:\\WINDOWS\\ShenzhoufuApp\\version3\\Interface\\shenzhoufu\\ShenzhoufuPay.cer";  //请到 http://www.shenzhoufu.com  网站进行下载

    String version = request.getParameter("version");            //获取神州付支付接口的版本号
    String merId = request.getParameter("merId");        //获取商户ID
    String payMoney = request.getParameter("payMoney");    //获取支付金额
    String orderId = request.getParameter("orderId");        //获取商户订单号
    String payResult = request.getParameter("payResult");    //获取交易结果,1 成功 0 失败
    String privateField = request.getParameter("privateField");        //获取商户私有数据
    String payDetails = request.getParameter("payDetails"); //获取支付详情
    String returnMd5String = request.getParameter("md5String");        //获取MD5加密串
    String signString = request.getParameter("signString");            //神州付证书签名
    String privateKey = "123456";

    ///生成加密串,注意顺序
    String combineString = version + merId + payMoney + orderId + payResult + privateField + payDetails + privateKey;
    //out.println("神州付网关返回数据：combineString=" + combineString);
    String md5String =DigestUtils.md5Hex(combineString);
    //（1）进行 MD5 校验
    if (md5String.equals(returnMd5String)) {
        //out.print("MD5验证成功！");
        //（2）进行 证书验签
        Boolean verifyResult = MerchantSignVerify.verify(szfPublicPath, md5String, signString);
        if (Boolean.TRUE.equals(verifyResult)) {
            //out.print("证书验签成功！");

            //用于服务器地址返回时,回复神州付支付平台:
            out.print(orderId);
            if ("1".equals(payResult)) {
                //支付成功
                //out.print("支付成功......");
                //todo 商户处理网站业务逻辑代码.
            } else {
                //支付失败
                //out.print("支付失败.....");
                //todo 商户处理网站业务逻辑代码.
            }
        } else {
            out.print("证书验签失败！");
        }
    } else {
        out.print("MD5验证失败！");
    }
%>