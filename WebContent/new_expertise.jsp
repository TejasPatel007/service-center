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
		String empl_ac = request.getParameter("act");
		String empl_lo_id = (String)session.getAttribute("username");
		Connection con = null;
		String sql = null;
		Statement st = null;
		PreparedStatement st1 = null;
		ResultSet rs = null;
		int i,rs1=0;
		int empl_id=0;
		int count=0;
		
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
		sql = "SELECT * FROM employee WHERE employee_login_id='"+ empl_lo_id +"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
			 empl_id = rs.getInt("employee_id");
		}
		if("new expertise".equals(empl_ac))
		{
			String[] expertise=request.getParameterValues("expertise");
			String[] new_exp=new String[expertise.length];
			for(i=0;i<expertise.length;i++){
			    new_exp[i]=expertise[i];
			}
			for(i=0;i<expertise.length;i++){
				sql= "INSERT INTO employee_expertise(employee_id,employee_expertise_skill)VALUES(?,?)";
				st1 = con.prepareStatement(sql);
				st1.setInt(1,empl_id);
				st1.setString(2,new_exp[i]);
				rs1 = st1.executeUpdate();
				if(rs1>0){%>
					<form method="post" name="form1" action="add_expertise.jsp">
					<script type="text/javascript">
					window.alert('Expertise submitted!');
					document.form1.submit();
					</script>
 					</form><%
				}
				else{%>
					<form method="post" name="form1" action="employee_action.jsp">
					<input type="hidden"  value="Profile" name="act">
					<script type="text/javascript">
					window.alert('Something went wrong!!');
					document.form1.submit();
					</script>
 					</form><%
				}
			}
		}
		if("edit expertise".equals(empl_ac))
		{
			try{
			String[] expertise=request.getParameterValues("expertise");
			String[] new_exp=new String[expertise.length];
			for(i=0;i<expertise.length;i++){
			    new_exp[i]=expertise[i];
			}
			
			for(i=0;i<expertise.length;i++){
				sql = "SELECT * FROM employee_expertise where employee_id='"+ empl_id +"'";
				st = con.createStatement();
				rs = st.executeQuery(sql);
				while(rs.next()){
					count++;
				}
				if(count==0){
					for(i=0;i<expertise.length;i++){
					sql= "INSERT INTO employee_expertise(employee_id,employee_expertise_skill)VALUES(?,?)";
					st1 = con.prepareStatement(sql);
					st1.setInt(1,empl_id);
					st1.setString(2,new_exp[i]);
					rs1 = st1.executeUpdate();
					}
				}
				else{
					sql = "UPDATE employee_expertise SET employee_expertise_skill='"+new_exp[i]+"' WHERE employee_id='"+empl_id+"'";
					st1 = con.prepareStatement(sql);
					rs1 = st1.executeUpdate();
				}
				if(rs1>0){%>
					<form method="post" name="form1" action="add_expertise.jsp">
					<script type="text/javascript">
					window.alert('Expertise submitted!');
					document.form1.submit();
					</script>
	 				</form><%		
				}
				else{%>
					<form method="post" name="form1" action="employee_action.jsp">
					<input type="hidden"  value="Profile" name="act">
					<script type="text/javascript">
					window.alert('Something went wrong!!xdf');
					document.form1.submit();
					</script>
					</form><%
				}
			}
			}
			catch(Exception p){
				
			}finally{
				
			}
			
			try{
			String[] rexpertise=request.getParameterValues("rexpertise");
			String[] del_exp=new String[rexpertise.length];
			for(i=0;i<rexpertise.length;i++){
			    del_exp[i]=rexpertise[i];
			}
			for(i=0;i<rexpertise.length;i++){
				sql = "delete from employee_expertise where employee_expertise_skill='"+del_exp[i]+"' and employee_id='"+empl_id+"'";
				st1 = con.prepareStatement(sql);
				rs1 = st1.executeUpdate();
				if(rs1>0){%>
					<form method="post" name="form1" action="add_expertise.jsp">
					<script type="text/javascript">
					window.alert('Data submitted successfully!');
					document.form1.submit();
					</script>
	 				</form><%		
				}
				else{%>
					<form method="post" name="form1" action="employee_action.jsp">
					<input type="hidden"  value="Profile" name="act">
					<script type="text/javascript">
					window.alert('Something went wrong!!');
					document.form1.submit();
					</script>
					</form><%
				}
			}
			}
			catch(Exception p){
				
			}finally{
				
			}
		}
	}
	catch (Exception p){%>
		<form method="post">
		<script type="text/javascript">
		window.alert('Sorry, There is some error!');
		window.location.href="add_expertise.jsp";
		</script>
 		</form><%
	}
	finally{
		//out.println("Error!");
	}
}
%>