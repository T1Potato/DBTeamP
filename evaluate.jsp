<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ include file="top.jsp"%>

<jsp:useBean id="userName" class="user.UserInfo" scope="session" />

<!DOCTYPE html>
<html>
<head>
<title>������</title>
<meta charset="EUC-KR">
<title>�����ͺ��̽��� Ȱ���� ������û �ý����Դϴ�.</title>
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
<style>
form {
	font-size: 0.3rem;
	font-weight: 400;
}
</style>
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
		<section class="main_section">
			<div align="center">
				<br>���� ���� ��û ���� ������ ���� �� �����ϴ�.
			</div>
			<table width="75%" align="center" id="select">
				<br>
				<tr>
					<th>�����⵵</th>
					<th>�����ȣ</th>
					<th>�����</th>
					<th>������</th>
				</tr>
				<%
      Connection myConn = null;
      Statement stmt = null;
      CallableStatement ntmt = null;
      ResultSet myResultSet = null;
      ResultSet sResultSet = null;
      String mySQL = "";
      String sSQL = "";
      String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
      String user = "c##ty"; 
      String passwd = "1811184";
      String dbdriver = "oracle.jdbc.driver.OracleDriver";
      
      
      
      try {
         Class.forName(dbdriver);
         myConn =  DriverManager.getConnection (dburl, user, passwd);
         stmt = myConn.createStatement();    
       } catch(SQLException ex) {
          System.err.println("SQLException: " + ex.getMessage());
       }
       mySQL = "select distinct t.t_year, t.t_semester, e.c_id, c.c_name from teach t, enroll e, course c where e.c_id not in (select e.c_id from enroll e where e.t_semester = Date2EnrollSemester(sysdate) and e.t_year = Date2EnrollYear(sysdate)) and e.s_id = '" + session_id + "' and c.c_id = e.c_id and t.t_year = e.t_year and t.t_semester = e.t_semester";
       myResultSet = stmt.executeQuery(mySQL);

      
      if (myResultSet != null) {
         while (myResultSet.next()) {   
            String c_id = myResultSet.getString("c_id");       
            String c_name = myResultSet.getString("c_name");
            int t_year = myResultSet.getInt("t_year");
            ntmt = myConn.prepareCall("{? =call beenEval(?,?)}");
            
            ntmt.setString(2, session_id);
            ntmt.setString(3, c_id);
            
            ntmt.registerOutParameter(1, java.sql.Types.INTEGER);
            
            ntmt.execute();
            int t = ntmt.getInt(1);
      %>
				<tr>
					<td align="center"><%= t_year %></td>
					<td align="center"><%= c_id %></td>
					<td align="center"><%= c_name %></td>
					<%
        if(t == 0){
        %>
					<td align="center">�Ϸ�</td>
					<%}else{ %>
					<td align="center"><a id="Wcolor"
						href="evaluate2.jsp?c_id=<%=c_id%>&c_name=<%=c_name%>"> ��</a></td>
					<%} %>
				</tr>
				<%
        }
      }
      ntmt.close();
      stmt.close();  myConn.close();   
      %>
			</table>
		</section>
	</main>
</body>
<script>
		const toggleBtn = document.querySelector('.navbar_toggle');
		const bar = document.querySelector('.asidebar');
		const section = document.querySelector('.main_section_img');
		toggleBtn.addEventListener('click', ()=> {
		bar.classList.toggle('active');
		section.classList.toggle('active');
		});
</script>
</html>