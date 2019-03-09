<%@ page import="classes.DBCP" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>

<h2 align="center"><span><strong>List of Employees for <%=request.getParameter("dept_no")%></strong></span></h2>
<h2 align="center"><span><strong><%=request.getParameter("dept_name")%></strong></span></h2>
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
        String sql = "SELECT employees.* " +
                "FROM employees " +
                "INNER JOIN dept_emp " +
                "ON employees.emp_no = dept_emp.emp_no " +
                "AND dept_emp.dept_no = " + "'" +
                request.getParameter("dept_no").trim() + "'";
        try (Connection connection = DBCP.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
    %>
    <tr bgcolor="#DEB887">

        <td>
            <button type="button"
                    onclick='location.href="http://localhost:8080/Employees_war_exploded/deleteEmployee?emp_no=<%=rs.getString("emp_no")%>&dept_no=<%=request.getParameter("dept_no")%>&dept_name=<%=request.getParameter("dept_name")%>"'>
                <span><strong>Delete</strong></span>
            </button>
            <button type="button"
                    onclick='location.href="http://localhost:8080/Employees_war_exploded/editEmployee?emp_no=<%=rs.getString("emp_no")%>&dept_no=<%=request.getParameter("dept_no")%>&dept_name=<%=request.getParameter("dept_name")%>"'>
                <span><strong>Edit</strong></span>
            </button>
            <%=rs.getString("emp_no") %>
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
    <button type="button"
            onclick='location.href="http://localhost:8080/Employees_war_exploded/addEmployee?dept_no= + <%=request.getParameter("dept_no")%>+ &dept_name= + <%=request.getParameter("dept_name")%>"'>
        <span><strong>Add employee</strong></span>
    </button>
</h2>
<h2 align="center">
    <button type="button" onclick='location.href="http://localhost:8080/Employees_war_exploded/departments"'>
        <span><strong>Back to departments</strong></span>
    </button>
</h2>