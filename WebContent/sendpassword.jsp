<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import ="java.sql.*" %> 
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
<title>Send Password</title>
</head>
<body>

</body>
</html>
<%
try{
	String lo_id = request.getParameter("email");    
    String desig = request.getParameter("designation");
    String pass = null;
    String name = null;
    Connection con = null;
   	Statement st = null;
    ResultSet rs = null;
    boolean login = false;

    Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/service_center","root","");
	String sql = "SELECT * FROM " +desig+ " WHERE "+desig+"_login_id='"+lo_id+"'";
	st= con.createStatement();
	rs = st.executeQuery(sql);
	while(rs.next()){
		 //Retrieve by column name
		 if("customer".equals(desig)){
			name = rs.getString("customer_name");
		 	pass = rs.getString("customer_login_password");
		 }
		 else if("employee".equals(desig)){
			name = rs.getString("employee_name");
			pass = rs.getString("employee_login_password");
		 }
		 else if("admin".equals(desig)){
			name = rs.getString("admin_name");
			pass = rs.getString("admin_login_password");
		 }
	}
	try{
	if(name==null && pass==null){
		throw new Exception();
	}
	
	String smtpServer = "smtp.gmail.com";                                                                                                                   
	String smtpPort = "587";                                                                                                                     
	final String authAddress = "thaservicecenter@gmail.com";                                                                                
	final String authPassword = "THAservicecenter247!";                                                                              
	String subject = "Password Recovery";                                                                                                                      
	String email = request.getParameter("email");                                                                                                                      
	String message = pass;
	String name1 = name;   
                                                   
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
  	message="Hello, "+name1+",\nYour Password Is:"+message;
    msg.setContent(message, "text/plain");
    
 	
 	//message.setText(message);

    Transport.send(msg);
	%><form method="post">
    <script type="text/javascript">
    window.alert('Password is sent on given mail!');
    window.location.href="login1.jsp";
    </script>
    </form><%
	}
	catch(Exception e){%>
	<form method="post">
	<script type="text/javascript">
	window.alert('Sorry, Incorrect Details!');
	window.location.href="forgotpassword.jsp";
	</script>
	</form><%
	}
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
}%>