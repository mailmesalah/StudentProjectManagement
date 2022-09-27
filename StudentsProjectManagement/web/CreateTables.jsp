<%-- 
    Document   : CreateTables.jsp
    Created on : May 24, 2011, 9:33:09 PM
    Author     : Vaio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            try {
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                Connection con = DriverManager.getConnection("jdbc:odbc:StudentDatabase", "system", "student");
                Statement stmt = con.createStatement();

               /* int i = stmt.executeUpdate("create table SPMDeptOfProfessors (ProfessorCode Number(4) not null,DeptCode number(4) not null,Role varchar2(30));");
                i = stmt.executeUpdate("create table SPMDepartments (DeptCode number(4) not null,DeptName varchar2(50) not null,Description varchar2(100));");
                i = stmt.executeUpdate("create table SPMProjectRegister (RegisterNo varchar2(10) not null,SemesterName varchar2(50) not null,ProjectCode number(4) not null,ProjectName varchar2(50) not null,Description varchar2(100),Status varchar2(1) not null);");
                i = stmt.executeUpdate("create table SPMBatchRegister (RegisterNo varchar2(10) not null,BatchCode number(4) not null);");
                i = stmt.executeUpdate("create table SPMGroupRegister (RegisterNo varchar2(10) not null,GroupCode number(4) not null,Status varchar2(1) not null);");
                i = stmt.executeUpdate("create table SPMGroupMaster (GroupCode number(4) not null,GroupName varchar2(50) not null,Description varchar2(100),BatchCode number(4)not null);");
                i = stmt.executeUpdate("create table SPMSemesterRegister(RegisterNo varchar2(10) not null,SemesterName varchar2(50) not null,SemesterExamDate Date not null,SubjectCode number(4)not null,SubjectName varchar2(50) not null,ExternalMaxMark number(4) not null,InternalMaxMark number(4) not null,ExternalMark number(4)not null,InternalMark number(4)not null,Status varchar2(1) not null,ExamAttended number(1) not null);");
                i = stmt.executeUpdate("create table SPMStudentMaster (UniqueID number(4)not null,RegisterNo varchar2(10)not null,StudentName varchar2(50) not null,DeptCode number(4)not null,Sex varchar2(1) not null,DateOfBirth Date not null,Address1 varchar2(30),Address2 varchar2(30),Address3 varchar2(30),Phone varchar2(20),Remarks varchar2(100),EmailID varchar2(50) not null,Status varchar2(1)not null);");
                i = stmt.executeUpdate("create table SPMProfessors(ProfessorCode number(4) not null,ProfessorName varchar2(30) not null,Address1 varchar2(30),Address2 varchar2(30),Address3 varchar2(30),Phone varchar2(20),Remarks varchar2(100),Status varchar2(1) not null);");
                i = stmt.executeUpdate("create table SPMAuthentication (UserType varchar2(1) not null,UniqueID number(4)not null,Username varchar2(20)not null,Password varchar2(20) not null,Code number(4));");
                i = stmt.executeUpdate("create table SPMSemesterMaster(RegisterNo varchar2(10)not null,SemesterName varchar2(100)not null,SemesterExamDate Date not null);");
                i = stmt.executeUpdate("create table SPMProjectNotification(BatchCode number(4) not null);");
                i = stmt.executeUpdate("create table SPMCurrentExam(BatchCode number(4)not null,ExamCode number(4)not null,QuestionsNo number(4)not null,ExamDuration number(4) not null,MinimumPercent number(4)not null);");
                i = stmt.executeUpdate("create table SPMCollegeMaster (CollegeName varchar2(50),Address1 varchar2(30),Address2 varchar2(30),Address3 varchar2(30),Phone varchar2(20),MessagingEmail varchar2(50));");
                i = stmt.executeUpdate("create table SPMCurrentProject(GroupCode number(4)not null,ProjectDescription varchar2(50)not null,StartDate Date not null,Status varchar2(5));");
                i = stmt.executeUpdate("create table SPMProjectsCompleted(ProjectCode number(4) not null,ProjectDescription varchar2(100) not null,StartDate Date not null,EndDate Date not null,Percent number(4) not null,Status varchar2(30) not null,StudentCode number(4) not null);");
                i = stmt.executeUpdate("create table SPMOnlineTestResults(StudentCode number(4) not null,ExamDescription varchar2(30) not null,ExamDate Date not null,Percent number(4)not null,Status varchar2(50) not null,OnlineTestCode number(4) not null);");
                i = stmt.executeUpdate("create table SPMAnswers(QuestionCode number(4) not null,AnswerCode number(4) not null,Answer varchar2(300)not null,CorrectAnswer number(1));");
                i = stmt.executeUpdate("create table SPMQuestions(ExamCode number(4) not null,QuestionCode number(4) not null,Question varchar2(300) not null);");
                i = stmt.executeUpdate("create table SPMExamMaster(ExamCode number (4) not null,ExamName varchar2(30) not null,DeptCode number(4) not null,Description varchar2(100));");
                i = stmt.executeUpdate("create table SPMBatchMaster(BatchCode number(4) not null,BatchName varchar2(50) not null,Description varchar2(100),DeptCode number(4) not null);");
                */
                stmt.close();
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        %>
    </body>
</html>
