<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.userDTO"%>
<%@ page import="user.userDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID=null;
	String userPassword=null;
	if(request.getParameter("userID")!=null){
		userID=request.getParameter("userID");
		
	}
	if(request.getParameter("userPassword")!=null){
		userPassword=request.getParameter("userPassword");
		
	}
	
	
	if(request.getParameter("userID")==null||request.getParameter("userPassword")==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('입력이안된 사항이 있습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	userDAO userDao=new userDAO();
	int result=userDao.login(userID,userPassword);
	if(result==1){
		session.setAttribute("userID", userID);
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}else if(result==0){
		PrintWriter script=response.getWriter();
		
		script.println("<script>");
		script.println("alert('비밀번호가 틀렸습니다.');");
		script.println("history.back();");
		
		script.println("</script>");
		script.close();
		return;
	}
	else if(result==-1){
		PrintWriter script=response.getWriter();
		
		script.println("<script>");
		script.println("alert('없는아이디 입니다.');");
		script.println("history.back();");
		
		script.println("</script>");
		script.close();
		return;
	}
	else{
		PrintWriter script=response.getWriter();
		
		script.println("<script>");
		script.println("alert('서버오류 입니다.');");
		script.println("history.back();");
		
		script.println("</script>");
		script.close();
		return;
	}
%>