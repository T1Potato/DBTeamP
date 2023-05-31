<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"  %>
<html>
<head>
	<meta charset="UTF-8">
	<title>시간표</title>
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
	table {
		border: 2px solid #d2d2d2;
		border-collapse: collapse;
		font-size: 0.9rem;
        font-family: Nanum Gothic;
        text-align: center;
        
	}
	
	th, td {
		border: 1px solid #d2d2d2;
		border-collapse: collapse;
        padding: 0.1rem;
        vertical-align : middle;
	}
	
	th {
		
		height: 1rem;
        padding: 0.3rem 0.6rem;
        background: rgb(117, 161, 255);
        color: white;
	}

    th:first-child {
      background: in
    }
	
	td {
		width: 85px;
		height: 60px;
	}
	</style>
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
				<li><a href="select.jsp">신청내역 조회</a></li>
				<li><a href="timetable.jsp" id="bold-menu">개인시간표</a></li>
				<li><a href="condition.jsp">수업 검색</a></li>
				<li><a href="evaluate.jsp">수업 평가</a></li>
			</ul>
			<ul class="aside_session">
				<li><%=log%></li>
				<li><a href="update.jsp">정보 수정</a></li>
			</ul>
		</aside>
		<section class="main_section">
		<table height="600" style="color: #121212">
		<caption>▶ 강의 시간표 ◀</caption>
		<tr>
			<th></th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
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
      String[][] timetable = new String[7][10];
      
      try {
          Class.forName(dbdriver);
          myConn =  DriverManager.getConnection (dburl, user, passwd);
          stmt = myConn.createStatement();   
        } catch(SQLException ex) {
           System.err.println("SQLException: " + ex.getMessage());
        }
        mySQL = "select e.c_id, e.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time, t.t_place from course c, enroll e, teach t where e.s_id='"+ session_id +"' and e.c_id = c.c_id and c.c_id = t.c_id and e.c_id_no = c.c_id_no and c.c_id_no =  t.c_id_no and e.t_semester = Date2EnrollSemester(sysdate) and e.t_year = Date2EnrollYear(sysdate) ORDER BY t_day,t_time ";
       myResultSet = stmt.executeQuery(mySQL);
       
       if (myResultSet != null) {
          while (myResultSet.next()) {   
             String c_id = myResultSet.getString("c_id");
             int c_id_no = myResultSet.getInt("c_id_no");         
             String c_name = myResultSet.getString("c_name");
             int c_unit = myResultSet.getInt("c_unit"); 
             int c_day = myResultSet.getInt("t_day");
             int c_time = myResultSet.getInt("t_time");
             timetable[c_day][c_time] = c_name;
         }
      }
       
       for (int c_time = 1; c_time <= 9; c_time++) {
           out.print("<tr>");
           out.print("<th>" + c_time + "</th>");
           for (int c_day = 1; c_day < 6; c_day++) {
               String subject = timetable[c_day][c_time];
               if (subject != null) {
                   out.print("<td>" + subject + "</td>");
               } else {
                   out.print("<td></td>");
               }
           }
           out.print("</tr>");
       }
       
      stmt.close();  myConn.close();   
      %>
	</table>
	</section>
	</main>
</body>
</html>