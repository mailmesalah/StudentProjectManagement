<%-- 
    Document   : ManageExamDetails
    Created on : May 11, 2011, 9:18:47 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Exam Details</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Manage Exam Details !</h1><hr>
        <%
            String deptCode = request.getParameter("deptcode");
        %>
        <a href="ManageExams.jsp?DepartmentCode=<%=deptCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
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

            String examCode = request.getParameter("examcode");
            String examName = request.getParameter("examname");
        %>
        <h4>Exam Name: <%=examName%></h4>
        <table border="1">
            <tr><td>Serial No</td><td>Question</td><td>Answer</td><td>Action</td></tr>            
            <%
                try {
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();
                    int count = 0;
                    ResultSet rsQuestion = stmt.executeQuery("Select Count(*) As Count From SPMQuestions Where(ExamCode=" + examCode + ");");
                    if (rsQuestion.next()) {
                        count = rsQuestion.getInt("Count");
                    } else {
                        count = 0;
                    }
                    rsQuestion = stmt.executeQuery("Select QuestionCode,Question From SPMQuestions Where(ExamCode=" + examCode + ");");
                    int i = 0;
                    int questionCode[] = new int[count];
                    String question[] = new String[count];
                    while (rsQuestion.next()) {
                        questionCode[i] = rsQuestion.getInt("QuestionCode");
                        question[i] = rsQuestion.getString("Question");
                        i++;
                    }
                    rsQuestion.close();
                    int slNo = 0;
                    while (slNo < count) {

            %>
            <tr><td><%=slNo + 1%></td>
                <td><%=question[slNo]%></td>
                <td></td>                
                <td><form name="form<%=i++%>" method="get" action="RemoveQuestion.jsp">
                        <input type="hidden" name="examname" value="<%=examName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="examcode" value="<%=examCode%>">
                        <input type="hidden" name="questioncode" value="<%=questionCode[slNo]%>">
                        <input type="submit" name="submit" value="Remove Question">
                    </form></td>
            </tr>
            <%
                int aslNo = 1;
                ResultSet rsAnswers = stmt.executeQuery("Select * From SPMAnswers Where(QuestionCode=" + questionCode[slNo] + ");");
                while (rsAnswers.next()) {
                    int answerCode = rsAnswers.getInt("AnswerCode");
                    String answer = rsAnswers.getString("Answer");
                    boolean correct = rsAnswers.getBoolean("CorrectAnswer");
            %>
            <tr><td><%=aslNo%></td>
                <td><%=answer%></td>
                <td><%=correct%></td>                
                <td><form name="form<%=i++%>" method="get" action="RemoveAnswer.jsp">
                        <input type="hidden" name="examname" value="<%=examName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="examcode" value="<%=examCode%>">
                        <input type="hidden" name="answercode" value="<%=answerCode%>">
                        <input type="hidden" name="questioncode" value="<%=questionCode[slNo]%>">
                        <input type="submit" name="submit" value="Remove Answer">
                    </form></td>
            </tr>
            <%
                    aslNo++;
                }
                rsAnswers.close();
            %>
            <form name="formAdd<%=slNo%>" method="get" action="AddAnswer.jsp">
                <tr>
                    <td>
                        <input type="hidden" name="examname" value="<%=examName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="examcode" value="<%=examCode%>">
                        <input type="hidden" name="questioncode" value="<%=questionCode[slNo]%>">
                    </td>                    
                    <td><input type="text" name="answer" size="100"></td>
                    <td>
                        <select id="correctAnswer" name="correctanswer">
                            <option value="true">True</option>
                            <option value="false">False</option>
                        </select>
                    </td>                    
                    <td><input type="submit" name="Add" value="Add Answer"></td>
                </tr>
            </form>
            <%
                        slNo++;
                    }
                    stmt.close();
                } catch (Exception e) {
                    System.out.println(e.toString());
                }
            %>
            <form name="formAdd" method="get" action="AddQuestion.jsp">
                <tr><td></td>
                    <td>
                        <input type="text" name="question" size="100">
                        <input type="hidden" name="examname" value="<%=examName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                    </td>
                    <td><input type="hidden" name="examcode" value="<%=examCode%>"></td>                    
                    <td><input type="submit" name="Add" value="Add Question"></td>
                </tr>
            </form>
        </table>
    </center>
    </body>   
</html>
