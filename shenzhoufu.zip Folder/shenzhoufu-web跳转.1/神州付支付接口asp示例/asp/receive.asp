<!--#include file="MD5.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>神州付支付接口v3.0 DEMO</title>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
</head>
<%	
	privateKey="123456" '密钥
	certFile = "c:\ShenzhoufuPay.cer" '神州付证书文件

	'获得服务器返回数据
	version = Request("version") '版本号
	merId = Request("merId") '商户ID
	payMoney = Request("payMoney") '支付金额
	orderId = Request("orderId") '订单号
	payResult = Request("payResult") '支付结果
	privateField = Request("privateField") '商户私有数据
	payDetails = Request("payDetails") '支付详情
	md5String = Request("md5String") 'MD5校验串
	signString = Request("signString") '证书签名

	'进行MD5校验
	'md5(version+merId+payMoney+orderId+payResult+privateField+payDetails+privateKey)
	myCombineString=version&merId&payMoney&orderId&payResult&privateField&payDetails&privateKey
	myMd5String=MD5(myCombineString)

	If md5String=myMd5String Then
		Set	sign32 = server.createobject("sign32.SignVerify")
		If(sign32.Verify(certFile,myMd5String,signString)) Then
			Response.write("MD5校验成功!</br>")
			Response.write("二级签名校验成功！")
			'todo..。商户业务逻辑
		Else
			Response.write("二级签名校验错误！")
		End If
	Else
		Response.write("MD5校验失败!")	
	End If
%>