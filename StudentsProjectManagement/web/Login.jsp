<%-- 
    Document   : Login
    Created on : Apr 3, 2011, 2:01:44 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Project Management And Online Exam</title>
    </head>
    <%
    application.setInitParameter("CurrentProjectAbstract", "E:\\wORksHoP\\StudentProjectManagement\\StudentsProjectManagement\\CurrentProject\\Abstract");
    application.setInitParameter("CompletedProjectAbstract", "E:\\wORksHoP\\StudentProjectManagement\\StudentsProjectManagement\\CompletedProjects\\Abstract");
    application.setInitParameter("CurrentProjectReport", "E:\\wORksHoP\\StudentProjectManagement\\StudentsProjectManagement\\CurrentProject\\Report");
    application.setInitParameter("CompletedProjectReport", "E:\\wORksHoP\\StudentProjectManagement\\StudentsProjectManagement\\CompletedProjects\\Report");
    %>
    <body bgcolor="#F0F0F0"><center>
        <h1>Student Project Management And Online Exam</h1>
        <hr>
        Login <br>
        <a href="/StudentsProjectManagement/Admin/AdminLogin.jsp">Login as Administrator</a><br>
        <a href="/StudentsProjectManagement/Professor/ProfessorLogin.jsp">Login as Professor</a><br>
        <a href="/StudentsProjectManagement/Student/StudentLogin.jsp">Login as Student</a><br>
        <hr>
        Register <br>
        <a href="Professor/ProfessorRegister.jsp">Register for Professor</a><br>
        <a href="Student/StudentRegister.jsp">Register for Student</a>
        <br><br>
        <a href="OnlineTest/ProfessorLogin.jsp">Online Test</a><br>          
        </center>
    </body>
</html>
