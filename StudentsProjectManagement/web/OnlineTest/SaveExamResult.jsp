<%-- 
    Document   : SaveExamResult
    Created on : May 21, 2011, 5:33:22 PM
    Author     : Salah
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Result</title>
    </head>
    <body bgcolor="#F0F0F0"><center> 
        <h1>Exam Result !</h1><hr>
        <%
            String deptCode = request.getParameter("deptcode");
        %>
        <a href="ShowBatches.jsp?DepartmentCode=<%=deptCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
        <%
            String regNo = request.getParameter("registerno");
            String examCode = request.getParameter("examcode");
            String batchCode = request.getParameter("batchcode");
            int questionsNo = Integer.parseInt(request.getParameter("questionsno"));
            String questionsCode[] = new String[questionsNo];
            String answersCode[] = new String[questionsNo];
            int i = 0;
            while (i < questionsNo) {
                questionsCode[i] = request.getParameter("question" + i);
                answersCode[i] = request.getParameter("answer" + i);
                i++;
            }


            try {

                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

                ResultSet rs;
                i = 0;
                int attendedAnswers = 0;
                int correctAnswers = 0;
                while (i < questionsNo) {
                    if (answersCode[i] != null) {
                        attendedAnswers++;
                        rs = stmt.executeQuery("Select AnswerCode From SPMAnswers Where (QuestionCode=" + questionsCode[i] + " And CorrectAnswer=1);");
                        if (rs.next()) {
                            if ((rs.getInt("AnswerCode")+"").equals(answersCode[i])) {
                                correctAnswers++;
                            }
                        } else {
                        }
                    } else {
                    }
                    i++;
                }
                Calendar c = Calendar.getInstance();               
                rs = stmt.executeQuery("Select UniqueID,StudentName From SPMStudentMaster Where(RegisterNo='" + regNo + "');");
                if (rs.next()) {
                    int studentCode = rs.getInt("UniqueID");
                    String studentName = rs.getString("StudentName");

                    rs = stmt.executeQuery("Select SPMExamMaster.ExamName,SPMCurrentExam.MinimumPercent From SPMExamMaster,SPMCurrentExam Where(SPMCurrentExam.BatchCode=" + batchCode + " And SPMCurrentExam.ExamCode=" + examCode + " And SPMExamMaster.ExamCode=SPMCurrentExam.ExamCode);");
                    if (rs.next()) {
                        String examName = rs.getString("ExamName");
                        double minimumPercent = rs.getInt("MinimumPercent");
                        double percent = ((correctAnswers * 1.0) / questionsNo) * 100;
                        String status = (percent >= minimumPercent) ? "Pass" : "Fail";

                        String already = (String) session.getAttribute("RegisterNo");
                        already = already == null ? "" : already;
                        if (!already.equals(regNo)) {
                            rs = stmt.executeQuery("Select Max(OnlineTestCode) As OCode From SPMOnlineTestResults;");
                            int onlineTestCode = 1;
                            if (rs.next()) {
                                onlineTestCode = rs.getInt("OCode") + 1;
                            } else {
                            }
                            String d=DateFormat.getDateInstance(DateFormat.DATE_FIELD).format(c.getTime());
                            int records = stmt.executeUpdate("Insert Into SPMOnlineTestResults Values (" + studentCode + ",'" + examName + "',to_date('"+d+"','mm/dd/yyyy')," + percent + ",'" + status + "'," + onlineTestCode + ");");
                            session.setAttribute("RegisterNo", regNo);
                        } else {
                        }
        %>
        <table border="1">
            <form name="form1" method="post" action="ShowBatches.jsp">
                <input type="hidden" name="DepartmentCode" value="<%=deptCode%>">
                <tr><td>Student Name</td><td>:</td><td><%=studentName%></td></tr>
                <tr><td>Register No</td><td>:</td><td><%=regNo%></td></tr>
                <tr><td>Exam</td><td>:</td><td><%=examName%></td></tr>
                <tr><td>Date</td><td>:</td><td><%=(DateFormat.getDateInstance().format(c.getTime()))%></td></tr>
                <tr><td>No of Questions</td><td>:</td><td><%=questionsNo%></td></tr>
                <tr><td>Questions Attended</td><td>:</td><td><%=attendedAnswers%></td></tr>
                <tr><td>Correct Answers</td><td>:</td><td><%=correctAnswers%></td></tr>
                <tr><td>Percent</td><td>:</td><td><%=percent%> %</td></tr>
                <tr><td>Status</td><td>:</td><td><%=status%></td></tr>
                <tr><td></td><td></td><td><input type="submit" name="submit" value="OK"></td></tr>
            </form>
        </table>

        <%
                    }
                }                
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
    </center>
    </body>
</html>
