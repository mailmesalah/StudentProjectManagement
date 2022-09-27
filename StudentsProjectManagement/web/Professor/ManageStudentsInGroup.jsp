<%-- 
    Document   : ManageStudentsInGroup
    Created on : Apr 29, 2011, 5:22:34 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Students In Group</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
            <h1>Manage Students In Group !</h1><hr>
            <%
                String deptCode = request.getParameter("deptcode");
                String batchName = request.getParameter("batchname");
                String batchCode = request.getParameter("batchcode");
            %>
            <a href="ManageGroupsOfBatch.jsp?deptcode=<%=deptCode%>&batchname=<%=batchName%>&batchcode=<%=batchCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
            <%
                String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
                String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
                if (uniqueID.equals("") || !userType.equals("P")) {
                    response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
                }
            %>
            <%try {
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

                    String groupName = request.getParameter("groupname");
                    String groupCode = request.getParameter("groupcode");
            %>
            <h4>Batch: <%=batchName%></h4>
            <h5>Group: <%=groupName%></h5>
            <table border="1">
                <tr><td>Status</td><td>Register No</td><td>Student Name</td><td>Sex</td><td>Date Of Birth</td><td>Action</td></tr>
                <%
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();

                    ResultSet rs = stmt.executeQuery("Select SPMStudentMaster.RegisterNo,SPMStudentMaster.StudentName,SPMStudentMaster.Sex,SPMStudentMaster.DateOfBirth,SPMGroupRegister.Status From SPMStudentMaster,SPMGroupRegister Where (SPMGroupRegister.GroupCode=" + groupCode + " And SPMGroupRegister.RegisterNo=SPMStudentMaster.RegisterNo And SPMStudentMaster.RegisterNo In (Select GR.RegisterNo From SPMGroupRegister GR Where(GR.GroupCode=" + groupCode + "))) Order By SPMStudentMaster.StudentName ;");
                    int i = 0;
                    while (rs.next()) {
                        i++;
                        String registerNo = rs.getString("RegisterNo");
                        String studentName = rs.getString("StudentName");
                        String sex = (rs.getString("Sex").equals("M") ? "Male" : "Female");
                        String dateOfBirth = rs.getDate("DateOfBirth") + "";
                        String status = ((rs.getString("Status").equals("L")) ? "Leader" : "Member");
                %>
                <tr><td><%=status%></td>
                    <td><%=registerNo%></td>
                    <td><%=studentName%></td>
                    <td><%=sex%></td>
                    <td><%=dateOfBirth%></td>
                    <td><form name="form<%=i++%>" method="get" action="RemoveStudentFromGroup.jsp">
                            <input type="hidden" name="registerno" value="<%=registerNo%>">
                            <input type="hidden" name="batchcode" value="<%=batchCode%>">
                            <input type="hidden" name="batchname" value="<%=batchName%>">
                            <input type="hidden" name="deptcode" value="<%=deptCode%>">
                            <input type="hidden" name="groupcode" value="<%=groupCode%>">
                            <input type="hidden" name="groupname" value="<%=groupName%>">
                            <input type="submit" name="submit" value="Remove From Group">
                        </form></td>
                </tr>
                <%
                    }
                    rs.close();
                %>
            </table>

            <h4>Students Available To Add</h4>
            <table border="1">
                <tr><td>Status</td><td>Register No</td><td>Student Name</td><td>Sex</td><td>Date Of Birth</td><td>Action</td></tr>
                <%
                    rs = stmt.executeQuery("Select SPMStudentMaster.RegisterNo,SPMStudentMaster.StudentName,SPMStudentMaster.Sex,SPMStudentMaster.DateOfBirth From SPMStudentMaster Where (SPMStudentMaster.RegisterNo Not In (Select SPMGroupRegister.RegisterNo From SPMGroupRegister) And SPMStudentMaster.RegisterNo In (Select SPMBatchRegister.RegisterNo From SPMBatchRegister Where SPMBatchRegister.BatchCode=" + batchCode + ")) Group By SPMStudentMaster.RegisterNo,SPMStudentMaster.StudentName,SPMStudentMaster.Sex,SPMStudentMaster.DateOfBirth Order By SPMStudentMaster.StudentName;");
                    while (rs.next()) {
                        String registerNo = rs.getString("RegisterNo");
                        String studentName = rs.getString("StudentName");
                        String sex = (rs.getString("Sex").equals("M") ? "Male" : "Female");
                        String dateOfBirth = rs.getDate("DateOfBirth") + "";
                %>
                <tr>
                <form name="form<%=i++%>" method="get" action="AddStudentToGroup.jsp">
                    <td>
                        <select name="status">
                            <option value="M">Member</option>
                            <option value="L">Leader</option>
                        </select>
                    </td>
                    <td><%=registerNo%></td>
                    <td><%=studentName%></td>
                    <td><%=sex%></td>
                    <td><%=dateOfBirth%></td>
                    <td>                        
                        <input type="hidden" name="registerno" value="<%=registerNo%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="groupcode" value="<%=groupCode%>">
                        <input type="hidden" name="groupname" value="<%=groupName%>">
                        <input type="submit" name="submit" value="Add To Group">
                    </td>
                </form>
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
