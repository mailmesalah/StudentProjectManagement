<%-- 
    Document   : TestUpload
    Created on : May 23, 2011, 9:22:57 PM
    Author     : Salah
--%>


<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.io.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form name="form1" method="post" action="CreateTables.jsp">
            <input type="submit" name="submit" value="Create Tables">
        </form>                
        <%
        File dir = new File("F:\\wORksHoP\\StudentProjectManagement\\StudentsProjectManagement\\CurrentProject\\Abstract\\1234.doc");
            MultipartParser mp = new MultipartParser(request, 1 * 1024 * 1024);
            com.oreilly.servlet.multipart.Part part;
            while ((part = mp.readNextPart()) != null) {
                String name = part.getName();
                if (part.isParam()) {
                    // it's a parameter part
                    ParamPart paramPart = (ParamPart) part;
                    String value = paramPart.getStringValue();
                    out.println("param; name=" + name + ", value=" + value);
                } else if (part.isFile()) {
                    // it's a file part
                    FilePart filePart = (FilePart) part;
                    String fileName = filePart.getFileName();
                    if (fileName != null) {
                        // the part actually contained a file
                        long size = filePart.writeTo(dir);
                        out.println("file; name=" + name + "; filename=" + fileName
                                + ", filePath=" + filePart.getFilePath()
                                + ", content type=" + filePart.getContentType()
                                + ", size=" + size);

                    } else {
                        // the field did not contain a file
                        out.println("file; name=" + name + "; EMPTY");
                    }
                    out.flush();
                }
            }
            //MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request); mrequest.getParameter("fileName");

        %>
    </body>
</html>
