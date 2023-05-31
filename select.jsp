<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"  %>
<html>
<head>
	<title>수강신청 조회</title>
	<meta charset="EUC-KR">
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
	<link rel="stylesheet" href="table.css">
</head>
<body>
<%@ include file="top.jsp" %>
<%  if (session_id==null) { %>
	<script>
		alert("로그인 해주세요.");
		location.href = "login.jsp";
	</script> 
<% }
%>
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
				<li><a href="select.jsp" id="bold-menu">신청내역 조회</a></li>
				<li><a href="timetable.jsp">개인시간표</a></li>
				<li><a href="condition.jsp">수업 검색</a></li>
				<li><a href="evaluate.jsp">수업 평가</a></li>
			</ul>
			<ul class="aside_session">
				<li><%=log%></li>
				<li><a href="update.jsp">정보 수정</a></li>
			</ul>
		</aside>
		<section class="main_section">
		   <table width="75%" align="center" id = "select">
		   <br>
		   <tr>
		      <th>과목번호</th>
		      <th>분반</th>
		      <th>과목명</th>
		      <th>학점</th>
		      <th>수강 취소</th>
		   </tr>
		   <%
		      Connection myConn = null;
		      Statement stmt = null;
		      ResultSet myResultSet = null;
		      String mySQL = "";
		      String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
		      String user = "c##ty"; 
		      String passwd = "1811184";
		      String dbdriver = "oracle.jdbc.driver.OracleDriver";
		      
		      
			  int sum = 0, sum2=18;
		      
		      try {
		         Class.forName(dbdriver);
		         myConn =  DriverManager.getConnection (dburl, user, passwd);
		         stmt = myConn.createStatement();   
		       } catch(SQLException ex) {
		          System.err.println("SQLException: " + ex.getMessage());
		       }
		       mySQL = "select e.c_id, e.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, enroll e, teach t where e.s_id='"+ session_id +"' and e.c_id = c.c_id and c.c_id = t.c_id and e.c_id_no = c.c_id_no and c.c_id_no =  t.c_id_no and e.t_semester = Date2EnrollSemester(sysdate) and e.t_year = Date2EnrollYear(sysdate) ORDER BY t_day,t_time ";
		      myResultSet = stmt.executeQuery(mySQL);
		      
		      if (myResultSet != null) {
		         while (myResultSet.next()) {   
		            String c_id = myResultSet.getString("c_id");
		            int c_id_no = myResultSet.getInt("c_id_no");         
		            String c_name = myResultSet.getString("c_name");
		            int c_unit = myResultSet.getInt("c_unit"); 
		            int t_day = myResultSet.getInt("t_day");
		        
					
					  sum = sum + c_unit;
		      %>
		      <tr>
		        <td align="center"><%= c_id %></td>
		        <td align="center"><%= c_id_no %></td> 
		        <td align="center"><%= c_name %></td>
		        <td align="center"><%= c_unit %></td>
		  
		        <td align="center"><a id="Wcolor"
						href="delete_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>">
							취소 </a></td>
		      </tr>
		      <%
		         }
		      }
		      stmt.close();  myConn.close();   
		      %>
		   </table>
		   <table width="75%" align="center">
		   <tr>
					<td align="right"> 총 신청 학점은 <%= sum %>점 입니다.</td>
			</tr>
			<tr>
					<td align="right"> 남은 학점은  <%= sum2-sum %>점 입니다.</td>
			</tr>
		  </table>
				</section>
	</main>
</body>
</html>