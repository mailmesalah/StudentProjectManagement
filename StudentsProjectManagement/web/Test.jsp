<%-- 
    Document   : Test
    Created on : May 23, 2011, 6:48:39 PM
    Author     : Salah
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        Calendar c = Calendar.getInstance();
        out.println(c.getTimeInMillis());
    %>
    <% String duration = "10";%>
    <% int a = Integer.parseInt(duration);%>
    <head><title></title>
        <script type="text/javascript">
            var cmin=<%= a%>;
            var total=cmin*60;
            cmin=cmin-1;
            var ctr=0;
            var dom=document.getElementById("kulu");
            function ram(){
                var dom=document.getElementById("kulu");
                dom.value=(cmin)+"minutes"+(total%60)+"seconds";
            <% String t = "10";%>
                    var tt=<%= t%>
                    if(tt=="false"){ram1();}
                    total=total-1;ctr++;
                    if(ctr==60){ctr=0;cmin=cmin-1;}
                    if(total==0){
                        ram1();}
                    setTimeout("ram()", 1000);
                }
                function ram1(){
                    //window.location.replace("/hcl/TTimeUp.jsp");
                }
        </script>
    </head>
    <body background="image/background.gif" onload="ram()">
    <center>
        <form name="form1">
            <table border="1">
                <input type="text" id="kulu"/>
            </table>
        </form>
        <form ENCTYPE='multipart/form-data' method='POST' action='TestUpload.jsp'>
            <input type='file' name='sfile'>
            <input type='submit' value='Upload'>
        </form>
    </center>    
</body>
</html>

