<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
</head>
<body>
</body>
</html>
<%
try{
    String iname = request.getParameter("username");    
    String iaddress = request.getParameter("address");
    String icontact = request.getParameter("contact");
    String iemail = request.getParameter("email");
    String ipassword = request.getParameter("passid");
    String desig = (String)session.getAttribute("desig");
    String isexp = request.getParameter("exp");
    String iszip = request.getParameter("zip");
    if(iszip!=""){
    	iaddress=iaddress+',ZIP:'+iszip;
    }
    if(iname=="" && iaddress=="" && icontact==null && iemail=="" && ipassword=="")
    {
    	%><jsp:forward page="register1.jsp" /><% 
    }
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root", "");
    Statement st = con.createStatement();

    if("admin".equals(desig))
    {
    	desig="employee";
    	String isalary = request.getParameter("sal");
    	int i = st.executeUpdate("insert into " + desig +"("+desig+"_name, "+desig+"_address, "+desig+"_contact_no, "+desig+"_login_id, "+desig+"_login_password, "+desig+"_salary) values ('" + iname + "','" + iaddress + "','" + icontact + "','" + iemail + "','" + ipassword +"','" + isalary + "')");
    	if (i > 0) {
    		String sql = "select employee_id from employee where employee_login_id='"+iemail+"'";
    		st = con.createStatement();
    		ResultSet rs = st.executeQuery(sql);
    		if(rs.next()==true){
    			int empl_id = rs.getInt("employee_id");
	    		
    			int j = st.executeUpdate("insert into employee_expertise values ('" + empl_id + "','" + isexp + "')");
    			if(j>0){
    				response.sendRedirect("welcome.jsp");
    			}else{
        			response.sendRedirect("register1.jsp");
        		}
    		}
    	} else {
        	response.sendRedirect("register1.jsp");
    	}
    }
   	else
    {
    	desig="customer";
    	int i = st.executeUpdate("insert into " + desig +"("+desig+"_name, "+desig+"_address, "+desig+"_contact_no, "+desig+"_login_id, "+desig+"_login_password) values ('" + iname + "','" + iaddress + "','" + icontact + "','" + iemail + "','" + ipassword +"')");
    	if (i > 0) {
        	session.setAttribute("username", iemail);
        	session.setAttribute("desig", desig);
        	response.sendRedirect("welcome.jsp");
    	} else {
        	response.sendRedirect("login1.jsp");
    	}
    }
}
catch (Exception e) 
{%>
	<form method="post" action="login1.jsp">
	<script type="text/javascript">
	window.alert('Sorry, There is some error!');
	</script>
	</form><%
	if(request.getSession().getAttribute("username")==null)
		response.sendRedirect("login1.jsp");
	else
		response.sendRedirect("welcome.jsp");
} 
finally {
	//nothing
}
%>