<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*, java.util.*, java.text.*, java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello <%= (String)session.getAttribute("username") %></title>
</head>
</html>
<%if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");	
else
{
	try{
		int cust_id=Integer.parseInt(request.getParameter("cdetails"));
		Timestamp serv_re_da = new Timestamp(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S").parse(request.getParameter("serv_re")).getTime());
		
		String stringDate = request.getParameter("serv_es");
		DateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date parsedUtilDate = formater.parse(stringDate);
		java.sql.Date date1= new java.sql.Date(parsedUtilDate.getTime());
		
		String empl_lo_id = (String)session.getAttribute("username");
		Connection con = null;
		String sql = null;
		String sql1 = null;
		String sql2 = null;
		Statement st = null;
		PreparedStatement st1 = null;
		PreparedStatement st2 = null;
		ResultSet rs = null;
		int i,rs1=0,rs2=0;
		
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
		sql = "SELECT * FROM employee WHERE employee_login_id='"+ empl_lo_id +"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
			int empl_id = rs.getInt("employee_id");
			sql1 = "insert into query_report(customer_id,employee_id,service_request_date,issue_detail,issue_status,service_estimated_date) values (?,?,?,'UNKNOWN','pending',?)";
			st1 = con.prepareStatement(sql1);
			st1.setInt(1, cust_id);
			st1.setInt(2, empl_id);
			st1.setTimestamp(3, serv_re_da);
			st1.setDate(4, date1);
			rs1=st1.executeUpdate();
			if(rs1>0){
				sql2 = "update customer_service set service_fulfill_date='"+ date1+"' WHERE service_request_date='"+ serv_re_da +"'";
				st2 = con.prepareStatement(sql2);
				rs2 = st2.executeUpdate();
				if(rs2>0){%>
					<form method="post" name="form1" action="employee_action.jsp">
					<input type="hidden"  value="New Job" name="act">
					<script type="text/javascript">
					window.alert('Date submitted successfully!');
					document.form1.submit();
					</script>
			 		</form><%
				}
				else{%>
					<form method="post" name="form1" action="employee_action.jsp">
					<input type="hidden"  value="New Job" name="act">
					<script type="text/javascript">
					window.alert('Something went wrong!!');
					document.form1.submit();
					</script>
			 		</form><%
				}
			}
			else{%>
				<form method="post">
				<script type="text/javascript">
				window.alert('Something went wrong!');
				window.location.href="welcome.jsp";
				</script>
		 		</form><%
			}
		}
	}
	catch (Exception p){%>
		<form method="post">
		<script type="text/javascript">
		window.alert('Sorry, There is some error!');
		window.location.href="new_job.jsp";
		</script>
 		</form><%
	}
	finally{
		//out.println("Error!");
	}
}
%>