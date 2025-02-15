<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>    
<%@ page import="java.io.*, java.util.*, java.text.*" %>
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
	try{
		String ad_lo_id = (String)session.getAttribute("username");
		int cust_id=Integer.parseInt(request.getParameter("cust_id"));
		Timestamp serv_re_da = new Timestamp(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S").parse(request.getParameter("serv_re")).getTime());
		Connection con = null;
		String sql = null;
		String sql1 = null;
		Statement st = null;
		Statement st1 = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		String desig = (String)session.getAttribute("desig");
		String name=null,exp=null;
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
        <div class="content" align ="justify" style="font-size:18px">
        <table class="table" style="table-layout:auto" width="150">
		<tr><th>Employee-Id</th>
		<th>Employee Name</th>
		<th>Employee Login Id</th>
		<th>Expertise</th>
		<th>Assign</th></tr><%
		
		sql = "SELECT * FROM employee where employee_status= 'inactive'";
		st= con.createStatement();
		rs = st.executeQuery(sql);
		if(!rs.next()){%>
			<form method="post">
			<script type="text/javascript">
			window.alert('No employee is free to assign!');
			window.location.href="admin_new_job.jsp";
			</script>
			</form><%		
		}
		do{
	   		String empl_na = rs.getString("employee_name");
			int empl_id = rs.getInt("employee_id");
			String empl_lo_id = rs.getString("employee_login_id");
												
			//Display values%>
			<tr><td> <%= empl_id %></td>
			<td><%= empl_na %></td>
			<td><%= empl_lo_id %></td><td><%
			sql1 = "SELECT * FROM employee_expertise WHERE employee_id='"+ empl_id +"'";
       	    st1 = con.createStatement();
       	    rs1 = st1.executeQuery(sql1); 
       	    while(rs1.next()){
       	    	exp=rs1.getString("employee_expertise_skill");
       	    	%><%= exp %> <%
       	    }%></td>
			<form method="post" action ="assign_employee1.jsp" name="form1" >
			<input type="hidden" value="<%=empl_id %>" name="empl_id">
			<input type="hidden" value="<%=serv_re_da %>" name="serv_re">
			<td><input type="submit" value="Assign" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center"></td></tr>
			</form><%
		}while(rs.next());
		%></table></br>
		<form method="post" action="admin_action.jsp">
		<input type="hidden" name="act" value="New Queries" >
		<input type="submit" value="Back" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
		</form><%
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
	}%>

</div></div></div><%
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
