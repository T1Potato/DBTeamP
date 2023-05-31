<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>수업 평가</title>
	<meta data-rh="true" name="viewport"
		content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
		href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@400;700&display=swap"
		rel="stylesheet">
	<script src="https://kit.fontawesome.com/98e3c5fbec.js"
		crossorigin="anonymous"></script>
	<link rel="stylesheet" href="main.css">
	<style>
		form{
		font-size: 0.3rem;
		font-weight: 400;	
		}
	</style>
</head>
<body>
<%@ include file="top.jsp"%>
<nav class="navbar">
		<div class="navbar_toggle">
		<img src="sook.png"/>
		</div>
		<div class="navbar_logo">
			숙명여자대학교
		</div>
		<div class="navbar_session">
			<% if (session_id != null) { %>
			<%=session_id%>님 방문을 환영합니다.
			
			<% } else { %>
			로그인 후 사용하십시오.
			<% } %>
		</div>
	</nav>
	<main>
		<aside class="asidebar">
			<ul class="aside_menu">
				<li></li>
				<li><a href="insert.jsp">수강신청 입력</a></li>
				<li><a href="select.jsp">수강신청 확인</a></li>
				<li><a href="timetable.jsp">개인시간표</a></li>
				<li><a href="evaluate.jsp">수업 검색</a></li>
				<li><a href="condition.jsp" id="bold-menu">수업 평가</a></li>
			</ul>
			<ul class="aside_session">
				<li><%=log%></li>
				<li><a href="update.jsp">정보 수정</a></li>
			</ul>
		</aside>
		<section class="main_section" style="align-items: flex-start; justify-content: flex-start; padding: 1rem;">
			<%
			String c_id = request.getParameter("c_id");
			String c_name = request.getParameter("c_name");
			%>
			   <form action="evaluate_verify.jsp">
			    수업 코드:<input type="text" name="cid" id="cid" value=<%=c_id %> readomly/>
			   <p style="margin-top: 0.3rem;">강의 점수를 입력해 주세요.</p>
			  
			   <input type="radio" name="rate" id="rate" value="1" checked="checked">1점
			   <input type="radio" name="rate" id="rate" value="2">2점
			   <input type="radio" name="rate" id="rate" value="3">3점
			   <input type="radio" name="rate" id="rate" value="4">4점
			   <input type="radio" name="rate" id="rate" value="5">5점
			   <input type="submit" value="확인">
			</form>
		</section>
	</main>
</body>
</html>