<%-- 
    Document   : ManageBatches
    Created on : Apr 29, 2011, 12:11:38 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Batches</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Manage Batches !</h1><hr>
        <a href="SelectDepartmentForBatches.jsp">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br><br>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
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
        %>
        <table border="1">
            <tr><td>Batch Name</td><td>Description</td><td>Students</td><td>Groups<td>Send Message</td><td>Online Test Notification</td><td>Project Notification</td></td><td>Action</td></tr>            
            <%
                        String deptCode = request.getParameter("DepartmentCode");
                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                        Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                        Statement stmt = con.createStatement();

                        ResultSet rs = stmt.executeQuery("Select * From SPMBatchMaster Where(DeptCode="+deptCode+") Order By BatchName;");
                        int i = 0;
                        while (rs.next()) {
                            int batchCode = rs.getInt("BatchCode");
                            String batchName = rs.getString("BatchName");
                            String description = rs.getString("Description");
            %>
            <tr><td><%=batchName%></td>
                <td><%=description%></td>                
                <td>
                    <form name="form<%=i++%>" method="get" action="ManageStudentsInBatch.jsp">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Show Students">
                    </form>
                </td>
                <td>
                    <form name="form<%=i++%>" method="get" action="ManageGroupsOfBatch.jsp">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Show Groups">
                    </form>
                </td>
                <td>
                    <form name="form<%=i++%>" method="get" action="SendMessage.jsp">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Send Message">
                    </form>
                </td>
                <td>
                    <form name="form<%=i++%>" method="get" action="OnlineTestNotification.jsp">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Online Test Notification">
                    </form>
                </td>
                <td>
                    <form name="form<%=i++%>" method="get" action="ProjectNotification.jsp">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Project Notification">
                    </form>
                </td>
                <td>
                    <form name="form<%=i++%>" method="get" action="RemoveBatch.jsp">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="  Remove  ">
                    </form>
                </td>
            </tr>
            <%
                        }
                        rs.close();
                        stmt.close();
            %>
            <form name="formAdd" method="get" action="AddBatch.jsp">
                <tr><td><input type="text" name="batchname" size="30"></td>
                    <td><input type="text" name="description" size="30"></td>
                    <td><input type="hidden" name="deptcode" value="<%=deptCode%>"></td>
                    <td></td><td></td><td></td><td></td>
                    <td><input type="submit" name="Add" value="     Add     "></td>
                </tr>
            </form>
        </table>
        </center>
    </body>
</html>
