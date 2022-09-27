<%-- 
    Document   : StudentProfile
    Created on : Apr 4, 2011, 3:22:53 PM
    Author     : Sely
--%>

<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Profile</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
            <h1>Student Profile!</h1><hr>
            <a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
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
                        ResultSet rs = stmt.executeQuery("Select * From SPMStudentMaster Where SPMStudentMaster.UniqueID=" + studentCode + " ;");
                        int i = 0;
                        if (rs.next()) {
                            session.setAttribute("studentCode", rs.getInt("UniqueID"));
                            String regNo = rs.getString("RegisterNo");
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
                            out.println("<tr><td>Register No</td><td>:</td><td>" + regNo + "</td></tr>");
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
                    rs = stmt.executeQuery("Select SM.SemesterName,SM.SemesterExamDate,((Select Sum(SPMSemesterRegister.ExternalMaxMark) From SPMSemesterRegister Where(SPMSemesterRegister.SemesterName=SM.SemesterName And SPMSemesterRegister.SemesterExamDate=SM.SemesterExamDate And SPMSemesterRegister.RegisterNo='" + regNo + "'))+(Select Sum(SPMSemesterRegister.InternalMaxMark) From SPMSemesterRegister Where(SPMSemesterRegister.SemesterName=SM.SemesterName And SPMSemesterRegister.SemesterExamDate=SM.SemesterExamDate And SPMSemesterRegister.RegisterNo='" + regNo + "'))) As MaxMarks,((Select Sum(SPMSemesterRegister.ExternalMark) From SPMSemesterRegister Where(SPMSemesterRegister.SemesterName=SM.SemesterName And SPMSemesterRegister.SemesterExamDate=SM.SemesterExamDate And SPMSemesterRegister.RegisterNo='" + regNo + "'))+(Select Sum(SPMSemesterRegister.InternalMark) From SPMSemesterRegister Where(SPMSemesterRegister.SemesterName=SM.SemesterName And SPMSemesterRegister.SemesterExamDate=SM.SemesterExamDate And SPMSemesterRegister.RegisterNo='" + regNo + "'))) As ObtainedMarks From SPMSemesterMaster SM Where SM.RegisterNo='"+regNo+"' Order By SM.SemesterName,SM.SemesterExamDate ;");
                %>
            <table border="1">            
                <tr><td>Semester Name</td><td>Semester Date</td><td>Total Marks</td><td>Show</td></tr>
                <%
                    String semesterName = "";
                    Date semesterDate;
                    String sSemesterDate="";
                    int maxMarks = 0;
                    int obtainedMarks = 0;
                    int l = 0;
                    while (rs.next()) {
                        semesterName = rs.getString("SemesterName");
                        semesterDate= rs.getDate("SemesterExamDate");                        
                        maxMarks = rs.getInt("MaxMarks");
                        obtainedMarks = rs.getInt("ObtainedMarks");
                        sSemesterDate = DateFormat.getDateInstance(DateFormat.DEFAULT).format(semesterDate) + "";
                %>
                <tr><td><%=semesterName%></td><td><%=sSemesterDate%></td><td><%=obtainedMarks%>/<%=maxMarks%></td>
                    <td><form name="form<%=l%>" method="get" action="ShowSemesterOfStudent.jsp">
                            <input type="hidden" name="semestername" value="<%=semesterName%>">
                            <input type="hidden" name="semesterdate" value="<%=semesterDate%>">
                            <input type="hidden" name="studentcode" value="<%=regNo%>">
                            <input type="submit" name="show" value="   Show  ">
                        </form></td>                
                </tr>
                <%
                        l = l + 1;
                    }
                %>                
            </table>
            <h4><b>Online Test Attended</b></h4>
            <table border="1">            
                <tr><td>Exam</td><td>Exam Date</td><td>Percent</td><td>Status</td></tr>
                <%
                    rs = stmt.executeQuery("Select * From SPMOnlineTestResults Where StudentCode=" + studentCode + " ;");
                    while (rs.next()) {
                        String examName = rs.getString("ExamDescription");
                        String examDate = DateFormat.getDateInstance(DateFormat.DEFAULT).format(rs.getDate("ExamDate")) + "";
                        int percent = rs.getInt("Percent");
                        String examStatus = rs.getString("Status");
                %>        
                <tr>
                    <td><%=examName%></td>
                    <td><%=examDate%></td>
                    <td><%=percent%></td>
                    <td><%=examStatus%></td>
                </tr>        
                <%}%>
            </table>        
            <h4><b>Projects Completed</b></h4>
            <table border="1">            
                <tr><td>Project</td><td>Start Date</td><td>End Date</td><td>Percent</td><td>Status</td><td>Download Abstract</td><td>Download Report</td></tr>
                <%
                    int j = 0;
                    rs = stmt.executeQuery("Select * From SPMProjectsCompleted Where StudentCode=" + studentCode + " ;");
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
                </tr>        
                <%}%>
            </table>        
            <h4><b>Current Project</b></h4>
            <%
                String member = "";
                int groupCode = 0;
                rs = stmt.executeQuery("Select SPMGroupRegister.* From SPMProjectNotification,SPMBatchRegister,SPMGroupRegister Where(SPMGroupRegister.RegisterNo='" + regNo + "' And SPMBatchRegister.RegisterNo=SPMGroupRegister.RegisterNo And SPMProjectNotification.BatchCode=SPMBatchRegister.BatchCode);");
                if (rs.next()) {
                    groupCode = rs.getInt("GroupCode");
                    member = rs.getString("Status");                                                       
                } else {                    
                }
                session.setAttribute("GroupCode", groupCode);
                rs = stmt.executeQuery("Select SPMCurrentProject.*,SPMGroupRegister.Status As Member From SPMCurrentProject,SPMGroupRegister Where(SPMCurrentProject.GroupCode=SPMGroupRegister.GroupCode And SPMGroupRegister.RegisterNo='" + regNo + "');");                
                boolean found = rs.next();                
                if (found || member.length() > 0) {
                    String projectDescription = "";
                    String startDate = "";
                    String projectStatus = "";
                    if (found) {
                        groupCode = rs.getInt("GroupCode");
                        projectDescription = rs.getString("ProjectDescription");
                        startDate = DateFormat.getDateInstance(DateFormat.DEFAULT).format(rs.getDate("StartDate")) + "";
                        projectStatus = rs.getString("Status");
                        projectStatus = (projectStatus.equals("AS") ? "Abstract Submitted" : (projectStatus.equals("AA") ? "Abstract Accepted" : (projectStatus.equals("AR") ? "Abstract Rejected" : (projectStatus.equals("RS") ? "Report Submited" : (projectStatus.equals("RA") ? "Report Accepted" : (projectStatus.equals("PC") ? "Project Created" : "Report Rejected"))))));
                        member = rs.getString("Member");
                    }
            %>      
            <table border="1">            
                <tr><td>Project</td><td>Start Date</td><td>Status</td><td>Download Abstract</td><td>Download Report</td><td>Submit Abstract</td><td>Submit Report</td><td>Action</td></tr>
                <%
                    if (member.equals("L")) {
                        if (projectDescription.equals("")) {
                %>
                <tr>
                <form name="formCreate" method="post" action="CreateProject.jsp">
                    <input type="hidden" name="studentcode" value="<%=studentCode%>"> 
                    <td>
                        <input type="text" name="project" size="30" value="">
                    </td>
                    <td>
                        <input type="hidden" name="groupcode" value="<%=groupCode%>">                                                
                    </td>
                    <td></td><td></td><td></td><td></td><td></td>
                    <td>
                        <input type="submit" name="show" value="Create Project">
                    </td>
                </form>
                </tr>
                <%
                } else {
                %>
                <tr>
                    <td><%=projectDescription%></td>
                    <td><%=startDate%></td>
                    <td><%=projectStatus%></td>            
                    <td>
                        <form name="form1" method="get" action="DownloadCurrentAbstract.jsp">
                            <input type="hidden" name="groupcode" value="<%=groupCode%>">                                                
                            <input type="submit" name="download" value="Download Abstract">
                        </form>
                    </td>
                    <td>
                        <form name="form2" method="get" action="DownloadCurrentReport.jsp">
                            <input type="hidden" name="groupcode" value="<%=groupCode%>">                                                
                            <input type="submit" name="download" value="Download Report">
                        </form>    
                    </td>
                    <td>
                        <form name="form3" enctype="multipart/form-data" method="post" action="SubmitAbstract.jsp">                                                
                            <input type='file' name='sfile'>
                            <input type="submit" value="Submit Abstract">
                        </form>
                    </td>
                    <td>
                        <form name="form4" enctype="multipart/form-data" method="post" action="SubmitReport.jsp">
                            <input type='file' name='sfile'>
                            <input type="submit" name="submit" value="Submit Report">
                        </form>
                    </td>
                    <td>
                        <form name="form5" method="get" action="RemoveProject.jsp">
                            <input type="hidden" name="studentcode" value="<%=studentCode%>"> 
                            <input type="hidden" name="groupcode" value="<%=groupCode%>">                                                
                            <input type="submit" name="remove" value="Remove Project">
                        </form>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td><%=projectDescription%></td>
                    <td><%=startDate%></td>
                    <td><%=projectStatus%></td>
                    <td>
                        <form name="form1" method="get" action="DownloadCurrentAbstract.jsp">
                            <input type="hidden" name="groupcode" value="<%=groupCode%>">                                                
                            <input type="submit" name="download" value="Download Abstract">
                        </form>
                    </td>
                    <td>
                        <form name="form2" method="get" action="DownloadCurrentReport.jsp">
                            <input type="hidden" name="groupcode" value="<%=groupCode%>">                                                
                            <input type="submit" name="download" value="Download Report">
                        </form>    
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <%
                        }
                    }
                %>
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
