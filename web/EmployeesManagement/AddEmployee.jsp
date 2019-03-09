<%@ page import="classes.DBCP" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.time.LocalDate" %>

<h2 align="center"><span><strong>New employee to department <%=request.getParameter("dept_no")%></strong></span></h2>

<table align="center" cellpadding="5" cellspacing="5" border="1">
    <tr>

    </tr>
    <tr bgcolor="#A52A2A">
        <td><b>Employee's no</b></td>
        <td><b>First name</b></td>
        <td><b>Last name</b></td>
        <td><b>Email</b></td>
        <td><b>Hire date</b></td>
        <td><b>Department</b></td>
    </tr>

    <%
        if (request.getParameter("firstname") == null) {
            String sql = "SELECT emp_no from employees where emp_no=(select max(emp_no) from employees)";
            try (Connection connection = DBCP.getConnection();
                 PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery();) {
                while (rs.next()) {


    %>


    <form>
        <tr bgcolor="#DEB887">

            <td><input name=emp_no type="text" readonly value="<%=(Integer.parseInt(rs.getString("emp_no"))+1)%>">
            </td>
            <td><input name=firstname type="text">
            </td>
            <td><input name=lastname type="text">
            </td>
            <td><input name=email type="text">
            </td>
            <td><input name=hiredate type="date" value="<%=LocalDate.now()%>">
            </td>
            <td><input name="dept_no" type="text" readonly value="<%=request.getParameter("dept_no")%>">
            </td>
            <input name=dept_name type="hidden" value="<%=request.getParameter("dept_name")%>">
        </tr>
        <h2 align="center"><input type="submit" value="Apply"></h2>
    </form>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {

    %>
    <%
            if (request.getParameter("firstname").matches("^[a-zA-Z-]+$") && request.getParameter("firstname") != null
                    && request.getParameter("lastname").matches("^[a-zA-Z-]+$") && request.getParameter("lastname") != null
                    && request.getParameter("email").contains("@") && request.getParameter("email") != null) {
                String insertEmployee = "insert into `mydb`.`employees` "
                        + "(`emp_no`, `first_name`, `last_name`, `email`, `hire_date`) "
                        + "values ('" + request.getParameter("emp_no") + "', '"
                        + request.getParameter("firstname") + "', '"
                        + request.getParameter("lastname") + "', '"
                        + request.getParameter("email") + "', '"
                        + request.getParameter("hiredate") + "');";
                String insertDeptEmp = "insert into `mydb`.`dept_emp` "
                        + "(`emp_no`, `dept_no`) values ('"
                        + request.getParameter("emp_no").trim() + "', '"
                        + request.getParameter("dept_no").trim() + "');";
                try (Connection connection = DBCP.getConnection();
                     PreparedStatement insertEmployeeStatement = connection.prepareStatement(insertEmployee);
                     PreparedStatement insertDeptEmpStatement = connection.prepareStatement(insertDeptEmp)) {
                    insertEmployeeStatement.execute();
                    insertDeptEmpStatement.execute();
                    response.sendRedirect("http://localhost:8080/Employees_war_exploded/getDepartmentsStuff?dept_no="
                            + request.getParameter("dept_no").trim()
                            + "&dept_name="
                            + request.getParameter("dept_name").trim());
                } catch (Exception e) {
                    String sql = "insert into `mydb`.`unconfirmedemployees` " +
                            "(`emp_no`, `first_name`, `last_name`, `email`, `hire_date`) "
                            + "values ('" + request.getParameter("emp_no") + "', '"
                            + request.getParameter("firstname") + "', '"
                            + request.getParameter("lastname") + "', '"
                            + request.getParameter("email") + "', '"
                            + request.getParameter("hiredate") + "');";
                    try (Connection connection = DBCP.getConnection();
                         PreparedStatement ps = connection.prepareStatement(sql)) {
                        ps.execute();
                        response.sendRedirect("http://localhost:8080/Employees_war_exploded/getUnconfirmedEmployees");
                    } catch (Exception ex) {
                        e.printStackTrace();
                    }
                }
            } else {
                String sql = "insert into `mydb`.`unconfirmedemployees` " +
                        "(`emp_no`, `first_name`, `last_name`, `email`, `hire_date`) "
                        + "values ('" + request.getParameter("emp_no") + "', '"
                        + request.getParameter("firstname") + "', '"
                        + request.getParameter("lastname") + "', '"
                        + request.getParameter("email") + "', '"
                        + request.getParameter("hiredate") + "');";
                try (Connection connection = DBCP.getConnection();
                     PreparedStatement ps = connection.prepareStatement(sql)) {
                    ps.execute();
                    response.sendRedirect("http://localhost:8080/Employees_war_exploded/getUnconfirmedEmployees");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

    %>
</table>
<h2 align="center">
    <button type="button" onclick='location.href="http://localhost:8080/Employees_war_exploded/index.jsp"'>
        <span><strong>Return</strong></span>
    </button>
</h2>