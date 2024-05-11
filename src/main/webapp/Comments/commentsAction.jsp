<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<body>
	<%
		String userName = (String) session.getAttribute("userNameSession");
	
		if (userName == null) {
%>
			<script>
				alert("로그인 후 작성해주세요!✈");
				location.href = document.referrer; //이전페이지로 이동 후 리로드
			</script>
<%
		}
	else {
		request.setCharacterEncoding("UTF-8");
		
		String tripNum = request.getParameter("tripNum");
		String comments = request.getParameter("comments");
		String userNum = (String) session.getAttribute("userNumSession");

		Class.forName("com.mysql.jdbc.Driver");
		request.setCharacterEncoding("UTF-8");
		
		String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
		String user = "root"; // 데이터베이스 사용자 이름
    	String password = "abcd1234"; // 데이터베이스 비밀번호
    	
		Connection con = DriverManager.getConnection(url, user, password);
		con.setAutoCommit(false);
		
		String sql = "INSERT INTO commentsTbl(comments, userNum, tripNum) VALUES(?,?,?)";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, comments);
		pstmt.setString(2, userNum);
		pstmt.setString(3, tripNum);
		
		pstmt.executeUpdate();
		con.commit();
		pstmt.close();
		con.close();
%>
	<script>
		alert("작성 완료!✈");
		location.href = document.referrer; //이전페이지로 이동 후 리로드
	</script>
<%
	}
%>
	</body>
</html>