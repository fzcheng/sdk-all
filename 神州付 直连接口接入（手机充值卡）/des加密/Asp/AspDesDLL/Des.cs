using System;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.IO;
using System.Runtime.InteropServices;

namespace DesForAsp
{
    [ComVisible(true)]
    public interface iDes
    {

        string encode(string explainText, string desKey);
        string decode(string encryptText, string desKey);

    }


    [ComVisible(true)]
    [ClassInterface(ClassInterfaceType.AutoDual)]   
    public class Des:iDes
    {
        public Des(){

        }

        public string encode(string explainText, string desKey)
        {
            try
            {
                DESCryptoServiceProvider des = new DESCryptoServiceProvider();
                des.Mode = CipherMode.ECB;
                des.Key = System.Text.Encoding.UTF8.GetBytes(desKey);
                des.IV = des.Key;
                byte[] inputByteArray = System.Text.Encoding.UTF8.GetBytes(explainText);
                MemoryStream ms = new MemoryStream();
                CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);
                cs.Write(inputByteArray, 0, inputByteArray.Length);
                cs.FlushFinalBlock();
                return Convert.ToBase64String(ms.ToArray());
            }
            catch (System.Exception e)
            {
                return e.ToString();
            }
        }

        public string decode(string encryptText, string desKey)
        {
            try
            {
                DESCryptoServiceProvider des = new DESCryptoServiceProvider();
                des.Mode = CipherMode.ECB;
                des.Key = System.Text.Encoding.UTF8.GetBytes(desKey);
                des.IV = des.Key;
                byte[] inputByteArray = Convert.FromBase64String(encryptText);
                MemoryStream ms = new MemoryStream();
                CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
                cs.Write(inputByteArray, 0, inputByteArray.Length);
                cs.FlushFinalBlock();
                System.Text.Encoding encoding = new System.Text.UTF8Encoding();
                return encoding.GetString(ms.ToArray());
            }
            catch (System.Exception e)
            {
                return e.ToString();
            }
        }
    }
}
