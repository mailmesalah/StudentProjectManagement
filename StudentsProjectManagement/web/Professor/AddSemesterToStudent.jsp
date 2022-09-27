<%-- 
    Document   : AddSemesterToStudent
    Created on : Apr 5, 2011, 4:21:20 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Semester To Student </title>
    </head>
    <body>
        <h1>Add Semester To Student !</h1>
        <%
            String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
            String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
            if (uniqueID.equals("") || !userType.equals("P")) {
                response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
            }
        %>
        <%
            String semesterName = request.getParameter("semestername");
            String semesterDate = request.getParameter("semesterdate");
            String studentCode = request.getParameter("studentcode");

            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();
            try {
                
                ResultSet rs = stmt.executeQuery("Select SPMSemesterMaster.* From SPMSemesterMaster Where (SPMSemesterMaster.SemesterName='" + semesterName + "') And (SPMSemesterMaster.SemesterExamDate=to_date('" + semesterDate + "','mm/dd/yyyy')) And (SPMSemesterMaster.RegisterNo='" + studentCode + "');");
                
                if (rs.next()) {
                    session.setAttribute("Error", "Semester Already Created for the Student !");
                    session.setAttribute("Info", "");
                    response.sendRedirect("StudentDetails.jsp?studentCode=" + studentCode);
                } else {
                    try {
                        int i = stmt.executeUpdate("Insert Into SPMSemesterMaster Values ('" + studentCode + "','" + semesterName + "',to_date('" + semesterDate + "','mm/dd/yyyy'));");

                        if (i > 0) {
                            session.setAttribute("Error", "");
                            session.setAttribute("Info", "Successfully Added !");
                            response.sendRedirect("StudentDetails.jsp?studentCode=" + studentCode);
                        } else {
                            session.setAttribute("Error", "Unknown Error !");
                            session.setAttribute("Info", "");
                            response.sendRedirect("StudentDetails.jsp?studentCode=" + studentCode);
                        }
                    } catch (Exception e) {
                        stmt.close();
                        out.println(e.toString());
                    }
                }
            } catch (Exception e) {
                stmt.close();
                out.println(e.toString());
            }
            stmt.close();
        %>
    </body>
</html>
