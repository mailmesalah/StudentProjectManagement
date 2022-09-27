<%-- 
    Document   : SendingMessage
    Created on : May 20, 2011, 8:17:29 PM
    Author     : Salah
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@ page import="sun.net.smtp.SmtpClient, java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sending Message</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Successfully Send !</h1><hr>
        <% String deptCode = request.getParameter("deptcode");%>
        <a href="ManageBatches.jsp?DepartmentCode=<%=deptCode%>">Previous</a>|<a href="/StudentsProjectManagement/Login.jsp">Home</a>|<a href="/StudentsProjectManagement/SignOut.jsp">Sign Out</a><br>
        <%
            String uniqueID = ((String) session.getAttribute("UniqueID")) == null ? "" : ((String) session.getAttribute("UniqueID"));
            String userType = ((String) session.getAttribute("UserType")) == null ? "" : ((String) session.getAttribute("UserType"));
            if (uniqueID.equals("") || !userType.equals("P")) {
                response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
            }
        %>
        <%
            String subject = request.getParameter("subject");
            String messageBody = request.getParameter("message");
            String batchCode = request.getParameter("batchcode");
            String batchName = request.getParameter("batchname");
            
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("Select * From SPMCollegeMaster;");
            if (rs.next()) {
                String from = rs.getString("MessagingEmail");

                ArrayList to = new ArrayList();
                rs = stmt.executeQuery("Select SPMStudentMaster.EmailID From SPMStudentMaster Where(SPMStudentMaster.RegisterNo In (Select SPMBatchRegister.RegisterNo From SPMBatchRegister Where(SPMBatchRegister.BatchCode=" + batchCode + ")));");
                boolean found = false;
                while (rs.next()) {
                    to.add(rs.getString("EmailID"));
                    found = true;
                }

                try {
                    //SmtpClient client = new SmtpClient("127.0.0.1");
                    /*SmtpClient client = new SmtpClient("smtp.gmail.com");
                    client.from(from);
                    client.to(to);
                    PrintStream message = client.startMessage();
                    message.println("To: " + to);
                    message.println("Subject: "+subject);                    
                    message.println();
                    message.println(messageBody);
                    message.println();
                    message.println();
                    client.closeServer();*/
                    String host = "smtp.gmail.com", user = "shaju003", pass = "98491000";
                    String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
                    boolean sessionDebug = true;
                    Properties props = System.getProperties();
                    props.put("mail.host", host);
                    props.put("mail.transport.protocol.", "smtp");
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.", "true");
                    props.put("mail.smtp.port", "465");
                    props.put("mail.smtp.socketFactory.fallback", "false");
                    props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
                    Session mailSession = Session.getDefaultInstance(props, null);
                    mailSession.setDebug(sessionDebug);
                    Message msg = new MimeMessage(mailSession);
                    msg.setFrom(new InternetAddress(from));

                    InternetAddress[] address = new InternetAddress[to.size()];
                    for (int i = 0; i < to.size(); i++) {
                        address[i] = new InternetAddress(to.get(i) + "");
                    }
                    msg.setRecipients(Message.RecipientType.TO, address);
                    msg.setSubject(subject);
                    msg.setContent(messageBody, "text/html"); // use setText if you want to send text
                    Transport transport = mailSession.getTransport("smtp");
                    transport.connect(host, user, pass);
                    boolean wasEmailSent = false;
                    try {
                        transport.sendMessage(msg, msg.getAllRecipients());
                        wasEmailSent = true; // assume it was sent
                    } catch (Exception err) {
                        wasEmailSent = false; // assume it's a fail
                        System.out.println("ERROR SENDING EMAIL:" + err.toString());
                        session.setAttribute("Error", to + "ERROR SENDING EMAIL:" + err.toString());
                        response.sendRedirect("SendMessage.jsp?deptcode=" + deptCode + "&batchcode=" + batchCode + "&batchname=" + batchName);
                    }
                    transport.close();


                } catch (Exception e) {
                    System.out.println("ERROR SENDING EMAIL:" + e.toString());
                    session.setAttribute("Error", "ERROR SENDING EMAIL:" + e.toString());
                    response.sendRedirect("SendMessage.jsp?deptcode=" + deptCode + "&batchcode=" + batchCode + "&batchname=" + batchName);
                }

            } else {
                /**
                Error Message for not having sender address
                 */
                System.out.println("ERROR SENDING EMAIL:");
                session.setAttribute("Error", "ERROR SENDING EMAIL:");
                response.sendRedirect("SendMessage.jsp?deptcode=" + deptCode + "&batchcode=" + batchCode + "&batchname=" + batchName);
            }
            stmt.close();
        %>        
    </center>
</body>
</html>
