<%-- 
    Document   : StartExam
    Created on : May 21, 2011, 3:35:30 PM
    Author     : Salah
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Start Exam</title>
        <%
            int duration = Integer.parseInt(request.getParameter("duration"));
            session.setMaxInactiveInterval(duration * 60);
            String examStarted = (String) session.getAttribute("ExamStarted");
            long timeInSec=0;
            long currentTime=0;
            long currentSec=0;
            Calendar c=Calendar.getInstance();
            if (examStarted != null && examStarted.equals("Started")) {                
                timeInSec=Long.parseLong(session.getAttribute("StartTimeInSec")+"");                
                long timeNow=c.getTimeInMillis()/(1000);
                currentSec=(timeNow-timeInSec);                
                currentTime=duration-(currentSec/60);
                currentSec=(duration*60)-currentSec;                               
            }else{                
                timeInSec=c.getTimeInMillis()/(1000);
                session.setAttribute("StartTimeInSec",timeInSec);
                currentTime=duration;
                currentSec=currentTime*60-1;
            }                       
        %>
        <script type="text/javascript">
            var durationMinutes=<%=currentTime%>;
            var totalSec=<%=currentSec%>;
            durationMinutes=durationMinutes-1;
            var oneMinute=0;            
            function runExam(){
                var durationTextBox=document.getElementById("Duration");
                durationTextBox.value=(durationMinutes)+" : "+(totalSec%60)+"";
                                                
                totalSec=totalSec-1;oneMinute++;
                if(oneMinute==60){
                    oneMinute=0;
                    durationMinutes--;
                }
                if(totalSec<=0){
                    endExam();
                }
                setTimeout("runExam()", 1000);
            }
            function endExam(){
                var endButton=document.getElementById("EndExam");
                endButton.click();                
            }
        </script>
    </head>
    <body  bgcolor="#F0F0F0" onload="runExam()"><center>
        <h1>Start Exam !</h1><hr>
        <%
            String registerNo = request.getParameter("registerno");
            String batchCode = request.getParameter("batchcode");
            String examName = request.getParameter("examname");
            String examCode = request.getParameter("examcode");
            String batchName = request.getParameter("batchname");
            String deptCode = request.getParameter("deptcode");
            String studentName = request.getParameter("studentname");
        %>
        <table border="1">
            <tr><td>Student Name</td><td>:</td><td><b><%=studentName%></b></td></tr>
            <tr><td>Register No</td><td>:</td><td><b><%=registerNo%></b></td></tr>
            <tr><td>Exam</td><td>:</td><td><b><%=examName%></b></td></tr>            
            <tr><td>Time Left</td><td>:</td><td><b><input type="text" id="Duration" value="<%=currentTime%>:00"></b></td></tr>
        </table>            
        <%
            //try {
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();
                
                if (examStarted != null && examStarted.equals("Started")) {

                    ArrayList selectedQuestions =  (ArrayList)session.getAttribute("SelectedQuestions");
                    int questionsNo = selectedQuestions.size();
                    ArrayList questions = (ArrayList)session.getAttribute("Questions");
                    ArrayList questionsCode = (ArrayList)session.getAttribute("QuestionsCode");

        %>
        <table border="1">
            <form name="form1" method="post" action="SaveExamResult.jsp">
                <input type="hidden" name="registerno" value="<%=registerNo%>">
                <input type="hidden" name="examcode" value="<%=examCode%>">
                <input type="hidden" name="batchcode" value="<%=batchCode%>">
                <input type="hidden" name="deptcode" value="<%=deptCode%>">
                <input type="hidden" name="questionsno" value="<%=questionsNo%>">
                <tr><td>Q.No</td><td>Question</td><td>Answer</td></tr>
                <%
                    int j = 0;
                    while (j < questionsNo) {
                %>
                <tr><td><%=j + 1%></td><td><%=questions.get(Integer.parseInt(selectedQuestions.get(j)+""))%></td><td><input type="hidden" name="question<%=j%>" value="<%=questionsCode.get(Integer.parseInt(selectedQuestions.get(j)+""))%>"></td></tr>
                        <%
                            ResultSet rs = stmt.executeQuery("Select AnswerCode,Answer From SPMAnswers Where(QuestionCode=" + questionsCode.get(Integer.parseInt(selectedQuestions.get(j)+"")) + ");");
                            while (rs.next()) {
                                int answerCode = rs.getInt("AnswerCode");
                                String answer = rs.getString("Answer");
                        %>
                <tr>
                    <td></td>
                    <td><%=answer%></td>
                    <td><input type="radio" name="answer<%=j%>" value="<%=answerCode%>"></td>
                </tr>
                <%
                        }
                        j++;
                    }
                %>
                <tr><td></td><td></td><td><input type="submit" id="EndExam" name="submit" value="End Exam"></td></tr>
            </form>
        </table>
        <%
        } else {
            ResultSet rs = stmt.executeQuery("Select * From SPMCurrentExam Where(ExamCode=" + examCode + " And BatchCode=" + batchCode + ");");
            if (rs.next()) {
                int questionsNo = rs.getInt("QuestionsNo");
                int examDuration = rs.getInt("ExamDuration");
                int minimumPercent = rs.getInt("MinimumPercent");

                rs = stmt.executeQuery("Select Count(*) As Count From SPMQuestions Where (ExamCode=" + examCode + ");");
                int recordCount = 0;
                if (rs.next()) {
                    recordCount = rs.getInt("Count");
                } else {
                }

                if (recordCount >= questionsNo) {

                    ArrayList questionsCode = new ArrayList();
                    ArrayList questions = new ArrayList();
                    rs = stmt.executeQuery("Select QuestionCode,Question From SPMQuestions Where (ExamCode=" + examCode + ");");
                    int i = 0;
                    while (rs.next()) {
                        questionsCode.add(rs.getInt("QuestionCode"));
                        questions.add(rs.getString("Question"));
                        i++;
                    }

                    Random r = new Random();
                    ArrayList selectedQuestions = new ArrayList();
                    int j = 0;
                    while (j < questionsNo) {
                        int ranNum = r.nextInt(recordCount);
                        boolean found = false;
                        i = 0;
                        while (i < j) {
                            if (ranNum == Integer.parseInt(selectedQuestions.get(i)+"")) {
                                found = true;
                                break;
                            }
                            i++;
                        }
                        if (!found) {
                            selectedQuestions.add(ranNum);
                            j++;
                        }
                    }
        %>
        <table border="1">
            <form name="form1" method="post" action="SaveExamResult.jsp">
                <input type="hidden" name="registerno" value="<%=registerNo%>">
                <input type="hidden" name="examcode" value="<%=examCode%>">
                <input type="hidden" name="batchcode" value="<%=batchCode%>">
                <input type="hidden" name="deptcode" value="<%=deptCode%>">
                <input type="hidden" name="questionsno" value="<%=questionsNo%>">
                <tr><td>Q.No</td><td>Question</td><td>Answer</td></tr>
                <%
                    j = 0;
                    while (j < questionsNo) {
                %>
                <tr><td><%=j + 1%></td><td><%=questions.get(Integer.parseInt(selectedQuestions.get(j)+""))%></td><td><input type="hidden" name="question<%=j%>" value="<%=questionsCode.get(Integer.parseInt(selectedQuestions.get(j)+""))%>"></td></tr>
                        <%
                            rs = stmt.executeQuery("Select AnswerCode,Answer From SPMAnswers Where(QuestionCode=" + questionsCode.get(Integer.parseInt(selectedQuestions.get(j)+"")) + ");");
                            while (rs.next()) {
                                int answerCode = rs.getInt("AnswerCode");
                                String answer = rs.getString("Answer");
                        %>
                <tr>
                    <td></td>
                    <td><%=answer%></td>
                    <td><input type="radio" name="answer<%=j%>" value="<%=answerCode%>"></td>
                </tr>
                <%
                        }
                        j++;
                    }
                %>
                <tr><td></td><td></td><td><input type="submit" name="submit" id="EndExam" value="End Exam"></td></tr>
            </form>
        </table>
        <%
                            session.setAttribute("SelectedQuestions", selectedQuestions);
                            session.setAttribute("Questions", questions);
                            session.setAttribute("QuestionsCode", questionsCode);
                            session.setAttribute("ExamStarted", "Started");

                        } else {
                            session.setAttribute("Error", "Not Enough Quesions Available !");
                            response.sendRedirect("ShowStudentShortDetails.jsp?batchname=" + batchName + "&batchcode=" + batchCode + "&deptcode=" + deptCode + "&registerno=" + registerNo);
                        }

                    } else {
                    }
                }

                stmt.close();
            /*} catch (Exception e) {
                System.out.println(e.toString());
            }*/
            
        %>
    </center>
    </body>
</html>
