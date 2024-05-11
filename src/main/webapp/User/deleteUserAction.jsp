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
	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");

	String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
	String user = "root";
   	String password = "abcd1234";
   	
	try {
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, user, password);
		con.setAutoCommit(false);

		String sql = "SELECT userId FROM userTbl WHERE userId = ? AND userPw = ?";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, userId);
		pstmt.setString(2, userPw);
		
		
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			sql = "DELETE FROM usertbl WHERE userId = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,userId);
			pstmt.executeUpdate();
			
		    con.commit();
%>
		<script>
			alert("탈퇴 완료✈");
			location.href="../index.jsp";
			<% session.invalidate(); %>
		</script>
<%
		} else {
%>
		<script>
			alert("입력하신 내용을 다시 확인해주세요✈");
			location.href="deleteUser.jsp";
		</script>
<%
		}
		
		pstmt.close();
		con.close();
		rs.close();
		
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>
