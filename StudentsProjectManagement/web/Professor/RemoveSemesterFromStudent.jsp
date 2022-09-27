<%-- 
    Document   : RemoveSemesterFromStudent
    Created on : Apr 5, 2011, 7:26:44 PM
    Author     : Sely
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Remove Semester From Student</title>
    </head>
    <body>
        <h1>Remove Semester From Student !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("P")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            String semesterName= request.getParameter("semestername");
            String semesterDate= request.getParameter("semesterdate");
            String studentCode= request.getParameter("studentcode");

            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();
            try{
            ResultSet rs = stmt.executeQuery("Select SPMSemesterMaster.* From SPMSemesterMaster Where (SPMSemesterMaster.SemesterName='"+semesterName+"') And (SPMSemesterMaster.SemesterExamDate=to_date('"+semesterDate+"','yyyy/mm/dd')) And (SPMSemesterMaster.RegisterNo='"+studentCode+"');");
            if(rs.next()){
                try{
                    out.println(semesterDate);
                int i = stmt.executeUpdate("Delete From SPMSemesterMaster Where (SPMSemesterMaster.SemesterName='"+semesterName+"') And (SPMSemesterMaster.SemesterExamDate=to_date('"+semesterDate+"','yyyy/mm/dd')) And (SPMSemesterMaster.RegisterNo='"+studentCode+"');");

                if(i>0){
                    session.setAttribute("Error", "");
                    session.setAttribute("Info", "Successfully Removed !");
                    response.sendRedirect("StudentDetails.jsp?studentCode="+studentCode);
                }else{
                    session.setAttribute("Error", "Unknown Error !");
                    session.setAttribute("Info", "");
                    response.sendRedirect("StudentDetails.jsp?studentCode="+studentCode);
                }
                }catch(Exception e){out.println(e.toString());}
            }else{
                session.setAttribute("Error", "The Semester doesn't Exist !");
                session.setAttribute("Info", "");
                response.sendRedirect("StudentDetails.jsp?studentCode="+studentCode);
            }
            }catch(Exception e){out.println(e.toString());}
            stmt.close();
        %>
    </body>
</html>
