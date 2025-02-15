<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%
	try{
    	String lo_id = request.getParameter("email");    
    	String lo_pa = request.getParameter("password");
    	String desig = request.getParameter("designation");
    	Connection con = null;
    	PreparedStatement st = null;
    	ResultSet rs = null;
    	boolean login = false;

	    Class.forName("com.mysql.jdbc.Driver");
	    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
	    String sql = "SELECT * FROM " + desig + " WHERE "+desig+"_login_id=? AND "+desig+"_login_password=?";
	    st = con.prepareStatement(sql);
	    st.setString(1, lo_id);
	    st.setString(2, lo_pa);
	    rs = st.executeQuery();
	    login = rs.next();
	    if (login) 
	    {
		    request.getSession().setAttribute("username", lo_id);
	       	request.getSession().setAttribute("desig", desig);
	       	response.sendRedirect("welcome.jsp");
	    } 
	    else 
	    {%>
			<form method="post" action="login1.jsp">
			<script type="text/javascript">
			window.alert('Invalid Userid/Password!');
			window.history.go(-1);
			</script>
	 		</form><%    	
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