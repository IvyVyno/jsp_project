<%@ page import="classes.DBCP" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>

<%
    String sql = "DELETE FROM `mydb`.`departments` WHERE (`dept_no` = " + request.getParameter("dept_no").trim() + ");";
    try (Connection connection = DBCP.getConnection();
         PreparedStatement ps = connection.prepareStatement(sql);) {
        ps.execute(sql);
        response.sendRedirect("http://localhost:8080/Employees_war_exploded/departments");
    } catch (Exception e) {
%>
<h2 align="center"><span><strong>RESTRICTED!</strong></span></h2>
<p align="center"><span><strong>You can't delete department which contains employees. You need to delete employees first.</strong></span>
</p>
<h2 align="center">
    <button type="button" onclick='location.href="http://localhost:8080/Employees_war_exploded/departments"'>
        <span><strong>Return to Departments</strong></span>
    </button>
</h2>
<%
    }
%>