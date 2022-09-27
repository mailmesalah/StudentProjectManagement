<%-- 
    Document   : RejectProfessor
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
        <title>Reject Professor</title>
    </head>
    <body>
        <h1>Reject Professor!</h1><hr>
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

                    int i = stmt.executeUpdate("Update SPMProfessors Set Status='J' Where SPMProfessors.ProfessorCode=" + professorCode + ";");

                    if (i > 0) {
                        session.setAttribute("Info", "Successfully Rejected !");
                        session.setAttribute("Error", "");
                        response.sendRedirect("ManageProfessors.jsp");
                    } else {
                        session.setAttribute("Error", "Rejection Unsuccessfull !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageProfessors.jsp");
                    }
                    stmt.close();
        %>
    </body>
</html>
