<!--#include file="MD5.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ݸ�֧���ӿ�v3.0 DEMO</title>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
</head>
<%
	'szfGatewayUrl = "http://pay3.shenzhoufu.com/interface/version3/entry.aspx" '//���ݸ�֧�����ص�ַ
	szfGatewayUrl = "http://pay3.shenzhoufu.com/interface/version3/entry.aspx?charset=gb2312" '���ݸ�֧�����ص�ַ ���ݸ����ر���Ϊutf-8����ʾ���������Ϊgb2312

	privateKey = "123456" '��Կ

	'��֧֯����������
	version = "3" '�汾�� *
	merId = "151525" '�̻�ID *
	payMoney = "1" '֧�����(��λ����) *
	orderId = "20081404-151525-001" '�����ţ���ʽ��yyyyMMdd-merId-SN�� * 
	pageReturnUrl = "" 'ҳ�淵�ص�ַ
	serverReturnUrl = "" '���������ص�ַ
	merUserName = "����" '�̻����û�����
	merUserMail = "" '�̻����û�Email
	itemName = "" '��Ʒ����
	itemDesc = "" '��Ʒ����
	bankId = "" 'ƽ̨����ID
	privateField = "" '�̻�˽������
	gatewayId = "0" '֧����ʽid
	cardTypeCombine = "0"; '�ƶ���ֵ���������п���֧��
	verifyType = "1" '����У�鷽ʽ
	returnType = "3" '���ؽ����ʽ
	isDebug = "0" '�Ƿ����
	'����MD5����
	'md5String=md5(version+"|"+merId+"|"+payMoney+"|"+orderId+"|"+pageReturnUrl+"|"+serverReturnUrl+"|"+privateField+"|"+privateKey+"|"+verifyType+"|"+returnType+"|"+isDebug)
	combineString=version&"|"&merId&"|"&payMoney&"|"&orderId&"|"&pageReturnUrl&"|"&serverReturnUrl&"|"&privateField&"|"&privateKey&"|"&verifyType&"|"&returnType&"|"&isDebug
	md5String=MD5(combineString)
%> 
<body>
	<form method="post" name="form1" action="<%=szfGatewayUrl%>">
		<input type="hidden" name="version" value="<%=version%>">
		<input type="hidden" name="merId" value="<%=merId%>">
		<input type="hidden" name="payMoney" value="<%=payMoney%>">
		<input type="hidden" name="orderId" value="<%=orderId%>">
		<input type="hidden" name="pageReturnUrl" value="<%=pageReturnUrl%>">
		<input type="hidden" name="serverReturnUrl" value="<%=serverReturnUrl%>">
		<input type="hidden" name="merUserName" value="<%=merUserName%>">
		<input type="hidden" name="merUserMail" value="<%=merUserMail%>">
		<input type="hidden" name="itemName" value="<%=itemName%>">
		<input type="hidden" name="itemDesc" value="<%=itemDesc%>">
		<input type="hidden" name="bankId" value="<%=bankId%>">
		<input type="hidden" name="privateField" value="<%=privateField%>">
		<input type="hidden" name="gatewayId" value="<%=gatewayId%>">
		<input type="hidden" name="cardTypeCombine" value="<%=cardTypeCombine%>">
		<input type="hidden" name="verifyType" value="<%=verifyType%>">
		<input type="hidden" name="returnType" value="<%=returnType%>">
		<input type="hidden" name="isDebug" value="<%=isDebug%>">
		<input type="hidden" name="md5String" value="<%=md5String%>">

		<input type="submit" value="���ݸ�֧��">
	</form>
</body>
