<%-- 
    Document   : AddBatch
    Created on : Apr 29, 2011, 12:33:42 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Batch</title>
    </head>
    <body>
        <h1>Add Batch !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
                    try {
                        String batchName = request.getParameter("batchname");
                        String description = request.getParameter("description");
                        String deptCode = request.getParameter("deptcode");

                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                        Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                        Statement stmt = con.createStatement();

                        ResultSet rs = stmt.executeQuery("Select * From SPMBatchMaster Where (BatchName='" + batchName + "' And DeptCode=" + deptCode + ");");
                        if (rs.next()) {
                            session.setAttribute("Error", "Addition Unsuccessfull : Batch already Exist !");
                            session.setAttribute("Info", "");
                            response.sendRedirect("ManageBatches.jsp?DepartmentCode=" + deptCode);

                        } else {
                            int iBatchCode = 0;                            
                            rs = stmt.executeQuery("Select Max(SPMBatchMaster.BatchCode) As BCode From SPMBatchMaster ;");
                            if (rs.next()) {
                                iBatchCode = rs.getInt("BCode") + 1;
                            } else {
                                iBatchCode = 1;
                            }

                            int i = stmt.executeUpdate("Insert Into SPMBatchMaster Values (" + iBatchCode + ",'" + batchName + "','" + description + "'," + deptCode + ");");
                            if (i > 0) {
                                session.setAttribute("Info", "Successfully Added !");
                                session.setAttribute("Error", "");
                                response.sendRedirect("ManageBatches.jsp?DepartmentCode=" + deptCode);
                            } else {
                                session.setAttribute("Error", "Addition Unsuccessfull !");
                                session.setAttribute("Info", "");
                                response.sendRedirect("ManageBatches.jsp?DepartmentCode=" + deptCode);
                            }
                        }
                        stmt.close();
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }
        %>
    </body>
</html>
