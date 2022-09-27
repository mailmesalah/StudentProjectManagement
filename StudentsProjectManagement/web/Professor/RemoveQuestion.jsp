<%-- 
    Document   : RemoveQuestion
    Created on : May 11, 2011, 10:53:46 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove Question</title>
    </head>
    <body>
        <h1>Remove Question !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            String deptCode = request.getParameter("deptcode");
            String questionCode = request.getParameter("questioncode");
            String examCode = request.getParameter("examcode");
            String examName = request.getParameter("examname");

            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("Select * From SPMAnswers Where (QuestionCode=" + questionCode + ");");
            if (rs.next()) {
                rs.close();
                session.setAttribute("Error", "Deletion Unsuccessfull: Remove Answers First !");
                session.setAttribute("Info", "");
                response.sendRedirect("ManageExamDetails.jsp?deptcode=" + deptCode+"&examname="+examName+"&examcode="+examCode);
            } else {

                int i = stmt.executeUpdate("Delete From SPMQuestions Where (QuestionCode=" + questionCode + " And ExamCode=" + examCode + ");");
                if (i > 0) {
                    session.setAttribute("Info", "Successfully Removed !");
                    session.setAttribute("Error", "");
                    response.sendRedirect("ManageExamDetails.jsp?deptcode=" + deptCode+"&examname="+examName+"&examcode="+examCode);
                } else {
                    session.setAttribute("Error", "Deletion Unsuccessfull !");
                    session.setAttribute("Info", "");
                    response.sendRedirect("ManageExamDetails.jsp?deptcode=" + deptCode+"&examname="+examName+"&examcode="+examCode);
                }
            }
            stmt.close();
        %>
    </body>
</body>
</html>
