<%@ page import="classes.DBCP" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>

<h2 align="center"><span><strong>List of Departments</strong></span></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
    <tr>

    </tr>
    <tr bgcolor="#A52A2A">
        <td><b>Department's id</b></td>
        <td><b>Department's name</b></td>
    </tr>

    <%
        String sql = "SELECT * FROM departments ORDER BY dept_no";
        try (Connection connection = DBCP.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
    %>
    <tr bgcolor="#DEB887">

        <td>
            <button type="button"
                    onclick='location.href=
                            "http://localhost:8080/Employees_war_exploded/getDepartmentsStuff?dept_no= + <%=rs.getString("dept_no") %> + &dept_name= + <%=rs.getString("dept_name")%>"'>
                <span><strong><%=rs.getString("dept_no").toUpperCase() %></strong></span></button>
            <button type="button"
                    onclick='location.href=
                            "http://localhost:8080/Employees_war_exploded/editDepartment?dept_no= +<%=rs.getString("dept_no") %>"'>
                <span><strong>Edit</strong></span></button>
            <button type="button"
                    onclick='location.href="http://localhost:8080/Employees_war_exploded/deleteDepartment?dept_no= +<%=rs.getString("dept_no") %>"'>
                <span><strong>Delete</strong></span></button>
        <td><%=rs.getString("dept_name")%>
        </td>

    </tr>

    <%
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    %>


</table>

<h2 align="center">
    <button type="button" onclick='location.href="http://localhost:8080/Employees_war_exploded/addDepartment"'>
        <span><strong>Add department</strong></span>
    </button>
</h2>
<h2 align="center">
    <button type="button" onclick='location.href="http://localhost:8080/Employees_war_exploded/index.jsp"'>
        <span><strong>Return</strong></span>
    </button>
</h2>

<p align="center">Press the department's number to get the list of employees for selected department</p>
<p align="center"><span><strong>CAUTION!</strong> You cannot delete department if it contains one or more employees</span></p>