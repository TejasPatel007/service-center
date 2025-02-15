<%@ page language="java" contentType="text/html; charset=ISO-8859-1"                                                                        
    pageEncoding="ISO-8859-1"%>                                                                                                             
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">                                      
<%@page import="java.util.Properties"%>                                                                                                     
<%@page import="javax.mail.Session"%>                                                                                                       
<%@page import="javax.mail.Authenticator"%>                                                                                                 
<%@page import="javax.mail.PasswordAuthentication"%>                                                                                        
<%@page import="javax.mail.Message"%>                                                                                                       
<%@page import="javax.mail.internet.MimeMessage"%>                                                                                          
<%@page import="javax.mail.internet.InternetAddress"%>                                                                                      
<%@page import="javax.mail.Transport"%>                                                                                                     
<html>                                                                                                                                      
<head>                                                                                                                                      
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">                                                                    
<title>Email Test</title>                                                                                                                   
</head>                                                                                                                                     
<body>                                                                                                                                      
<%     
try{
	String smtpServer = "smtp.gmail.com";                                                                                                                   
	String smtpPort = "587";                                                                                                                     
	final String authAddress = request.getParameter("auth_add");                                                                                
	final String authPassword = request.getParameter("auth_pass");                                                                              
	String subject = request.getParameter("subject");                                                                                                                      
	String email = "thaservicecenter@gmail.com";//THAservicecenter247!                                                                                                                        
	String message = request.getParameter("message");
	String name = request.getParameter("name");   
                                                   
    Properties props = new Properties();     
	props.put("mail.smtp.host", smtpServer); 
    props.put("mail.smtp.port", smtpPort);   
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.auth", "true");       
                                                         
    // create some properties and get the default Session
    Session sessionMail = Session.getInstance(props, new Authenticator() {
    	public PasswordAuthentication getPasswordAuthentication() {      
        	return new PasswordAuthentication(authAddress, authPassword);
            }                                                                    
        });                                                                   
                                                                                      
	sessionMail.setDebug(true);

    // create a message
    Message msg = new MimeMessage(sessionMail);

    // set the from and to address
    InternetAddress addressFrom = new InternetAddress(authAddress);
    msg.setFrom(addressFrom);

    InternetAddress[] addressTo = new InternetAddress[1];
    addressTo[0] = new InternetAddress(email);
    msg.setRecipients(Message.RecipientType.TO, addressTo);

	// Setting the Subject and Content Type
    msg.setSubject(subject);
	
 	// Now set the actual message
 	if(name!=""){
  		message="Hello, this is "+name+",\n"+message;
 	}
    msg.setContent(message, "text/plain");
    
 	
 	//message.setText(message);

    Transport.send(msg);
    %><form method="post">
    <script type="text/javascript">
    window.alert('Mail sent successfully!');
    window.location.href="index.html";
    </script>
    </form><%
}
catch(Exception e){%>
	<form method="post">
	<script type="text/javascript">
	window.alert('Sorry, Mail sending failure!');
	window.location.href="index.html";
	</script>
	</form><%
}
finally{
	//nothing
}
%>