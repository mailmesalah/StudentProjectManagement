<%-- 
    Document   : OnlineTestNotification
    Created on : May 20, 2011, 8:30:22 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Test Notification</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Online Test Notification !</h1><hr>
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

            try {

                String batchCode = request.getParameter("batchcode");
                String batchName = request.getParameter("batchname");
                String deptName = "";

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
                String examName = "";
                int questionsNo = 0;
                int examDuration = 0;
                int minimumPercent = 0;
                String examStatus = "";

                rs = stmt.executeQuery("Select SPMExamMaster.ExamName,SPMCurrentExam.* From SPMCurrentExam,SPMExamMaster Where(SPMCurrentExam.BatchCode=" + batchCode + " And SPMExamMaster.ExamCode=SPMCurrentExam.ExamCode);");
                if (rs.next()) {
                    examName = rs.getString("ExamName");
                    questionsNo = rs.getInt("QuestionsNo");
                    examDuration = rs.getInt("ExamDuration");
                    minimumPercent = rs.getInt("MinimumPercent");
                    bExist = true;
                    examStatus = "Exam Assigned to the Batch";
                } else {
                    bExist = false;
                    examStatus = "Currently No Exam Assigned to the Batch";
                }
        %>
        <table border="1">
            <tr><td>Department</td><td>:</td><td><%=deptName%></td></tr>
            <tr><td>Batch</td><td>:</td><td><%=batchName%></td></tr>
            <tr><td>Exam Status</td><td>:</td><td><%=examStatus%></td></tr>
            <%
                if (bExist) {

            %>
            <tr><td></td><td></td><td></td></tr>
            <tr><td>Exam Details</td><td></td><td></td></tr>
            <tr><td>Exam</td><td>:</td><td><%=examName%></td></tr>
            <tr><td>No of Questions</td><td>:</td><td><%=questionsNo%></td></tr>
            <tr><td>Exam Duration</td><td>:</td><td><%=examDuration%></td></tr>
            <tr><td>Minimum Percent To Pass</td><td>:</td><td><%=minimumPercent%></td></tr>
            <tr>
                <td></td><td></td>
                <td>
                    <form name="form1" method="post" action="CloseExamFromBatch.jsp">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Close Exam">
                    </form>
                </td>
            </tr>
            <%
            } else {

            %>
            <tr>
                <td></td><td></td>
                <td>
                    <form name="form1" method="post" action="SetExamToBatch.jsp">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Set Exam">
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
