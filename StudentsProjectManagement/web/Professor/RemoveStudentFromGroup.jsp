<%-- 
    Document   : RemoveStudentFromGroup
    Created on : Apr 29, 2011, 6:10:10 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove Student From Group</title>
    </head>
    <body>
        <h1>Remove Student From Group !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
                    String registerNo = request.getParameter("registerno");
                    String batchCode = request.getParameter("batchcode");
                    String batchName = request.getParameter("batchname");
                    String groupCode = request.getParameter("groupcode");
                    String groupName = request.getParameter("groupname");
                    String deptCode = request.getParameter("deptcode");

                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();

                    int i = stmt.executeUpdate("Delete From SPMGroupRegister Where (GroupCode="+groupCode+" And RegisterNo='"+registerNo+"');");
                    if(i>0){
                        session.setAttribute("Info", "Successfully Removed !");
                        session.setAttribute("Error", "");
                        response.sendRedirect("ManageStudentsInGroup.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                    }else{
                        session.setAttribute("Error", "Deletion Unsuccessfull !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageStudentsInGroup.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                    }
                    stmt.close();
        %>
    </body>
</html>
