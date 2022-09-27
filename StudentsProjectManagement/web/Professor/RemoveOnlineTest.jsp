<%-- 
    Document   : RemoveOnlineTest
    Created on : May 21, 2011, 3:16:36 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove Online Test</title>
    </head>
    <body>
        <h1>Remove Online Test !</h1><br>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            String registerNo = request.getParameter("registerno");
            String examCode = request.getParameter("examcode");
            String studentID=(String)session.getAttribute("studentCode");
            try{
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();
                
                int records = stmt.executeUpdate("Delete From SPMOnlineTestResults Where (StudentCode="+studentID+" And OnlineTestCode="+examCode+");");
                if(records>0){
                    session.setAttribute("Info", "Successfully Removed The Test !");
                    response.sendRedirect("StudentDetails.jsp?studentCode="+registerNo);
                }else{
                    session.setAttribute("Error", "Deletion Failed !");
                    response.sendRedirect("StudentDetails.jsp?studentCode="+registerNo);
                }
                stmt.close();
            }catch(Exception e){System.out.println(e.toString());}
        %>
    </body>
</html>
