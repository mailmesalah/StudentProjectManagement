<%-- 
    Document   : RemoveDepartmentFromProfessor
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
        <title>Remove Department From Professor</title>
    </head>
    <body>
        <h1>Remove Department From Professor!</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("A")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            String deptCode= request.getParameter("SelectDeptCode");
            String professorCode= request.getParameter("ProfessorCode");            

            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();
            try{
            ResultSet rs = stmt.executeQuery("Select * From SPMDeptOfProfessors Where SPMDeptOfProfessors.DeptCode="+deptCode+" And SPMDeptOfProfessors.ProfessorCode="+professorCode+";");
            if(rs.next()){
                try{
                int i = stmt.executeUpdate("Delete From SPMDeptOfProfessors Where ProfessorCode="+professorCode+" And DeptCode="+deptCode+";");

                if(i>0){
                    session.setAttribute("Error", "");
                    session.setAttribute("Info", "Successfully Removed !");
                    response.sendRedirect("ProfessorDetails.jsp?DeptCode=&DeptName=&professorCode="+professorCode);
                }else{
                    session.setAttribute("Error", "Unknown Error !");
                    session.setAttribute("Info", "");
                    response.sendRedirect("ProfessorDetails.jsp?DeptCode=&DeptName=&professorCode="+professorCode);
                }
                }catch(Exception e){out.println(e.toString());}
            }else{
                session.setAttribute("Error", "The Department doesn't Exist !");
                session.setAttribute("Info", "");
                response.sendRedirect("ProfessorDetails.jsp?DeptCode=&DeptName=&professorCode="+professorCode);
            }
            }catch(Exception e){out.println(e.toString());}
            stmt.close();
        %>
    </body>
</html>
