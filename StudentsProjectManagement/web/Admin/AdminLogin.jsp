<%-- 
    Document   : AdminLogin
    Created on : Apr 3, 2011, 7:58:00 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Login</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Administrator Login!</h1>
        <hr>
        <%
            String sError=(String)session.getAttribute("Error");
            if(sError != null){
                out.println(sError+"<br>");
                session.setAttribute("Error", "");
            }
        %>
        <a href="/StudentsProjectManagement/Login.jsp">Home</a>
        <table border="0" >
        <form name="AdminLogin" method="post" action="CheckIfAdmin.jsp">
            <tr><td>Username</td><td>:</td><td><input type="text" name="username" value="" size="30"></td></tr>
            <tr><td>Password</td><td>:</td><td><input type="password" name="password" value="" size="30"></td></tr>
            <tr><td></td><td></td><td><input type="submit" name="submit" value="Submit"></td></tr>
        </form>
        </table>
        </center>
    </body>
</html>
