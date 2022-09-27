<%-- 
    Document   : ReportReject
    Created on : May 21, 2011, 8:11:35 AM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report Reject</title>
    </head>
    <body>
        <h1>Report Reject !</h1><hr>
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
            String groupCode = request.getParameter("groupcode");
            String groupName = request.getParameter("groupname");
            String status = request.getParameter("status");

            if (status.equals("No Project Started") || status.equals("Abstract Accepted") || status.equals("Abstract Submitted") || status.equals("Abstract Rejected")) {
                session.setAttribute("Error", "Error: Please Check Current Status !");
                response.sendRedirect("ShowProject.jsp?batchcode=" + batchCode + "&batchname=" + batchName + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
            }

            try {
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

                int records = stmt.executeUpdate("Update SPMCurrentProject Set Status='RR' Where(GroupCode=" + groupCode + ");");
                if (records > 0) {
                    session.setAttribute("Info", "Successfully Rejected the Report !");
                    response.sendRedirect("ShowProject.jsp?batchcode=" + batchCode + "&batchname=" + batchName + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                } else {
                    session.setAttribute("Error", "Error Occured !");
                    response.sendRedirect("ShowProject.jsp?batchcode=" + batchCode + "&batchname=" + batchName + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                }
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
    </body>
</html>
