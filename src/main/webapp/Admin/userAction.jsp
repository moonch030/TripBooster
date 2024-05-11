<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String userTel = request.getParameter("userTel");
		String userName = request.getParameter("userName");
		String userPw = request.getParameter("userPw");
		String userNum = (String) session.getAttribute("userNumSession");

		Class.forName("com.mysql.jdbc.Driver");
		request.setCharacterEncoding("UTF-8");
		
		String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
		String user = "root"; // 데이터베이스 사용자 이름
    	String password = "abcd1234"; // 데이터베이스 비밀번호
    	
		Connection con = DriverManager.getConnection(url, user, password);
		con.setAutoCommit(false);
		
		String sql = "UPDATE userTbl SET userName = ?, userTel = ?, userPw = ? WHERE userNum = ?";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, userName);
		pstmt.setString(2, userTel);
		pstmt.setString(3, userPw);
		pstmt.setString(4, userNum);
		
		pstmt.executeUpdate();
		con.commit();
		pstmt.close();
		con.close();
		
		String newName = request.getParameter("userName");
		session.setAttribute("userNameSession", newName);
		
	%>
	<script>
		alert("수정 완료 ✈");
		location.href = document.referrer;
	</script>
	</body>
</html>