<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*, java.util.*, java.text.*" %>
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
<script>
var dat=new Array();
function isDateSelected(x){
	var temp1;
	temp1="select_"+x.toString();
	var today = new Date();
	var inputDate = new Date(document.getElementById(temp1).value);
	if (inputDate < today){
		dat[x]=1;
	}
	else{
		dat[x]=0;
	}
}
function validate(){
	var i=0;
	var l=dat.length;
	var err=new Array();
	for(i=0;i<l;i++){
		if(dat[i]==1){
			err.push(i+1);
		}
		else{
			continue;
		}
	}
	if(err.length==0){
		return true;
	}
	else{
		alert("Correct following Date field/s:"+err);
		return false;
	}
}
function isDateSelected1(x){
	var temp1;
	temp1="select_"+x.toString();
	var today = new Date();
	var inputDate = new Date(document.getElementById(temp1).value);
	if (inputDate < today){
		dat[x]=1;
	}
	else{
		dat[x]=0;
	}
}
function validate1(){
	if(dat[0]==1){
		alert("Correct Date field:");
		return false;
	}
	else{
		return true;
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello <%= (String)session.getAttribute("username") %></title>
</head>
<body>
<%if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");	
else
{
	try{
		String empl_ac = request.getParameter("act");
		String empl_lo_id = (String)session.getAttribute("username");
		Timestamp serv_re_da = new Timestamp(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S").parse(request.getParameter("serv_re")).getTime());
		int cust_id = Integer.parseInt(request.getParameter("cdetails"));
		int i=0,flag=0;
		Connection con = null;
		String sql = null;
		Statement st = null;
		ResultSet rs = null;
		String name=null;
		String desig = (String)session.getAttribute("desig");
	
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
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
						<a href="employee_action.jsp?act=Logout" class="page-scroll" style="color:#FFFFFF;font-size:16px " target="_self">LOGOUT</a>
					</div>
			<div class="content" align ="justify" style="font-size:16px"><%
		if("Add new query".equals(empl_ac)){%>
			<form method="post" action="add_job.jsp">
			How many problems?
			<input type="number" name="problem_numbers" min="1" max="99" value=1 style="color: #282f35">
			<input type="hidden" value="<%=cust_id%>" name="cdetails">
			<input type="hidden" value="<%=serv_re_da%>" name="sdetails">
			<input type="submit" value="OK" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center" >
			</form>
			<form method="post" action="employee_action.jsp">
				<input type="hidden" name="act" value="Edit Job">
			 	<input type="submit" value="Back"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
			</form><%
		}
		if("Change query status".equals(empl_ac)){flag=0;%>
		<table class="table" style="table-layout:auto" width="150">
		<tr>
		<th>Issue Detail</th>
		<th>Issue Status</th>
		<th>Action</th></tr><%
		try{
			sql = "SELECT * FROM query_report WHERE service_request_date='"+ serv_re_da +"' and issue_detail<>'UNKNOWN'";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next()){
				flag++;
				String issue_de = rs.getString("issue_detail");
				String issue_st = rs.getString("issue_status");
				
					%><tr><td><%= issue_de %></td><td><%= issue_st %></td><%
					if(("pending".equals(issue_st))){%>
						<form method="post" action="change_query_status.jsp">
						<input type="hidden" value="<%=serv_re_da%>" name="sdetails">
						<input type="hidden" value="<%=issue_de%>" name="dedetails">
						<input type="hidden" value="<%=issue_st%>" name="stdetails">
						<input type="hidden" value="<%=cust_id%>" name="cdetails">
						<td><input type="submit" value="Done"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center"></td>
						</form><%
					}
					else{
						%><td></td><%
					}
			}%></tr></table>
			<form method="post" action="employee_action.jsp">
			<input type="hidden" name="act" value="Edit Job">
		 	<input type="submit" value="Back"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
		</form><%
		if(flag==0){
			throw new Exception();
		}
		}
		catch(Exception e){%>
		<form method="post" action="employee_action.jsp?act=Edit Job">
		<script type="text/javascript">
		window.alert("Sorry, You haven't added any query yet!");
		window.location.href="employee_action.jsp?act=Edit Job";
		</script>
 		</form><%
		}
		}
		if("Change estimated date".equals(empl_ac)){flag=0;
			sql = "SELECT * FROM query_report WHERE service_request_date='"+ serv_re_da +"' and issue_detail<>'UNKNOWN'";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()){i=0;%>
			<table class="table" style="table-layout:auto" width="150">
			<tr><th>No.</th><th>Issue Detail</th>
			<th>Old Estimated date</th>
			<th>New Estimated date</th></tr>
			<form name="myForm" method="post" action="change_estimated_date.jsp" onsubmit="return validate()"><%
				do{
				flag++;
				String issue_de = rs.getString("issue_detail");
				String issue_st = rs.getString("issue_status");
				java.util.Date serv_es_da = rs.getDate("service_estimated_date");
				%>
				<tr><td><%=i+1 %></td><td><%= issue_de %></td><td><%= serv_es_da %></td>
				<td><input type="date" name="dadetails<%=i%>" id="select_<%=i %>" style="color: #282f35" onblur="isDateSelected(<%=i%>)">
				<input type="hidden" value="<%=serv_re_da%>" name="sdetails">
				<input type="hidden" value="<%=issue_de%>" name="dedetails<%=i%>"></td></tr>
				<%
				i++;
				}while(rs.next());%></table>
				<input type="hidden" value="<%=i%>" name="idetails">
				<input type="submit" value="OK" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center">
				</form></br></br><%
			}
			else{i=0;%>
				<form name="myForm1" method="post" action="change_estimated_date.jsp" onsubmit="return validate1()">
				Do you want to change Job completion date?
				<input type="date" name="dadetails<%=i%>" id="select_<%=i %>" style="color: #282f35" onblur="isDateSelected1(<%=i%>)">
				<input type="hidden" value="<%=serv_re_da%>" name="sdetails">
				<input type="hidden" value="UNKNOWN" name="dedetails<%=i%>">
				<input type="hidden" value="<%=i+1%>" name="idetails"></br></br>
				<input type="submit" value="OK" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center">
				</form></br><%
			}%>
			<form method="post" action="employee_action.jsp">
				<input type="hidden" name="act" value="Edit Job">
			 	<input type="submit" value="Back"  style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
			</form>
			</div>
			</div>
   			</div><%	
		}
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
		//nothing!!!
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