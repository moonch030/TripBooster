<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
	<%
		request.setCharacterEncoding("UTF-8");

		String tripNum = request.getParameter("tripNum");
		String userNum = (String) session.getAttribute("userNumSession");
		String userName = (String) session.getAttribute("userNameSession");
		
		if(userName == null) {
	%>
		<script>
			alert("로그인 해주세요✈");
			location.href = document.referrer; //이전페이지로 이동 후 리로드
		</script>
	<%
		}
		
		else {
			Class.forName("com.mysql.jdbc.Driver");
			request.setCharacterEncoding("UTF-8");
			
			String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
			String user = "root"; // 데이터베이스 사용자 이름
	    	String password = "abcd1234"; // 데이터베이스 비밀번호
	    	
			Connection con = DriverManager.getConnection(url, user, password);
			con.setAutoCommit(false);
			
			String sql = "SELECT count(likeNum) FROM userLikeTbl WHERE userNum = ? AND tripNum = ?";
			
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userNum);
			pstmt.setString(2, tripNum);
			
			ResultSet rs = pstmt.executeQuery();
			int count = 0;
			
			while(rs.next()) {
				count = rs.getInt(1);
			}	
			rs.close();
			
			if(count >= 1){
			%>
				<script>
					alert("찜이 되어 있어요✈");
					window.history.back();
				</script>
		<%
				pstmt.close();
				con.close();
			} else {
				
				String sql2 = "INSERT INTO userLikeTbl(userNum, tripNum) VALUES(?,?)";
				PreparedStatement pstmt2 = con.prepareStatement(sql2);
				pstmt2.setString(1, userNum);
				pstmt2.setString(2, tripNum);
				
				pstmt2.executeUpdate();
				con.commit();
				pstmt.close();
				con.close();
			%>
				<script>
					alert("찜✈");
					location.href = document.referrer; //이전페이지로 이동 후 리로드
					//window.history.back();
					//location.reload(); //두번실행됨
				</script> 
			<%
			}
		}
	%>