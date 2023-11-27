<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.userDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	

final String purple   = "\u001B[35m" ;



final String exit     = "\u001B[0m" ;
	
	
	request.setCharacterEncoding("UTF-8");
	String code="";
	
	//
	
	//
	
	if(request.getParameter("code")!=null){
		code=(String)request.getParameter("code");
		System.out.println(purple+code+exit);
	}
	userDAO userDao=new userDAO();
	String userID=null;
	
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
		
	}
	if(userID==null){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 하세요')");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	String userEmail=userDao.getUserEmail(userID);
	
	
	boolean isRight = (new SHA256().getSHA256(userEmail).equals(code))?true:false;
	
	
	if(isRight){
		userDao.setUserEmailChecked(userID);
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('인증에 성공했습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}else{
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 코드 입니다.')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	
	
	
	
	
	
	
	
%>