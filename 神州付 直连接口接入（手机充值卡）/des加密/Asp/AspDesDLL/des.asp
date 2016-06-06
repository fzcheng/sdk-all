<%
SET des = Server.CreateObject("DesForAsp.Des")
desKey="aaaaaaaa"
explainText="abc"
encryptText=des.encode(explainText,desKey)
response.Write("<p>密钥："&desKey&"</p>")
response.Write("<p>明文："&explainText&"</p>")
response.Write("<p>密文："&encryptText&"</p>")
response.Write("<p>解密："&des.decode(encryptText,desKey)&"</p>")
%>