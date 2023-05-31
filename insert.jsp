<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ include file="top.jsp"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>������û �Է�</title>
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

	<nav class="navbar">
		<div class="navbar_toggle">
		<img src="sook.png"/>
		</div>
		<div class="navbar_logo">
			�����ڴ��б�
		</div>
		<div class="navbar_session">
			<% if (session_id != null) { %>
			<%=session_id%>�� �湮�� ȯ���մϴ�.
			
			<% } else { %>
			�α��� �� ����Ͻʽÿ�.
			<% } %>
		</div>
	</nav>
	<main>
		<aside class="asidebar">
			<ul class="aside_menu">
				<li></li>
				<li><a href="insert.jsp" id="bold-menu">������û �Է�</a></li>
				<li><a href="select.jsp">��û���� ��ȸ</a></li>
				<li><a href="timetable.jsp">���νð�ǥ</a></li>
				<li><a href="condition.jsp">���� �˻�</a></li>
				<li><a href="evaluate.jsp">���� ��</a></li>
			</ul>
			<ul class="aside_session">
				<li><%=log%></li>
				<li><a href="update.jsp">���� ����</a></li>
			</ul>
		</aside>
		<section class="main_section">
			<%
			if (session_id==null) response.sendRedirect("login.jsp");
			char[] c_day = {'��','ȭ','��','��','��'};
			%>
			
			<table>
			<caption style="padding: 3px;">������ ���ϴ� ������ �����ϼ���.</caption>
			<br>
			<tr><th>�����ȣ</th><th>�й�</th><th>�����</th><th>����</th>
			<th>����</th><th>����</th><th>������û</th></tr>
			<%
			Connection myConn = null; Statement stmt = null;
			ResultSet myResultSet = null; String mySQL = "";
			String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
			String user="c##ty"; String passwd="1811184";
			String dbdriver = "oracle.jdbc.driver.OracleDriver"; 
			try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
			} catch(SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
			}
			mySQL = "select distinct c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where t.t_year = Date2EnrollYear(SYSDATE) and t.t_semester = Date2EnrollSemester(SYSDATE) and c.c_id = t.c_id and c.c_id_no = t.c_id_no";
			myResultSet = stmt.executeQuery(mySQL);
			if (myResultSet != null) {
			while (myResultSet.next()) {
			String c_id = myResultSet.getString("c_id");
			int c_id_no = myResultSet.getInt("c_id_no");
			String c_name = myResultSet.getString("c_name");
			int c_unit = myResultSet.getInt("c_unit");
			int t_day = myResultSet.getInt("t_day");
			int t_time = myResultSet.getInt("t_time");
			%>
			<tr>
			<td><%= c_id %></td> <td><%= c_id_no %></td> 
			<td><%= c_name %></td><td><%= c_unit %></td>
			<td><%= c_day[t_day-1] %></td>
			<td><%= t_time %></td>
			
			
			<td><a href="insert_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= 
			c_id_no %>">��û</a></td>
			</tr>
			<%
			}
			}
			stmt.close(); myConn.close();
			%>
			</table>
		</section>
	</main>
</body>
</html>