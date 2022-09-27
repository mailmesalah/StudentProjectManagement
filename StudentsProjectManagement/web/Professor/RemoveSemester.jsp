<%-- 
    Document   : RemoveSemester
    Created on : Apr 28, 2011, 12:04:52 AM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove Semester</title>
    </head>
    <body>
        <h1>Remove Semester!</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
                    String semesterName = request.getParameter("semestername");
                    String semesterDate = request.getParameter("semesterdate");
                    String registerNo = request.getParameter("studentcode");
                    String subjectCode = request.getParameter("subjectcode");
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();

                    int i = stmt.executeUpdate("Delete From SPMSemesterRegister Where (RegisterNo='" + registerNo + "' And SemesterName='" + semesterName + "' And SemesterExamDate=to_date('" + semesterDate + "','yyyy/mm/dd') And SubjectCode=" + subjectCode + ");");
                    if (i > 0) {
                        session.setAttribute("Info", "Successfully Removed !");
                        session.setAttribute("Error", "");
                        response.sendRedirect("ShowSemesterOfStudent.jsp?studentcode=" + registerNo + "&semestername=" + semesterName + "&semesterdate=" + semesterDate);
                    } else {
                        session.setAttribute("Error", "Deletion Unsuccessfull !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ShowSemesterOfStudent.jsp?studentcode=" + registerNo + "&semestername=" + semesterName + "&semesterdate=" + semesterDate);
                    }
                    stmt.close();
        %>
    </body>
</html>
