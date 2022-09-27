<%-- 
    Document   : AddExam
    Created on : May 11, 2011, 9:07:06 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Exam</title>
    </head>
    <body>
        <h1>Add Exam !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
                <%
                    try {
                        String examName = request.getParameter("examname");
                        String description = request.getParameter("description");
                        String deptCode = request.getParameter("deptcode");

                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                        Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                        Statement stmt = con.createStatement();

                        ResultSet rs = stmt.executeQuery("Select * From SPMExamMaster Where (ExamName='" + examName + "' And DeptCode=" + deptCode + ");");
                        if (rs.next()) {
                            session.setAttribute("Error", "Addition Unsuccessfull : Exam already Exist !");
                            session.setAttribute("Info", "");
                            response.sendRedirect("ManageExams.jsp?DepartmentCode=" + deptCode);

                        } else {
                            int iExamCode = 0;                            
                            rs = stmt.executeQuery("Select Max(SPMExamMaster.ExamCode) As ECode From SPMExamMaster ;");
                            if (rs.next()) {
                                iExamCode = rs.getInt("ECode") + 1;
                            } else {
                                iExamCode = 1;
                            }

                            int i = stmt.executeUpdate("Insert Into SPMExamMaster Values (" + iExamCode + ",'" + examName + "'," + deptCode + ",'" + description + "');");

                            if (i > 0) {
                                session.setAttribute("Info", "Successfully Added !");
                                session.setAttribute("Error", "");
                                response.sendRedirect("ManageExams.jsp?DepartmentCode=" + deptCode);
                            } else {
                                session.setAttribute("Error", "Addition Unsuccessfull !");
                                session.setAttribute("Info", "");
                                response.sendRedirect("ManageExams.jsp?DepartmentCode=" + deptCode);
                            }
                        }
                        stmt.close();
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }
        %>
    </body>
</html>
