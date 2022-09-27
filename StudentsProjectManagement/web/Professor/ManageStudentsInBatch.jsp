<%-- 
    Document   : ManageStudentsInBatch
    Created on : Apr 29, 2011, 1:12:18 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Students In Batch</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Manage Students In Batch !</h1><hr>
        <%
            String deptCode = request.getParameter("deptcode");
        %>
        <a href="ManageBatches.jsp?DepartmentCode=<%=deptCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br><br>
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

                String batchName = request.getParameter("batchname");
                String batchCode = request.getParameter("batchcode");
        %>
        <h4>Batch: <%=batchName%></h4>
        <table border="1">
            <tr><td>Register No</td><td>Student Name</td><td>Sex</td><td>Date Of Birth</td><td>Action</td></tr>
            <%


                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

                ResultSet rs = stmt.executeQuery("Select SPMStudentMaster.RegisterNo,SPMStudentMaster.StudentName,SPMStudentMaster.Sex,SPMStudentMaster.DateOfBirth From SPMStudentMaster Where (SPMStudentMaster.RegisterNo In (Select SPMBatchRegister.RegisterNo From SPMBatchRegister Where(SPMBatchRegister.BatchCode=" + batchCode + ")) And SPMStudentMaster.DeptCode=" + deptCode + " ) Order By SPMStudentMaster.StudentName;");
                int i = 0;
                while (rs.next()) {
                    String registerNo = rs.getString("RegisterNo");
                    String studentName = rs.getString("StudentName");
                    String sex = (rs.getString("Sex").equals("M") ? "Male" : "Female");
                    String dateOfBirth = rs.getDate("DateOfBirth") + "";
            %>
            <tr><td><%=registerNo%></td>
                <td><%=studentName%></td>
                <td><%=sex%></td>
                <td><%=dateOfBirth%></td>
                <td><form name="form<%=i++%>" method="get" action="RemoveStudentFromBatch.jsp">
                        <input type="hidden" name="registerno" value="<%=registerNo%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="  Remove  ">
                    </form></td>
            </tr>
            <%
                }
                rs.close();
            %>            
        </table>

        <h4>Students Available To Add</h4>
        <table border="1">
            <tr><td>Register No</td><td>Student Name</td><td>Sex</td><td>Date Of Birth</td><td>Action</td></tr>
            <%
                rs = stmt.executeQuery("Select SPMStudentMaster.RegisterNo,SPMStudentMaster.StudentName,SPMStudentMaster.Sex,SPMStudentMaster.DateOfBirth From SPMStudentMaster Where (SPMStudentMaster.RegisterNo Not In (Select SPMBatchRegister.RegisterNo From SPMBatchRegister) And SPMStudentMaster.DeptCode=" + deptCode + " ) Order By SPMStudentMaster.StudentName;");
                while (rs.next()) {
                    String registerNo = rs.getString("RegisterNo");
                    String studentName = rs.getString("StudentName");
                    String sex = (rs.getString("Sex").equals("M") ? "Male" : "Female");
                    String dateOfBirth = rs.getDate("DateOfBirth") + "";
            %>
            <tr><td><%=registerNo%></td>
                <td><%=studentName%></td>
                <td><%=sex%></td>
                <td><%=dateOfBirth%></td>
                <td><form name="form<%=i++%>" method="get" action="AddStudentToBatch.jsp">
                        <input type="hidden" name="registerno" value="<%=registerNo%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="  Add To Batch  ">
                    </form></td>
            </tr>
            <%
                    }
                    rs.close();
                    stmt.close();
                } catch (Exception e) {
                    System.out.println(e.toString());
                }
            %>
        </table>        
        </center>
    </body>
</html>
