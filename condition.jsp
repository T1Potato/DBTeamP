<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>���� ��ȸ</title>
</head>
<body>
	<%@ include file="top.jsp"%>
	<%
	if (session_id == null) {
	%>
	<script>
		alert("�α��� ���ּ���.");
		location.href = "login.jsp";
	</script>
	<% } %>
	<form action="condition.jsp" method="post">
		<label for="year">�⵵:</label> <input type="text" id="year" name="year"><br>

		<label for="semester">�б�:</label> <input type="text" id="semester"
			name="semester"><br> <label for="major">����:</label> <input
			type="text" id="major" name="major"><br> <input
			type="submit" value="��ȸ">
	</form>

	<table width="75%" align="center" id="select">
		<br>
		<tr>
			<th>�����ȣ</th>
			<th>�й�</th>
			<th>�����</th>
			<th>����</th>
			<th>����</th>
			<th>����</th>
			<th>������</th>
		</tr>
	<%
        // Oracle �����ͺ��̽� ���� ����
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String username = "c##ty";
        String password = "1811184";

        // ����� �Է� ��������
        String inputYear = request.getParameter("year");
        String inputSemester = request.getParameter("semester");
        String inputMajor = request.getParameter("major");

        if (inputYear == null) inputYear = "2023";
    	if (inputSemester == null) inputSemester = "1";
        // �����ͺ��̽� ���� �� ���� ������ ���� ��ü �ʱ�ȭ
        
        Connection conn = null;
		Statement stmt = null;
		CallableStatement ntmt = null;
		ResultSet myResultSet = null;
		
		String selectQuery = "";
		String mySQL = "";
		String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "c##ty";
		String passwd = "1811184";
		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		String sday = "";
        
        try {
			Class.forName(dbdriver);
			conn = DriverManager.getConnection(dburl, user, passwd);
			stmt = conn.createStatement();
		} catch (SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}
/*
        if (inputYear == null && inputSemester == null && inputMajor == null) {
        	selectQuery = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no =  t.c_id_no ORDER BY c_id";
        }else if(inputYear != null && inputSemester == null && inputMajor == null){
        	selectQuery = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no =  t.c_id_no and t.t_year='" 
    				+ inputYear + "' ORDER BY c_id";
        }else if(inputYear == null && inputSemester == null && inputMajor != null){
        	selectQuery = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no =  t.c_id_no and c.c_major='" 
    				+ inputMajor + "' ORDER BY c_id ";
        }else if(inputYear == null && inputSemester != null && inputMajor == null){
        	selectQuery = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no =  t.c_id_no and t.t_semester='" 
    				 + inputSemester + "' ORDER BY c_id ";
        }else if(inputYear != null && inputSemester != null && inputMajor == null){
        	selectQuery = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no =  t.c_id_no and t.t_year='" 
    				+ inputYear + "' and t.t_semester='" + inputSemester + "' ORDER BY c_id ";
        }else if(inputYear != null && inputSemester == null && inputMajor != null){
        	selectQuery = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no =  t.c_id_no and t.t_year='" 
    				+ inputYear + "' and c.c_major='" + inputMajor + "' ORDER BY c_id ";
        }else if(inputYear == null && inputSemester != null && inputMajor != null){
        	selectQuery = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no =  t.c_id_no and c.c_major='" 
    				+ inputMajor + "' and t.t_semester='" + inputSemester + "' ORDER BY c_id ";
        }else{
        	selectQuery = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no =  t.c_id_no and t.t_year='" 
    				+ inputYear + "' and t.t_semester='" + inputSemester + "' and c.c_major='" + inputMajor + "' ORDER BY c_id ";
        }*/
            try {
                // Oracle ����̹� �ε�
                Class.forName("oracle.jdbc.driver.OracleDriver");

                // �����ͺ��̽� ����
                conn = DriverManager.getConnection(url, username, password);

                // ���� ��ȸ ���� ����
                
                selectQuery = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_day, t.t_time from course c, teach t where c.c_id = t.c_id and c.c_id_no =  t.c_id_no and t.t_year='" 
    				+ inputYear + "' and t.t_semester='" + inputSemester + "' ORDER BY c_id "; 
                
                stmt = conn.createStatement();
                
                myResultSet = stmt.executeQuery(selectQuery);

                // ��ȸ ��� ���
        		if (myResultSet != null) {
        			while (myResultSet.next()) {
        				String c_id = myResultSet.getString("c_id");
        				int c_id_no = myResultSet.getInt("c_id_no");
        				String c_name = myResultSet.getString("c_name");
        				int c_unit = myResultSet.getInt("c_unit");
        				int c_day = myResultSet.getInt("t_day");
        				int c_time = myResultSet.getInt("t_time");
        				ntmt = conn.prepareCall("{? = call avgScore(?)");
        				ntmt.setString(2,c_id);
        				ntmt.registerOutParameter(1, java.sql.Types.VARCHAR);
        				ntmt.execute();
        				String eval = ntmt.getString(1);
        				
        				if(eval==null){
        					eval="����";
        				}else{
        					eval = eval+"��";
        				}
        				

        				if(c_day == 1){
        					sday = "��";
        				}else if(c_day == 2){
        					sday = "ȭ";
        				}else if(c_day == 3){
        					sday = "��";
        				}else if(c_day == 4){
        					sday = "��";
        				}else {
        					sday = "��";
        				}
        				
        		%>

	<tr>
		<td align="center"><%=c_id%></td>
		<td align="center"><%=c_id_no%></td>
		<td align="center"><%=c_name%></td>
		<td align="center"><%=c_unit%></td>
		<td align="center"><%=sday%></td>
		<td align="center"><%=c_time%></td>
		<td align="center"><%=eval%></td>
	</tr>
	<%
        		}
        		
        		stmt.close();
        		conn.close(); }
            }catch (SQLException ex) {
    			System.err.println("SQLException: " + ex.getMessage());
    		} 
        		%>
        		</table>
	
</body>
</html>
