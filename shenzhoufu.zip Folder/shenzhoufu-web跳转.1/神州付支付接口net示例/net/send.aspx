<%@ Page Language="C#" AutoEventWireup="true" CodeFile="send.aspx.cs" Inherits="send"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>神州付支付接口v3.0 DEMO</title>
</head>
<body>


    <div style="text-align:left">
    发送的数据如下：<br/>
    <ul style="">
        <li>
        version = <%=version.Value%>
        </li>        
        <li>
        mverId = <%=merId.Value%>
        </li>
        <li>
        payMoney = <%=payMoney.Value %>
        </li>
        <li>
        orderId = <%=orderId.Value %>
        </li>
        <li>
        pageReturnUrl = <%=pageReturnUrl.Value %>
        </li>
        <li>
        serverReturnUrl = <%=serverReturnUrl.Value %>
        </li>
        <li>
        merUserName = <%=merUserName.Value %>
        </li>
        <li>
        merUserMail = <%=merUserMail.Value %>
        </li>
        <li>
        itemName = <%=itemName.Value %>
        </li>
        <li>
        itemDesc = <%=itemDesc.Value %>
        </li>
        <li>
        bankId = <%=bankId.Value %>
        </li>
        <li>
        privateField = <%=privateField.Value %>
        </li>
        <li>
        md5String = <%=md5String.Value %>
        </li>
        <li>
        gatewayId = <%=gatewayId.Value %>
        </li>
		<li>
        cardTypeCombine = <%=cardTypeCombine.Value %>
        </li>
        <li>
        verifyType = <%=verifyType.Value %>
        </li>
        <li>
        return Type = <%=returnType.Value %>
        </li>
        <li>
        isDebug = <%=isDebug.Value %>
        </li>
        <li>
        signString = <%=signString.Value %>
        </li>
    </ul>
</div>
<p></p>
<form id="fm" runat="server" method="post" >

    <asp:HiddenField ID="version" runat="server"></asp:HiddenField>             
    <asp:HiddenField ID="merId" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="payMoney" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="orderId" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="pageReturnUrl" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="serverReturnUrl" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="merUserName" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="merUserMail" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="itemName" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="itemDesc" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="bankId" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="privateField" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="md5String" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="gatewayId" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="cardTypeCombine" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="verifyType" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="returnType" runat="server"></asp:HiddenField>        
    <asp:HiddenField ID="isDebug" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="signString" runat="server"></asp:HiddenField>
    <asp:Button ID="submitBt" runat="server"  Text="神州行支付" PostBackUrl="http://pay3.shenzhoufu.com/interface/version3/entry.aspx"/>

</form>

</body>
