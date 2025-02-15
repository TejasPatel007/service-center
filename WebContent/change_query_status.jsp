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
		int cust_id = Integer.parseInt(request.getParameter("cdetails"));
		String empl_lo_id = (String)session.getAttribute("username");
		String issue_de = request.getParameter("dedetails");
		String issue_st = request.getParameter("stdetails");
		Timestamp serv_re_da = new Timestamp(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S").parse(request.getParameter("sdetails")).getTime());
		
		Connection con = null;
		String sql,sql1,sql2 = null;
		Statement st2 = null;
		PreparedStatement st,st1 = null;
		int i,rs=0,rs1=0,flag=0;
		ResultSet rs2 = null;
		
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
		
		sql = "update query_report set issue_status = 'done' WHERE service_request_date='"+ serv_re_da +"' and issue_detail='"+issue_de+"'";
		st = con.prepareStatement(sql);
		rs=st.executeUpdate();
		sql1 = "update query_report set service_estimated_date = '"+ new java.sql.Date(new java.util.Date().getTime()) +"' WHERE service_request_date='"+ serv_re_da +"' and issue_detail='"+issue_de+"'";
		st1 = con.prepareStatement(sql1);
		rs1=st1.executeUpdate();
		if(rs>0 && rs1>0){
			sql2 = "SELECT issue_detail,issue_status FROM query_report WHERE service_request_date='"+ serv_re_da +"'";
			st2 = con.createStatement();
			rs2 = st2.executeQuery(sql2);
			while(rs2.next()){
				issue_de = rs2.getString("issue_detail");
				issue_st = rs2.getString("issue_status");
				if(issue_de.matches("UNKNOWN")==false){
					if(issue_st.matches("done")){
						flag=0;
					}
					else{
						flag=1;
						break;
					}
				}
				else
					continue;
			}
			if(flag==0){
				
				sql = "update customer_service set service_fulfill_date='"+ new java.sql.Date(new java.util.Date().getTime()) +"' WHERE service_request_date='"+ serv_re_da +"'";
				st = con.prepareStatement(sql);
				st.executeUpdate();
				sql = "update query_report set service_estimated_date = '"+ new java.sql.Date(new java.util.Date().getTime()) +"' WHERE service_request_date='"+ serv_re_da +"' and issue_detail='UNKNOWN'";
				st = con.prepareStatement(sql);
				st.executeUpdate();	
				sql = "update query_report set issue_status = 'done' WHERE service_request_date='"+ serv_re_da +"' and issue_detail='UNKNOWN'";
				st = con.prepareStatement(sql);
				st.executeUpdate();
			}
			%>
			<form method="post" name="form1" action="edit_current_job.jsp">
			<input type="hidden" value="Change query status" name="act">
			<input type="hidden" value="<%=serv_re_da %>" name="serv_re">
			<input type="hidden" value="<%=cust_id%>" name="cdetails">
			<script type="text/javascript">
			window.alert('Status Changed!');
			document.form1.submit();
			</script>
			</form><%
		}
		else{%>
			<form method="post" action="welcome.jsp">
			<script type="text/javascript">
			window.alert('Error!');
			window.location.back();
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
		//nothing!!!
	}
}
%>