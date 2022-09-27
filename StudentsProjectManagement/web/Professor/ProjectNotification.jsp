<%-- 
    Document   : ProjectNotification
    Created on : May 20, 2011, 10:24:29 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project Notification</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Project Notification !</h1><hr>
        <%
            String deptCode = request.getParameter("deptcode");
        %>
        <a href="ManageBatches.jsp?DepartmentCode=<%=deptCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
        <%
            String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
            String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
            if (uniqueID.equals("") || !userType.equals("P")) {
                response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
            }
        %>
        <%
            String errors = (String) session.getAttribute("Error");
            String info = (String) session.getAttribute("Info");
            if (errors != null) {
                out.println(errors);
            }
            if (info != null) {
                out.println(info);
            }
            //Reset the session variables
            session.setAttribute("Error", "");
            session.setAttribute("Info", "");

            String batchCode = request.getParameter("batchcode");
            String batchName = request.getParameter("batchname");
            String deptName = "";
            try {
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

                ResultSet rs = stmt.executeQuery("Select DeptName From SPMDepartments Where (DeptCode=" + deptCode + ");");
                if (rs.next()) {
                    deptName = rs.getString("DeptName");
                } else {
                    session.setAttribute("Error", "Department doesnt Exist !");
                    response.sendRedirect("ManageBatches.jsp?DepartmentCode=" + deptCode);
                }

                boolean bExist = false;
                String examStatus = "";

                rs = stmt.executeQuery("Select * From SPMProjectNotification Where(SPMProjectNotification.BatchCode=" + batchCode + ");");
                if (rs.next()) {
                    examStatus = "Project Notification Send";
                    bExist = true;
                } else {
                    examStatus = "No Current Project";
                    bExist = false;
                }
        %>
        <table border="1">
            <tr><td>Department</td><td>:</td><td><%=deptName%></td></tr>
            <tr><td>Batch</td><td>:</td><td><%=batchName%></td></tr>
            <tr><td>Project Status</td><td>:</td><td><%=examStatus%></td></tr>
            <%
                if (bExist) {

            %>                        
            <tr>
                <td></td><td></td>
                <td>
                    <form name="form1" method="post" action="CloseProjectNotification.jsp">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Close Project">
                    </form>
                </td>
            </tr>
            <%
            } else {

            %>
            <tr>
                <td></td><td></td>
                <td>
                    <form name="form1" method="post" action="SendProjectNotification.jsp">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Send Project Notification">
                    </form>
                </td>
            </tr>
            <%
                    }
                stmt.close();
                } catch (Exception e) {
                    System.out.println(e.toString());
                }
            %>

        </table>
    </center>
    </body>
</html>
