<%-- 
    Document   : SubmitReport
    Created on : May 25, 2011, 11:02:15 AM
    Author     : Vaio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.io.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
            String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
            if (uniqueID.equals("") || !userType.equals("S")) {
                response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
            }

        %>
        <%        
            String studentCode = session.getAttribute("studentCode")+"";
            
            try {
                String groupCode = session.getAttribute("GroupCode") + "";

                File dir = new File(application.getInitParameter("CurrentProjectReport") + "\\" + groupCode + ".doc");

                MultipartParser mp = new MultipartParser(request, 1 * 1024 * 1024);
                com.oreilly.servlet.multipart.Part part;
                while ((part = mp.readNextPart()) != null) {
                    String name = part.getName();
                    if (part.isParam()) {
                        // it's a parameter part
                        ParamPart paramPart = (ParamPart) part;
                        String value = paramPart.getStringValue();
                        //out.println("param; name=" + name + ", value=" + value);
                    } else if (part.isFile()) {
                        // it's a file part
                        FilePart filePart = (FilePart) part;
                        String fileName = filePart.getFileName();
                        if (fileName != null) {
                            // the part actually contained a file
                            long size = filePart.writeTo(dir);
                            //out.println("file; name=" + name + "; filename=" + fileName + ", filePath=" + filePart.getFilePath()+ ", content type=" + filePart.getContentType()+ ", size=" + size);

                        } else {
                            // the field did not contain a file
                            //out.println("file; name=" + name + "; EMPTY");
                        }
                        //out.flush();
                    }
                }
                             

                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();
                
                int i = stmt.executeUpdate("Update SPMCurrentProject Set Status='RS' Where (GroupCode=" + groupCode + ");");
                stmt.close();
                session.setAttribute("Info", "Successfully Submited !");
                response.sendRedirect("StudentProfile.jsp?studentCode=" + studentCode);
            } catch (Exception e) {
                session.setAttribute("Error", e.toString());
                response.sendRedirect("StudentProfile.jsp?studentCode=" + studentCode);
            }
        %>
    </body>
</html>
