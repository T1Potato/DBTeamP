<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

<%String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");

%>
<!DOCTYPE html>


<%
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##ty";
String passwd="1811184"; // ��й�ȣ
String dbdriver = "oracle.jdbc.driver.OracleDriver";
Connection conn = null;
Statement stmt = null, mySQL = null;

try{
Class.forName(dbdriver);
out.println("jdbc driver �ε� ����");
conn = DriverManager.getConnection(dburl, user, passwd);
out.println("����Ŭ ���� ����");
} catch (ClassNotFoundException e){
System.out.println("driver �ε� ����");
} catch (SQLException e){
System.out.println("����Ŭ ���� ����");
System.out.println(e);
}
%>
<%
stmt = conn.createStatement();
String sql = "select s_id from student where s_id='" +userID + "' and s_pwd='" + userPassword + "'";
ResultSet myResultSet = stmt.executeQuery(sql);
if(myResultSet.next()){
	session.setAttribute("user", userID);
	response.sendRedirect("main.jsp");
}else {
	%>
	<script>
		alert("����� ���̵� Ȥ�� ��ȣ�� Ʋ�Ƚ��ϴ�.");
		location.href="login.jsp";
	</script>
	<% 
}
	stmt.close();
	conn.close();
	%>
