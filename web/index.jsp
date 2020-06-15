<%--
  Created by IntelliJ IDEA.
  it.pointPharma.generalClasses.User: patrich
  Date: 08/06/20
  Time: 23.13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
      <title>PharmaPoint</title>
      <link rel="stylesheet" href="CSS/Stylesheet.css"/>
      <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap" rel="stylesheet">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
  </head>
  <body>
    <div id="aboveTheFoldContent">
        <div id="text">
            <p>WELCOME!</p>
            <p>1000+ pharmacies, 1 platform</p>
            <a href="#form"> Sezione login</a>
        </div>
    </div>
    <div id="form">
        <p>LOGIN</p>
        <form action="login.do" method="POST">
            E-MAIL<br>
            <input type="email" placeholder="example@contoso.com" required><br>
            PASSWORD<br>
            <input type="password" placeholder="********" required><br>
            <input type="submit" value="SUBMIT"><br>
        </form>
    </div>

  </body>
</html>
