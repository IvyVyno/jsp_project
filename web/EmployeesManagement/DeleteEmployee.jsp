<%@ page import="java.sql.Connection" %>
<%@ page import="classes.DBCP" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<%
    String sqlDeleteFromEmployees = "delete from employees where `emp_no` = " + request.getParameter("emp_no").trim();
    String sqlDeleteFromDeptEmp = "delete from dept_emp where `emp_no` = " + request.getParameter("emp_no").trim();
    try (Connection connection = DBCP.getConnection();
         PreparedStatement ps = connection.prepareStatement(sqlDeleteFromDeptEmp);
         PreparedStatement sps = connection.prepareStatement(sqlDeleteFromEmployees)) {
        ps.execute();
        sps.execute();
        response.sendRedirect("http://localhost:8080/Employees_war_exploded/getDepartmentsStuff?dept_no="
                + request.getParameter("dept_no").trim()
                + "&dept_name=" + request.getParameter("dept_name"));
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

