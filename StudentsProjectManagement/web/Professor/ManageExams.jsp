<%-- 
    Document   : ManageExams
    Created on : Apr 30, 2011, 12:34:34 AM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Exams</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Manage Exams !</h1><hr>
        <a href="SelectDepartmentForExams.jsp">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
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
        %>
        <table border="1">
            <tr><td>Exam Name</td><td>Description</td><td>Show</td><td>Action</td></tr>            
            <%
                        String deptCode = request.getParameter("DepartmentCode");
                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                        Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                        Statement stmt = con.createStatement();

                        ResultSet rs = stmt.executeQuery("Select * From SPMExamMaster Where(DeptCode="+deptCode+") Order By ExamName;");
                        int i = 0;
                        while (rs.next()) {
                            int examCode = rs.getInt("ExamCode");
                            String examName = rs.getString("ExamName");
                            String description = rs.getString("Description");
            %>
            <tr><td><%=examName%></td>
                <td><%=description%></td>
                <td><form name="form<%=i++%>" method="get" action="ManageExamDetails.jsp">
                        <input type="hidden" name="examname" value="<%=examName%>">
                        <input type="hidden" name="examcode" value="<%=examCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="Show Exam Details">
                    </form></td>                
                <td><form name="form<%=i++%>" method="get" action="RemoveExam.jsp">
                        <input type="hidden" name="examcode" value="<%=examCode%>">
                        <input type="hidden" name="deptcode" value="<%=deptCode%>">
                        <input type="submit" name="submit" value="  Remove  ">
                    </form></td>
            </tr>
            <%
                        }
                        rs.close();
                        stmt.close();
            %>
            <form name="formAdd" method="get" action="AddExam.jsp">
                <tr><td><input type="text" name="examname" size="30"></td>
                    <td><input type="text" name="description" size="30"></td>
                    <td><input type="hidden" name="deptcode" value="<%=deptCode%>"></td>                    
                    <td><input type="submit" name="Add" value="     Add     "></td>
                </tr>
            </form>
        </table>
        </center>
    </body>
</html>
