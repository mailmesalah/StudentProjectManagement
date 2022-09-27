<%-- 
    Document   : AddQuestion
    Created on : May 11, 2011, 10:28:26 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Question</title>
    </head>
    <body>
        <h1>Add Question !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            try {
                String question = request.getParameter("question");
                String examCode = request.getParameter("examcode");
                String examName = request.getParameter("examname");
                String deptCode = request.getParameter("deptcode");

                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

                ResultSet rs = stmt.executeQuery("Select * From SPMQuestions Where (Question='" + question + "' And ExamCode=" + examCode + ");");
                if (rs.next()) {
                    session.setAttribute("Error", "Addition Unsuccessfull : Question already Exist !");
                    session.setAttribute("Info", "");
                    response.sendRedirect("ManageExamDetails.jsp?deptcode=" + deptCode+"&examname="+examName+"&examcode="+examCode);

                } else {
                    int iQuestionCode = 0;
                    rs = stmt.executeQuery("Select Max(SPMQuestions.QuestionCode) As QCode From SPMQuestions ;");
                    if (rs.next()) {
                        iQuestionCode = rs.getInt("QCode") + 1;
                    } else {
                        iQuestionCode = 1;
                    }

                    int i = stmt.executeUpdate("Insert Into SPMQuestions Values (" + examCode + "," + iQuestionCode + ",'" + question + "');");
                    
                    if (i > 0) {
                        session.setAttribute("Info", "Successfully Added !");
                        session.setAttribute("Error", "");
                        response.sendRedirect("ManageExamDetails.jsp?deptcode=" + deptCode+"&examname="+examName+"&examcode="+examCode);
                    } else {
                        session.setAttribute("Error", "Addition Unsuccessfull !");
                        session.setAttribute("Info", "");
                        response.sendRedirect("ManageExamDetails.jsp?deptcode=" + deptCode+"&examname="+examName+"&examcode="+examCode);
                    }
                }
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
    </body>
</html>
