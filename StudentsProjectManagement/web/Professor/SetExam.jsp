<%-- 
    Document   : SetExam
    Created on : May 20, 2011, 9:56:17 PM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Set Exam</title>
    </head>
    <body>
        <h1>Set Exam !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            String batchCode = request.getParameter("batchcode");
            String batchName = request.getParameter("batchname");
            String deptCode = request.getParameter("deptcode");
            String examCode = request.getParameter("examcode");
            String questionsNo = request.getParameter("questionsno");
            String examDuration = request.getParameter("examduration");
            String minimumPercent = request.getParameter("minimumpercent");
            try {


                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();
                
                ResultSet rs = stmt.executeQuery("Select SPMExamMaster.ExamName,SPMCurrentExam.* From SPMCurrentExam,SPMExamMaster Where(SPMCurrentExam.BatchCode=" + batchCode + " And SPMExamMaster.ExamCode=SPMCurrentExam.ExamCode);");
                if(rs.next()){
                    session.setAttribute("Error", "Exam Already Exist !");
                    response.sendRedirect("OnlineTestNotification.jsp?deptcode=" + deptCode + "&batchcode=" + batchCode + "&batchname=" + batchName);
                }
                
                int records = stmt.executeUpdate("Insert Into SPMCurrentExam Values (" + batchCode + "," + examCode + "," + questionsNo + "," + examDuration + "," + minimumPercent + ");");
                if (records > 0) {
                    session.setAttribute("Info", "Successfully Set Exam !");
                    response.sendRedirect("OnlineTestNotification.jsp?deptcode=" + deptCode + "&batchcode=" + batchCode + "&batchname=" + batchName);
                } else {
                    session.setAttribute("Error", "Error Occured !");
                    response.sendRedirect("OnlineTestNotification.jsp?deptcode=" + deptCode + "&batchcode=" + batchCode + "&batchname=" + batchName);
                }
                stmt.close();

            } catch (Exception e) {
                System.out.println(e.toString());
                session.setAttribute("Error", "Error Occured !");
                response.sendRedirect("OnlineTestNotification.jsp?deptcode=" + deptCode + "&batchcode=" + batchCode + "&batchname=" + batchName);
            }
        %>
    </body>
</html>
