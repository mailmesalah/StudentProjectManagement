<%-- 
    Document   : AddDepartmentToProfessor
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
        <title>Add Department to Professor </title>
    </head>
    <body>
        <h1>Adding to department !</h1>
        <%
            String deptCode= request.getParameter("SelectDeptCode");            
            //String deptName= request.getParameter("SelectDeptName");
            String role= request.getParameter("Role");
            String professorCode= request.getParameter("ProfessorCode");
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();
            try{
            ResultSet rs = stmt.executeQuery("Select * From SPMDeptOfProfessors Where SPMDeptOfProfessors.DeptCode="+deptCode+" And SPMDeptOfProfessors.ProfessorCode="+professorCode+";");
            if(rs.next()){
                session.setAttribute("Error", "The Department already Exist !");
                session.setAttribute("Info", "");
                response.sendRedirect("ProfessorDetails.jsp?DeptCode=&DeptName=&professorCode="+professorCode);
            }else{
                try{
                int i = stmt.executeUpdate("Insert Into SPMDeptOfProfessors Values ("+professorCode+","+deptCode+",'"+role+"');");
                
                if(i>0){
                    session.setAttribute("Error", "");
                    session.setAttribute("Info", "Successfully Added !");
                    response.sendRedirect("ProfessorDetails.jsp?DeptCode=&DeptName=&professorCode="+professorCode);
                }else{
                    session.setAttribute("Error", "Unknown Error !");
                    session.setAttribute("Info", "");
                    response.sendRedirect("ProfessorDetails.jsp?DeptCode=&DeptName=&professorCode="+professorCode);
                }
                }catch(Exception e){out.println(e.toString());}
            }
            }catch(Exception e){out.println(e.toString());}
            stmt.close();
        %>
    </body>
</html>
