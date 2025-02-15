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
		int i;
		String empl_lo_id = (String)session.getAttribute("username");
		int cust_id = Integer.parseInt(request.getParameter("cdetails"));
		int prob = Integer.parseInt(request.getParameter("problems"));
		String[] proble = new String[prob];
		for(i=0;i<prob;i++){
			proble[i] = request.getParameter("problem"+i);
		}
		Timestamp serv_re_da = new Timestamp(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S").parse(request.getParameter("sdetails")).getTime());

		String[] stringDate = new String[prob];
		for(i=0;i<prob;i++){
			stringDate[i] = request.getParameter("date"+i);
		}
		DateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date parsedUtilDate = formater.parse(stringDate[0]);
		java.sql.Date[] date1= new java.sql.Date[prob];
		for(i=0;i<prob;i++){
			parsedUtilDate = formater.parse(stringDate[i]);
			date1[i] = new java.sql.Date(parsedUtilDate.getTime());
		}
				
		Connection con = null;
		String sql = null;
		String sql1 = null;
		Statement st = null;
		PreparedStatement st1 = null;
		ResultSet rs = null;
		int rs1=0;
		
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
		sql = "SELECT * FROM employee WHERE employee_login_id='"+ empl_lo_id +"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
			int empl_id = rs.getInt("employee_id");
			for(i=0;i<prob;i++){
				sql1 = "insert into query_report(customer_id,employee_id,service_request_date,issue_detail,issue_status,service_estimated_date) values (?,?,?,?,'pending',?)";
				st1 = con.prepareStatement(sql1);
				st1.setInt(1, cust_id);
				st1.setInt(2, empl_id);
				st1.setTimestamp(3, serv_re_da);
				st1.setString(4, proble[i]);
				st1.setDate(5, date1[i]);
				rs1=st1.executeUpdate();
				if(rs1>0){%>
					<form method="post" name="form1" action="employee_action.jsp">
					<input type="hidden" value="Edit Job" name="act">
					<script type="text/javascript">
					window.alert('Query added successfully!');
					document.form1.submit();
					</script>
		 			</form><%
				}
				else{%>
					<form method="post" action="welcome.jsp">
					<script type="text/javascript">
					window.alert('Error!');
					window.location.go(-2);
					</script>
	 				</form><%
				}
			}
		}
	}
	catch (Exception e){%>
		<form method="post">
		<script type="text/javascript">
		window.alert('Sorry, There is some error!');
		window.location.href="employee_action.jsp?act=Edit Job";
		</script>
 		</form><%
	}
	finally{
		//nothing!!!
	}
}
%>