<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>神州付支付接口v3.0 DEMO</title>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
</head>
<?php
	$szfGatewayUrl = "http://pay3.shenzhoufu.com/interface/version3/entry.aspx";//神州付支付网关地址
    $privateKey = "123456";//密钥

	//组织支付请求数据
	$version = "3";//版本号 *
	$merId = "151525";//商户ID *
	$payMoney = "100";//支付金额(单位：分) *
	$orderId = "20081404-151525-001";//订单号（格式：yyyyMMdd-merId-SN） * 
	$pageReturnUrl = "";//页面返回地址
	$serverReturnUrl = "";//服务器返回地址
	$merUserName = "中文";//商户网站的用户的姓名
	$merUserMail = "";//商户网站的用户的Email
	$itemName = "";//产品名称
	$itemDesc = "";//产品描述
	$bankId = "";//平台银行ID
	$privateField = "";//商户私有数据
	$gatewayId = "0";//支付方式id
	$cardTypeCombine = "0"; //移动充值卡（神州行卡）支付
	$verifyType = "1";//数据校验方式
	$returnType = "3";//返回结果方式
	$isDebug = "0";//是否调试
	//进行MD5加密
	//md5String=md5( version+"|"  + merId+"|"  + payMoney+"|"  + orderId+"|"  + pageReturnUrl+"|"  + serverReturnUrl+"|"  + privateField+"|"  + privateKey+"|"  + verifyType+"|"  + returnType+"|"  + isDebug)
	$combineString=$version."|".$merId."|".$payMoney."|".$orderId."|".$pageReturnUrl."|".$serverReturnUrl."|".$privateField."|".$privateKey."|".$verifyType."|".$returnType."|".$isDebug;
	$md5String=md5($combineString);
?>
<body>
	<form method="post" name="form1" action="<?php echo $szfGatewayUrl;?>">
		<input type="hidden" name="version" value="<?php echo $version;?>">
		<input type="hidden" name="merId" value="<?php echo $merId;?>">
		<input type="hidden" name="payMoney" value="<?php echo $payMoney;?>">
		<input type="hidden" name="orderId" value="<?php echo $orderId;?>">
		<input type="hidden" name="pageReturnUrl" value="<?php echo $pageReturnUrl;?>">
		<input type="hidden" name="serverReturnUrl" value="<?php echo $serverReturnUrl;?>">
		<input type="hidden" name="merUserName" value="<?php echo $merUserName;?>">
		<input type="hidden" name="merUserMail" value="<?php echo $merUserMail;?>">
		<input type="hidden" name="itemName" value="<?php echo $itemName;?>">
		<input type="hidden" name="itemDesc" value="<?php echo $itemDesc;?>">
		<input type="hidden" name="bankId" value="<?php echo $bankId;?>">
		<input type="hidden" name="privateField" value="<?php echo $privateField;?>">
		<input type="hidden" name="gatewayId" value="<?php echo $gatewayId;?>">
		<input type="hidden" name="cardTypeCombine" value="<?php echo $cardTypeCombine;?>">
		<input type="hidden" name="verifyType" value="<?php echo $verifyType;?>">
		<input type="hidden" name="returnType" value="<?php echo $returnType;?>">
		<input type="hidden" name="isDebug" value="<?php echo $isDebug;?>">
		<input type="hidden" name="md5String" value="<?php echo $md5String;?>">

		<input type="submit" value="神州付支付">
	</form>
</body>