<%-- 
    Document   : RemoveGroupFromBatch
    Created on : Apr 29, 2011, 4:15:28 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove Group From Batch</title>
    </head>
    <body>
        <h1>Remove Group From Batch !</h1>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
                    String groupCode = request.getParameter("groupcode");
                    String batchCode = request.getParameter("batchcode");
                    String deptCode = request.getParameter("deptcode");
                    String batchName = request.getParameter("batchname");

                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();

                    int i = stmt.executeUpdate("Delete From SPMGroupMaster Where (BatchCode="+batchCode+" And GroupCode="+groupCode+");");
                    if(i>0){
                        session.setAttribute("Info", "Successfully Removed !");
                        session.setAttribute("Error", "");
                        response.sendRedirect("ManageGroupsOfBatch.jsp?deptcode="+ deptCode+"&batchname="+batchName+"&batchcode="+batchCode);
                    }else{
                        session.setAttribute("Error", "Deletion Unsuccessfull !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageGroupsOfBatch.jsp?deptcode="+ deptCode+"&batchname="+batchName+"&batchcode="+batchCode);
                    }
                    stmt.close();
        %>
    </body>
</html>
