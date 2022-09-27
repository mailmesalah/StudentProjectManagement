<%-- 
    Document   : AddDepartment
    Created on : Apr 4, 2011, 7:26:07 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Department</title>
    </head>
    <body>
        <h1>Adding Department!</h1><hr>
        <%
                    String deptCode = request.getParameter("DeptCode");
                    String deptName = request.getParameter("DeptName");
                    String description = request.getParameter("Description");
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();

                    ResultSet rs = stmt.executeQuery("Select * From SPMDepartments Where DeptCode=" + deptCode + ";");
                    if (rs.next()) {
                        session.setAttribute("Error", "Addition Unsuccessfull : Dept.Code already Exist !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageDepartments.jsp");
                        
                    } else {

                        int i = stmt.executeUpdate("Insert Into SPMDepartments (DeptCode,DeptName,Description) Values (" + deptCode + ",'" + deptName + "','" + description + "');");
                        if (i > 0) {
                            session.setAttribute("Info", "Successfully Added !");
                            session.setAttribute("Error", "");
                            response.sendRedirect("ManageDepartments.jsp");
                        } else {
                            session.setAttribute("Error", "Addition Unsuccessfull !");
                            session.setAttribute("Info", "");
                            response.sendRedirect("ManageDepartments.jsp");
                        }
                    }
                    stmt.close();
        %>
    </body>
</html>
