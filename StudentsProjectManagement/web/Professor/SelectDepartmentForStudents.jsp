<%-- 
    Document   : SelectDepartmentForStudents
    Created on : Apr 27, 2011, 3:18:32 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Select Department For Students</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Select Department For Students!</h1><hr>
        <a href="ProfessorProfile.jsp">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br><br>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();
                    String professorCode = (String)session.getAttribute("ProfessorCode");

                    ResultSet rs = stmt.executeQuery("Select SPMDepartments.DeptCode,SPMDepartments.DeptName From SPMDepartments Where (SPMDepartments.DeptCode In(Select SPMDeptOfProfessors.DeptCode From SPMDeptOfProfessors Where SPMDeptOfProfessors.ProfessorCode="+professorCode+"));");
                    while(rs.next()) {
                %>
                <a href="ShowStudentsOfDepartment.jsp?DepartmentCode=<%=rs.getInt("DeptCode")%>"><%=rs.getString("DeptName")%></a><br>
        <%
                    } 
                    rs.close();
                    stmt.close();
        %>
        </center>
    </body>
</html>
