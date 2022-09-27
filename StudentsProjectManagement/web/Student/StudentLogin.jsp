<%-- 
    Document   : StudentLogin
    Created on : Apr 3, 2011, 7:59:04 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Login</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Student Login!</h1><hr>
        <a href="/StudentsProjectManagement/Login.jsp">Home</a>
        <%
            String sError=(String)session.getAttribute("Error");
            if(sError != null){
                out.println(sError+"<br>");
                session.setAttribute("Error", "");
            }
        %>
        <table border="1" >
        <form name="StudentLogin" method="post" action="CheckIfStudent.jsp">
            <tr><td>Username</td><td>:</td><td><input type="text" name="username" value="" size="30"></td></tr>
            <tr><td>Password</td><td>:</td><td><input type="password" name="password" value="" size="30"></td></tr>
            <tr><td></td><td></td><td><input type="submit" name="submit" value="Submit"></td></tr>
        </form>
        </table>
        </center>
    </body>
</html>
