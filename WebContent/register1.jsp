<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% String desig = (String)session.getAttribute("desig"); %>
<html>
<head><!-- Basic Page Needs
    ================================================== -->
    <meta charset="utf-8">
    <!--[if IE]><meta http-equiv="x-ua-compatible" content="IE=9" /><![endif]-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicons
    ================================================== -->
    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
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
<title>Register</title>
<script type="text/javascript">

// After form loads focus will go to User id field.
function firstfocus()
{
	var uname = document.registration.username.focus();
	return true;
}

// This function will validate Name.
function allLetter()
{ 
	var uname = document.registration.username;
	var letters = /^[A-Za-z]{3,15}$/;
	if(uname.value.match(letters))
	{
		// Focus goes to next field i.e. Email.
		document.registration.email.focus();
		document.getElementById("errorBox").style.visibility = 'hidden';
		return true;
	}
	else
	{
		uname.focus();
		document.getElementById("errorBox").innerHTML = 'Enter only alphabets and length should be of 3-15 characters';
		return false;
	}
}

// This function will validate Email.
function ValidateEmail()
{
	var uemail = document.registration.email;
	var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	if(uemail.value.match(mailformat))
	{
		// Focus goes to next field i.e. Password.
		document.registration.passid.focus();
		document.getElementById("errorBox1").style.visibility = 'hidden';
		return true;
	}
	else
	{
		document.getElementById("errorBox1").innerHTML = 'Please provide valid email address';
		uemail.focus();
		return false;
	}
}

// This function will validate Password.
function pass()
{
	var passid = document.registration.passid;
	var passformat = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/;
	if(passid.value.match(passformat))
	{
		// Focus goes to next field i.e. Contact.
		document.registration.contact.focus();
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

// This function will validate Contact No.
function conno()
{
	var conno = document.registration.contact;
	var connoformat = /^([0-9]\d{2,4}-\d{6,8})|(([+][9][1]|[9][1]|[0]){0,1}([7-9]{1})([0-9]{9}))+$/;
	if (conno.value.match(connoformat))
	{
		// Focus goes to next field i.e. Address.
		document.registration.address.focus();
		document.getElementById("errorBox3").style.visibility = 'hidden';
		return true;
		
	}
	else{
		document.getElementById("errorBox3").innerHTML = "Please provide valid contact number";
		conno.focus();
		return false;
	}
}

// This function will validate Address.
function addr()
{ 
	var uadd = document.registration.address;
	var letters = /^\d+,|[a-zA-Z0-9.,/-]|[(?:[a-zA-Z0-9.,/-]+,|,\d|\s|(?:[A-Z][a-z.-]+[ ]?)$/;
	if(uadd.value.match(letters))
	{
		// Focus goes to next field i.e. Zip.
		document.registration.zip.focus();
		document.getElementById("errorBox4").style.visibility = 'hidden';
		return true;
	}
	else	
	{
		document.getElementById("errorBox4").innerHTML = 'Please provide valid address';
		uadd.focus();
		return false;
	}
}

// This function will validate ZIP Code.
function allnumeric()
{ 
	var uzip = document.registration.zip;
	var numbers = /^[1-9][0-9]{5}$/;
	if(uzip.value.match(numbers))
	{
		<%if("admin".equals(desig)){%>
			// Focus goes to next field i.e. salary.
			document.registration.sal.focus();
			document.getElementById("errorBox5").style.visibility = 'hidden';
			return true;<%
		}%>
		// Focus goes to next field i.e. submit.
		document.registration.submit.focus();
		document.getElementById("errorBox5").style.visibility = 'hidden';
		return true;
	}
	else
	{
		document.getElementById("errorBox5").innerHTML = 'Please provide valid ZIP code';
		uzip.focus();
		return false;
	}
}

function validate()
{
	if(allLetter()==true && ValidateEmail()==true && pass()==true && conno()==true && addr()==true && allnumeric()==true)
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
<style>
.error{
	color:#F00;
	text-align:"middle";
	}
</style>
</head>
<body onload="firstfocus();">
<div id="contact">
	<div class="container">
    	<div class="section-title text-left">
              <h2>Register</h2>
                <hr align="left" style="margin-top: -5px">
            </div>

            <div class="row">
                <div class="col-md-9">
                        <div class="row">
                            <div class="col-md-9" style="font-size:16px">
                            
<form name='registration' method="post" onsubmit="return validate()" action="register.jsp">
<table width="900px">
<tr><th width="100px">
<label for="username">Name:</label></th>
<td width="200px"><input class="form-control" type="text" name="username" maxlength="25" onblur="allLetter()" style="color:#FFFFFF" /></td>
<td><div class="error" id="errorBox" style="visibilty:hidden;text-align:middle;"></div></td></tr><tr></tr>
</br>
<tr><th>Email:</th>
<td width="200px"><input class="form-control" type="text" name="email" maxlength="50" onblur="ValidateEmail()" style="color:#FFFFFF"/></td>
<td><div class="error" id="errorBox1" style="visibilty:hidden;text-align:middle;"></div></td></tr>

<tr><th>Password:</th>
<td width="200px"><input class="form-control" type="password" name="passid" maxlength="16" onblur="pass()" style="color:#FFFFFF" /><td>
<td ><div class="error" id="errorBox2" style="visibilty:hidden;text-align:middle;"></div></td></tr>

<tr><th>Contact Number:</th>
<td width="200px"><input class="form-control" type="text" name="contact" maxlength="10" onblur="conno()" style="color:#FFFFFF" /></td>
<td><div  class="error" id="errorBox3" style="visibilty:hidden;text-align:middle;"></div></td></tr>

<tr><th>Address:</th>
<td width="200px"><input class="form-control" type="text" name="address" maxlength="150" style="color:#FFFFFF" /></td>
<td><div  class="error" id="errorBox4" style="visibilty:hidden;text-align:middle;"></div></td></tr>

<tr><th>ZIP Code:</th>
<td width="200px"><input  class="form-control" type="text" name="zip" maxlength="6" onblur="allnumeric()" style="color:#FFFFFF" /></td>
<td><div  class="error" id="errorBox5" style="visibilty:hidden;text-align:middle;"></div></td></tr>

<%if("admin".equals(desig)){%>
<tr><th>Salary:</th>
<td width="200px"><input class="form-control" type="text" name="sal" maxlength="6" style="color:#FFFFFF" /></td></tr>
<tr><th>Expertise:</th>
<td width="200px"><input class="form-control" type="text" name="exp" style="color:#FFFFFF" /></td></tr>
<%}%>
</table></br>
<div>
<div style="display: inline-block;">
<input type="submit" name="submit" value="Register" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s; "/>
</form></div>
<%if("admin".equals(desig)){%>
<div style="display: inline-block;">
<form method="post" action="welcome.jsp">
<input type="submit" name="submit" value="Back" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;margin:10px 15px "/>
</form></div><%
}
else{%>
<div style="display: inline-block;">
<form method="post" action="index.html">
<input type="submit" name="submit" value="Back" style="text-transform: uppercase;background: #c59a6d;color: #282f35;border: 1px solid #c59a6d;padding: 15px 35px;border-radius: 0;font-size: 12px;color: #ffffff;transition: all 0.5s;margin:10px 15px "/>
</form></div><%
}%></div>
</div>
</div>
</div>
</div>
</div>
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