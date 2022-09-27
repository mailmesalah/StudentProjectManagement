<%-- 
    Document   : SignOut.jsp
    Created on : May 22, 2011, 2:49:11 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Out</title>
    </head>
    <body>
        <h1>Sign Out !</h1><hr>
        <%
            session.setAttribute("UniqueID", "");
            session.setAttribute("UserType", "");
            response.sendRedirect("Login.jsp");
        %>
    </body>
</html>
