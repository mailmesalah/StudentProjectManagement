<%-- 
    Document   : SendMessage
    Created on : May 20, 2011, 2:47:27 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Send Message</title>
    </head>
    <body bgcolor="#F0F0F0"><center>       
        <%
            String deptCode = request.getParameter("deptcode");
        %>
        <a href="ManageBatches.jsp?DepartmentCode=<%=deptCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
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
        <%
            String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
            String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
            if (uniqueID.equals("") || !userType.equals("P")) {
                response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
            }
        %>
        <%
            String batchCode = request.getParameter("batchcode");
            String batchName = request.getParameter("batchname");

        %>
        <h1>Send Message !</h1><hr>
        <form name="form1" method="get" action="SendingMessage.jsp">            
            <input name="batchcode" type="hidden" value="<%=batchCode%>"></input>
            <input name="batchname" type="hidden" value="<%=batchName%>"></input>
            <input name="deptcode" type="hidden" value="<%=deptCode%>"></input>

            <table border="1">                
                <tr>
                    <td>To</td>
                    <td><%=batchName%></td>
                </tr>
                <tr>
                    <td>Subject</td>
                    <td><input name="subject" type="text" size="79" value=""></td>
                </tr>
                <tr>
                    <td></td>
                    <td><textarea name="message" cols="60" rows="10"></textarea></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input name="submit" type="submit" value="Send"></td>
                </tr>
            </table>
        </form>
    </center>
    </body>
</html>
