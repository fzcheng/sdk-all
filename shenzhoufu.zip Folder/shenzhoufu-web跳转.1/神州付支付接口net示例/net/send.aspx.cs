using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography.X509Certificates;
using System.Security.Cryptography;
using System.Text; 

public partial class send : System.Web.UI.Page
{
    String privateKey = "123456";

    protected void Page_Load(object sender, EventArgs e)
    {
        //组织支付请求数据
        version.Value = "3";//版本号 *
        merId.Value = "151525";//商户ID *
        payMoney.Value = "1";//支付金额(单位：分) *
        orderId.Value = "20081404-151525-001";//订单号（格式：yyyyMMdd-merId-SN） * 
        pageReturnUrl.Value = "";//页面返回地址
        serverReturnUrl.Value = "";//服务器返回地址
        merUserName.Value = "你好";//商户的用户姓名
        merUserMail.Value = "";//商户的用户Email
        itemName.Value = "";//产品名称
        itemDesc.Value = "";//产品描述
        bankId.Value = "";//平台银行ID
        privateField.Value = "";//商户私有数据
        gatewayId.Value = "0";//支付方式id
		cardTypeCombine.Value ="0"; //移动充值卡（神州行卡）支付
        verifyType.Value = "1";//数据校验方式
        returnType.Value = "3";//返回结果方式
        isDebug.Value = "0";//是否调试



        //进行MD5加密
        /*
       md5String=md5(version+"|"+merId+"|"+payMoney+"|"+orderId+"|"+pageReturnUrl+"|"+serverReturnUrl+"|"+privateField+"|"+privateKey+"|"+verifyType+"|"+returnType+"|"+isDebug)
        */
        String combineString = version.Value+"|" + merId.Value+"|" + payMoney.Value+"|" + orderId.Value+"|" + pageReturnUrl.Value+"|" + serverReturnUrl.Value+"|" + privateField.Value+"|" + privateKey+"|" + verifyType.Value+"|" + returnType.Value+"|" + isDebug.Value;
        Console.WriteLine("combineString=" + combineString);
        md5String.Value = FormsAuthentication.HashPasswordForStoringInConfigFile(combineString, "MD5").ToLower();


    }
}

