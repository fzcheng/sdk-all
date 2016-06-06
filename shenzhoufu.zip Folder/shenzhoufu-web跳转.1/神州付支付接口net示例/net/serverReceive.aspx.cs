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

public partial class serverReceive : System.Web.UI.Page
{
    String privateKey = "123456";

    protected void Page_Load(object sender, EventArgs e)
    {
        String version = Request.Params.Get("version"); //版本号
        String merId = Request.Params.Get("merId"); //商户ID
        String payMoney = Request.Params.Get("payMoney"); //支付金额
        String orderId = Request.Params.Get("orderId"); //订单号
        String payResult = Request.Params.Get("payResult"); //支付结果
        String privateField = Request.Params.Get("privateField");
        String payDetails = Request.Params.Get("payDetails");
        String md5String = Request.Params.Get("md5String"); //MD5校验串
        String signString = Request.Params.Get("signString"); //神州付支付系统对md5加密后的32位字符串(md5String)进行签名。

        /*
         * MD5校验
         * md5String =md5(version+merId+payMoney+orderId+payResult+privateField+payDetails+privateKey)
         */
        String combineString = version + merId + payMoney
            + orderId + payResult + privateField + payDetails + privateKey;
        String md5 = FormsAuthentication.HashPasswordForStoringInConfigFile(combineString, "MD5").ToLower();

        if (md5.Equals(md5String))
        {
            //Response.WriteLine("MD5验证成功");

            if (veriSig(md5, signString))
            {
                //Response.WriteLine("签名认证成功");
                Response.Write(orderId);
                //todo 处理商户自己的业务逻辑
            }
            else
            {
                Response.Write("验证失败");
            }
        }
        else
        {
            Response.Write("验证失败");
            return;
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
