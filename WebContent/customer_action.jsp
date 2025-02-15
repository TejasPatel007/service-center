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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello <%= (String)session.getAttribute("username") %></title>
</head>
<body>
<% if((request.getSession().getAttribute("username"))==null){
	request.getSession().invalidate();
	response.sendRedirect("login1.jsp");
}
else
{
	String cust_ac = request.getParameter("act");
	String cust_lo_id = (String)session.getAttribute("username");
	Connection con = null;
	String sql = null;
	String sql1 = null;
	String sql2 = null;
	String sql3 = null;
	PreparedStatement pst = null;
	Statement st = null;
	Statement st1 = null;
	Statement st2 = null;
	Statement st3 = null;
	ResultSet rs = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	boolean login = false;
	String name=null;
	String desig=(String)session.getAttribute("desig");
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
	sql = "SELECT "+desig+"_name FROM "+desig+" WHERE "+desig+"_login_id='"+ cust_lo_id +"'";
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
        <li><a href="customer_action.jsp?act=Query" class="page-scroll" target="_self">Home</a></li>
            <li><a href="customer_action.jsp?act=Profile" class="page-scroll" target="_self"> Profile</a></li>
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
				<a href="customer_action.jsp?act=Logout" class="page-scroll" style="color:#FFFFFF;font-size:16px " target="_self">LOGOUT</a>&nbsp&nbsp&nbsp
			</div>
	<%
	sql = "SELECT * FROM customer WHERE customer_login_id='"+ cust_lo_id +"'";
	st = con.createStatement();
	rs = st.executeQuery(sql);
	if("Profile".equals(cust_ac))
	{%><div class="content" align ="justify" style="font-size:20px"><%
		    while(rs.next()){
         	//Retrieve by column name
         	String cust_na = rs.getString("customer_name");
         	String cust_ad = rs.getString("customer_address");
         	long cust_co_no = rs.getLong("customer_contact_no");
         	String cust_lo_pa = rs.getString("customer_login_password");
	
         	//Display values%>
         	Login ID: <%= cust_lo_id %></br>
         	Name: <%= cust_na %></br>
         	Address: <%= cust_ad %></br>
         	Contact Number: <%= cust_co_no %></br></br>
         	<form method="post" action="change_password.jsp">
		 	<button value="Change Password" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">Change Password</button>
		 	</form><%
      	}%>	
            </br>
        <form method="post" action="welcome.jsp">
		 <input type="submit" value="Back"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
		</form>
	</div>
        </div>
    </div>
		 <%
	}

	else if("Summary".equals(cust_ac))
	{%><div class="content" align ="justify" style="font-size:16px"><table class="table" style="table-layout:auto" width="150">
					<tr><th>Service request date</th>
					<th>Service Fulfill date</th>
					<th>Query Details</th>
					<th>Employee Name</th>
					<th>Employee Contact Number</th>
					<th>Employee Assigned Date</th>
					<th>Details</th></tr><tr><% 
            sql = "SELECT * FROM customer WHERE customer_login_id='"+ cust_lo_id +"'";
     		st = con.createStatement();
     		rs = st.executeQuery(sql);
     		while(rs.next()){
              	//Retrieve by column name
              	int cust_id  = rs.getInt("customer_id");
              	
              	sql1 = "SELECT * FROM customer_service WHERE customer_id='"+ cust_id +"'";
              	st1 = con.createStatement();
         		rs1 = st1.executeQuery(sql1);
         		if(rs1.next()){
         		do{
              		Timestamp serv_re_da = rs1.getTimestamp("service_request_date");
              		java.sql.Date serv_fu_da = rs1.getDate("service_fulfill_date");
              		String quer_de = rs1.getString("query_details");
              		int empl_id = rs1.getInt("employee_id");
              		
              		//Display values%>
              		<td> <%= serv_re_da %></td><%
              		if(serv_fu_da==null){%>
              			<td></td><%
              		}else{%>
              			    <td> <%= serv_fu_da %></td><%
              		}%>
              		        <td> <%= quer_de %></td><%
              			sql2 = "SELECT * FROM employee WHERE employee_id='"+ empl_id +"'";
              			st2 = con.createStatement();
                 		rs2 = st2.executeQuery(sql2);
                 		while(rs2.next()){
                 			String empl_na = rs2.getString("employee_name");
                 			String empl_co_no = rs2.getString("employee_contact_no");
                 			String empl_se_re_da = rs1.getString("employee_service_request_date");%>
     					    <td> <%= empl_na %></td>
              				<td> <%= empl_co_no %></td>
              				<td> <%= empl_se_re_da %></td><%
              				int j=0;
              				sql3="select * from query_report where employee_id='"+empl_id+"' AND service_request_date='"+serv_re_da+"'";
              				st3 = con.createStatement();
                     		rs3 = st3.executeQuery(sql3);
                     		while(rs3.next())
                     		{
                     			String issue_de=rs3.getString("issue_detail");
                     				if(("UNKNOWN".equals(issue_de))==false){
                     					j++;
                     				}
                     		}
                     		if(j>0){%>
                 				<form method="post" action="summary_detail.jsp">
                 				<input type="hidden" name=cust_id value="<%= cust_id%>">
                 				<input type="hidden" name=serv_re value="<%= serv_re_da%>">
                 				<td><input type="submit" value="View"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center"></td></tr>
	                 			</form>
                 			<%
                     		}
                     		else{%>
                     			<td></td></tr>
                     		<% }
                 		}
         		}while(rs1.next());
     		}else{%>
    		<form method="post">
    		<script type="text/javascript">
    		window.alert("Sorry, You haven't posted any job!");
    		window.location.href="customer_action.jsp";
    		</script>
     		</form><%
     		}	
     	}%>
		</table><% 
      	%>
        <form method="post" action="welcome.jsp">
		 <input type="submit" value="Back"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
		</form>
	</div>
        </div>
    </div>
		<%	
	}
	
	else if("Query".equals(cust_ac))
	{%><div class="content" align ="justify" style="font-size:20px">
			Any Query?
		   	<form method="post" action="query.jsp">
		   	<input type=text maxlength=256 size="35px" placeholder="Insert your problem description here" name="query_detail" style="color: #282f35" required>
		   	<input type="submit" value="Submit Query"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 10em;  height: 2em;text-align: center">
		   	</form>
			</div>
        </div>
    </div><%
	}
	
	else if("Logout".equals(cust_ac))
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
