<%@ Page Language="C#" AutoEventWireup="true" CodeFile="receive.aspx.cs" Inherits="recieve" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
    <title>神州付支付接口v3.0 DEMO</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            接收到的数据如下：<br/>
            <ul>
                <li>
                version = <asp:Label ID="lbVersion" runat="server"></asp:Label>
                </li>
                <li>
                merId = <asp:Label ID="lbMerId" runat="server"></asp:Label>
                </li>
                <li>
                payMoney = <asp:Label ID="lbPayMoney" runat="server"></asp:Label>
                </li>
                <li>
                orderId = <asp:Label ID="lbOrderId" runat="server"></asp:Label>
                </li>
                <li>
                payResult = <asp:Label ID="lbPayResult" runat="server"></asp:Label>
                </li>
                <li>
                privateField = <asp:Label ID="lbPrivateField" runat="server"></asp:Label>
                </li>
                <li>
                payDetails = <asp:Label ID="lbPayDetails" runat="server"></asp:Label>
                </li>
                <li>
                md5String = <asp:Label ID="lbMd5String" runat="server"></asp:Label>
                </li>
                <li>
                signString = <asp:Label ID="lbSignString" runat="server"></asp:Label>
                </li>
            </ul>
            <p>
                <asp:Label ID = "md5CheckedResult" runat="server"></asp:Label><br />
                <asp:Label ID="checkedPayResult" runat="server"></asp:Label>
            </p>
        </div>
    </form>
</body>
</html>
