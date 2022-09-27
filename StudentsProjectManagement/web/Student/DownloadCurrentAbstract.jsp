<%-- 
    Document   : DownloadCurrentAbstract
    Created on : Jun 1, 2011, 5:00:03 AM
    Author     : Salah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.FileInputStream" %>
<%@page import="java.io.BufferedInputStream"  %>
<%@page import="java.io.File"  %>
<%@page import="java.io.IOException" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String groupCode = session.getAttribute("GroupCode") + "";
            // you  can get your base and parent from the database            
            String filename = groupCode + ".doc";
            String filepath = application.getInitParameter("CurrentProjectAbstract") + "\\";

            BufferedInputStream buf = null;
            ServletOutputStream myOut = null;

            try {

                myOut = response.getOutputStream();
                File myfile = new File(filepath + filename);

                //set response headers
                response.setContentType("text/plain");
                response.addHeader("Content-Disposition", "attachment; filename=" + filename);
                response.setContentLength((int) myfile.length());

                FileInputStream input = new FileInputStream(myfile);
                buf = new BufferedInputStream(input);
                int readBytes = 0;

                //read from the file; write to the ServletOutputStream
                while ((readBytes = buf.read()) != -1) {
                    myOut.write(readBytes);
                }

            } catch (IOException ioe) {

                throw new ServletException(ioe.getMessage());

            } finally {

                //close the input/output streams
                if (myOut != null) {
                    myOut.close();
                }
                if (buf != null) {
                    buf.close();
                }

            }

        %>

    </body>
</html>
