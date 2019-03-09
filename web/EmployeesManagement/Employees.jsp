<%@ page import="classes.DBCP" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<h2 align="center"><span><strong>List of employees</strong></span></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
    <tr>

    </tr>
    <tr bgcolor="#A52A2A">
        <td><b>Employee's id</b></td>
        <td><b>First name</b></td>
        <td><b>Last name</b></td>
        <td><b>Email</b></td>
        <td><b>Hire date</b></td>
    </tr>

    <%
        String sql = "SELECT * FROM employees";
        try (Connection connection = DBCP.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
    %>
    <tr bgcolor="#DEB887">

        <td><%=rs.getString("emp_no") %>
        </td>
        <td><%=rs.getString("first_name") %>
        </td>
        <td><%=rs.getString("last_name") %>
        </td>
        <td><%=rs.getString("email") %>
        </td>
        <td><%=rs.getString("hire_date") %>
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
    <button type="button" onclick='location.href="http://localhost:8080/Employees_war_exploded/index.jsp"'>
        <span><strong>Return</strong></span>
    </button>
</h2>