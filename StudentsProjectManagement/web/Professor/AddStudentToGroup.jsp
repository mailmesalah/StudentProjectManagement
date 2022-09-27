<%-- 
    Document   : AddStudentToGroup
    Created on : Apr 29, 2011, 6:09:49 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Student To Group</title>
    </head>
    <body>
        <h1>Add Student To Group !</h1><hr>
        <%
            String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
            String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
            if (uniqueID.equals("") || !userType.equals("P")) {
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
            String status = request.getParameter("status");

            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();
            ResultSet rs;
            out.println(groupCode);
            try {
                if (status.equals("L")) {
                    rs = stmt.executeQuery("Select * From SPMGroupRegister Where (SPMGroupRegister.GroupCode=" + groupCode + " And SPMGroupRegister.Status='L');");
                    if (rs.next()) {
                        session.setAttribute("Error", "Addition Unsuccessfull : The Group Already Have a Leader !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageStudentsInGroup.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                    } else {
                        rs = stmt.executeQuery("Select * From SPMGroupRegister Where (SPMGroupRegister.GroupCode=" + groupCode + " And SPMGroupRegister.RegisterNo='" + registerNo + "');");
                        if (rs.next()) {
                            session.setAttribute("Error", "Addition Unsuccessfull : Student already Added !");
                            session.setAttribute("Info", "");
                            response.sendRedirect("ManageStudentsInGroup.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                        } else {

                            int i = stmt.executeUpdate("Insert Into SPMGroupRegister Values ('" + registerNo + "'," + groupCode + ",'" + status + "');");
                            if (i > 0) {
                                session.setAttribute("Info", "Successfully Added !");
                                session.setAttribute("Error", "");
                                response.sendRedirect("ManageStudentsInGroup.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                            } else {
                                session.setAttribute("Error", "Addition Unsuccessfull !");
                                session.setAttribute("Info", "");
                                response.sendRedirect("ManageStudentsInGroup.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                            }
                        }
                    }
                } else {
                    rs = stmt.executeQuery("Select * From SPMGroupRegister Where (SPMGroupRegister.GroupCode=" + groupCode + " And SPMGroupRegister.RegisterNo='" + registerNo + "');");
                    if (rs.next()) {
                        session.setAttribute("Error", "Addition Unsuccessfull : Student already Added !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageStudentsInGroup.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                    } else {

                        int i = stmt.executeUpdate("Insert Into SPMGroupRegister Values ('" + registerNo + "'," + groupCode + ",'" + status + "');");
                        if (i > 0) {
                            session.setAttribute("Info", "Successfully Added !");
                            session.setAttribute("Error", "");
                            response.sendRedirect("ManageStudentsInGroup.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                        } else {
                            session.setAttribute("Error", "Addition Unsuccessfull !");
                            session.setAttribute("Info", "");
                            response.sendRedirect("ManageStudentsInGroup.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                        }
                    }
                }
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
    </body>
</html>
