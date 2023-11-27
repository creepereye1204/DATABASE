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
	if (!emailChecked) {
	PrintWriter script=response.getWriter();
	script.println("<script>");
	script.println("alert('인증해주세요.');");
	script.println("location.href='index.jsp'");
	script.println("</script>");
	script.close();
	return;
	}
	
	
	request.setCharacterEncoding("UTF-8");
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	String host = "http://localhost:8080/Lecture_Evaluation/";
	String from = "iostream1204@gamil.com";
	String to = "creepereye15@naver.com";
	String subject = userID+"(님의 신고 메일 입니다)";
	String happen = "<h1>"+title+"</h1>"+"<div></div>"+"<h2>"+content+"</h2>";
	
	
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
		msg.setContent(happen, "text/html;charset=UTF8");
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
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('신고되었습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
	
	
%>
