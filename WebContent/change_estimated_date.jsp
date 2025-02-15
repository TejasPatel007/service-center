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
		String empl_lo_id = (String)session.getAttribute("username");
		int prob = Integer.parseInt(request.getParameter("idetails"));
		int i,counter=0;
		
		String[] issue_de = new String[prob];
		for(i=0;i<prob;i++){
			issue_de[i] = request.getParameter("dedetails"+i);
			
		}

		Timestamp serv_re_da = new Timestamp(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S").parse(request.getParameter("sdetails")).getTime());
	
		String[] stringDate = new String[prob];
		for(i=0;i<prob;i++){
			stringDate[i] = request.getParameter("dadetails"+i);
			if(stringDate[i]==""){
				counter++;
			}
		}
		if(counter==prob){
			throw new IOException("All_Blank_Dates");
		}
		
		String strDate="0000-00-00";
		DateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date parsedUtilDate = formater.parse("0000-00-00");
		if(stringDate[0]==""){
			parsedUtilDate = formater.parse("0000-00-00");
		}
		else{
			parsedUtilDate = formater.parse(stringDate[0]);
		}
		java.sql.Date[] date1= new java.sql.Date[prob];
		
	    for(i=0;i<prob;i++){
			if(stringDate[i]==""){
				parsedUtilDate = formater.parse(strDate);
				date1[i] = new java.sql.Date(parsedUtilDate.getTime());
			}
			else{
				parsedUtilDate = formater.parse(stringDate[i]);
				date1[i] = new java.sql.Date(parsedUtilDate.getTime());
			}
		}
	
		Connection con = null;
		String sql,sql1 = null;
		PreparedStatement st,st1 = null;
		int rs=0,rs1=0;
		
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
		for(i=0;i<prob;i++){
			if(stringDate[i]==""){
				continue;
			}
			else{
				if("UNKNOWN".equals(issue_de[i])){
					sql = "update customer_service set service_fulfill_date='"+ date1[i] +"' WHERE service_request_date='"+ serv_re_da +"'";
					st = con.prepareStatement(sql);
					rs=st.executeUpdate();
					if(rs==0){%>
					<form method="post" action="employee_action.jsp" name ="form1">
					<input type="hidden" value="Edit Job" name="act">
					<script type="text/javascript">
					window.alert("Error!");
					document.form1.submit();
					</script>
		 			</form><%
					}
				}	
				sql1 = "update query_report set service_estimated_date = '"+ date1[i] +"' WHERE service_request_date='"+ serv_re_da +"' and issue_detail='"+ issue_de[i] +"'";
				st1 = con.prepareStatement(sql1);
				rs1=st1.executeUpdate();
				
				if(rs1>0){%>
				<form method="post" action="employee_action.jsp" name ="form1">
				<input type="hidden" value="Edit Job" name="act">
				<script type="text/javascript">
				window.alert('Date Changed!');
				document.form1.submit();
				</script>
 				</form><%
				}
				else{%>
				<form method="post" action="employee_action.jsp" name ="form1">
				<input type="hidden" value="Edit Job" name="act">
				<script type="text/javascript">
				window.alert("Error!");
				document.form1.submit();
				</script>
	 			</form><%
				}
			}
		}
	}
	catch (IOException ioe){%>
		<form method="post">
		<script type="text/javascript">
		window.alert('No change in dates!');
		window.location.href="employee_action.jsp?act=Edit Job";
		</script>
		</form><%		
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