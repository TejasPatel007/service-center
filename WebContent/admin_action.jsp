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
<body>
<% if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");	
else
{
	String ad_ac = request.getParameter("act");
	String ad_lo_id = (String)session.getAttribute("username");
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
	String desig=(String)session.getAttribute("desig");
	int count=0;int count1=0;int count2=0;
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
	sql = "SELECT "+desig+"_name FROM "+desig+" WHERE "+desig+"_login_id='"+ ad_lo_id +"'";
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
            
	<%
	if("Dashboard".equals(ad_ac))
	{
    	sql="SELECT * FROM customer";
    	st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
			count++;
			
		}
		sql1="SELECT * FROM employee";
    	st1 = con.createStatement();
		rs1 = st1.executeQuery(sql1);
		while(rs1.next()){
			count1++;
			
		}
		sql2="SELECT * FROM customer_service WHERE employee_id = 0 ";
		st2 = con.createStatement();
		rs2 = st1.executeQuery(sql2);
		while(rs2.next()){
			count2++;
			
		}
  	%>
            <div class="content" align ="justify" style="font-size:20px">
            <table style="margin-right: -15px;margin-left: -15px;">
		<tr><td><div style="width: 50%; text-align:center;padding:20px;border-color:#f0ad4e;margin-right:-260px;margin-left: 110px;color: #fff;background-color:#f0ad4e;font-size:25px">
		 Customer Registered
     	<pre style="background:transparent;border:none;overflow:hidden;color:#FFFFFF">        <input type="text" align="middle" value="<%=count%>" style="background: transparent;border:none;font-size:40px">
    	 </pre></div></td>
    	<td><div style="width: 50%; text-align:center;padding:20px;margin-right: -40px;margin-left: -90px;border-color:#ADFF2F;color: #fff;background-color:#ADFF2F;font-size:25px">
		 Employee Hired
     	<pre style="background:transparent;border:none;overflow:hidden;color:#FFFFFF">        <input type="text" align="middle" value="<%=count1%>" style="background: transparent;border:none;font-size:40px">
     	</pre></div></td> 
     	<td><div style="width: 50%; text-align:center;padding:20px;margin-right: 150px;margin-left: -300px;border-color:#d9534f;color: #fff;background-color:#d9534f;font-size:25px">
		 New Service Request
     	<pre style="background:transparent;border:none;overflow:hidden;color:#FFFFFF">        <input type="text" align="middle" value="<%=count2%>" style="background: transparent;border:none;font-size:40px">
     	</pre></div></td></tr></table>
     </div>
    	</div>
    	</div><%
	}
	if("Profile".equals(ad_ac))
	{%><div class="content" align ="justify" style="font-size:20px"><%
		sql = "SELECT * FROM admin WHERE admin_login_id='"+ ad_lo_id +"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
         	//Retrieve by column name
         	String ad_na = rs.getString("admin_name");
         	String ad_ad = rs.getString("admin_address");
         	long ad_co_no = rs.getLong("admin_contact_no");
         	String ad_lo_pa = rs.getString("admin_login_password");
	
         	//Display values%>
         	Login ID: <%= ad_lo_id %></br>
         	Name: <%= ad_na %></br>
         	Address: <%= ad_ad %></br>
         	Contact Number: <%= ad_co_no %></br></br>
         	<form method="post" action="change_password.jsp">
		 	<button value="Change Password" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">Change Password</button>
		 	</form><%
      	}%></br>
		<form method ="post" action="welcome.jsp" >
		<input type="submit" value="Back" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
	    </form>
	    </div>
    	</div>
    	</div>
	    <%
	}

	else if("Employee Summary".equals(ad_ac))
	{%><div class="content" align ="justify" style="font-size:20px">
            <table class="table" style="table-layout:auto" width="150">
         	<tr>
         	<th>Employee ID</th> 
         	<th>Employee Name</th> 
         	<th>Employee Status</th> 
    		<th>Details</th></tr><%
		sql = "SELECT * FROM employee";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
         	//Retrieve by column name
         	int empl_id  = rs.getInt("employee_id");
         	String empl_na = rs.getString("employee_name");
         	String empl_st = rs.getString("employee_status");
         	String empl_lo_id = rs.getString("employee_login_id");%>
         	<tr><td><%= empl_id %></td>
         	<td><%= empl_na %></td>
         	<td><%= empl_st %></td>
    		<form method="post" name="form1" action="employee_details.jsp">
    		<input type=hidden value="<%=empl_lo_id%>" name="details">
         	<td><input type="submit" Value="View" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center"></td></tr>
         	</form>
         	<%
    	}%></table></br>
		<form method ="post" action="welcome.jsp">
		<input type="submit" value="Back" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
	    </form>
	    </div>
		</div>
   		</div><%
	}
	
	else if("Customer Summary".equals(ad_ac))
	{%><div class="content" align ="justify" style="font-size:20px">
	<table class="table" style="table-layout:auto" width="150">
         	<tr>
         	<th>Customer ID</th>
         	<th>Customer Login ID</th>
         	<th>Customer Name</th>
         	<th>Details</th></tr>
		<%
		sql = "SELECT * FROM customer";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
         	//Retrieve by column name
         	int cust_id  = rs.getInt("customer_id");
         	String cust_na = rs.getString("customer_name");
         	String cust_lo_id = rs.getString("customer_login_id");
         	   			
         	//Display values%>
         	 <tr><td><%= cust_id %></td>
         	 <td><%= cust_lo_id %></td>
         	 <td><%= cust_na %></td>
         	<form method="post" name="form2" action="customer_details1.jsp">
         	<input type=hidden value="<%=cust_lo_id%>" name="details">
         	<td><input type="submit" Value="View" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center"></td></tr>
         	</form><%
    	}%></table></br>
		<form method ="post" action="welcome.jsp">
		<input type="submit" value="Back" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
	    </form>
	    </div>
	    </div>
	    </div><%	
	}

	else if("New Queries".equals(ad_ac))
	{
		response.sendRedirect("admin_new_job.jsp"); 	
	}
	
	else if("Register Employee".equals(ad_ac))
	{
		response.sendRedirect("register1.jsp");	
	}
	
	else if("Logout".equals(ad_ac))
	{
		request.getSession().invalidate();
        response.sendRedirect(request.getContextPath() + "/login1.jsp"); 	
	}
	
	else{
		response.sendRedirect("welcome.jsp");
	}
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
