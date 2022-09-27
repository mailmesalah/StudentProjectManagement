<%-- 
    Document   : ManageGroupsOfBatch
    Created on : Apr 29, 2011, 2:50:56 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Groups Of Batch</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Manage Groups Of Batch !</h1><hr>
        <%String deptCode = request.getParameter("deptcode");%>
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
        %>
        <h4>Batch: <%=batchName%></h4>
        <table border="1">
            <tr><td>Group Name</td><td>Description</td><td>Students</td><td>Show Project</td><td>Action</td></tr>
            <%
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

                ResultSet rs = stmt.executeQuery("Select * From SPMGroupMaster Where(BatchCode=" + batchCode + ") Order By GroupName;");
                int i = 0;
                while (rs.next()) {
                    int groupCode = rs.getInt("GroupCode");
                    String groupName = rs.getString("GroupName");
                    String description = rs.getString("Description");
            %>
            <tr><td><%=groupName%></td>
                <td><%=description%></td>
                <td>
                    <form name="form<%=i++%>" method="post" action="ManageStudentsInGroup.jsp">
                        <input type="hidden" name="groupname" value="<%=groupName%>">
                        <input type="hidden" name="groupcode" value="<%=groupCode%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="submit" name="submit" value="Show Students">
                    </form>
                </td>
                <td>
                    <form name="form<%=i++%>" method="post" action="ShowProject.jsp">
                        <input type="hidden" name="groupname" value="<%=groupName%>">
                        <input type="hidden" name="groupcode" value="<%=groupCode%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="submit" name="submit" value="Show Project">
                    </form>
                </td>
                <td>
                    <form name="form<%=i++%>" method="post" action="RemoveGroupFromBatch.jsp">
                        <input type="hidden" name="groupname" value="<%=groupName%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="groupcode" value="<%=groupCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="submit" name="submit" value="  Remove  ">
                    </form>
                </td>
            </tr>
            <%
                }
                rs.close();
                stmt.close();
            %>
            <form name="formAdd" method="get" action="AddGroupToBatch.jsp">
                <tr><td><input type="text" name="groupname" size="30"></td>
                    <td><input type="text" name="description" size="30"></td>
                    <td><input type="hidden" name="batchcode" value="<%=batchCode%>"></td>
                    <td><input type="hidden" name="batchname" value="<%=batchName%>"></td>                    
                    <td><input type="submit" name="Add" value="     Add     "></td>
                </tr>
            </form>
        </table>
        </center>
    </body>
</html>
