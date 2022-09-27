<%-- 
    Document   : RemoveProject
    Created on : May 21, 2011, 12:39:15 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove Project</title>
    </head>
    <body>
        <h1>Remove Project !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("S")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            String studentCode = request.getParameter("studentcode");
            String groupCode = request.getParameter("groupcode");

            try {
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();
                
                int records = stmt.executeUpdate("Delete From SPMCurrentProject Where(GroupCode="+groupCode+");");
                if(records>0){
                    session.setAttribute("Info", "Successfully Removed The Project !");
                    response.sendRedirect("StudentProfile.jsp?studentCode="+studentCode);
                }else{
                    session.setAttribute("Error", "Deletion Failed !");
                    response.sendRedirect("StudentProfile.jsp?studentCode="+studentCode);
                }
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
    </body>
</html>
