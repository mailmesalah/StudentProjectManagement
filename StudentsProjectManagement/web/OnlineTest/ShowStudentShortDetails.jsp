<%-- 
    Document   : ShowStudentShortDetails
    Created on : May 20, 2011, 11:46:06 AM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Details</title>
    </head>
    <body bgcolor="#F0F0F0"><center> 
        <h1>Student Details !</h1><hr>       
        <%
            String deptCode = request.getParameter("deptcode");
        %>
        <a href="ShowBatches.jsp?DepartmentCode=<%=deptCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
        <% String errors = (String) session.getAttribute("Error");
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
            //Clearing session for next exam
            session.setAttribute("ExamStarted", "");
            session.setAttribute("RegisterNo", "");

            try {
                String regNo = request.getParameter("registerno");
                String batchName = request.getParameter("batchname");
                String batchCode = request.getParameter("batchcode");

                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

                ResultSet rs = stmt.executeQuery("Select StudentName,Sex,DateOfBirth,SPMCurrentExam.*,SPMExamMaster.ExamName From SPMStudentMaster,SPMBatchRegister,SPMCurrentExam,SPMExamMaster Where ( SPMStudentMaster.RegisterNo='" + regNo + "' And SPMStudentMaster.RegisterNo=SPMBatchRegister.RegisterNo And SPMBatchRegister.BatchCode=" + batchCode + " And SPMCurrentExam.BatchCode=" + batchCode + " And SPMExamMaster.ExamCode=SPMCurrentExam.ExamCode);");
                if (rs.next()) {
                    String studentName = rs.getString("StudentName");
                    String sex = rs.getString("Sex").equals("M") ? "Male" : "Female";
                    String dateOfBirth = rs.getDate("DateOfBirth") + "";
                    int examCode = rs.getInt("ExamCode");
                    int questionsNo = rs.getInt("QuestionsNo");
                    int examDuration = rs.getInt("ExamDuration");
                    int minimumPercent = rs.getInt("MinimumPercent");
                    String examName = rs.getString("ExamName");
        %>              
        <table border="1">
            <tr><td>Register No</td><td>:</td><td><%=regNo%></td></tr>
            <tr><td>Student Name</td><td>:</td><td><%=studentName%></td></tr>
            <tr><td>Sex</td><td>:</td><td><%=sex%></td></tr>
            <tr><td>Date Of Birth</td><td>:</td><td><%=dateOfBirth%></td></tr>
            <tr><td></td><td></td><td></td></tr>
            <tr><td>Exam</td><td>:</td><td><%=examName%></td></tr>
            <tr><td>Exam Duration in mts</td><td>:</td><td><%=examDuration%></td></tr>
            <tr><td>No of Questions</td><td>:</td><td><%=questionsNo%></td></tr>
            <tr><td>Minimum Percent to Pass</td><td>:</td><td><%=minimumPercent%></td></tr>
            <tr><td></td><td></td>
                <td>
                    <form name="form1" method="post" action="StartExam.jsp">
                        <input type="hidden" name="duration" value="<%=examDuration%>">
                        <input type="hidden" name="examname" value="<%=examName%>">
                        <input type="hidden" name="examcode" value="<%=examCode%>">
                        <input type="hidden" name="registerno" value="<%=regNo%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="studentname" value="<%=studentName%>">
                        <input type="submit" name="submit" value="Start Exam">
                    </form>
                </td>
            </tr>
        </table>
        <%
                } else {
                    session.setAttribute("Error", "Student Not Found in the batch !");
                    response.sendRedirect("ShowBatches.jsp?DepartmentCode=" + deptCode);
                }
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
    </center>
    </body>
</html>
