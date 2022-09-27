<%-- 
    Document   : AddAnswer
    Created on : May 12, 2011, 12:00:16 AM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Answer</title>
    </head>
    <body>
        <h1>Add Answer !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            try {
                String answer = request.getParameter("answer");
                String questionCode = request.getParameter("questioncode");
                String examCode = request.getParameter("examcode");
                String examName = request.getParameter("examname");
                String deptCode = request.getParameter("deptcode");
                boolean correctAnswer = request.getParameter("correctanswer").equals("true")?true:false;

                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

                ResultSet rs = stmt.executeQuery("Select * From SPMAnswers Where (Answer='" + answer + "' And QuestionCode=" + questionCode + ");");
                if (rs.next()) {
                    session.setAttribute("Error", "Addition Unsuccessfull : Answer already Exist !");
                    session.setAttribute("Info", "");
                    response.sendRedirect("ManageExamDetails.jsp?deptcode=" + deptCode+"&examname="+examName+"&examcode="+examCode);

                } else {
                    int iAnswerCode = 0;
                    
                    rs = stmt.executeQuery("Select Max(SPMAnswers.AnswerCode) As ACode From SPMAnswers ;");
                    if (rs.next()) {
                        iAnswerCode = rs.getInt("ACode") + 1;
                    } else {
                        iAnswerCode = 1;
                    }
                    
                    if(correctAnswer){
                        int j = stmt.executeUpdate("Update SPMAnswers Set CorrectAnswer=0 Where (QuestionCode="+questionCode+");");
                    }
                    
                    int i = stmt.executeUpdate("Insert Into SPMAnswers Values (" + questionCode + "," + iAnswerCode + ",'" + answer + "',"+(correctAnswer?1:0)+");");
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
