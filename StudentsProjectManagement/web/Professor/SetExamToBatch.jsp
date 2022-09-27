<%-- 
    Document   : SetExamToBatch
    Created on : May 20, 2011, 9:32:04 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Set Exam To Batch</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Set Exam To Batch !</h1><hr>
        <%
            String batchCode = request.getParameter("batchcode");
            String batchName = request.getParameter("batchname");
            String deptCode = request.getParameter("deptcode");
        %>
        <a href="OnlineTestNotification.jsp?batchcode=<%=batchCode%>&batchname=<%=batchName%>&deptcode=<%=deptCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
        <%
            String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
            String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
            if (uniqueID.equals("") || !userType.equals("P")) {
                response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
            }
        %>
        <%
            try {
        %>
        <br><h4>Batch :<%=batchName%></h4>
        <table border="1">
            <tr><td>Exam</td><td>No of Questions</td><td>Exam Duration in Mts</td><td>Minimum Percent</td><td>Add</td></tr>
            <tr>
            <form name="form1" method="post" action="SetExam.jsp">
                <input type="hidden" name="batchcode" value="<%=batchCode%>">
                <input type="hidden" name="batchname" value="<%=batchName%>">
                <input type="hidden" name="deptcode" value="<%=deptCode%>">
                <td>
                    <select name="examcode">
                        <%
                            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                            Statement stmt = con.createStatement();

                            ResultSet rs = stmt.executeQuery("Select ExamCode,ExamName From SPMExamMaster Order By ExamName;");
                            while (rs.next()) {
                        %>
                        <option value="<%=rs.getInt("ExamCode")%>"><%=rs.getString("ExamName")%></option>                        
                        <%
                                }
                                stmt.close();

                            } catch (Exception e) {
                                System.out.println(e.toString());
                            }
                        %>
                    </select>                    
                </td>
                <td>
                    <input type="text" name="questionsno" size="20">
                </td>
                <td>
                    <input type="text" name="examduration" size="20">
                </td>
                <td>
                    <input type="text" name="minimumpercent" size="20">
                </td>
                <td>
                    <input type="submit" name="sumbit" value="Set">
                </td>
            </form>
            </tr>
        </table>
    </center>
</body>
</html>
