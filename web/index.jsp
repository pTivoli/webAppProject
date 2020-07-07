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
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
  </head>
  <body>
    <div id="aboveTheFoldContent">
        <p>PharmaPoint</p>
        <div id="text">
            <p>WELCOME!</p>
            <p>1000+ pharmacies, 1 platform</p>
            <a href="#form">&#8623; LOGIN &#8623;</a>
        </div>
    </div>
    <div id="form">
        <p>LOGIN</p>
        <form action="login.do" method="POST">
            E-MAIL<br>
            <input type="email" name="email" placeholder="email@example.com" required><br>
            PASSWORD<br>
            <input type="password" name="password" placeholder="********" required><br>
            <input type="submit" value="SUBMIT"><br>
        </form>
    </div>

  </body>
</html>
