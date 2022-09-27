<%-- 
    Document   : AddStudentToBatch
    Created on : Apr 29, 2011, 1:58:11 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Student To Batch</title>
    </head>
    <body>
        <h1>Add Student To Batch !</h1><hr>
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
                    String deptCode = request.getParameter("deptcode");

                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();

                    ResultSet rs = stmt.executeQuery("Select * From SPMBatchRegister Where (SPMBatchRegister.BatchCode=" + batchCode + " And SPMBatchRegister.RegisterNo='"+registerNo+"');");
                    if (rs.next()) {
                        session.setAttribute("Error", "Addition Unsuccessfull : Student already Added !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageStudentsInBatch.jsp?batchname="+batchName+"&batchcode="+batchCode+"&deptcode="+deptCode);

                    } else {

                        int i = stmt.executeUpdate("Insert Into SPMBatchRegister Values ('" + registerNo + "'," + batchCode + ");");
                        if (i > 0) {
                            session.setAttribute("Info", "Successfully Added !");
                            session.setAttribute("Error", "");
                            response.sendRedirect("ManageStudentsInBatch.jsp?batchname="+batchName+"&batchcode="+batchCode+"&deptcode="+deptCode);
                        } else {
                            session.setAttribute("Error", "Addition Unsuccessfull !");
                            session.setAttribute("Info", "");
                            response.sendRedirect("ManageStudentsInBatch.jsp?batchname="+batchName+"&batchcode="+batchCode+"&deptcode="+deptCode);
                        }
                    }
                    stmt.close();
        %>
    </body>
</html>
