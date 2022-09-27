<%-- 
    Document   : AddGroupToBatch
    Created on : Apr 29, 2011, 4:00:11 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Group To Batch</title>
    </head>
    <body>
        <h1>Add Group To Batch !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
                    try {
                        String groupName = request.getParameter("groupname");
                        String description = request.getParameter("description");
                        String batchCode = request.getParameter("batchcode");
                        String deptCode=request.getParameter("deptcode");
                        String batchName=request.getParameter("batchname");

                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                        Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                        Statement stmt = con.createStatement();

                        ResultSet rs = stmt.executeQuery("Select * From SPMGroupMaster Where (GroupName='" + groupName + "' And batchCode=" + batchCode + ");");
                        if (rs.next()) {
                            session.setAttribute("Error", "Addition Unsuccessfull : Group already Exist !");
                            session.setAttribute("Info", "");
                            response.sendRedirect("ManageBatches.jsp?DepartmentCode=" + deptCode);

                        } else {
                            int iGroupCode = 0;
                            rs = stmt.executeQuery("Select Max(SPMGroupMaster.GroupCode) As GCode From SPMGroupMaster ;");
                            if (rs.next()) {
                                iGroupCode = rs.getInt("GCode") + 1;
                            } else {
                                iGroupCode = 1;
                            }

                            int i = stmt.executeUpdate("Insert Into SPMGroupMaster Values (" + iGroupCode + ",'" + groupName + "','" + description + "'," + batchCode + ");");
                            if (i > 0) {
                                session.setAttribute("Info", "Successfully Added !");
                                session.setAttribute("Error", "");
                                response.sendRedirect("ManageGroupsOfBatch.jsp?deptcode="+ deptCode+"&batchname="+batchName+"&batchcode="+batchCode);
                            } else {
                                session.setAttribute("Error", "Addition Unsuccessfull !");
                                session.setAttribute("Info", "");
                                response.sendRedirect("ManageGroupsOfBatch.jsp?deptcode="+ deptCode+"&batchname="+batchName+"&batchcode="+batchCode);
                            }
                        }
                        stmt.close();
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }
        %>
    </body>
</html>
