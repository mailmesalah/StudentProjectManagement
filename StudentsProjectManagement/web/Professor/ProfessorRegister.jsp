<%-- 
    Document   : ProfessorRegister
    Created on : Apr 3, 2011, 7:58:52 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Professor Register</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Professor Register!</h1><hr>
        <a href="/StudentsProjectManagement/Login.jsp">Home</a><br>
        <script type="text/javascript"  language="java">
            function showAvailablityWindow(){
                var userName = document.getElementById('Username');
                openWindow = window.open("", "", "height=600, width=700,toolbar=no,scrollbars="+scroll+",menubar=no");
                openWindow.location="CheckIfUsernameAvailable.jsp?username="+userName.value;
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
            <form  name="form" method="post" action="RegisterNewProfessor.jsp">

                <tr><td>Username</td><td>:</td><td><input id="Username" type="text" name="username" value="" size="30"></td><td><input type="button" name="check" value="Check for Availability" onclick="showAvailablityWindow()"></td></tr>
                <tr><td>Password</td><td>:</td><td><input type="password" name="password" value="" size="30"></td><td></td></tr>
                <tr><td>Re Enter Password</td><td>:</td><td><input type="password" name="repassword" value="" size="30"></td><td></td></tr>
                <tr><td></td><td></td><td></td><td></td></tr>
                <tr><td>Professor Name</td><td>:</td><td><input type="text" name="professorname" value="" size="30"></td><td></td></tr>
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
