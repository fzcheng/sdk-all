<!--#include file="MD5.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ݸ�֧���ӿ�v3.0 DEMO</title>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
</head>
<%	
	privateKey="123456" '��Կ
	certFile = "c:\ShenzhoufuPay.cer" '���ݸ�֤���ļ�

	'��÷�������������
	version = Request("version") '�汾��
	merId = Request("merId") '�̻�ID
	payMoney = Request("payMoney") '֧�����
	orderId = Request("orderId") '������
	payResult = Request("payResult") '֧�����
	privateField = Request("privateField") '�̻�˽������
	payDetails = Request("payDetails") '֧������
	md5String = Request("md5String") 'MD5У�鴮
	signString = Request("signString") '֤��ǩ��

	'����MD5У��
	'md5(version+merId+payMoney+orderId+payResult+privateField+payDetails+privateKey)
	myCombineString=version&merId&payMoney&orderId&payResult&privateField&payDetails&privateKey
	myMd5String=MD5(myCombineString)

	If md5String=myMd5String Then
		Set	sign32 = server.createobject("sign32.SignVerify")
		If(sign32.Verify(certFile,myMd5String,signString)) Then
			Response.write("MD5У��ɹ�!</br>")
			Response.write("����ǩ��У��ɹ���")
			'todo..���̻�ҵ���߼�
		Else
			Response.write("����ǩ��У�����")
		End If
	Else
		Response.write("MD5У��ʧ��!")	
	End If
%>