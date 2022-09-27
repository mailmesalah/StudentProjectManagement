<%-- 
    Document   : RemoveProfessor
    Created on : Apr 5, 2011, 7:56:05 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove Professor</title>
    </head>
    <body>
        <h1>Remove Professor!</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("A")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>

        <%
                    String professorCode = request.getParameter("professorCode");
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();                    

                    int i = stmt.executeUpdate("Delete From SPMProfessors Where SPMProfessors.ProfessorCode=" + professorCode + ";");
                    int j = stmt.executeUpdate("Delete From SPMAuthentication Where (SPMAuthentication.Code=" + professorCode + " And SPMAuthentication.UserType='P');");

                    if (i > 0 && j > 0) {
                        session.setAttribute("Info", "Successfully Removed !");
                        session.setAttribute("Error", "");
                        response.sendRedirect("ManageProfessors.jsp");
                    } else {
                        session.setAttribute("Error", "Removal Unsuccessfull !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageProfessors.jsp");
                    }
                    stmt.close();
        %>
    </body>
</html>
