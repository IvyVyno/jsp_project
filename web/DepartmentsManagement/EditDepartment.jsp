<%@ page import="classes.DBCP" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<h2 align="center"><span><strong>Edit Department <%=request.getParameter("dept_no")%></strong></span></h2>

<table align="center" cellpadding="5" cellspacing="5" border="1">
    <tr>

    </tr>
    <tr bgcolor="#A52A2A">
        <td><b>Department's ID</b></td>
        <td><b>Department's Name</b></td>
    </tr>

    <%
        if (request.getParameter("deptname") == null) {
            String sql = "select * from departments where `dept_no` = " + request.getParameter("dept_no").trim();
            try (Connection connection = DBCP.getConnection();
                 PreparedStatement ps = connection.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery();) {
                while (rs.next()) {


    %>


    <form>
        <tr bgcolor="#DEB887">

            <td><input name="dept_no" type="text" readonly value="<%=(Integer.parseInt(rs.getString("dept_no")))%>">
            </td>
            <td><input name=deptname type="text" value="<%=rs.getString("dept_name")%>">
            </td>
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
            if (request.getParameter("deptname").matches("^[a-z A-Z]+$")) {
                String updateEmployee = "update `mydb`.`departments` "
                        + "set `dept_name` = '"
                        + request.getParameter("deptname").trim()
                        + "' where (`dept_no` = "
                        + request.getParameter("dept_no").trim() + ");";
                try (Connection connection = DBCP.getConnection();
                     PreparedStatement insertEmployeeStatement = connection.prepareStatement(updateEmployee);) {
                    insertEmployeeStatement.execute();
                    response.sendRedirect("http://localhost:8080/Employees_war_exploded/departments");
                } catch (Exception e) {
                    String sql = "insert into `mydb`.`unconfirmeddepartments` " +
                            "(`dept_no`, `dept_name`) "
                            + "values ('" + request.getParameter("dept_no") + "', '"
                            + request.getParameter("deptname") + "');";
                    try (Connection connection = DBCP.getConnection();
                         PreparedStatement ps = connection.prepareStatement(sql)) {
                        ps.execute();
                        response.sendRedirect("http://localhost:8080/Employees_war_exploded/getUnconfirmedDepartments");
                    } catch (Exception ex) {
                        e.printStackTrace();
                    }
                }
            } else {
                String sql = "insert into `mydb`.`unconfirmeddepartments` " +
                        "(`dept_no`, `dept_name`) "
                        + "values ('" + request.getParameter("dept_no") + "', '"
                        + request.getParameter("deptname") + "');";
                try (Connection connection = DBCP.getConnection();
                     PreparedStatement ps = connection.prepareStatement(sql)) {
                    ps.execute();
                    response.sendRedirect("http://localhost:8080/Employees_war_exploded/getUnconfirmedDepartments");
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