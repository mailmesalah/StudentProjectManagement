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
        <title>Remove Student</title>
    </head>
    <body>
        <h1>Remove Student!</h1><hr>
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
                    int i = 0;
                    int j = 0;
                    ResultSet rs = stmt.executeQuery("Select SPMStudentMaster.UniqueID From SPMStudentMaster Where SPMStudentMaster.RegisterNo='" + studentCode + "';");
                    if (rs.next()) {
                        studentCode = rs.getString("UniqueID");

                        i = stmt.executeUpdate("Delete From SPMStudentMaster Where SPMStudentMaster.UniqueID=" + studentCode + ";");
                        j = stmt.executeUpdate("Delete From SPMAuthentication Where SPMAuthentication.Code=" + studentCode +  " and UserType='S';");
                    }
                    if (i > 0 && j > 0) {
                        session.setAttribute("Info", "Successfully Removed !");
                        session.setAttribute("Error", "");
                        response.sendRedirect("ShowStudentsOfDepartment.jsp?DepartmentCode="+session.getAttribute("DepartmentCode"));
                    } else {
                        session.setAttribute("Error", "Removal Unsuccessfull !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ShowStudentsOfDepartment.jsp?DepartmentCode="+session.getAttribute("DepartmentCode"));
                    }
                    stmt.close();

        %>
    </body>
</html>
