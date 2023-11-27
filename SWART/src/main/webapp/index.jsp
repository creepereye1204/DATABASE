<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.userDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
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
<%
	request.setCharacterEncoding("UTF-8");
	String lectureDivide="전체";
	String searchType="최신순";
	String search="";
	int pageNumber=0;
	if(request.getParameter("lectureDivide")!=null){
		lectureDivide=request.getParameter("lectureDivide");
	}
	if(request.getParameter("searchType")!=null){
		searchType=request.getParameter("searchType");
	}
	if(request.getParameter("search")!=null){
		search=request.getParameter("search");
	}
	if(request.getParameter("pageNumber")!=null){
		try{
			pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
		}catch(Exception e){
			System.out.println("검색 페이지 오류");
		}
		
	}
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){
		PrintWriter script=response.getWriter();
		
		script.println("<script>");
		script.println("alert('로그인 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		
		script.println("</script>");
		script.close();
		return;
	}
	
	boolean emailChecked= new userDAO().getUserEmailChecked(userID);
	if(!emailChecked){
		PrintWriter script=response.getWriter();
		
		script.println("<script>");
		script.println("location.href='emailSendConfirm.jsp';");
		
		
		script.println("</script>");
		script.close();
		return;
	}
	
	
%>

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
	
						<a class="dropdown-item" href="./userLogoutAction.jsp">로그아웃</a>
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
	<section class="container">

		<form name="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공" <%if(lectureDivide.equals("전공"))out.println("selected"); %>>전공</option>
				<option value="교양" <%if(lectureDivide.equals("교양"))out.println("selected"); %>>교양</option>
				<option value="기타" <%if(lectureDivide.equals("기타"))out.println("selected"); %>>기타</option>
				
				
			
			</select> 
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순" >최신순</option>
				<option value="추천순" <%if(searchType.equals("추천순"))out.println("selected"); %>>추천순</option>
				
				
			
			</select> 
			<input type="text" name="search" class="btn btn-outline mx-1 mt-2"
				placeholder="내용을 입력하세요">
			<button type="submit" class="btn btn primary mx-1 bg-primary">검색</button>
			<a class="btn btn-warning mx-1" data-toggle="modal"
				href="#registerModal">등록하기</a> <a class="btn btn-danger mx-1"
				data-toggle="modal" href="#reportModal">신고하기</a>


		</form>
<%
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<>();
	evaluationList= new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	if(evaluationList!=null)
		for(int i=0;i<evaluationList.size();i++){
			if(i==5)break;
			EvaluationDTO evaluation = evaluationList.get(i);
		
	
%>
		
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%=evaluation.getLectureName() %>&nbsp;<small><%=evaluation.getProfessorName() %></small>
						&nbsp;<small>최지웅</small>
					</div>
					<div class="col-4 text-right">
						종합 <span style="color: red;"><%=evaluation.getTotalScore() %></>A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%=evaluation.getEvaluationTitle() %>&nbsp;<small><%=evaluation.getLectureYear() %>년 <%=evaluation.getSemesterDivide() %> <%=evaluation.getLectureDivide() %></small>
				</h5>
				<p class="card-text"><%=evaluation.getEvaluationContent() %></p>
				<div class="row">
				<div class="col-9 text-left">
					<span class="card-text">
						성적<span style="color:red;"> <%=evaluation.getCreditScore() %></span>
						널널<span style="color:orange;"> <%=evaluation.getComfortableScore() %></span>
						강의<span style="color:blue;"> <%=evaluation.getLectureScore() %></span>
						<span style="color:green">(추천:<%=evaluation.getLikeCount() %>)</span>
					</span>
				</div>
				<div class="col-3 text-right">
				    <h1><%=evaluation.getEvaluationID() %></h1>
					<a class="btn btb-modal bg-secondary" onclick="return confirm('기모띠?')" href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID() %>">추천</a>
					<a class="btn btb-modal bg-secondary" onclick="return confirm('삭제ㄱ?')" href="./deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID() %>">삭제</a>
				</div>
				</div>
			</div>
		</div>
<%
	}
%>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	if(pageNumber<=0){
		
	
%>
	<a class="page-link disabled">이전</a>
<%
	}else{
		
%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8")%>&searchType=<%= URLEncoder.encode(searchType,"UTF-8")%>&search=<%= URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%= pageNumber-1%>">이전</a>
<%
		
	}
%>
		</li>
		<li class="page-item">
			<%
	if(evaluationList.size()<6){
		
	
%>
	<a class="page-link disabled">다음</a>
<%
	}else{
		
%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8")%>&searchType=<%= URLEncoder.encode(searchType,"UTF-8")%>&search=<%= URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%= pageNumber+1%>">이전</a>
<%
		
	}
%>
		</li>
	</ul>
	</section>
	<div class="modal fade" id="registerModal" tabindex="1" role="dialog"
		aria-labelledby="modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-labeled="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>강의명</label> <input type="text" name="lectureName"
									class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>교수명</label> <input type="text" name="professorName"
									class="form-control" maxlength="20">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>수강 연도</label> <select name="lectureYear"
									class="form-control">
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023" selected="selected">2023</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>학기</label> <select name="semesterDivide"
									class="form-control">
									<option value="1학기">1학기</option>
									<option value="여름학기">여름학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울학기">겨울학기</option>
								</select>

							</div>
							<div class="form-group col-sm-4">
								<label>강의 구분</label> <select name="lectureDivide"
									class="form-control">
									<option value="전공">전공필수</option>
									<option value="전공">전공선택</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label>제목</label> <input type="text" name="evaluationTitle"
								class="form-control">
						</div>



						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control input-lg"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>종합</label> <select name="totalScore" class="form-control">
									<option value="A" selected="selected">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>성적</label> <select name="creditScore"
									class="form-control">
									<option value="A" selected="selected">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">

								<label>널널</label> <select name="comfortableScore"
									class="form-control">
									<option value="A" selected="selected">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>강의</label> <select name="lectureScore"
									class="form-control">
									<option value="A" selected="selected">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">

							<button class="btn btn-danger" type='submit'>등록하기</button>
							<button class="btn btn-secondary" data-dismiss="modal">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="reportModal" tabindex="1" role="dialog"
		aria-labelledby="modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-labeled="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">



						<div class="form-group">
							<label>신고 제목</label> <input type="text" name="title"
								class="form-control">
						</div>



						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="content" class="form-control input-lg"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button class="btn btn-secondary">신고</button>
							<button class="btn btn-danger" data-dismiss="modal">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
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