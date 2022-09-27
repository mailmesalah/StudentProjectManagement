<%-- 
    Document   : StudentRegister
    Created on : Apr 3, 2011, 7:59:17 PM
    Author     : Sely
--%>

<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Register</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
            <h1>Student Register!</h1><hr>
            <a href="/StudentsProjectManagement/Login.jsp">Home</a>

            <script type="text/javascript"  language="java">
                function showAvailablityWindow(){
                    var userName = document.getElementById('Username');
                    openWindow = window.open("", "", "height=600, width=700,toolbar=no,scrollbars="+scroll+",menubar=no");
                    openWindow.location="CheckIfUsernameAvailable.jsp?username="+userName.value;
                }

                function changeCode(){
                <%
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("Select Count(*) as Count From SPMDepartments ;");
                    int recordCount = 0;
                    if (rs.next()) {
                        recordCount = rs.getInt("Count");
                    }
                    rs.close();
                    rs = stmt.executeQuery("Select SPMDepartments.DeptCode,SPMDepartments.DeptName From SPMDepartments Order By SPMDepartments.DeptName ;");
                    int deptCodeArray[] = new int[recordCount];
                    String deptNameArray[] = new String[recordCount];
                    int i = 0;
                    while (rs.next()) {
                        deptCodeArray[i] = rs.getInt("DeptCode");
                        deptNameArray[i] = rs.getString("DeptName");
                        i = i + 1;
                    }
                    stmt.close();
                %>
                        var deptCode = new Array(<%=deptCodeArray.length%>);
                <%
                    for (int k = 0; k < deptCodeArray.length; k++) {
                %>
                        deptCode[<%=k%>] = <%=deptCodeArray[k]%>;
                <%
                    }
                %>
                        var index = document.form.SelectDeptName.selectedIndex;
                        document.form.deptcode.value=deptCode[index];                            
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

            <pre>

            </pre>
            <table border="1">
                <form  name="form" method="post" action="RegisterNewStudent.jsp">

                    <tr><td>Username</td><td>:</td><td><input id="Username" type="text" name="username" value="" size="30"></td><td><input type="button" name="check" value="Check for Availability" onclick="showAvailablityWindow()"></td></tr>
                    <tr><td>Password</td><td>:</td><td><input type="password" name="password" value="" size="30"></td><td></td></tr>
                    <tr><td>Re Enter Password</td><td>:</td><td><input type="password" name="repassword" value="" size="30"></td><td></td></tr>
                    <tr><td></td><td></td><td></td><td></td></tr>
                    <tr><td>Register No</td><td>:</td><td><input type="text" name="registerno" value="" size="30"></td><td></td></tr>
                    <tr><td>Student Name</td><td>:</td><td><input type="text" name="studentname" value="" size="30"></td><td></td></tr>
                    <tr><td>Department</td><td>:</td><td>
                            <select  name="SelectDeptCode">
                                <%

                                    for (int j = 0; j < deptNameArray.length; j++) {
                                        out.println("<option value=\"" + deptCodeArray[j] + "\">" + deptNameArray[j]);
                                    }

                                %>
                            </select>
                        </td><td></td></tr>
                    <tr><td>Sex</td><td>:</td><td>
                            <select id="Sex" name="sex">
                                <option value="M">Male</option>
                                <option value="F">Female</option>
                            </select>
                        </td><td></td></tr>
                    <tr><td>Date Of Birth</td><td>:</td><td>
                            <select name="day">
                                <%for (int k = 1; k <= 31; k++) {%>
                                <option value="<%=k%>"><%=k%></option>
                                <%}%>
                            </select>
                            <select name="month">
                                <%for (int k = 1; k <= 12; k++) {%>
                                <option value="<%=k%>"><%=k%></option>
                                <%}%>
                            </select>
                            <select name="year">
                                <%for (int k = (Calendar.getInstance()).get(Calendar.YEAR) - 30; k <= (Calendar.getInstance()).get(Calendar.YEAR) - 15; k++) {%>
                                <option value="<%=k%>"><%=k%></option>
                                <%}%>
                            </select>
                        </td><td></td></tr>
                    <input type="hidden" name="deptcode" value="<%=deptCodeArray.length > 0 ? deptCodeArray[0] : ""%>">
                    <tr><td>Email ID</td><td>:</td><td><input type="text" name="email" value="" size="30"></td><td></td></tr>
                    <tr><td>Address</td><td>:</td><td><input type="text" name="address1" value="" size="30"></td><td></td></tr>
                    <tr><td></td><td>:</td><td><input type="text" name="address2" value="" size="30"></td><td></td></tr>
                    <tr><td></td><td>:</td><td><input type="text" name="address3" value="" size="30"></td><td></td></tr>
                    <tr><td>Phone</td><td>:</td><td><input type="text" name="phone" value="" size="30"></td><td></td></tr>
                    <tr><td>Remarks</td><td>:</td><td><input type="text" name="remarks" value="" size="30"></td><td></td></tr>
                    <tr><td></td><td>:</td><td><input type="submit" name="Submit" value="Submit"></td><td></td></tr>
                </form>
            </table>
        </center>
    </body>
</html>
