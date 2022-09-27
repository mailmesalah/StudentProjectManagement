<%-- 
    Document   : RegisterNewStudent
    Created on : Apr 23, 2011, 5:11:52 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register New Student</title>
    </head>
    <body>
        <h1>Registering New Student!</h1>

        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String registerNo = request.getParameter("registerno");
            String studentName = request.getParameter("studentname");
            String deptCode = request.getParameter("SelectDeptCode");
            String sex = request.getParameter("sex");
            String dobDay = request.getParameter("day");
            String dobMonth = request.getParameter("month");
            String dobYear = request.getParameter("year");
            String email = request.getParameter("email");
            String address1 = request.getParameter("address1");
            String address2 = request.getParameter("address2");
            String address3 = request.getParameter("address3");
            String phone = request.getParameter("phone");
            String remarks = request.getParameter("remarks");
            System.out.println(password.equals(""));
           
            /**
             * Check if inputs are given correctly here.
             */
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();
            try {

                ResultSet rs = stmt.executeQuery("Select * From SPMAuthentication Where SPMAuthentication.Username = '" + username + "';");
                if (!password.equals("") && !registerNo.equals("") && !studentName.equals("") && !email.equals("")) {


                    if (rs.next()) {
                        session.setAttribute("Error", "Username already Exist !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("StudentRegister.jsp");
                    } else {
                        try {
                            int uniqueID = 1;
                            int studentCode = 1;
                            try {
                                rs = stmt.executeQuery("Select Max(SPMAuthentication.UniqueID) From SPMAuthentication Where SPMAuthentication.UserType = 'S';");
                            } catch (Exception e) {
                                System.out.println(e.toString());
                            }
                            if (rs.next()) {
                                uniqueID = rs.getInt(1) + 1;
                            }
                            try {
                                rs = stmt.executeQuery("Select Max(SPMStudentMaster.UniqueID) From SPMStudentMaster;");
                            } catch (Exception e) {
                                System.out.println(e.toString());
                            }
                            if (rs.next()) {
                                studentCode = rs.getInt(1) + 1;
                            }
                            int i = 0;
                            try {
                                i = stmt.executeUpdate("Insert Into SPMAuthentication Values ('S'," + uniqueID + ",'" + username + "','" + password + "'," + studentCode + ");");
                            } catch (Exception e) {
                                System.out.println(e.toString());
                            }
                            int j = 0;
                            try {
                                j = stmt.executeUpdate("Insert Into SPMStudentMaster Values (" + studentCode + ",'" + registerNo + "','" + studentName + "'," + deptCode + ",'" + sex + "',to_date('" + dobMonth + "/" + dobDay + "/" + dobYear + "','mm/dd/yyyy'),'" + address1 + "','" + address2 + "','" + address3 + "','" + phone + "','" + remarks + "','" + email + "','R');");
                            } catch (Exception e) {
                                System.out.println(e.toString());
                            }

                            if (i > 0 && j > 0) {
                                session.setAttribute("Error", "");
                                session.setAttribute("Info", "Successfully Registered !");
                                response.sendRedirect("RegistrationCompleted.jsp");
                            } else {
                                session.setAttribute("Error", "Unknown Error !");
                                session.setAttribute("Info", "");
                                response.sendRedirect("StudentRegister.jsp");
                            }
                        } catch (Exception e) {
                            out.println(e.toString());
                        }
                    }
                } else {                    
                    session.setAttribute("Error", "Please Enter needed Datas  !");
                    session.setAttribute("Info", "");
                    response.sendRedirect("StudentRegister.jsp");
                }
                rs.close();
                stmt.close();
            } catch (Exception e) {
                out.println(e.toString());
            }
        %>
    </body>
</html>
