<%-- 
    Document   : ProfessorLogin
    Created on : May 20, 2011, 11:26:14 AM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Professor Login</title>
    </head>
    <body bgcolor="#F0F0F0"><center>        
        <h1>Professor Login for Online Test!</h1><hr>
        <a href="/StudentsProjectManagement/Login.jsp">Home</a><br>
        <%
            String sError = (String) session.getAttribute("Error");
            if (sError != null) {
                out.println(sError + "<br>");
                session.setAttribute("Error", "");
            }
        %>
        <table border="1" >
            <form name="ProfessorLogin" method="post" action="CheckIfProfessor.jsp">
                <tr><td>Username</td><td>:</td><td><input type="text" name="username" value="" size="30"></td></tr>
                <tr><td>Password</td><td>:</td><td><input type="password" name="password" value="" size="30"></td></tr>
                <tr><td></td><td></td><td><input type="submit" name="submit" value="Next"></td></tr>
            </form>
        </table>
    </center>
</body>
</html>
