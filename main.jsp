<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
String session_id = (String)session.getAttribute("user");
String log;
if (session_id==null) log="<a href='login.jsp'>로그인</a>";
else log="<a href='logout.jsp'>로그아웃</a>";
%>


<!DOCTYPE html>
<html>
<head>
<meta data-rh="true" name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
<title>수강신청 시스템</title>

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
</head>
<body>
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
				<li><a href="select.jsp">신청내역 조회</a></li>
				<li><a href="timetable.jsp">개인시간표</a></li>
				<li><a href="condition.jsp">강의 검색</a></li>
				<li><a href="evaluate.jsp">강의 평가</a></li>
			</ul>
			<ul class="aside_session">
				<li><%=log%></li>
				<li><a href="update.jsp">정보 수정</a></li>
			</ul>
		</aside>
		<section class="main_section">
			<img
				src="https://www.sookmyung.ac.kr/sites/sookmyungkr/images/sub/contents/ui_signature_07.png">
		</section>
	</main>
</body>
<script>const toggleBtn = document.querySelector('.navbar_toggle');
		const bar = document.querySelector('.asidebar');
		const section = document.querySelector('.main_section');
		toggleBtn.addEventListener('click', ()=> {
		bar.classList.toggle('active');
		section.classList.toggle('active');
		});
</script>
</html>