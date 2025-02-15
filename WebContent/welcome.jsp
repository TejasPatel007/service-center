<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String desig = (String)request.getSession().getAttribute("desig");%>
<html>
<head> <!-- Basic Page Needs
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello <%= (String)session.getAttribute("username") %></title>
</head>
<body>
<% if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");	
else
{
	String empl_lo_id = (String)session.getAttribute("username");
	Connection con = null;
	String sql,sql1,sql2,sql3 = null;
	Statement st,st1,st2,st3 = null;
	ResultSet rs,rs1,rs2,rs3 = null;
	
	String name=null;
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
	
if("customer".equals(desig))
{
sql = "SELECT "+desig+"_name FROM "+desig+" WHERE "+desig+"_login_id='"+ empl_lo_id +"'";
	st = con.createStatement();
	rs = st.executeQuery(sql);
	while(rs.next()){
		name = rs.getString(1);
	}%>
<div class="navmenu navmenu-default navmenu-fixed-left offcanvas"> <!--- Off Canvas Side Menu -->
	
    <div class="close" data-toggle="offcanvas" data-target=".navmenu">
        <span class="fa fa-close"></span>
    </div>
	
    <div class="add-margin" style="margin-top:50px;margin-bottom:50px" align="justify"><img src="favicon.png?" style="margin:auto; width:100px;display:block" /></div>
    <ul class="nav navmenu-nav"> <!--- Menu -->
        	<li><a href="customer_action.jsp?act=Query" class="page-scroll" target="_self">Home</a></li>
            <li><a href="customer_action.jsp?act=Profile" class="page-scroll" target="_self">Profile</a></li>
            <li><a href="customer_action.jsp?act=Summary" class="page-scroll" target="_self">Summary</a></li>
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
				<a href="customer_action.jsp?act=Logout" class="page-scroll" style="color:#FFFFFF;font-size:16px" target="_self">LOGOUT</a>&nbsp&nbsp&nbsp
			</div>

            <div class="content" align ="justify" style="font-size:20px">
            Any Query?
		   	<form method="post" action="query.jsp">
		   	<input type=text maxlength=256 size="35px" placeholder="Insert your problem description here" name="query_detail" style="color: #282f35" required>
		   	<input type="submit" value="Submit Query"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 10em;  height: 2em;text-align: center">
		   	</form>
			</div>
            </div>

        </div>
    </div>
    <%
}
else if("employee".equals(desig))
{int count=0;int count1=0;int count2=0;int empl_id;
sql = "SELECT "+desig+"_name FROM "+desig+" WHERE "+desig+"_login_id='"+ empl_lo_id +"'";
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
    <li><a href="employee_action.jsp?act=Dashboard" class="page-scroll" >Dashboard</a></li>
    <li><a href="employee_action.jsp?act=Profile" class="page-scroll" >Profile</a></li>
    <li><a href="employee_action.jsp?act=Summary" class="page-scroll">Summary</a></li>
    <li><a href="employee_action.jsp?act=New Job" class="page-scroll">New Job</a></li>
    <li><a href="employee_action.jsp?act=Edit Job" class="page-scroll">Edit Job</a></li>
    </ul><!--- End Menu -->
    
</div> <!--- End Off Canvas Side Menu -->

<!-- Home Section -->
<div id="home">
	
    <div class="container text-center">
	
        <!-- Navigation -->
        <nav id="menu" data-toggle="offcanvas" data-target=".navmenu">
            <span class="fa fa-bars"></span>
        </nav>
            <div align= "right"style="font-size:16px">Hello,<%=name %>&nbsp&nbsp<%
		
		sql = "select * from employee where employee_login_id='"+empl_lo_id+"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
	     	//Retrieve by column name
	     	String empl_st = rs.getString("employee_status");
			if("inactive".equals(empl_st)){
			%><a href="change_status.jsp" class="page-scroll" style="color:#FFFFFF;font-size:16px " target="_self">INACTIVE</a>&nbsp&nbsp<%
			}
			else{
			%><a href="change_status.jsp" class="page-scroll" style="color:#FFFFFF;font-size:16px " target="_self">ACTIVE</a>&nbsp&nbsp<%
			}
	  	}%>
       	 <a href="employee_action.jsp?act=Logout" class="page-scroll" style="color:#FFFFFF;font-size:16px " target="_self">LOGOUT</a>&nbsp&nbsp&nbsp
		</div>    
        <% 
        sql3="SELECT * FROM employee WHERE employee_login_id='"+empl_lo_id+"'";
		st3 = con.createStatement();
		rs3 = st3.executeQuery(sql3);
		if(rs3.next()==true)
		{
		empl_id = rs3.getInt("employee_id");
		
    	sql="SELECT DISTINCT(customer_id) FROM customer_service WHERE employee_id='"+empl_id+"'";
    	st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
			count++;
			
		}
		sql1="SELECT customer_id FROM query_report WHERE issue_detail= 'UNKNOWN' AND issue_status = 'done' AND employee_id='"+empl_id+"'";
    	st1 = con.createStatement();
		rs1 = st1.executeQuery(sql1);
		while(rs1.next()){
			count1++;
			
		}
		sql2="SELECT * FROM query_report  WHERE issue_detail='UNKNOWN' AND issue_status = 'pending' AND employee_id='"+empl_id+"'";
		st2 = con.createStatement();
		rs2 = st1.executeQuery(sql2);
		while(rs2.next()){
			count2++;
			
		}
		}%>
        <div class="content" align ="justify" style="font-size:20px">
        <table style="margin-right: -15px;margin-left: -15px;">
	<tr><td><div style="width: 50%; text-align:center;padding:20px;border-color:#7FFF00;margin-right:-260px;margin-left: 110px;color: #fff;background-color:#7FFF00;font-size:25px">
	 Customers Assigned
 	<pre style="background:transparent;border:none;overflow:hidden;color:#FFFFFF">        <input type="text" align="middle" value="<%=count%>" style="background: transparent;border:none;font-size:40px">
	 </pre></div></td>
	<td><div style="width: 50%; text-align:center;padding:20px;margin-right: -40px;margin-left: -90px;border-color:#1E90FF;color: #fff;background-color:#1E90FF;font-size:25px">
	 Services  Fulfilled
 	<pre style="background:transparent;border:none;overflow:hidden;color:#FFFFFF">        <input type="text" align="middle" value="<%=count1%>" style="background: transparent;border:none;font-size:40px">
 	</pre></div></td> 
 	<td><div style="width: 50%; text-align:center;padding:20px;margin-right: 150px;margin-left: -300px;border-color:#DC143C;color: #fff;background-color:#DC143C;font-size:25px">
	 Services Pending
 	<pre style="background:transparent;border:none;overflow:hidden;color:#FFFFFF">        <input type="text" align="middle" value="<%=count2%>" style="background: transparent;border:none;font-size:40px">
 	</pre></div></td></tr></table>
 </div>
	</div>
	</div>
	<%
}	
else if("admin".equals(desig))
{sql = "SELECT "+desig+"_name FROM "+desig+" WHERE "+desig+"_login_id='"+ empl_lo_id +"'";
	st = con.createStatement();
	rs = st.executeQuery(sql);
	while(rs.next()){
		name = rs.getString(1);
	}%>
<div class="navmenu navmenu-default navmenu-fixed-left offcanvas"> <!--- Off Canvas Side Menu -->

<div class="close" data-toggle="offcanvas" data-target=".navmenu">
    <span class="fa fa-close"></span>
</div>

<div class="add-margin" style="margin-top:50px;margin-bottom:50px" align="justify"><img src="favicon.png?" style="margin:auto; width:100px;display:block" /></div>
    
<ul class="nav navmenu-nav"> <!--- Menu -->
    <li><a href="admin_action.jsp?act=Dashboard" class="page-scroll" >Dashboard</a></li>
    <li><a href="admin_action.jsp?act=Profile" class="page-scroll" target="_self">Profile</a></li>
    <li><a href="admin_action.jsp?act=Employee Summary" class="page-scroll" target="_self">Employee Summary</a></li>
    <li><a href="admin_action.jsp?act=Customer Summary" class="page-scroll" target="_self">Customer Summary</a></li>
    <li><a href="admin_action.jsp?act=New Queries" class="page-scroll" target="_self">New Queries</a></li>
    <li><a href="admin_action.jsp?act=Register Employee" class="page-scroll" target="_self">Register Employee</a></li>
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
<%int count=0;int count1=0;int count2=0;
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
		<tr><td><div style="width: 50%; text-align:center;padding:20px;border-color:#FFD700;margin-right:-260px;margin-left: 110px;color: #fff;background-color:#FFD700;font-size:25px">
		 Customer Registered
     	<pre style="background:transparent;border:none;overflow:hidden;color:#FFFFFF">        <input type="text" align="middle" value="<%=count%>" style="background: transparent;border:none;font-size:40px">
    	 </pre></div></td>
    	<td><div style="width: 50%; text-align:center;padding:20px;margin-right: -60px;margin-left: -90px;border-color:#d9534f;color: #fff;background-color:#d9534f;font-size:25px">
		 Employee Hired
     	<pre style="background:transparent;border:none;overflow:hidden;color:#FFFFFF">        <input type="text" align="middle" value="<%=count1%>" style="background: transparent;border:none;font-size:40px">
     	</pre></div></td> 
     	<td><div style="width: 50%; text-align:center;padding:20px;margin-right: 130px;margin-left: -290px;border-color:#ADFF2F;color: #fff;background-color:#ADFF2F;font-size:25px">
		 New Service Request
     	<pre style="background:transparent;border:none;overflow:hidden;color:#FFFFFF">        <input type="text" align="middle" value="<%=count2%>" style="background: transparent;border:none;font-size:40px">
     	</pre></div></td></tr></table>
     </div>

</div>
</div>
<%
}
else{%>
<form method="post">
<script type="text/javascript">
	window.location.href="index.html";
</script><%
}
}%>

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
