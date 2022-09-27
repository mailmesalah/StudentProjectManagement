<%-- 
    Document   : ValidateStudent
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
        <title>Validate Student</title>
    </head>
    <body>
        <h1>Validate Student!</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>

        <%
                    String studentCode = request.getParameter("studentCode");
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();
                    

                    int i = stmt.executeUpdate("Update SPMStudentMaster Set Status='V' Where SPMStudentMaster.RegisterNo='" + studentCode + "';");

                    if (i > 0) {
                        session.setAttribute("Info", "Successfully Validated !");
                        session.setAttribute("Error", "");
                        response.sendRedirect("ShowStudentsOfDepartment.jsp?DepartmentCode="+session.getAttribute("DepartmentCode"));
                    } else {
                        session.setAttribute("Error", "Validation Unsuccessfull !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ShowStudentsOfDepartment.jsp?DepartmentCode="+session.getAttribute("DepartmentCode"));
                    }
                    stmt.close();
        %>
    </body>
</html>
