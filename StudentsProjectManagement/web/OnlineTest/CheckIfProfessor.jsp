<%-- 
    Document   : CheckIfProfessor
    Created on : Apr 3, 2011, 8:42:06 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checks if Valid Professor</title>
    </head>
    <body>
        <h4>Please wait while your username and password verifying</h4>
        <%
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");

                    ResultSet rs = stmt.executeQuery("Select * From SPMAuthentication Where UserType='P' And Username='" + username.trim() + "' And Password='" + password.trim() + "';");
                    if (!rs.next()) {
                        session.setAttribute("Error", "Username or Password Incorrect!");
                        session.setAttribute("ProfessorCode","");
                        response.sendRedirect("ProfessorLogin.jsp");
                    } else {
                        session.setAttribute("Error", "");
                        session.setAttribute("UniqueID", rs.getInt("UniqueID")+"");
                        session.setAttribute("UserType", "P");
                        session.setAttribute("ProfessorCode", rs.getInt("Code")+"");
                        response.sendRedirect("SelectDepartmentForExams.jsp");
                    }
                    rs.close();
                    stmt.close();
        %>
    </body>
</html>
