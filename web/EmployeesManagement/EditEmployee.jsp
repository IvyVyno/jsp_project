<%@ page import="classes.DBCP" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.time.LocalDate" %>

<h2 align="center"><span><strong>Employee <%=request.getParameter("emp_no").trim()%></strong></span></h2>

<table align="center" cellpadding="5" cellspacing="5" border="1">
    <tr>

    </tr>
    <tr bgcolor="#A52A2A">
        <td><b>Employee's no</b></td>
        <td><b>First name</b></td>
        <td><b>Last name</b></td>
        <td><b>Email</b></td>
        <td><b>Hire date</b></td>
    </tr>

    <%
        if (request.getParameter("firstname") == null) {
            String sql = "select * from employees where `emp_no` = " + request.getParameter("emp_no").trim();
            System.out.println(sql);
            try (Connection connection = DBCP.getConnection();
                 PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery();) {
                while (rs.next()) {
    %>


    <form>
        <tr bgcolor="#DEB887">

            <td><input name="emp_no" type="text" readonly value="<%=rs.getString("emp_no")%>">
            </td>
            <td><input name=firstname type="text" value="<%=rs.getString("first_name") %>">
            </td>
            <td><input name=lastname type="text" value="<%=rs.getString("last_name") %>">
            </td>
            <td><input name=email type="text" value="<%=rs.getString("email") %>">
            </td>
            <td><input name=hiredate type="date" value="<%=rs.getString("hire_date") %>">
            </td>
            <input name=dept_no type="hidden" value="<%=request.getParameter("dept_no")%>">
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
                String sql = "update employees set first_name = '"
                        + request.getParameter("firstname")
                        + "', last_name = '"
                        + request.getParameter("lastname")
                        + "', email = '"
                        + request.getParameter("email")
                        + "', hire_date = '"
                        + request.getParameter("hiredate")
                        + "'where emp_no = '"
                        + request.getParameter("emp_no") + "'";
                try (Connection connection = DBCP.getConnection();
                     PreparedStatement ps = connection.prepareStatement(sql)) {
                    ps.executeUpdate();
                    response.sendRedirect("http://localhost:8080/Employees_war_exploded/getDepartmentsStuff?dept_no="
                            + request.getParameter("dept_no")
                            + "&dept_name="
                            + request.getParameter("dept_name"));
                } catch (Exception e) {
                    sql = "insert into `mydb`.`unconfirmedemployees` " +
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



