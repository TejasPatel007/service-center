<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
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
<% if((request.getSession().getAttribute("username"))==null && (request.getSession().getAttribute("desig"))!="employee"){
	request.getSession().invalidate();
	response.sendRedirect("login1.jsp");
}	
else
{
	String empl_ac = request.getParameter("act");
	String empl_lo_id = (String)session.getAttribute("username");
	Connection con = null;
	String sql = null;
	String sql1 = null;
	String sql2 = null;
	String sql3 = null;
	String sql4 = null;
	String sql5 = null;
	Statement st = null;
	Statement st1 = null;
	Statement st2 = null;
	Statement st3 = null;
	Statement st4 = null;
	Statement st5 = null;
	ResultSet rs = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	ResultSet rs4 = null;
	ResultSet rs5 = null;
	int flag=0;
	int empl_id;
	String name=null;
	String desig= (String)session.getAttribute("desig");
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
	sql = "SELECT "+desig+"_name FROM "+desig+" WHERE "+desig+"_login_id='"+ empl_lo_id +"'";
	st = con.createStatement();
	rs = st.executeQuery(sql);
	while(rs.next()){
		name = rs.getString(1);
	}

	if("Dashboard".equals(empl_ac))
	{
		int count=0;
		int count1=0;
		int count2=0;
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
    	</div><%
	}
	else if("Profile".equals(empl_ac))
	{%>
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

            <div class="content" align ="justify" style="font-size:20px"><%
        sql = "SELECT * FROM employee WHERE employee_login_id='"+ empl_lo_id +"'";
        st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
         	//Retrieve by column name
         	String empl_na = rs.getString("employee_name");
         	String empl_ad = rs.getString("employee_address");
         	long empl_co_no = rs.getLong("employee_contact_no");
         	String empl_lo_pa = rs.getString("employee_login_password");
	
         	//Display values%>
         	Login ID: <%= empl_lo_id %></br>
         	Name: <%= empl_na %></br>
         	Address: <%= empl_ad %></br>
         	Contact Number: <%= empl_co_no %></br></br>
         	<form method="post" action="add_expertise.jsp">
		 	<button value="Add Expertise" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">Add Expertise</button>
		 	</form></br>
         	<form method="post" action="change_password.jsp">
		 	<button value="Change Password" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">Change Password</button>
		 	</form><%
      	}%></br>
    	<form method="post" action="welcome.jsp">
	 	<input type="submit" value="Back"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
		</form>
			</div>
    	</div>
	</div><%
	}

	else if("Summary".equals(empl_ac))
	{%>
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
		<div class="content" align ="justify" style="font-size:16px">
		<table class="table" style="table-layout:auto" width="150">
    					<tr>
    					<th>Customer Name</th>
    					<th>Customer Contact Number</th>
    					<th>Customer Address</th>
    					<th>Service Request date</th>
    					<th>Service Fulfill date</th>
    					<th>Job assigned</th>
    					<th>Query Details</th>
    					<th>Details</th></tr><%
		sql = "SELECT * FROM employee WHERE employee_login_id='"+ empl_lo_id +"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
         	//Retrieve by column name
         	 empl_id  = rs.getInt("employee_id");
         	
         	sql1 = "SELECT distinct(customer_id) FROM customer_service WHERE employee_id='"+ empl_id +"'";
         	st1 = con.createStatement();
    		rs1 = st1.executeQuery(sql1);
    		if(rs1.next()==true){
    			do{
    				int cust_id = rs1.getInt("customer_id");
    			
    				sql2 = "SELECT * FROM customer WHERE customer_id='"+ cust_id +"'";
    				st2 = con.createStatement();
    				rs2 = st2.executeQuery(sql2);
    				  
    				while(rs2.next()){
         				String cust_na = rs2.getString("customer_name");
         				long cust_co_no = rs2.getLong("customer_contact_no");
         				String cust_ad = rs2.getString("customer_address");
	         		
         				//Display values%>
         				<tr><td><%= cust_na %></td>
         				<td><%= cust_co_no %></td>
         				<td><%= cust_ad %></td>
         				<%int counter=0;
         				sql4 = "SELECT * FROM customer_service WHERE customer_id ='"+cust_id+"' AND employee_id='"+empl_id+"'";
         				st4 = con.createStatement();
         				rs4 = st4.executeQuery(sql4);
         				while(rs4.next())
         				{
         					if(counter!=0){
         						%></tr><tr><td></td><td></td><td></td><%
         					}
         					Timestamp serv_re_da = rs4.getTimestamp("service_request_date");
    	         			java.sql.Date serv_fu_da = rs4.getDate("service_fulfill_date");
             				Timestamp empl_se_re_da = rs4.getTimestamp("employee_service_request_date");
             				String quer_de = rs4.getString("query_details");
             				%>
         				<td><%= serv_re_da %></td><%
         				if(serv_fu_da==null){%>
         					<td></td><%
         				}else{%>
         					<td><%= serv_fu_da %></td><%
         				}%>
         				<td><%= empl_se_re_da %></td>
         				<td><%= quer_de %></td><%
                    		int j=0;
              				sql3="select * from query_report where customer_id='"+cust_id+"' AND service_request_date='"+serv_re_da+"'";
              				st3 = con.createStatement();
                     		rs3 = st3.executeQuery(sql3);
                     		while(rs3.next())
                     		{
                     			String issue_de=rs3.getString("issue_detail");
                     				if(("UNKNOWN".equals(issue_de))==false){
                     				j++;	
                     				
                     			%>
                     			<form method="post" action="summary_detail.jsp">
                     			<input type="hidden" name=cust_id value="<%= cust_id%>">
                     			<input type="hidden" name=serv_re value="<%= serv_re_da%>">
                     			<td><input type="submit" value="View"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center"></td>
                     			</form></br>
                     			<%break;
                     			}
                     		}
                     		if(j==0){%>
                     			<td></td></tr>
                     		<% }counter++;
         				}
         			}
    			}while(rs1.next());%></table></br>
       	<form method="post" action="welcome.jsp">
			<input type="submit" value="Back"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
		</form>
		</div>
		</div>
   		</div><%
			}
    		else{%>
					<form method="post" action="new_job.jsp">
					<script type="text/javascript">
					window.alert("You haven't done any job/All are completed!");
					window.location.href="welcome.jsp";
					</script>
		 			</form><%
    		}
		}
	}
	
	else if("Change Status".equals(empl_ac))
	{
		response.sendRedirect("change_status.jsp");	
	}
	
	else if("New Job".equals(empl_ac))
	{
	   	response.sendRedirect("new_job.jsp");	
	}
	
	else if("Edit Job".equals(empl_ac))
	{%>
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
	     	 empl_id = rs.getInt("employee_id");
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
		<div class="content" align ="justify" style="font-size:16px">
		<%
		try{flag=0;int i=0;
		sql = "select * from employee where employee_login_id='"+empl_lo_id+"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		while(rs.next()){
	     	//Retrieve by column name
	     	empl_id = rs.getInt("employee_id");
	     	
		sql = "SELECT distinct(service_request_date) FROM query_report where employee_id='"+empl_id+"'";
		st = con.createStatement();
		rs = st.executeQuery(sql);
		if(rs.next()){
		do{flag=0;
			Timestamp serv_re_da = rs.getTimestamp("service_request_date");
			
			sql1 = "SELECT * FROM query_report where service_request_date='"+serv_re_da+"' and issue_detail='UNKNOWN'";
			st1 = con.createStatement();
			rs1 = st1.executeQuery(sql1);
			while(rs1.next()){
				String issue_st = rs1.getString("issue_status");
				if("pending".equals(issue_st)){	flag++;	i++;			
					sql2 = "SELECT * FROM customer_service where service_request_date='"+serv_re_da+"'";
					st2 = con.createStatement();
					rs2 = st2.executeQuery(sql2);
					while(rs2.next()){
						int cust_id = rs2.getInt("customer_id");
						empl_id = rs2.getInt("employee_id");
						String quer_de = rs2.getString("query_details");
						Timestamp empl_se_re_da = rs2.getTimestamp("employee_service_request_date");
						
						sql3 = "SELECT distinct(customer_name) FROM customer where customer_id='"+cust_id+"'";
						st3 = con.createStatement();
						rs3 = st3.executeQuery(sql3);
						while(rs3.next()){
							String cust_na = rs3.getString("customer_name");
							//Display values%>
							<table class="table" style="table-layout:auto" width="150">
							<tr>
							<th colspan="2">Details</th>
							<th>Action</th></tr>
	       					<form method="post" action="edit_current_job.jsp">
	       					<tr><td>Customer Name</td><td width="450"><%= cust_na %></td><td rowspan="4"><input type="hidden" value="<%=cust_id%>" name="cdetails">
							<input type="hidden" value="<%=serv_re_da%>" name="serv_re">
							<input type="submit" value = "Add new query"  name="act" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 20em;  height: 2em;text-align: center"></br></br>
							<input type="submit" value = "Change query status" name="act" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 20em;  height: 2em;text-align: center"></br></br>
							<input type="submit" value = "Change estimated date" name="act" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 20em;  height: 2em;text-align: center">
							</td></tr>
	       					<tr><td>Issue</td><td width="450"><%= quer_de %></td></tr>
	       					<tr><td>Job posted</td><td width="450"><%= serv_re_da %></td></tr>
	       					<tr><td>Job assigned</td><td width="450"><%= empl_se_re_da %></td></tr>
			 				</form><%
						}
					}
					break;
				}
				else{
					continue;
				}
			}
			
		}while(rs.next());
		%></table><%
		if(i==0){ %>
		You have completed all jobs!</br></br><%
		} %>
       	<form method="post" action="welcome.jsp">
			<input type="submit" value="Back"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
		</form>
		</div>
		</div>
   		</div>
		<%
		}else{%>
			<form method="post" action="welcome.jsp">
			<script type="text/javascript">
			window.alert("You haven't done any job!");
			window.location.href="welcome.jsp";
			</script>
			</form><%
		}
		}
		}catch(Exception e){%>
		<form method="post" action="welcome">
		<script type="text/javascript">
		window.alert("Sorry, You haven't added any query yet/All jobs are completed!");
		window.location.href="welcome.jsp";
		</script>
 		</form><%
		}
	}
	
	else if("Logout".equals(empl_ac))
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