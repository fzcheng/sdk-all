<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page import="com.shenzhoufu.pay.payinterface.version3.utils.mer.MerchantSignVerify" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //String szfPublicPath = "C:\\WINDOWS\\ShenzhoufuApp\\version3\\Interface\\shenzhoufu\\szfPublic.cer";  //请到 http://www.shenzhoufu.com  网站进行下载
    String szfPublicPath = "C:\\WINDOWS\\ShenzhoufuApp\\version3\\Interface\\shenzhoufu\\ShenzhoufuPay.cer";  //请到 http://www.shenzhoufu.com  网站进行下载

    String version = request.getParameter("version");            //获取神州付消费接口的版本号
    String merId = request.getParameter("merId");        //获取商户ID
    String payMoney = request.getParameter("payMoney");    //获取消费金额
    String orderId = request.getParameter("orderId");        //获取商户订单号
    String payResult = request.getParameter("payResult");    //获取交易结果,1 成功 0 失败
    String privateField = request.getParameter("privateField");        //获取商户私有数据
    String payDetails = request.getParameter("payDetails"); //获取消费详情
    String returnMd5String = request.getParameter("md5String");        //获取MD5加密串
    String signString = request.getParameter("signString");            //神州付证书签名
    String cardMoney = request.getParameter("cardMoney");            //神州付证书签名
    String privateKey = "123456";

    out.println("version=" + version + "<br/>");
    out.println("merId=" + merId + "<br/>");
    out.println("payMoney=" + payMoney + "<br/>");
    out.println("orderId=" + orderId + "<br/>");
    out.println("payResult=" + payResult + "<br/>");
    out.println("privateField=" + privateField + "<br/>");
    out.println("returnMd5String=" + returnMd5String + "<br/>");
    out.println("signString=" + signString + "<br/>");
    out.println("cardMoney=" + cardMoney + "<br/>");

    ///生成加密串,注意顺序  下面的if else判断如果采用返回模式1请用不加竖线的，如果是返回模式2请用加竖线的
    String combineString;
    if (cardMoney != null) {
        combineString = version + "|" + merId + "|" + payMoney + "|" + cardMoney + "|" + orderId + "|" + payResult + "|" + privateField + "|" + payDetails + "|" + privateKey;
    } else {
        combineString = version + merId + payMoney + orderId + payResult + privateField + payDetails + privateKey;
    }
    //out.println("神州付网关返回数据：combineString=" + combineString);
    String md5String = DigestUtils.md5Hex(combineString);
    //（1）进行 MD5 校验
    String result;
    if (md5String.equals(returnMd5String)) {
        //out.print("MD5验证成功！");
        //用于服务器地址返回时,回复神州付消费平台:
        //（2）进行 证书验签
        Boolean verifyResult = MerchantSignVerify.verify(szfPublicPath, md5String, signString);
        if (Boolean.TRUE.equals(verifyResult)) {
            //out.print("证书验签成功！");
            if ("1".equals(payResult)) {
                //消费成功
                result = "消费成功";
                out.print("消费成功......" + "<br/>");
                //todo 商户处理网站业务逻辑代码.
            } else {
                //消费失败
                result = "消费失败";
                out.print("消费失败....." + "<br/>");
                //todo 商户处理网站业务逻辑代码.
            }
        } else {
            result = "证书验签失败";
            out.print("证书验签失败！" + "<br/>");
        }
    } else {
        result = "MD5验证失败";
        out.print("MD5验证失败！" + "<br/>");
    }
    response.getWriter().write(result + ", orderId=" + orderId);
%>