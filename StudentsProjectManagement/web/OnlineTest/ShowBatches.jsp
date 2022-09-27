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
        <title>Available Batches for Exam</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
            <h1>Available Batches for Exam !</h1><hr>
            <a href="SelectDepartmentForExams.jsp">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
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
                <tr><td>Batch Name</td><td>Description</td><td>Register No</td><td>Action</td></tr>            
                <%
                    String deptCode = request.getParameter("DepartmentCode");
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();

                    ResultSet rs = stmt.executeQuery("Select * From SPMBatchMaster Where(DeptCode=" + deptCode + " And BatchCode In (Select SPMCurrentExam.BatchCode From SPMCurrentExam)) Order By BatchName;");
                    int i = 0;
                    while (rs.next()) {
                        int batchCode = rs.getInt("BatchCode");
                        String batchName = rs.getString("BatchName");
                        String description = rs.getString("Description");
                %>
                <tr><td><%=batchName%></td>
                    <td><%=description%></td>
                <form name="form<%=i++%>" method="get" action="ShowStudentShortDetails.jsp">
                    <td>
                        <input type="text" name="registerno" size="30" value="">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">                    
                    </td>                                    
                    <td>
                        <input type="submit" name="submit" value="Next">
                    </td>
                </form>
                </tr>
                <%
                    }
                    rs.close();
                    stmt.close();
                %>        
            </table>
        </center>
    </body>
</html>
