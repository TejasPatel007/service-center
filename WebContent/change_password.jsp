<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% if((request.getSession().getAttribute("username"))==null)
	response.sendRedirect("login1.jsp");%>
<%try{
String desig = (String)request.getSession().getAttribute("desig");
String empl_ac = request.getParameter("act");
	String lo_id = (String)session.getAttribute("username");
	Connection con = null;
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	String name=null;
	
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
	sql = "SELECT "+desig+"_name FROM "+desig+" WHERE "+desig+"_login_id='"+ lo_id +"'";
	st = con.createStatement();
	rs = st.executeQuery(sql);
	while(rs.next()){
		name = rs.getString(1);
	}
%>
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
<title>Change password</title>
<style>
.error{
	color:#F00;
	}
</style>
<script language="javascript">

//After form loads focus will go to old password field.
function firstfocus()
{
	var uold = document.ChangePasswordForm.oldpassword.focus();
	return true;
}

//This function will validate Old Password.
function oldpass()
{
		if(document.ChangePasswordForm.oldpassword.value == "")
		{
			document.getElementById("errorBox").innerHTML = "Please input old password";
			document.ChangePasswordForm.oldpassword.focus();
			return false;
		} 
		else
		{
			var passid = document.ChangePasswordForm.oldpassword;
			var passformat = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/;
			if(passid.value.match(passformat))
			{
				document.getElementById("errorBox").style.visibility = 'hidden';
				return true;
			}
			else
			{
				document.getElementById("errorBox").innerHTML = "Password must be of length 8-16 and must include at least 1 Upper case, 1 Lower case, 1 Number & 1 Special character!";
				passid.focus();
				return false;
			}
		}
}

//This function will validate New Password.
function newpass()
{
		if(document.ChangePasswordForm.newpassword.value == "")
		{
			document.getElementById("errorBox1").innerHTML = "Please input new password";
			document.ChangePasswordForm.newpassword.focus(); 
			return false;
		} 
		else
		{
			var passid = document.ChangePasswordForm.newpassword;
			var passformat = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/;
			if(passid.value.match(passformat))
			{
				document.getElementById("errorBox1").style.visibility = 'hidden';
				return true;
			}
			else
			{
				document.getElementById("errorBox1").innerHTML = "Password must be of length 8-16 and must include at least 1 Upper case, 1 Lower case, 1 Number & 1 Special character!";
				passid.focus();
				return false;
			}
		}
}

//This function will validate Confirm Password.
function conpass()
{
		if(document.ChangePasswordForm.conpassword.value == "")
		{
			document.getElementById("errorBox2").innerHTML = "Please input confirm password";
			document.ChangePasswordForm.conpassword.focus(); 
			return false;
		} 
		else if(document.ChangePasswordForm.newpassword.value != document.ChangePasswordForm.conpassword.value)
		{
			document.getElementById("errorBox2").innerHTML = "Confirm Password Not Match";
			document.ChangePasswordForm.conpassword.focus(); 
			return false;
		} 
		else
		{
			var passid = document.ChangePasswordForm.conpassword;
			var passformat = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/;
			if(passid.value.match(passformat))
			{
				document.getElementById("errorBox2").style.visibility = 'hidden';
				return true;
			}
			else
			{
				document.getElementById("errorBox2").innerHTML = "Password must be of length 8-16 and must include at least 1 Upper case, 1 Lower case, 1 Number & 1 Special character!";
				passid.focus();
				return false;
			}
		}
}

function validate()
{
	if(oldpass()==true && newpass()==true && conpass()==true)
	{
		return true;
	}
	else{
		window.alert("Sorry Please Correct Error/s!");
		window.location.reload();
		return false;
	}
}
</script>
</head>
<body onload="firstfocus();">
<div class="navmenu navmenu-default navmenu-fixed-left offcanvas"> <!--- Off Canvas Side Menu -->
	
    <div class="close" data-toggle="offcanvas" data-target=".navmenu">
        <span class="fa fa-close"></span>
    </div>
	
    <div class="add-margin" style="margin-top:50px;margin-bottom:50px" align="justify"><img src="favicon.png?" style="margin:auto; width:100px;display:block" /></div>
    <ul class="nav navmenu-nav"> <!--- Menu -->
    <%if("customer".equals(desig)){%>
    <li><a href="customer_action.jsp?act=Query" class="page-scroll" target="_self">Home</a></li>
            <li><a href="customer_action.jsp?act=Profile" class="page-scroll" target="_self">Profile</a></li>
            <li><a href="customer_action.jsp?act=Summary" class="page-scroll" target="_self">Summary</a></li><%
    }else if("employee".equals(desig)){%>
    <li><a href="employee_action.jsp?act=Dashboard" class="page-scroll" >Dashboard</a></li>
    <li><a href="employee_action.jsp?act=Profile" class="page-scroll" >Profile</a></li>
    <li><a href="employee_action.jsp?act=Summary" class="page-scroll">Summary</a></li>
    <li><a href="employee_action.jsp?act=New Job" class="page-scroll">New Job</a></li>
    <li><a href="employee_action.jsp?act=Edit Job" class="page-scroll">Edit Job</a></li><%
    }else{%>
    <li><a href="admin_action.jsp?act=Dashboard" class="page-scroll" >Dashboard</a></li>
    <li><a href="admin_action.jsp?act=Profile" class="page-scroll" >Profile</a></li>
    <li><a href="admin_action.jsp?act=New Queries" class="page-scroll">New Queries</a></li>
    <li><a href="admin_action.jsp?act=Employee Summary" class="page-scroll">Employee Summary</a></li>
    <li><a href="admin_action.jsp?act=Customer Summary" class="page-scroll">Customer Summary</a></li>
    <li><a href="admin_action.jsp?act=Register Employee" class="page-scroll">Register Employee</a></li><%
    }%>
    </ul><!--- End Menu -->
    
</div> <!--- End Off Canvas Side Menu -->

<!-- Home Section -->
<div id="home" style="background: hidden;">
	
    <div class="container text-center">
	
        <!-- Navigation -->
        <nav id="menu" data-toggle="offcanvas" data-target=".navmenu">
            <span class="fa fa-bars"></span>
            </nav>
            <%if("customer".equals(desig)){%>
            <div align= "right"style="font-size:16px">Hello,<%=name %>&nbsp&nbsp
           	 <a href="customer_action.jsp?act=Logout" class="page-scroll" style="color:#FFFFFF;font-size:16px " target="_self">LOGOUT</a>&nbsp&nbsp&nbsp
			</div><%
			}else if("employee".equals(desig)){%>
			<div align= "right"style="font-size:16px">Hello,<%=name %>&nbsp&nbsp<%
		String empl_lo_id = (String)session.getAttribute("username");
		
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
			</div><%
			}else{%>
			<div align= "right"style="font-size:16px">Hello,<%=name %>&nbsp&nbsp
           	 <a href="admin_action.jsp?act=Logout" class="page-scroll" style="color:#FFFFFF;font-size:16px " target="_self">LOGOUT</a>&nbsp&nbsp&nbsp
			</div><%
			}%>
	 <div class="content" align ="justify" style="font-size:20px">
<div style="display:table-cell;vertical-align:middle;">
<form name="ChangePasswordForm" method="post" action="password_change.jsp" OnSubmit="return validate()">

<table border="0" align="left">
<tr>
<td><input type="password" style="background-color: #282f35" class="form-control" name="oldpassword" placeholder="Old Password" id="oldpassword" maxlength="16" onblur="oldpass()"></td>
<td><div class="error" id="errorBox" style="visibilty:hidden"></div></td>
</tr><tr><td>&nbsp;</td></tr>
<tr>
<td><input type="password" style="background-color: #282f35" class="form-control" name="newpassword" placeholder="New Password" id="newpassword" maxlength="16" onblur="newpass()"></td>
<td><div class="error" id="errorBox1" style="visibilty:hidden"></div></td>
</tr><tr><td>&nbsp;</td></tr>
<tr>
<td><input type="password" style="background-color: #282f35" class="form-control" name="conpassword" placeholder="Confirm Password" id="conpassword" maxlength="16" onblur="conpass()"></td>
<td><div class="error" id="errorBox2" style="visibilty:hidden"></div></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td><input type="submit" name="Submit" value="Save" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;width: 5em;  height: 2em;text-align: center"></td>
</tr>
</table>
</form>
</div>
</br>
<div style="display:table-cell;vertical-align:middle;">
<form method="post" action="<%=desig%>_action.jsp">
<input type="hidden" name="act" value="Profile">
<input type="submit" value="Back" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;"></td></tr>
</form>
</div></div></div></div>
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
<%}catch(Exception e){%>
		<form method="post">
		<script type="text/javascript">
		window.alert('Sorry, There is some error!');
		window.location.href="welcome.jsp";
		</script>
		</form><%
}
finally{
	//nothing!!!
}%>