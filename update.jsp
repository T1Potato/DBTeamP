<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<html>
<head>
	<title>������û ����� ���� ����</title>
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
	<%@ include file="top.jsp"%>
	<%  if (session_id==null) { %>
	<script>
		alert("�α��� ���ּ���.");
		location.href = "login.jsp";
	</script> 
<% }
%>
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
	<section>
		<aside class="asidebar">
			<ul class="aside_menu">
				<li></li>
				<li><a href="insert.jsp">������û �Է�</a></li>
				<li><a href="select.jsp">��û���� ��ȸ</a></li>
				<li><a href="timetable.jsp">���νð�ǥ</a></li>
				<li><a href="condition.jsp">���� �˻�</a></li>
				<li><a href="evaluates.jsp" id="bold-menu">���� ��</a></li>
			</ul>
			<ul class="aside_session">
				<li><%=log%></li>
				<li><a href="update.jsp">���� ����</a></li>
			</ul>
		</aside>
		</section>
		<section class="main_section">
			<%
			Connection myConn = null;
			Statement stmt = null;
			ResultSet myResultSet = null;
			String mySQL = "";
			String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "c##ty";
			String passwd = "1811184";
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			try {
				Class.forName(dbdriver);
				myConn = DriverManager.getConnection(dburl, user, passwd);
				stmt = myConn.createStatement();
			} catch (SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
			}
			mySQL = "select s_addr, s_pwd from student where s_id='" + session_id + "'";
			myResultSet = stmt.executeQuery(mySQL);
			if (myResultSet != null) {
				while (myResultSet.next()) {
					String s_addr = myResultSet.getString("s_addr");
					String s_pwd = myResultSet.getString("s_pwd");
					%>
					<form method="post" action="update_verify.jsp">
						<input type="hidden" name="s_id" size="30" value="<%=session_id%>">
						<table width="75%" align="center" border>
							<tr>
								<th>�� ��</th>
								<td><input type="text" name="s_addr" size="50"
									value="<%=s_addr%>"></td>
							</tr>
							<tr>
								<th>�н�����</th>
								<td><input type="password" name="s_pwd" size="20"
									value="<%=s_pwd%>"></td>
							</tr>
							<%
					}
					}
					stmt.close();
					myConn.close();
					%>
					<tr>
						<td colspan="2" align="center"><input type="submit"
							value="����"></td>
					</tr>
			</form>
		</section>
	</main>
</body>
</html>