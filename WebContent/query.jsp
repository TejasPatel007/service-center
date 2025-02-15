<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Query</title>
</head>
<body>
</body>
</html>
<% if((request.getSession().getAttribute("username"))==null){
	request.getSession().invalidate();
	response.sendRedirect("login1.jsp");
}	
else{
	try{
		String quer_de = request.getParameter("query_detail");
		String cust_lo_id = (String)session.getAttribute("username");
		Connection con = null;
		String sql = null;
		PreparedStatement pst = null;
		Statement st = null;
		ResultSet rs = null;
		int login = 0;
		quer_de=quer_de.trim();
		if(quer_de==null || quer_de.length() <= 0){
			throw new Exception();
		}
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
		sql = "SELECT * FROM customer WHERE customer_login_id='"+ cust_lo_id +"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);

		while(rs.next()){
       		//Retrieve by column name
       		int cust_id  = rs.getInt("customer_id");
	       	
			pst = con.prepareStatement("insert into customer_service (customer_id,service_request_date,query_details,employee_id) values ("+cust_id+",?,?,0)");
			pst.setTimestamp(1, new java.sql.Timestamp(new java.util.Date().getTime()));
			pst.setString(2, quer_de);
			pst.executeUpdate();%> 
			<form method="post">
			<script type="text/javascript">
			window.alert('Query submitted successfully!');
			window.location.href="welcome.jsp";
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