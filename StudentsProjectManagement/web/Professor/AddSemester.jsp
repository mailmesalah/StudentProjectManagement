<%-- 
    Document   : AddSemester
    Created on : Apr 28, 2011, 12:05:07 AM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Semester</title>
    </head>
    <body>
        <h1>Add Semester!</h1>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
                    try {
                        String semesterName = request.getParameter("semestername");
                        String semesterDate = request.getParameter("semesterdate");
                        String registerNo = request.getParameter("studentcode");
                        String subjectCode = request.getParameter("subjectcode");
                        String subjectName = request.getParameter("subjectname");
                        String externalMaxMark = request.getParameter("externalmaxmark");
                        String internalMaxMark = request.getParameter("internalmaxmark");
                        String externalMark = request.getParameter("externalmark");
                        String internalMark = request.getParameter("internalmark");
                        String examAttended = request.getParameter("examattended");
                        String status = request.getParameter("status");
                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                        Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                        Statement stmt = con.createStatement();
                        out.println("Date"+semesterDate);
                        ResultSet rs = stmt.executeQuery("Select * From SPMSemesterRegister Where (RegisterNo='" + registerNo + "' And SemesterName='" + semesterName + "' And SemesterExamDate=to_date('" + semesterDate + "','yyyy/mm/dd') And SubjectCode=" + subjectCode + ");");
                        
                        if (rs.next()) {
                            session.setAttribute("Error", "Addition Unsuccessfull : Subject Code already Exist !");
                            session.setAttribute("Info", "");
                            response.sendRedirect("ShowSemesterOfStudent.jsp?studentcode=" + registerNo + "&semestername=" + semesterName + "&semesterdate=" + semesterDate);
                        } else {
                            int yesNo=(examAttended.equals("Y") ? 1 : 0);
                            out.println("Date"+semesterDate);
                            int i = stmt.executeUpdate("Insert Into SPMSemesterRegister Values ('" + registerNo + "','" + semesterName + "',to_date('" + semesterDate + "','yyyy/mm/dd')," + subjectCode + ",'" + subjectName + "'," + externalMaxMark + "," + internalMaxMark + "," + externalMark + "," + internalMark + ",'" + status + "'," +yesNo+ ");");
                            if (i > 0) {
                                session.setAttribute("Info", "Successfully Added !");
                                session.setAttribute("Error", "");
                                response.sendRedirect("ShowSemesterOfStudent.jsp?studentcode=" + registerNo + "&semestername=" + semesterName + "&semesterdate=" + semesterDate);
                            } else {
                                session.setAttribute("Error", "Addition Unsuccessfull !");
                                session.setAttribute("Info", "");
                                response.sendRedirect("ShowSemesterOfStudent.jsp?studentcode=" + registerNo + "&semestername=" + semesterName + "&semesterdate=" + semesterDate);
                            }
                        }
                        stmt.close();
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }
        %>
    </body>
</html>
