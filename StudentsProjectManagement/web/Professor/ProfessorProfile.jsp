<%-- 
    Document   : ProfessorProfile
    Created on : Apr 4, 2011, 3:22:53 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Professor Profile</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Professor Profile!</h1><hr>
        <a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br><br>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <!out.println(session.getAttribute("ProfessorCode"));>
        <a href="SelectDepartmentForStudents.jsp">Student Verification</a><br>
        <a href="SelectDepartmentForBatches.jsp">Manage Batches</a><br>
        <a href="SelectDepartmentForExams.jsp">Manage Exams</a><br>
        </center>
    </body>
</html>
