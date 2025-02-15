<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>    
<%@ page import="java.io.*, java.util.*, java.text.*" %>
<% if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello <%= (String)session.getAttribute("username") %></title>
</head>
</html>
<% if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");	
else
{
	try{
		String ad_lo_id = (String)session.getAttribute("username");
		int empl_id=Integer.parseInt(request.getParameter("empl_id"));
		Timestamp serv_re_da = new Timestamp(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S").parse(request.getParameter("serv_re")).getTime());
		Timestamp ts = new java.sql.Timestamp(new java.util.Date().getTime());
		Connection con = null;
		PreparedStatement pst = null;
		PreparedStatement pst1 = null;
		int rs = 0;
		int rs1 = 0;
	
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
		pst = con.prepareStatement("update customer_service set employee_id=?,employee_service_request_date=? where service_request_date=?");
		pst.setInt(1, empl_id);
		pst.setTimestamp(2, new java.sql.Timestamp(new java.util.Date().getTime()));
		pst.setTimestamp(3, serv_re_da);
		rs=pst.executeUpdate();
		pst1 = con.prepareStatement("update employee set employee_status='active' where employee_id=?");
		pst1.setInt(1, empl_id);
		rs1=pst1.executeUpdate();
		if(rs!=0 && rs1!=0){%>
			<form method="post" action="welcome.jsp">
			<script type="text/javascript">
			window.alert('Employee assigned successfully!');
			window.location.href="admin_new_job.jsp";
			</script>
	 		</form><%
		}
		else{%>
			<form method="post" action="welcome.jsp">
			<script type="text/javascript">
			window.alert('Error!');
			window.location.href="assign_employee.jsp";
			</script>
	 		</form><%
		}
	}
	catch (Exception e){%>
		<form method="post">
		<script type="text/javascript">
		window.alert('Sorry, There is some error!');
		window.location.href="welcome.jsp";
		</script>
		</form><%
	}
	finally{
		//nothing
	}
}
%>