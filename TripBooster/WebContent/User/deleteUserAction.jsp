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
	try {
		Class.forName("com.mysql.jdbc.Driver");
		request.setCharacterEncoding("UTF-8");
		
		String url = "jdbc:mysql://localhost:3306/TripBooster";
		String user = "root";
	   	String password = "abcd1234";
	   	
		Connection con = DriverManager.getConnection(url, user, password);
		con.setAutoCommit(false);
		
		String userNum = (String) session.getAttribute("userNumSession");
		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		
		String sql = "SELECT * FROM userTbl WHERE userId = ? AND userPw = ?";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, userId);
		pstmt.setString(2, userPw);
		
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
		    pstmt.close();

		    String deleteSql = "DELETE FROM userTbl WHERE userNum = ?";
		    pstmt = con.prepareStatement(deleteSql);

		    pstmt.setString(1, userNum);

		    pstmt.executeUpdate();
		    con.commit();
%>
		<script>
			alert("탈퇴 완료✈");
			location.href="../index.jsp";
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
		con.close();
		
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>
