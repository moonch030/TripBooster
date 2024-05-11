<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
	<body>
	<%
	
		request.setCharacterEncoding("UTF-8");
	    try{
	        
	        String tripNum = request.getParameter("tripNum");
	        String tripCode = request.getParameter("tripCode");
	        String tripSort = request.getParameter("tripSort");
	        String tripName = request.getParameter("tripName");
	        String tripLoca = request.getParameter("tripLoca");
	        String tripImg = request.getParameter("tripImg"); 
	        String tripPerson = request.getParameter("tripPerson");
	        String tripParking = request.getParameter("tripParking");
	        String tripContent = request.getParameter("tripContent");
	        String tripTel = request.getParameter("tripTel");
	        
	        Class.forName("com.mysql.jdbc.Driver");
			request.setCharacterEncoding("UTF-8");
			
			String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
			String user = "root"; // 데이터베이스 사용자 이름
	    	String password = "abcd1234"; // 데이터베이스 비밀번호
	    	
			Connection con = DriverManager.getConnection(url, user, password);
			con.setAutoCommit(false);
			
			String sql = "UPDATE triptbl SET tripCode = ?, tripSort = ?, tripName = ?, tripLoca = ?, tripImg = ?, tripPerson = ?, tripParking = ?, tripContent = ?, tripTel = ? WHERE tripNum = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, tripCode);
			pstmt.setString(2, tripSort);
			pstmt.setString(3, tripName);
			pstmt.setString(4, tripLoca);
			pstmt.setString(5, tripImg);
			pstmt.setString(6, tripPerson);
			pstmt.setString(7, tripParking);
			pstmt.setString(8, tripContent);
			pstmt.setString(9, tripTel);
			pstmt.setString(10, tripNum);
			
			pstmt.executeUpdate();
			
			con.commit();
			pstmt.close();
			con.close();
			%>
			
	        <script>
		        alert("수정 완료 ✈");
				location.href = document.referrer;
	        </script>
	        <%

	    }catch (Exception e) {
	        e.printStackTrace();
	        %>
	        <script>
	            alert("오류가 발생했습니다.");
	            history.back();
	        </script>
	        <%
	    }
	%>
	</body>
</html>