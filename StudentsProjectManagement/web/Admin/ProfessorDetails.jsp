<%-- 
    Document   : ProfessorDetails
    Created on : Apr 5, 2011, 8:40:01 AM
    Author     : Sely
--%>

<%@page import="java.lang.String"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Professor Details</title>
    </head>
    <body bgcolor="#F0F0F0"><center>
        <h1>Professor Details!</h1><hr>
        <%
        String uniqueID=((String)session.getAttribute("UniqueID"))==null ?"":((String)session.getAttribute("UniqueID"));
        String userType=((String)session.getAttribute("UserType"))==null ?"":((String)session.getAttribute("UserType"));
        if(uniqueID.equals("")||!userType.equals("A")){
            response.sendRedirect("/StudentsProjectManagement/SignOut.jsp");
        }
        %>
        <%
            String errors = (String) session.getAttribute("Error");
            String info = (String) session.getAttribute("Info");

            if (errors != null) {
                out.println(errors);
            }
            if (info != null) {
                out.println(info);
            }
            //Reset the session variables
            session.setAttribute("Error", "");
            session.setAttribute("Info", "");

            String professorCode = request.getParameter("professorCode");
            String sDeptCode = request.getParameter("DeptCode");
            String sDeptName = request.getParameter("DeptName");

            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
            Statement stmt = con.createStatement();

            //For Populating Department Code and Departement Name on select                     
            if (!sDeptCode.equals("")) {
                try {
                    ResultSet rs1 = stmt.executeQuery("Select SPMDepartments.DeptName From SPMDepartments Where SPMDepartments.DeptCode=" + sDeptCode + " ;");
                    if (rs1.next()) {
                        sDeptName = rs1.getString("DeptName");
                    } else {
                        sDeptName = "";
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            } else if (!sDeptName.equals("")) {
                try {
                    ResultSet rs1 = stmt.executeQuery("Select SPMDepartments.DeptCode From SPMDepartments Where SPMDepartments.DeptName='" + sDeptName + "' ;");
                    if (rs1.next()) {
                        sDeptCode = rs1.getString("DeptCode");
                    } else {
                        sDeptCode = "";
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            }
        %>
        <Script type="text/javascript" language="java">
            function refresh(x){
                var selDeptCode = document.getElementById('SelectDeptCode');
                var selDeptName = document.getElementById('SelectDeptName');
                if(x==0){
                    window.location="ProfessorDetails.jsp?DeptCode="+selDeptCode.value+"&DeptName=&professorCode="+<%=professorCode%>;
                }else if(x==1){
                    window.location="ProfessorDetails.jsp?DeptCode=&DeptName="+selDeptName.value+"&professorCode="+<%=professorCode%>;
                }
            }
        </Script>
        <table border="1">
            <%

                try {
                    ResultSet rs = stmt.executeQuery("Select * From SPMProfessors Where SPMProfessors.ProfessorCode=" + professorCode + " ;");
                    int i = 0;
                    if (rs.next()) {
                        %>
                        <tr><td>Professor Code</td><td>:</td><td><%=professorCode%></td></tr>
                        <tr><td>Professor Name</td><td>:</td><td><%=rs.getString("ProfessorName")%></td></tr>
                        <tr><td>Address</td><td>:</td><td><%=rs.getString("Address1")%></td></tr>
                        <tr><td></td><td>:</td><td><%=rs.getString("Address2")%></td></tr>    
                        <tr><td></td><td>:</td><td><%=rs.getString("Address3")%></td></tr>
                        <tr><td>Phone</td><td>:</td><td><%=rs.getString("Phone")%></td></tr>
                        <tr><td>Remarks</td><td>:</td><td><%=rs.getString("Remarks")%></td></tr>
                        <%String status = rs.getString("Status");%>
                        <tr><td>Status</td><td>:</td><td><%=(status.equals("R") ? "Registered" : (status.equals("V") ? "Validated" : (status.equals("J") ? "Rejected" : "Disabled")))%></td></tr>                                 
        </table>
        <br><br><h4><b>Professor's Departments</b></h4>
        <%            
            rs = stmt.executeQuery("Select SPMDeptOfProfessors.Role,SPMDeptOfProfessors.DeptCode,SPMDepartments.DeptName From SPMDeptOfProfessors,SPMDepartments Where SPMDeptOfProfessors.ProfessorCode=" + professorCode + " And SPMDepartments.DeptCode=SPMDeptOfProfessors.DeptCode ;");
        %>
        <table border="1">
            <pre>
            <tr><td>Department Code</td><td>Department</td><td>Role</td><td>Action</td></tr>
                <%
                    int deptCode = 0;
                    String deptName = "";
                    String role = "";
                    int l = 0;
                    while (rs.next()) {
                        role = rs.getString("Role");
                        deptCode = rs.getInt("DeptCode");
                        deptName = rs.getString("DeptName");

                        out.println("<form name=\"form" + l + "\" method=\"get\" action=\"RemoveDepartmentFromProfessor.jsp\">");
                        out.println("<input type=\"hidden\" name=\"SelectDeptCode\" value=\"" + deptCode + "\">");
                        out.println("<input type=\"hidden\" name=\"ProfessorCode\" value=\"" + professorCode + "\">");
                        out.println("<tr><td>" + deptCode + "</td><td>" + deptName + "</td><td>" + role + "</td><td>" + "<input type=\"submit\" value=\"  Remove  \">" + "</td></tr>");
                        out.println("</form>");
                        l = l + 1;
                    }

                    rs = stmt.executeQuery("Select Count(*) as Count From SPMDepartments ;");
                    int recordCount = 0;
                    if (rs.next()) {
                        recordCount = rs.getInt("Count");
                    }
                    rs.close();

                    rs = stmt.executeQuery("Select SPMDepartments.DeptCode,SPMDepartments.DeptName From SPMDepartments Order By SPMDepartments.DeptName ;");
                    int deptCodeArray[] = new int[recordCount];
                    String deptNameArray[] = new String[recordCount];
                    i = 0;
                    while (rs.next()) {
                        deptCodeArray[i] = rs.getInt("DeptCode");
                        deptNameArray[i] = rs.getString("DeptName");
                        i = i + 1;
                    }
                %>
                <form name="formAdd" method="get" action="AddDepartmentToProfessor.jsp">
                <tr><td><input type="hidden" name="ProfessorCode" value="<%=professorCode%>">

                        <select id="SelectDeptCode" name="SelectDeptCode" onchange="refresh(0)">
                                <%
                                    for (int j = 0; j < deptCodeArray.length; j++) {
                                        if (sDeptCode.equals(""+deptCodeArray[j])) {
                                            out.println("<option value=\"" + deptCodeArray[j] + "\" selected>" + deptCodeArray[j]);
                                        } else {
                                            out.println("<option value=\"" + deptCodeArray[j] + "\">" + deptCodeArray[j]);
                                        }
                                    }
                                %>
                </select>

                </td><td>

                    <select id="SelectDeptName" name="SelectDeptName" onchange="refresh(1)">
                                <%
                                    for (int j = 0; j < deptNameArray.length; j++) {
                                        if (sDeptName.equals(deptNameArray[j])) {
                                            out.println("<option value=\"" + deptNameArray[j] + "\" selected>" + deptNameArray[j]);
                                        } else {
                                            out.println("<option value=\"" + deptNameArray[j] + "\">" + deptNameArray[j]);
                                        }
                                    }

                                %>
                </select>

                </td><td><input type="text" name="Role"></td><td><input type="submit" name="Add" value="     Add     "></td></tr>
                </form>
            </pre>
        </table>
        <%
                } else {
                    out.println("No Record Found !");
                }
            } catch (Exception e) {
                out.println(e.toString());
            }
            stmt.close();

        %>
        </center>
    </body>
</html>
