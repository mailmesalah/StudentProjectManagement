<%--
    Document   : ShowStudentsOfDepartment
    Created on : Apr 27, 2011, 3:37:01 PM
    Author     : Sely
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Students Of Department</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
            <h1>Show Students Of Department!</h1><hr>
            <a href="SelectDepartmentForStudents.jsp">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br><br>
            <%
                String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
                String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
                if (uniqueID.equals("") || !userType.equals("P")) {
                    response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
                }
            %>
            <script type="text/javascript"  language="java">
                function showDetails(studentCode){
                    openWindow = window.open("", "", "height=600, width=900,toolbar=no,scrollbars="+scroll+",menubar=no");
                    openWindow.location="StudentDetails.jsp?studentCode="+studentCode;
                }
            </script>
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
                <pre>
            <tr><td>Register No</td><td>Student</td><td>Status</td><td>Details</td><td>Validate</td><td>Reject</td><td>Disable</td><td>Remove</td></tr>
                </pre>
                <%
                    String deptCode = request.getParameter("DepartmentCode");
                    session.setAttribute("DepartmentCode", deptCode);
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();
                    ArrayList studentCode = new ArrayList();
                    ArrayList studentName = new ArrayList();
                    ArrayList status = new ArrayList();

                    ResultSet rs = stmt.executeQuery("Select SPMStudentMaster.RegisterNo,SPMStudentMaster.StudentName,SPMStudentMaster.Status From SPMStudentMaster Where SPMStudentMaster.DeptCode=" + deptCode + " Order By SPMStudentMaster.StudentName;");
                    while (rs.next()) {
                        studentCode.add(rs.getString("RegisterNo"));
                        studentName.add(rs.getString("StudentName"));
                        status.add(rs.getString("Status"));
                    }
                    rs.close();
                    stmt.close();

                    int i = 0;
                    while (studentCode.size() > i) {
                %>

                <form   method="post">
                    <input type="hidden" name="studentCode" value="<%=studentCode.get(i)%>">
                    <tr><td><%=studentCode.get(i)%></td><td><%=studentName.get(i)%></td><td><%=(status.get(i).equals("R") ? "Registered" : (status.get(i).equals("V") ? "Validated" : (status.get(i).equals("J") ? "Rejected" : "Disabled")))%></td>
                        <td><input type="button" name="Details" value="  Details   " onclick="showDetails('<%=studentCode.get(i)%>')"></td>
                </form>

                <form  method ="post" action="ValidateStudent.jsp">
                    <input type="hidden" name="studentCode" value="<%=studentCode.get(i)%>">
                    <td><input type="submit" name="validate" value="Validate"></td>
                </form>

                <form  method ="post" action="RejectStudent.jsp">
                    <input type="hidden" name="studentCode" value="<%=studentCode.get(i)%>">
                    <td><input type="submit" name="Reject" value="Reject"></td>
                </form>

                <form  method ="post" action="DisableStudent.jsp">
                    <input type="hidden" name="studentCode" value="<%=studentCode.get(i)%>">
                    <td><input type="submit" name="Disable" value="Disable"></td>
                </form>

                <form  method ="post" action="RemoveStudent.jsp">
                    <input type="hidden" name="studentCode" value="<%=studentCode.get(i)%>">
                    <td><input type="submit" name="Remove" value="Remove"></td>
                </form>

                <%
                        i++;
                    }
                %>

            </table>
        </center>
    </body>
</html>
