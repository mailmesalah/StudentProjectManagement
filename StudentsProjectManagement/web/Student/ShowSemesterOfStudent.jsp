<%-- 
    Document   : ShowSemesterOfStudent
    Created on : Apr 4, 2011, 3:27:03 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Semester Of Student</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Show Semester Of Student !</h1><hr>
        <a href="StudentProfile.jsp?studentCode=<%=((String) session.getAttribute("UniqueID"))%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><hr>
        <%
            String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
            String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
            if (uniqueID.equals("") || !userType.equals("S")) {
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
        %>
        <table border="1">            
            <tr><td>Subject Code</td><td>Subject Name</td><td>External Max Mark</td><td>Internal Max Mark</td><td>External Mark</td><td>Internal Mark</td><td>Exam Attended</td><td>Status</td></tr>
            <%try {
                    String registerNo = request.getParameter("studentcode");
                    String semesterName = request.getParameter("semestername");
                    String semesterDate = request.getParameter("semesterdate");

                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();
                    
                    ResultSet rs = stmt.executeQuery("Select * From SPMSemesterRegister Where (RegisterNo='" + registerNo + "' And SemesterName='" + semesterName + "' And SemesterExamDate=to_date('" + semesterDate + "','yyyy,mm,dd')) Order By SemesterName,SemesterExamDate;");
                    
                    int i = 0;
                    while (rs.next()) {
                        int subjectCode = rs.getInt("SubjectCode");
                        String subjectName = rs.getString("SubjectName");
                        int maxExternal = rs.getInt("ExternalMaxMark");
                        int maxInternal = rs.getInt("InternalMaxMark");
                        int externalMark = rs.getInt("ExternalMark");
                        int internalMark = rs.getInt("InternalMark");
                        String status = (rs.getString("Status").equals("P") ? "Pass" : "Fail");
                        String examAttended = (rs.getBoolean("ExamAttended") ? "Yes" : "No");
            %>
            <form name="form<%=i%>">
                <input type="hidden" name="semestername" value="<%=semesterName%>">
                <input type="hidden" name="semesterdate" value="<%=semesterDate%>">
                <input type="hidden" name="studentcode" value="<%=registerNo%>">
                <input type="hidden" name="subjectcode" value="<%=subjectCode%>">
                <tr><td><%=subjectCode%></td>
                    <td><%=subjectName%></td>
                    <td><%=maxExternal%></td>
                    <td><%=maxInternal%></td>
                    <td><%=externalMark%></td>
                    <td><%=internalMark%></td>
                    <td><%=examAttended%></td>
                    <td><%=status%></td>                    
                </tr>
            </form>
            <%
                    i = i + 1;
                }
                rs.close();
            %>            
        </table>
        
        <%
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
        </center>
    </body>
</html>
