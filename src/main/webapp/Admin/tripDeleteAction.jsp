<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
	String user = "root";
   	String password = "abcd1234";

	String tripNum = request.getParameter("tripNum");
	
   	
	try {
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, user, password);
		con.setAutoCommit(false);

		String sql = "DELETE FROM triptbl WHERE tripNum = ?";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, tripNum);
		
		pstmt.executeUpdate();
		con.commit();
		
		pstmt.close();
		con.close();
		
%>
		<script>
			alert("삭제 완료✈");
			location.href = document.referrer;
		</script>
<%
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>