<%
SET des = Server.CreateObject("DesForAsp.Des")
desKey="aaaaaaaa"
explainText="abc"
encryptText=des.encode(explainText,desKey)
response.Write("<p>��Կ��"&desKey&"</p>")
response.Write("<p>���ģ�"&explainText&"</p>")
response.Write("<p>���ģ�"&encryptText&"</p>")
response.Write("<p>���ܣ�"&des.decode(encryptText,desKey)&"</p>")
%>