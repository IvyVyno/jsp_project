<%@ page import="classes.DBCP" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<h2 align="center"><span><strong>List of Unconfirmed Departments</strong></span></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
    <tr>

    </tr>
    <tr bgcolor="#A52A2A">
        <td><b>Department's id</b></td>
        <td><b>Department's name</b></td>
    </tr>

    <%
        String sql = "SELECT * FROM unconfirmeddepartments";
        try (Connection connection = DBCP.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
    %>
    <tr bgcolor="#DEB887">

        <td><%=rs.getString("dept_no") %>
        </td>
        <td><%=rs.getString("dept_name") %>
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
