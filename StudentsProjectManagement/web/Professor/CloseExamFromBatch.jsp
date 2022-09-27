<%-- 
    Document   : CloseExamFromBatch
    Created on : May 20, 2011, 10:16:05 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Close Exam From Batch</title>
    </head>
    <body>
        <h1>Close Exam From Batch !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            String batchCode = request.getParameter("batchcode");
            String batchName = request.getParameter("batchname");
            String deptCode = request.getParameter("deptcode");
            try{
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();
                
                int records = stmt.executeUpdate("Delete From SPMCurrentExam Where(BatchCode="+batchCode+");");
                if (records > 0) {
                    session.setAttribute("Info", "Successfully Closed The Exam !");
                    response.sendRedirect("OnlineTestNotification.jsp?deptcode=" + deptCode + "&batchcode=" + batchCode + "&batchname=" + batchName);
                } else {
                    session.setAttribute("Error", "Error Occured !");
                    response.sendRedirect("OnlineTestNotification.jsp?deptcode=" + deptCode + "&batchcode=" + batchCode + "&batchname=" + batchName);
                }
                stmt.close();

            }catch(Exception e){System.out.println(e.toString());}
        %>
    </body>
</html>
