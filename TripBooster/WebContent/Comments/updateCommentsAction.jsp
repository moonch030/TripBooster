<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<body>
	<%
		request.setCharacterEncoding("UTF-8");
	

		String userNum = (String) session.getAttribute("userNumSession");
		String tripNum = request.getParameter("tripNum");
		String commentNum = request.getParameter("commentNum");

		Class.forName("com.mysql.jdbc.Driver");
		request.setCharacterEncoding("UTF-8");
		
		String url = "jdbc:mysql://localhost:3306/TripBooster";
		String user = "root"; // 데이터베이스 사용자 이름
    	String password = "abcd1234"; // 데이터베이스 비밀번호
    	
		Connection con = DriverManager.getConnection(url, user, password);
		con.setAutoCommit(false);
		
		String sql = "UPDATE commentTbl SET comments WHERE commentNum = ? AND userNum = ? AND tripNum = ?";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, commentNum);
		pstmt.setString(2, userNum);
		pstmt.setString(3, tripNum);
		
		pstmt.executeUpdate();
		con.commit();
		pstmt.close();
		con.close();
	%>
	<script>
		alert("수정 완료 ✈");
		location.href = document.referrer;
	</script>
	</body>
</html>