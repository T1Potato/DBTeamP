<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>������û ����� ���� ����</title>
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
				<td colspan="2" align="center"><input type="submit" value="����"></td>
			</tr>
			</form>
</body>
</html>