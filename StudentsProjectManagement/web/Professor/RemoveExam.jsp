<%-- 
    Document   : RemoveExam
    Created on : May 11, 2011, 9:13:02 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove Exam</title>
    </head>
    <body>
        <h1>Remove Exam !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
                    String deptCode = request.getParameter("deptcode");
                    String examCode = request.getParameter("examcode");
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();
                    
                    int i = stmt.executeUpdate("Delete From SPMExamMaster Where (ExamCode="+examCode+" And DeptCode="+deptCode+");");
                    if(i>0){
                        session.setAttribute("Info", "Successfully Removed !");
                        session.setAttribute("Error", "");
                        response.sendRedirect("ManageExams.jsp?DepartmentCode=" + deptCode);
                    }else{
                        session.setAttribute("Error", "Deletion Unsuccessfull !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageExams.jsp?DepartmentCode=" + deptCode);
                    }
                    stmt.close();
        %>
    </body>
</html>
