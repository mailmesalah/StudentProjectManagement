<%-- 
    Document   : CreateProject
    Created on : May 21, 2011, 10:05:55 AM
    Author     : Salah
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Project</title>
    </head>
    <body>
        <h1>Create Project !</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("S")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
        
        String studentCode = request.getParameter("studentcode");
        String groupCode = request.getParameter("groupcode");
        String projectDescription = request.getParameter("project");
        
        try{
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();
            Calendar c = Calendar.getInstance();
            String d=DateFormat.getDateInstance(DateFormat.DATE_FIELD).format(c.getTime());
            int records=stmt.executeUpdate("Insert Into SPMCurrentProject Values("+groupCode+",'"+projectDescription+"',to_date('"+d+"','mm/dd/yyyy'),'PC');");
            
            if(records>0){
                session.setAttribute("Info", "Successfully Project Created !");
                response.sendRedirect("StudentProfile.jsp?studentCode="+studentCode);
            }else{
                session.setAttribute("Error", "Project Creation Failed !");
                response.sendRedirect("StudentProfile.jsp?studentCode="+studentCode);
            }
            stmt.close();
            
        }catch(Exception e){System.out.println(e.toString());}
        %>
    </body>
</html>
