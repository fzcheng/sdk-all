using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Szx.Interface;//引用命名空间

namespace ConsoleApplication32
{
    class Program
    {
        static void Main(string[] args)
        {
            DES d = new DES();//声明实例
            string oText = @"10@111@111";//原文
            string key = @"wUNYaz47BLU=";//密钥

            string cText = d.Encrypt(oText, key);//DES.Encrypt()方法加密
            Console.WriteLine(cText);//打印

            string dText = d.Decrypt(cText, key);//DES.Decrypt()方法解密
            Console.WriteLine(dText);//打印
        }
    }
}
