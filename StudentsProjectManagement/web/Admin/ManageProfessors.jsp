<%-- 
    Document   : ManageProfessors
    Created on : Apr 4, 2011, 3:26:44 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Professors</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Manage Professors!</h1><hr>
        <a href="AdminProfile.jsp">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><hr>
        <script type="text/javascript"  language="java">
            function showDetails(professorCode){
                openWindow = window.open("", "", "height=600, width=700,toolbar=no,scrollbars="+scroll+",menubar=no");
                openWindow.location="ProfessorDetails.jsp?professorCode="+professorCode+"&DeptCode=&DeptName=";
            }
        </script>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("A")){
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
            <pre>
            <tr><td>Professor Code</td><td>Professor</td><td>Phone</td><td>Status</td><td>Details</td><td>Validate</td><td>Reject</td><td>Disable</td><td>Remove</td></tr>
            </pre>
            <%
                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                        Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                        Statement stmt = con.createStatement();

                        ResultSet rs = stmt.executeQuery("Select * From SPMProfessors Order By ProfessorName;");
                        int i = 0;
                        while (rs.next()) {
            %>
            <form  name="form<%=i%>" method="get">
                <%
                                            int professorCode = rs.getInt("ProfessorCode");
                                            out.println("<input type=\"hidden\" name=\"professorCode\" value=\"" + professorCode + "\">");
                                            String professorName = rs.getString("ProfessorName");
                                            String phone = rs.getString("Phone");
                                            String status = rs.getString("Status");
                                            out.println("<tr><td>" + professorCode + "</td><td>" + professorName + "</td><td>" + phone + "</td><td>" + (status.equals("R")?"Registered":(status.equals("V")?"Validated":(status.equals("J")?"Rejected":"Disabled"))) + "</td><td><input type=\"button\" name=\"Details\" value=\"  Details   \" onclick=\"showDetails("+ professorCode +")\"></td>");
                                            i = i + 1;
                %>
            </form>
            <%              //Validate button
                            out.println("<form name=\"form" + i + "\" method =\"get\" action=\"ValidateProfessor.jsp\">");
                            out.println("<input type=\"hidden\" name=\"professorCode\" value=\"" + professorCode + "\">");
                            out.println("<td><input type=\"submit\" name=\"validate\" value=\"Validate\"></td>");
                            out.println("</form>");
                            i = i + 1;

                            //Reject button
                            out.println("<form name=\"form" + i + "\" method =\"get\" action=\"RejectProfessor.jsp\">");
                            out.println("<input type=\"hidden\" name=\"professorCode\" value=\"" + professorCode + "\">");
                            out.println("<td><input type=\"submit\" name=\"Reject\" value=\"Reject\"></td>");
                            out.println("</form>");
                            i = i + 1;

                            //Disable button
                            out.println("<form name=\"form" + i + "\" method =\"get\" action=\"DisableProfessor.jsp\">");
                            out.println("<input type=\"hidden\" name=\"professorCode\" value=\"" + professorCode + "\">");
                            out.println("<td><input type=\"submit\" name=\"Disable\" value=\"Disable\"></td>");
                            out.println("</form>");
                            i = i + 1;

                            //Remove button
                            out.println("<form name=\"form" + i + "\" method =\"get\" action=\"RemoveProfessor.jsp\">");
                            out.println("<input type=\"hidden\" name=\"professorCode\" value=\"" + professorCode + "\">");
                            out.println("<td><input type=\"submit\" name=\"Remove\" value=\"Remove\"></td>");
                            out.println("</form>");
                            i = i + 1;
                        }
                        rs.close();
                        stmt.close();
            %>

        </table>
        </center>
    </body>
</html>
