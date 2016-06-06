<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String payMoney = "1";        //支付金额 (单位：分)
    String orderId = request.getParameter("orderId") == null ? "20000301-151525-888888888886" : request.getParameter("orderId");//商户订单号 （必须按照文档里面的订单规范组织订单）
%>
<html>
<head><title>DEMO</title>
    <script type="text/javascript">
        function onPaySubmit() {
            var cardMoney = "";
            var cardMoneys = document.getElementsByName("cardMoney");  //充值卡面额
            for (var i = 0; i < cardMoneys.length; i++) {
                if (cardMoneys[i].checked) {
                    cardMoney = cardMoneys[i].value;
                    break;
                }
            }
            if (cardMoney == "") {
                alert("请选择充值卡面额");
                return false;
            }
            var sn = document.getElementById("sn");//充值卡序列号
            if (sn.value == "") {
                alert("请输入充值卡序列号");
                return false;
            }
            var password = document.getElementById("password");//充值卡密码
            if (password.value == "") {
                alert("请输入充值卡密码");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<form id="serverconnszx" method="post" action="/server.jsp"
      onsubmit="return onPaySubmit();">
    <input name="payMoney" type="hidden" value="<%=payMoney%>">
    <input name="orderId" type="hidden" value="<%=orderId%>">

    <table border="0" align="center" cellpadding="0" cellspacing="0" class="szxPayTable">
        <tr>
            <td>订单号</td>
            <td width="400" align="left">
                <%=orderId%>
            </td>
        </tr>
        <tr>
            <td>支付金额</td>
            <td width="400" align="left">
                <%=payMoney%><strong>分</strong>
            </td>
        </tr>
        <tr>
            <td>充值卡面额</td>
            <td width="400" align="left">
                <input type="radio" name="cardMoney" value="50">50元
                <input type="radio" name="cardMoney" value="100">100元
                <input type="radio" name="cardMoney" value="300">300元
                <input type="radio" name="cardMoney" value="500">500元
                <span>请用户确认充值卡面值与产品面值相符，否则后果自负</span>
            </td>

        </tr>
        <tr>
            <td>充值卡序列号</td>
            <td width="400" align="left">
                <input id="sn" type="text" name="sn" style="letter-spacing:2px;width:300px;" maxlength="17"/>
            </td>
        </tr>
        <tr>
            <td>充值卡密码</td>
            <td width="400" align="left">
                <input id="password" type="text" name="password" style="letter-spacing:2px;width:300px;"
                       maxlength="19"/>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td width="400" align="left">
                <input type="submit" value="确认支付">
            </td>
        </tr>
    </table>
</form>
</body>
</html>