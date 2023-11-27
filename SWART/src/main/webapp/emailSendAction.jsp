<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="user.userDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.Gmail"%>
<%@ page import="java.io.PrintWriter"%>
<%
	
	userDAO userDao = new userDAO();
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}

	boolean emailChecked = userDao.getUserEmailChecked(userID);
	if (emailChecked) {
	PrintWriter script=response.getWriter();
	script.println("<script>");
	script.println("alert('이미 인증된 회원입니다.');");
	script.println("location.href='index.jsp'");
	script.println("</script>");
	script.close();
	return;
	}
	
	
	
	
	
	String host = "http://localhost:8080/Lecture_Evaluation/";
	String from = "iostream1204@gmail.com";
	String to =userDao.getUserEmail(userID);
	String subject = "강의평가를 위한 이메일 인증 메일입니다.";
	String content = "다음 링크에 접속하여 이메일 인증을 진행하세요." + "<a href='"+ host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to)+"'>이메일 인증하기</a>";
	
	
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com"); // google SMTP 주소
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	p.put("mail.smtp.ssl.protocols", "TLSv1.2"); // 추가된 코드
	p.put("mail.smtp.ssl.enable", "true");  // 추가된 코드

	
	try {
		Authenticator auth = new Gmail();
		
		Session ses = Session.getInstance(p,auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		
		Address fromAddr = new InternetAddress(from);
		
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		
		msg.addRecipient(Message.RecipientType.TO,toAddr);
		msg.setContent(content, "text/html;charset=UTF8");
		Transport.send(msg);
		
		
		
		
		} catch (Exception e) {
		
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류발생');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		}
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
	integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
	integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>

		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">메인</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id=dropdown data-toggle="dropdown">
						회원관리 </a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID==null){
		
	
%>


						<a class="dropdown-item" href="./userLogin.jsp">로그인</a> 
						<a class="dropdown-item" href="./userJoin.jsp">회원가입</a> 
<%
	}else{
		
	
%>						
	
						<a class="dropdown-item" href="#">로그아웃</a>
<%
	}
%>

					</div></li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="text" name="search" type="search"
					placeholder="내용을 입력하세요.">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container mt-3" style="max-width:560px;">
		<div class="alert alert-success mt-4" role="alert" >
			이메일 주소 인증 메일이 전송되었습니다. 회원가입시 입력했던 이메일에 들어가셔서 인증해주세요.
		</div>
		
	</section>
	
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.js"></script>


</body>
<footer>
<div class="form-group mt-4 mb-0 p-5 bg-secondary text-center display-2" style="color:#FFFFFF;">
	<label>Copyright &copy; C189081 &nbsp;<span class="display-6">디자인패턴 과제</span></label>
</div>
	
</footer>
</html>