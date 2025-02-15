<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% if((request.getSession().getAttribute("username"))!=null){
	request.getSession().invalidate();
	response.sendRedirect(request.getContextPath() + "/login1.jsp");
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
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
<style>
.error{
	color:#F00;
	}
</style>
<script>
//This function will validate Email.
function ValidateEmail()
{
	var uemail = document.login.email;
	var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	if(uemail.value.match(mailformat))
	{
		document.getElementById("errorBox").style.visibility = 'hidden';
		return true;
	}
	else
	{
		document.getElementById("errorBox").innerHTML = 'Please provide valid email address';
		uemail.focus();
		return false;
	}
}

function validate()
{
	if(ValidateEmail()==true)
	{
		return true;
	}
	else{
		window.alert("Sorry Please Enter Correct E-mail ID!");
		window.location.reload();
		return false;
	}
}
</script>
</head>
<body onload="firstfocus();">
<div id="home" style="background: #282f35">
<div id="contact">
	<div class="container">
    	<div class="section-title text-left">
              <h2>Forgot Password</h2>
                <hr align="left" style="margin-top: -5px">
            </div>

            <div class="row">
                <div class="col-md-9">
                        <div class="row">
                            <div class="col-md-9" style="font-size:16px">
                            <form name="login" method="post" onsubmit="return validate()" action="sendpassword.jsp" >
							<table width="800px">
                            <tr><td width="200px"> <input type="text" class="form-control" placeholder="User Email Id" id="email"  name="email" maxlength="50"  onblur="ValidateEmail()" style="color: #FFFFFF;"></td> 
                            <td width="600px"><div class="error" id="errorBox" style="visibilty:hidden"></div></td></tr>
                          
							<tr><td><select name="designation" class="form-control" style="color:#FFFFFF">
								 <option>Designation</option>
   								 <option value="customer">Customer</option>
    							 <option value="employee">Employee</option>
  							     <option value="admin">Administrator</option>
    						</select></td></tr></table>
							
							</br>			
							<div class="text-left" >
                            <input type="submit" value="Submit" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
                            </br>
                            </div>
							</form>
							</br>
							<form name="gobalcktologin" method="post" action="login1.jsp">
							<input type="submit" value="Back" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;">
							</form>
                            </div>
                            </div>
                        </div>
							
                    </div>
                </div>
             </div>
		</div>          
</body>
</html>