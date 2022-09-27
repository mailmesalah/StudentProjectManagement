<%-- 
    Document   : CheckIfUsernameAvailable
    Created on : Apr 23, 2011, 3:46:24 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checks Professor Username if available for register</title>
    </head>
    <body>
        <h1>Checks Username!</h1><hr>        
        <%

                    String username = request.getParameter("username");

                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();
                    if (!username.equals("")) {                        
                        ResultSet rs = stmt.executeQuery("Select * From SPMAuthentication Where SPMAuthentication.Username = '" + username + "';");
                        out.println(rs.next() ? username+" is Not Avaialable" : username+" is  Available");
                        rs.close();
                    } else {
                        out.println(username+" is Not Avaialable");
                    }
                    stmt.close();
        %>
        <table border="1">
            <form  name="form" method="post" action="CheckIfUsernameAvailable.jsp">
                <tr><td>Username</td><td>:</td><td><input id="Username" type="text" name="username" value="" size="30"></td><td><input type="button" name="check" value="Check for Availability"></td></tr>
            </form>
        </table>
    </body>
</html>
