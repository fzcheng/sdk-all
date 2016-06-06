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
using System.Diagnostics;
using System.Security.Cryptography.X509Certificates;
using System.Security.Cryptography;
using System.Text;

public partial class recieve : System.Web.UI.Page
{
    String privateKey = "123456";

    protected void Page_Load(object sender, EventArgs e)
    {
        lbVersion.Text = Request.Params.Get("version"); //版本号
        lbMerId.Text = Request.Params.Get("merId"); //商户ID
        lbPayMoney.Text = Request.Params.Get("payMoney"); //支付金额
        lbOrderId.Text = Request.Params.Get("orderId"); //订单号
        lbPayResult.Text = Request.Params.Get("payResult"); //支付结果
        lbPrivateField.Text = Request.Params.Get("privateField"); 
        lbPayDetails.Text = Request.Params.Get("payDetails");
        lbMd5String.Text = Request.Params.Get("md5String"); //MD5校验串
        lbSignString.Text = Request.Params.Get("signString"); //神州付支付系统对md5加密后的32位字符串(md5String)进行签名。

        /*
         * MD5校验
         * md5String =md5(version+merId+payMoney+orderId+payResult+privateField+payDetails+privateKey)
         */
        String combineString = lbVersion.Text + lbMerId.Text + lbPayMoney.Text
            + lbOrderId.Text + lbPayResult.Text + lbPrivateField.Text + lbPayDetails.Text + privateKey;
        String md5 = FormsAuthentication.HashPasswordForStoringInConfigFile(combineString, "MD5").ToLower();

        if (md5.Equals(lbMd5String.Text))
        {
            md5CheckedResult.Text = "MD5验证成功";
            if (veriSig(md5, lbSignString.Text))
            {
                if ("1".Equals(lbPayResult.Text))
                {
                    //支付成功
                    checkedPayResult.Text = "";
                    //处理网站逻辑代码.......
                }
                else
                {
                    //支付失败
                    checkedPayResult.Text = "";
                    //处理网站逻辑代码.......
                }
            }
        }
        else 
        {
            md5CheckedResult.Text = "MD5验证失败";
        }
    }


    public bool veriSig(String data, String sign)
    {

        X509Store store = new X509Store(StoreName.Root);
        store.Open(OpenFlags.ReadWrite);
        try
        {
            //for .Net Framework2.0(VS .NET 2005)
            X509Certificate2 certificate = new X509Certificate2("c:\\shenzhoufuPay.cer");	
            /*
            //for .Net Framework2.0(VS .NET 2005)
            X509Certificate certificate = X509Certificate.CreateFromCertFile("c:\\shenzhoufuPay.cer");	
            */
            RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();

            rsa.FromXmlString(certificate.PublicKey.Key.ToXmlString(false));
            if (rsa.VerifyData(Encoding.UTF8.GetBytes(data), "MD5", Convert.FromBase64String(sign)))
            {
                Console.Write("签名认证通过！");
                return true;
            }
            else
            {
                Console.Write("签名认证失败！");
                return false;
            }
        }
        catch (Exception e)
        {
            Console.Write(e.Message);
            return false;
        }
    }

}
