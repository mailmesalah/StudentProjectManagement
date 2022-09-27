<%-- 
    Document   : ShowProject
    Created on : May 20, 2011, 11:16:17 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Project</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Show Project !</h1><hr>
        <%
            String batchCode = request.getParameter("batchcode");
            String batchName = request.getParameter("batchname");
            String deptCode = request.getParameter("deptcode");
        %>
        <a href="ManageGroupsOfBatch.jsp?deptcode=<%=deptCode%>&batchname=<%=batchName%>&batchcode=<%=batchCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
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

            String groupCode = request.getParameter("groupcode");
            String groupName = request.getParameter("groupname");
            
            session.setAttribute("GroupCode", groupCode);

            try {
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

                ResultSet rs = stmt.executeQuery("Select SPMGroupRegister.Status,SPMStudentMaster.StudentName From SPMStudentMaster,SPMGroupRegister Where (SPMStudentMaster.RegisterNo=SPMGroupRegister.RegisterNo And SPMGroupRegister.GroupCode=" + groupCode + ") Order By SPMGroupRegister.Status,SPMStudentMaster.StudentName;");
        %>
        <h4>Group :<%=groupName%></h4><br>
        <table border="1">
            <%
                while (rs.next()) {
            %>
            <tr><td><%=(rs.getString("Status").equals("L") ? "Group Leader" : "Group Member")%></td><td>:</td><td><%=rs.getString("StudentName")%></td><td></td><td></td></tr>
            <%
                }
                String projectStatus = "";
                String projectDescription = "";
                String startDate = "";
                boolean projectStarted = false;
                rs = stmt.executeQuery("Select * From SPMCurrentProject Where(GroupCode=" + groupCode + ");");
                if (rs.next()) {
                    projectDescription = rs.getString("ProjectDescription");
                    startDate = rs.getDate("StartDate") + "";
                    String status = rs.getString("Status");
                    projectStatus = (status.equals("AS") ? "Abstract Submitted" : (status.equals("AA") ? "Abstract Accepted" : (status.equals("AR") ? "Abstract Rejected" : (status.equals("RS") ? "Report Submited" : (status.equals("RA") ? "Report Accepted" : (status.equals("PC") ? "Project Created" : "Report Rejected"))))));
                    projectStarted = true;
                } else {
                    projectStatus = "No Project Started";
                    projectStarted = false;
                }
                if (!projectStarted) {


            %>
            <tr>
                <td>Project Status</td><td>:</td><td><%=projectStatus%></td><td></td><td></td>
            </tr>        
            <%

            } else {
            %>
            <tr>
                <td>Project Status</td><td>:</td><td><%=projectStatus%></td><td></td><td></td>
            </tr>
            <tr>
                <td>Project Abstract</td>
                <td>:</td>
                <td>
                    <form name="form1" method="post" action="DownloadCurrentAbstract.jsp">                        
                        <input type="submit" name="submit" value="Download">
                    </form>
                </td>
                <td>                    
                    <form name="form2" method="post" action="AcceptAbstract.jsp">
                        <input type="hidden" name="status" value="<%=projectStatus%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="groupcode" value="<%=groupCode%>">
                        <input type="hidden" name="groupname" value="<%=groupName%>">
                        <input type="submit" name="submit" value="Accept">
                    </form>
                </td>
                <td>
                    <form name="form3" method="post" action="RejectAbstract.jsp">
                        <input type="hidden" name="status" value="<%=projectStatus%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="groupcode" value="<%=groupCode%>">
                        <input type="hidden" name="groupname" value="<%=groupName%>">
                        <input type="submit" name="submit" value="Reject">
                    </form>
                </td>
            </tr>
            <tr>
                <td>Project Report</td>
                <td>:</td>
                <td>
                    <form name="form4" method="post" action="DownloadCurrentReport.jsp">                        
                        <input type="submit" name="submit" value="Download">
                    </form>
                </td>                
                <td>
                    <form name="form5" method="post" action="AcceptReport.jsp">
                        <input type="hidden" name="status" value="<%=projectStatus%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="groupcode" value="<%=groupCode%>">
                        <input type="hidden" name="groupname" value="<%=groupName%>">
                        <input type="submit" name="submit" value="Accept">
                    </form>
                </td>
                <td>
                    <form name="form6" method="post" action="RejectReport.jsp">
                        <input type="hidden" name="status" value="<%=projectStatus%>">
                        <input type="hidden" name="batchcode" value="<%=batchCode%>">
                        <input type="hidden" name="batchname" value="<%=batchName%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="hidden" name="groupcode" value="<%=groupCode%>">
                        <input type="hidden" name="groupname" value="<%=groupName%>">
                        <input type="submit" name="submit" value="Reject">
                    </form>
                </td>
            </tr>

            <%
                }
                if (!projectStatus.equals("No Project Started")) {
            %>
        </table>
        <h4>Complete Project</h4><br>
        <form name="form7" method="post" action="CloseProject.jsp">
            <input type="hidden" name="batchcode" value="<%=batchCode%>">
            <input type="hidden" name="batchname" value="<%=batchName%>">
            <input type="hidden" name="deptcode" value="<%=deptCode%>">
            <input type="hidden" name="groupcode" value="<%=groupCode%>">
            <input type="hidden" name="groupname" value="<%=groupName%>">
            <input type="hidden" name="startdate" value="<%=startDate%>">
            <input type="hidden" name="projectdescription" value="<%=projectDescription%>">
            <table border="1">
                <tr><td>Serial No</td><td>Student Name</td><td>Percent</td><td>Status</td></tr>
                <%
                    int i = 0;
                    rs = stmt.executeQuery("Select SPMStudentMaster.UniqueID,SPMStudentMaster.StudentName,SPMGroupRegister.Status From SPMStudentMaster,SPMGroupRegister Where (SPMStudentMaster.RegisterNo=SPMGroupRegister.RegisterNo And SPMGroupRegister.GroupCode=" + groupCode + ") Order By SPMGroupRegister.Status,SPMStudentMaster.StudentName;");
                    while (rs.next()) {
                %>
                <tr>
                    <td><%=i + 1%></td>
                    <td>
                        <input type="hidden" name="studentcode<%=i%>" value="<%=rs.getInt("UniqueID")%>">
                        <%=rs.getString("StudentName")%>
                    </td>
                    <td>
                        <input type="text" name="percent<%=i%>" size="20">
                    </td>
                    <td>
                        <select name="status<%=i%>">
                            <option value="Completed">Completed</option>
                            <option value="Not Completed">Not Completed</option>
                            <option value="Partially Completed">Partially Completed</option>
                        </select>
                    </td>                
                </tr>
                <%
                        i++;
                    }
                %>
                <tr>
                    <td></td><td></td><td></td>
                    <td>
                        <input type="hidden" name="limit" value="<%=i%>">
                        <input type="submit" name="submit" value="Close Project">
                    </td>
                </tr>
            </table>
        </form>
        <%

                }
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
    </center>
</body>
</html>
