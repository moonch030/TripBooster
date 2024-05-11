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
		
		String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
		String user = "root";
	   	String password = "abcd1234";
	   	
		Connection con = DriverManager.getConnection(url, user, password);
		
		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		
		String sql = "SELECT userNum, userId, userName FROM userTbl WHERE userId = ? AND userPw = ?";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, userId);
		pstmt.setString(2, userPw);
		
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			session.setAttribute("userNumSession", rs.getString("userNum"));
			session.setAttribute("userNameSession", rs.getString("userName"));
%>
		<script>
			alert("<%=rs.getString("userName")%>님 떠나볼까요?✈");
			location.href="../index.jsp";
		</script>
<%
		}
		
		else {
%>
		<script>
			alert("입력하신 내용을 다시 확인해주세요✈");
			location.href="../login.jsp";
		</script>
<%
		}
		pstmt.close();
		con.close();
		
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>