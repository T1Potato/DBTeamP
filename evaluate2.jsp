<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������</title>
</head>
<body>
<%@ include file="top.jsp"%>
<%
String c_id = request.getParameter("c_id");
String c_name = request.getParameter("c_name");
%>
   <form action="evaluate_verify.jsp">
    ���� �ڵ�:<input type="text" name="cid" id="cid" value=<%=c_id %> readonly/>
   <p>���� ������ �Է��� �ּ���.</p>
  
   <input type="radio" name="rate" id="rate" value="1" checked="checked">1��
   <input type="radio" name="rate" id="rate" value="2">2��
   <input type="radio" name="rate" id="rate" value="3">3��
   <input type="radio" name="rate" id="rate" value="4">4��
   <input type="radio" name="rate" id="rate" value="5">5��
    <input type="submit" value="Ȯ��">
</form>


</body>
</html>