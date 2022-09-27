<%-- 
    Document   : ManageDepartments
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
        <title>Manage Departments</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Manage Departments!</h1><hr>
        <a href="AdminProfile.jsp">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("A")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            String errors=(String)session.getAttribute("Error");
            String info =(String)session.getAttribute("Info");
            if(errors!=null){
                out.println(errors);
            }
            if(info!=null){
                out.println(info);
            }
            //Reset the session variables
            session.setAttribute("Error", "");
            session.setAttribute("Info", "");
        %>
        <table border="1">
            <pre>
            <tr><td>  Department Code   </td><td>     Department Name        </td><td>            Description             </td><td>  Action  </td></tr>
            </pre>
            <%
                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                        Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                        Statement stmt = con.createStatement();

                        ResultSet rs = stmt.executeQuery("Select * From SPMDepartments Order By DeptName;");
                        int i = 0;
                        while (rs.next()) {
            %>
            <form name="form<%=i%>" method="get" action="RemoveDepartment.jsp">
                <%
                                            int deptCode = rs.getInt("DeptCode");
                                            out.println("<input type=\"hidden\" name=\"DeptCode\" value=\"" + deptCode + "\">");
                                            out.println("<tr><td>" + deptCode + "</td><td>" + rs.getString("DeptName") + "</td><td>" + rs.getString("Description") + "</td><td><input type=\"submit\" name=\"Remove\" value=\"  Remove   \"></td></tr>");
                                            i = i + 1;
                %>
            </form>
            <%
                        }
                        rs.close();
                        stmt.close();
            %>
            <form name="formAdd" method="get" action="AddDepartment.jsp">
                <tr><td><input type="text" name="DeptCode"></td><td><input type="text" name="DeptName"></td><td><input type="text" name="Description"></td><td><input type="submit" name="Add" value="     Add     "></td></tr>
            </form>
        </table>
        </center>
    </body>
</html>
