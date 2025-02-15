<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello <%= (String)session.getAttribute("username") %></title>
</head>
</html>
<% if((request.getSession().getAttribute("username"))==null){
	request.getSession().invalidate();
	response.sendRedirect("login1.jsp");
}
else {
	try{
		String empl_lo_id = (String)session.getAttribute("username");
		Connection con = null;
		String sql = null;
		String sql1 = null;
		String sql2 = null;
		Statement st = null;
		Statement st1 = null;
		Statement st2 = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
		sql = "select * from employee where employee_login_id='"+empl_lo_id+"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		if(rs.next()==true){
			do{
	     		//Retrieve by column name
     			String empl_st = rs.getString("employee_status");
				if("inactive".equals(empl_st)){
					sql1 = "update employee set employee_status = 'active' WHERE employee_login_id='"+ empl_lo_id +"'";
					st1 = con.createStatement();
					st1.executeUpdate(sql1);%>
					<form method="post" action="welcome.jsp">
					<script type="text/javascript">
					window.alert('Now you are active!');
					window.location.href="welcome.jsp";
					</script>
		 			</form><%
				}
				else{
					sql2 = "update employee set employee_status = 'inactive' WHERE employee_login_id='"+ empl_lo_id +"'";
					st2 = con.createStatement();
					st2.executeUpdate(sql2);%>
					<form method="post" action="welcome.jsp">
					<script type="text/javascript">
					window.alert('Now you are inactive!');
					window.location.href="welcome.jsp";
					</script>
		 			</form><%
				}
			}while(rs.next());
  		}
		else{%>
			<form method="post" action="new_job.jsp">
			<script type="text/javascript">
			window.alert("Sorry, There is some error!");
			window.location.href="welcome.jsp";
			</script>
			</form><%
		}
	}
	catch (Exception e){%>
		<form method="post">
		<script type="text/javascript">
		window.alert('There is some problem!');
		window.location.href="welcome.jsp";
		</script>
		</form><%
	}
	finally{
		//out.println("Error!");
	}
}
%>