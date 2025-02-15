<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Password Change</title>
</head>
<body>
</body>
</html>
<%
	try {
	String oldp = request.getParameter("oldpassword");
	String newp = request.getParameter("newpassword");
	String conp = request.getParameter("conpassword");
	String desig = (String)session.getAttribute( "desig" );
	String username = (String)session.getAttribute( "username" );
	Connection con = null;
	Statement st = null;
	String pass = "";
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/service_center";
		con = DriverManager.getConnection(url, "root", "");
		st = con.createStatement();
		ResultSet rs = st.executeQuery("select * from " + desig + " where " + desig + "_login_password = '"+ oldp + "' AND " + desig +"_login_id = '"+ username +"'");
		if (rs.next()) { 
			pass = rs.getString( "" + desig + "_login_password");
		}
		if (pass.equals(oldp)) {
			st = con.createStatement();
			st.executeUpdate("update " + desig + " set " + desig + "_login_password ='"+ newp + "' where "+ desig +"_login_id = '"+ username +"'");
			%>
			<form method="post" name="form1" action="<%=desig%>_action.jsp">
			<input type="hidden" name="act" value="Profile">
			<script type="text/javascript">
			window.alert('Password changed successfully!');
			document.form1.submit();
			</script>
 			</form><%
		} 
		else {
			%>
			<form method="post" action="welcome.jsp">
			<script type="text/javascript">
			window.alert("Old Password doesn't match!");
			window.location.href="change_password.jsp";
			</script>
 			</form><%
		}
		
	} 
	catch (Exception e) {
		out.println(e);
	}
	finally{
		st.close();
		con.close();
	}
%>