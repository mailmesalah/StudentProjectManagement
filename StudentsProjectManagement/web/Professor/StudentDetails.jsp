<%-- 
    Document   : StudentDetails
    Created on : Apr 5, 2011, 8:40:01 AM
    Author     : Sely
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.lang.String"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Details</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Student Details!</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
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

            String studentCode = request.getParameter("studentCode");

            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();

        %>
        <Script type="text/javascript" language="java">

        </Script>
        <table border="1">
            <%

                try {
                    ResultSet rs = stmt.executeQuery("Select * From SPMStudentMaster Where SPMStudentMaster.RegisterNo='" + studentCode + "' ;");
                    int i = 0;
                    if (rs.next()) {
                        int studentID=rs.getInt("UniqueID");
                        session.setAttribute("studentCode", studentID+"");
                        String studentName = rs.getString("StudentName");
                        String sex = (rs.getString("Sex").equals("M") ? "Male" : "Female");
                        String date = DateFormat.getDateInstance(DateFormat.DEFAULT).format(rs.getDate("DateOfBirth")) + "";
                        String address1 = rs.getString("Address1");
                        String address2 = rs.getString("Address2");
                        String address3 = rs.getString("Address3");
                        String phone = rs.getString("Phone");
                        String remarks = rs.getString("Remarks");
                        String email = rs.getString("EmailID");
                        String status = rs.getString("Status");
                        out.println("<tr><td>Register No</td><td>:</td><td>" + studentCode + "</td></tr>");
                        out.println("<tr><td>Student Name</td><td>:</td><td>" + studentName + "</td></tr>");
                        out.println("<tr><td>Sex</td><td>:</td><td>" + sex + "</td></tr>");
                        out.println("<tr><td>Date Of Birth</td><td>:</td><td>" + date + "</td></tr>");
                        out.println("<tr><td>Email ID</td><td>:</td><td>" + email + "</td></tr>");
                        out.println("<tr><td>Address</td><td>:</td><td>" + address1 + "</td></tr>");
                        out.println("<tr><td></td><td>:</td><td>" + address2 + "</td></tr>");
                        out.println("<tr><td></td><td>:</td><td>" + address3 + "</td></tr>");
                        out.println("<tr><td>Phone</td><td>:</td><td>" + phone + "</td></tr>");
                        out.println("<tr><td>Remarks</td><td>:</td><td>" + remarks + "</td></tr>");
                        out.println("<tr><td>Status</td><td>:</td><td>" + (status.equals("R") ? "Registered" : (status.equals("V") ? "Validated" : (status.equals("J") ? "Rejected" : "Disabled"))) + "</td></tr>");
            %></table><%
                out.println("<h4><b>Semester Details</b></h4>");
                rs = stmt.executeQuery("Select SM.SemesterName,SM.SemesterExamDate,((Select Sum(SPMSemesterRegister.ExternalMaxMark) From SPMSemesterRegister Where(SPMSemesterRegister.SemesterName=SM.SemesterName And SPMSemesterRegister.SemesterExamDate=SM.SemesterExamDate And SPMSemesterRegister.RegisterNo='" + studentCode + "'))+(Select Sum(SPMSemesterRegister.InternalMaxMark) From SPMSemesterRegister Where(SPMSemesterRegister.SemesterName=SM.SemesterName And SPMSemesterRegister.SemesterExamDate=SM.SemesterExamDate And SPMSemesterRegister.RegisterNo='" + studentCode + "'))) As MaxMarks,((Select Sum(SPMSemesterRegister.ExternalMark) From SPMSemesterRegister Where(SPMSemesterRegister.SemesterName=SM.SemesterName And SPMSemesterRegister.SemesterExamDate=SM.SemesterExamDate And SPMSemesterRegister.RegisterNo='" + studentCode + "'))+(Select Sum(SPMSemesterRegister.InternalMark) From SPMSemesterRegister Where(SPMSemesterRegister.SemesterName=SM.SemesterName And SPMSemesterRegister.SemesterExamDate=SM.SemesterExamDate And SPMSemesterRegister.RegisterNo='" + studentCode + "'))) As ObtainedMarks From SPMSemesterMaster SM Where(SM.RegisterNo='"+studentCode+"') Order By SM.SemesterName,SM.SemesterExamDate;");
            %>
        <table border="1">            
            <tr><td>Semester Name</td><td>Semester Date</td><td>Total Marks</td><td>Show</td><td>Action</td></tr>
            <%
                String semesterName = "";
                String sSemesterDate="";
                Date semesterDate;
                int maxMarks = 0;
                int obtainedMarks = 0;
                int l = 0;
                while (rs.next()) {
                    semesterName = rs.getString("SemesterName");
                    semesterDate=rs.getDate("SemesterExamDate");
                    sSemesterDate = DateFormat.getDateInstance(DateFormat.DEFAULT).format(semesterDate);
                    maxMarks = rs.getInt("MaxMarks");
                    obtainedMarks = rs.getInt("ObtainedMarks");
            %>
            <tr><td><%=semesterName%></td><td><%=sSemesterDate%></td><td><%=obtainedMarks%>/<%=maxMarks%></td>
                <td><form name="form<%=l%>" method="get" action="ShowSemesterOfStudent.jsp">
                        <input type="hidden" name="semestername" value="<%=semesterName%>">
                        <input type="hidden" name="semesterdate" value="<%=semesterDate%>">
                        <input type="hidden" name="studentcode" value="<%=studentCode%>">
                        <input type="submit" name="show" value="   Show  ">
                    </form></td>
                    <%
                        l = l + 1;
                    %>
                <td><form name="form<%=l%>" method="get" action="RemoveSemesterFromStudent.jsp">
                        <input type="hidden" name="semestername" value="<%=semesterName%>">
                        <input type="hidden" name="semesterdate" value="<%=semesterDate%>">
                        <input type="hidden" name="studentcode" value="<%=studentCode%>">
                        <input type="submit" name="remove" value="  Remove  "></form></td>
            </tr>
            <%
                    l = l + 1;
                }
            %>
            <form name="formAdd" method="get" action="AddSemesterToStudent.jsp">
                <tr><td><input type="hidden" name="studentcode" value="<%=studentCode%>">
                        <input type="text" name="semestername" size="30"></td>
                    <td><input type="text" name="semesterdate" size="30"></td>
                    <td></td><td></td><td><input type="submit" name="Add" value="     Add     "></td></tr>
            </form>            
        </table>

        <h4><b>Online Test Attended</b></h4>

        <table border="1">            
            <tr><td>Exam</td><td>Exam Date</td><td>Percent</td><td>Status</td><td>Remove</td></tr>
            <%
                int j = 0;
                rs = stmt.executeQuery("Select * From SPMOnlineTestResults Where StudentCode=" + studentID +" ;" );
                while (rs.next()) {
                    String examName = rs.getString("ExamDescription");
                    String examDate = DateFormat.getDateInstance(DateFormat.DEFAULT).format(rs.getDate("ExamDate")) + "";
                    int percent = rs.getInt("Percent");
                    String examStatus = rs.getString("Status");
                    int examCode = rs.getInt("OnlineTestCode");
            %>        
            <tr>
                <td><%=examName%></td>
                <td><%=examDate%></td>
                <td><%=percent%></td>
                <td><%=examStatus%></td>
                <td>
                    <form name="form<%=j++%>" method="post" action="RemoveOnlineTest.jsp">                        
                        <input type="hidden" name="registerno" value="<%=studentCode%>">                        
                        <input type="hidden" name="examcode" value="<%=examCode%>">                        
                        <input type="submit" name="show" value="Remove">
                    </form>
                </td>
            </tr>               
        <%}%>
        </table> 
        <h4><b>Projects Completed</b></h4>
        
        <table border="1">            
            <tr><td>Project</td><td>Start Date</td><td>End Date</td><td>Percent</td><td>Status</td><td>Download Abstract</td><td>Download Report</td><td>Remove</td></tr>
            <%
                        
                rs = stmt.executeQuery("Select * From SPMProjectsCompleted Where StudentCode=" + studentID + " ;");
                while (rs.next()) {
                    int projectCode = rs.getInt("ProjectCode");
                    String project = rs.getString("ProjectDescription");
                    String startDate = DateFormat.getDateInstance(DateFormat.DEFAULT).format(rs.getDate("StartDate")) + "";
                    String endDate = DateFormat.getDateInstance(DateFormat.DEFAULT).format(rs.getDate("EndDate")) + "";
                    int percent = rs.getInt("Percent");
                    String projectStatus = rs.getString("Status");
            %>        
            <tr>
                <td><%=project%></td>
                <td><%=startDate%></td>
                <td><%=endDate%></td>
                <td><%=percent%></td>
                <td><%=projectStatus%></td>
                <td>
                    <form name="form<%=j++%>" method="get" action="DownloadAbstract.jsp">
                        <input type="hidden" name="projectcode" value="<%=projectCode%>">                                                
                        <input type="submit" name="show" value="Download Abstract">
                    </form>
                </td>                
                <td>
                    <form name="form<%=j++%>" method="get" action="DownloadReport.jsp">
                        <input type="hidden" name="projectcode" value="<%=projectCode%>">                        
                        <input type="submit" name="show" value="Download Report">
                    </form>
                </td>
                <td>
                    <form name="form<%=j++%>" method="post" action="RemoveCompletedProject.jsp">
                       <input type="hidden" name="registerno" value="<%=studentCode%>">                        
                        <input type="hidden" name="projectcode" value="<%=projectCode%>">                        
                        <input type="submit" name="show" value="Remove">
                    </form>                                        
                </td>
            </tr>               
        <%}%>
        </table> 
        <%
                } else {
                    out.println("No Record Found !");
                }
            } catch (Exception e) {
                out.println(e.toString());
            }
            stmt.close();

        %>
        </center>
    </body>
</html>
