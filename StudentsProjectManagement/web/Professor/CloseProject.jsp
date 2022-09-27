<%-- 
    Document   : CloseProject
    Created on : May 21, 2011, 8:13:40 AM
    Author     : Salah
--%>

<%@page import="java.io.File"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.nio.file.Files;" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Close Project</title>
    </head>
    <body>
        <h1>Close Project!</h1><hr>
        <%
            String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
            String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
            if (uniqueID.equals("") || !userType.equals("P")) {
                response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
            }
        %>
        <%
            String batchCode = request.getParameter("batchcode");
            String batchName = request.getParameter("batchname");
            String deptCode = request.getParameter("deptcode");
            String groupCode = request.getParameter("groupcode");
            String groupName = request.getParameter("groupname");
            int limit = Integer.parseInt(request.getParameter("limit"));
            String startDate = request.getParameter("startdate");
            String projectDescription = request.getParameter("projectdescription");
            Calendar c = Calendar.getInstance();

            String studentCode[] = new String[limit];
            int percent[] = new int[limit];
            String status[] = new String[limit];
            int i = 0;
            while (i < limit) {
                studentCode[i] = request.getParameter("studentcode" + i);
                percent[i] = Integer.parseInt(request.getParameter("percent" + i));
                if (percent[i] > 100) {
                    session.setAttribute("Error", "Give Valid Value in Percent Column !");
                    response.sendRedirect("ShowProject?batchcode=" + batchCode + "&batchname=" + batchName + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                }
                status[i] = request.getParameter("status" + i);
                i++;
            }

            try {
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();
                int projectCode = 0;
                ResultSet rs = stmt.executeQuery("Select Max(ProjectCode) As PCode From SPMProjectsCompleted;");
                if (rs.next()) {
                    projectCode = rs.getInt("PCode") + 1;
                } else {
                    projectCode = 1;
                }
                i = 0;

                String d = DateFormat.getDateInstance(DateFormat.DATE_FIELD).format(c.getTime());
                while (i < limit) {
                    int records = stmt.executeUpdate("Insert Into SPMProjectsCompleted Values(" + projectCode + ",'" + projectDescription + "',to_date('" + startDate + "','yyyy-mm-dd'),to_date('" + d + "','mm/dd/yyyy')," + percent[i] + ",'" + status[i] + "'," + studentCode[i] + ");");
                    try {
                        File source = new File(application.getInitParameter("CurrentProjectAbstract") + "\\" + groupCode + ".doc");
                        File destination = new File(application.getInitParameter("CompletedProjectAbstract") + "\\" + projectCode + ".doc");
                        Files.copy(source.toPath(), destination.toPath());
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }
                    try {
                        File source = new File(application.getInitParameter("CurrentProjectReport") + "\\" + groupCode + ".doc");
                        File destination = new File(application.getInitParameter("CompletedProjectReport") + "\\" + projectCode + ".doc");
                        Files.copy(source.toPath(), destination.toPath());
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }
                    ++i;
                    ++projectCode;
                }

                int records = stmt.executeUpdate("Delete From SPMCurrentProject Where (GroupCode=" + groupCode + ");");

                session.setAttribute("Info", "Successfully Project Closed !");
                response.sendRedirect("ShowProject.jsp?batchcode=" + batchCode + "&batchname=" + batchName + "&deptcode=" + deptCode + "&groupcode=" + groupCode + "&groupname=" + groupName);
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
    </body>
</html>
