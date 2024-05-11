<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try {
	Class.forName("com.mysql.jdbc.Driver");
	request.setCharacterEncoding("UTF-8");
	
	String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
	String user = "root"; // 데이터베이스 사용자 이름
   	String password = "abcd1234"; // 데이터베이스 비밀번호
   	
	Connection con = DriverManager.getConnection(url, user, password);
	
	String userId = request.getParameter("userId");
	
	String sql = "SELECT count(userId) FROM userTbl WHERE userId = ?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setString(1, userId);
	
	ResultSet rs = pstmt.executeQuery();
	
	if(rs.next()){
		int flag = Integer.parseInt(rs.getString(1));
		
		if(flag > 0){
		%>
			<script>
				alert("중복된 아이디 입니다.\n다른 아이디를 사용해주세요.");
				window.close();
			</script>
		<%
		} else {
		%>
			<script>
				alert("사용가능한 아이디 입니다.");
				window.close();
			</script>
		<%
		}
	}
	pstmt.close();
	con.close();
	
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>