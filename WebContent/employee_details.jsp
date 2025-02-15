<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>    
<% if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- Basic Page Needs
    ================================================== -->
    <meta charset="utf-8">
    <!--[if IE]><meta http-equiv="x-ua-compatible" content="IE=9" /><![endif]-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicons
    ================================================== -->
    <link rel="shortcut icon" href="favicon.ico?" type="image/x-icon">
    <link rel="apple-touch-icon" href="img/apple-touch-icon.png">
    <link rel="apple-touch-icon" sizes="72x72" href="img/apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="img/apple-touch-icon-114x114.png">

    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css"  href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="font-awesome-4.2.0/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="css/jasny-bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/animate.css">

    <!-- Slider
    ================================================== -->
    <link href="css/owl.carousel.css" rel="stylesheet" media="screen">
    <link href="css/owl.theme.css" rel="stylesheet" media="screen">

    <!-- Stylesheet
    ================================================== -->
    <link rel="stylesheet" type="text/css"  href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/responsive.css">


    <link href='http://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>

    <script type="text/javascript" src="js/modernizr.custom.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<title>Hello <%= (String)session.getAttribute("username") %></title>
</head>
<%
if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");	
else
{
	try{
		String empl_lo_id = request.getParameter("details");
		Connection con = null;
		String sql = null;
		String sql1 = null;
		String sql2 = null;
		Statement st = null;
		Statement st1 = null;
		Statement st2 = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String name=null;
		String lo_id = (String)session.getAttribute("username");
		String desig = (String)session.getAttribute("desig");
		if(empl_lo_id==null){
			throw new Exception();
		}
		
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
		sql = "SELECT "+desig+"_name FROM "+desig+" WHERE "+desig+"_login_id='"+ lo_id +"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
			name = rs.getString(1);
		}
		
		%>
		<div class="navmenu navmenu-default navmenu-fixed-left offcanvas"> <!--- Off Canvas Side Menu -->

		<div class="close" data-toggle="offcanvas" data-target=".navmenu">
		<span class="fa fa-close"></span>
		</div>

		<div class="add-margin" style="margin-top:50px;margin-bottom:50px" align="justify"><img src="favicon.png?" style="margin:auto; width:100px;display:block" /></div>
		<ul class="nav navmenu-nav"> <!--- Menu -->
		<li><a href="admin_action.jsp?act=Dashboard" class="page-scroll" >Dashboard</a></li>
		<li><a href="admin_action.jsp?act=Profile" class="page-scroll" >Profile</a></li>
		<li><a href="admin_action.jsp?act=New Queries" class="page-scroll">New Queries</a></li>
		<li><a href="admin_action.jsp?act=Employee Summary" class="page-scroll">Employee Summary</a></li>
		<li><a href="admin_action.jsp?act=Customer Summary" class="page-scroll">Customer Summary</a></li>
		<li><a href="admin_action.jsp?act=Register Employee" class="page-scroll">Register Employee</a></li>
		</ul><!--- End Menu -->

		</div> <!--- End Off Canvas Side Menu -->

		<!-- Home Section -->
		<div id="home">

		<div class="container text-center">

		<!-- Navigation -->
		<nav id="menu" data-toggle="offcanvas" data-target=".navmenu">
		    <span class="fa fa-bars"></span>
		    </nav>
		    <div align= "right"style="font-size:16px">Hello,<%=name %>&nbsp&nbsp
		   	 <a href="admin_action.jsp?act=Logout" class="page-scroll" style="color:#FFFFFF;font-size:16px " target="_self">LOGOUT</a>&nbsp&nbsp&nbsp
			</div>
		    <div class="content" align ="justify" style="font-size:18px">
		    <%
		sql = "SELECT * FROM employee where employee_login_id='"+ empl_lo_id +"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
     		//Retrieve by column name
     		int empl_id  = rs.getInt("employee_id");
     		String empl_na = rs.getString("employee_name");
     		long empl_co_no = rs.getLong("employee_contact_no");
     		String empl_ad = rs.getString("employee_address");
	   		
    	 	//Display values%>
	     	<form method="post" name="form1">
	     	<table class="table">
     		<tr><td>Employee ID : <%= empl_id %></td>
     		<td>Login ID : <%= empl_lo_id %></td></tr>
     		<tr><td>Employee Name : <%= empl_na %></td>
     		<td>Employee Contact Number : <%= empl_co_no %></td></tr>
     		<tr><td>Employee Address : <%= empl_ad %></td>
     		<%
         	sql1 = "SELECT employee_expertise_skill FROM employee_expertise where employee_id='"+empl_id+"'";
    		st1 = con.createStatement();
    		rs1 = st1.executeQuery(sql1);
         	while(rs1.next()){
             	//Retrieve by column name
             	String empl_ex_sk = rs1.getString("employee_expertise_skill");
             	
             	//Display values%>
             	<td>Employee Expertise : <%= empl_ex_sk %></td></tr></table></br><%
    		}
         	%></br>
         	<table class="table">
         	<tr><th>Customer ID</th>
     		<th>Customer Email-ID</th>
     		<th>Customer Name</th>
     		<th>Deatils</th></tr><%
         	
         	sql2 = "SELECT DISTINCT customer_id FROM customer_service where employee_id="+empl_id;
    		st2 = con.createStatement();
    		rs2 = st2.executeQuery(sql2);
         	while(rs2.next()){
             	//Retrieve by column name
             	int cust_id  = rs2.getInt("customer_id");

           		sql = "SELECT customer_name,customer_login_id FROM customer where customer_id="+cust_id;
    			st = con.createStatement();
	    		rs = st.executeQuery(sql);
         		while(rs.next()){
             	//Retrieve by column name
             	String cust_na  = rs.getString("customer_name");
     			String cust_lo_id = rs.getString("customer_login_id");
     			             	
             	//Display values%>
             	<form method="post" name="form2">
             	<tr><td><%= cust_id %></td>
             	<td><%= cust_lo_id %></td>
             	<td><%= cust_na %></td>
             	
             	<input type=hidden value="<%=empl_id%>" name="edetails">
             	<input type=hidden value="<%=cust_lo_id%>" name="cdetails">
         		<td><input type="submit" Value="View" formaction="customer_details.jsp" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center"></td></tr>
         		</form><%
        		}
         	}%></table></br><%
    	}
    	%>
    	</form>
    	<form name="form3" method="post" action="admin_action.jsp">
    	<input type="hidden" value="Employee Summary" name="act">
    	<input type="submit" value="Back" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
    	</form><%
	}
	catch (Exception e){%>
		<form method="post">
		<script type="text/javascript">
		window.alert('Sorry, There is some error!',e);
		window.location.href="welcome.jsp";
		</script>
		</form><%
	}
	finally{
		//out.println("Error!");
	}%></div></div></div><%
}	
%>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.1.11.1.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/SmoothScroll.js"></script>
    <script type="text/javascript" src="js/jasny-bootstrap.min.js"></script>

    <script src="js/owl.carousel.js"></script>
    <script src="js/typed.js"></script>
    
    <!-- Javascripts
    ================================================== -->
    <script type="text/javascript" src="js/main.js"></script>
    </body>
    </html>