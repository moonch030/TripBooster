<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/resources/layout/head.jsp"%>
</head>
<body>
<jsp:include page="/resources/layout/adminNav.jsp"></jsp:include>
<%
    request.setCharacterEncoding("UTF-8");
    String tripNum = request.getParameter("tripNum");
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
        String user = "root";
        String password = "abcd1234";
        
        Connection con = DriverManager.getConnection(url, user, password);
        con.setAutoCommit(false);
        
        String sql = "SELECT * FROM triptbl WHERE tripNum = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, tripNum);
        
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            String tripSort = rs.getString("tripSort");
            String tripCode = rs.getString("tripCode");
            String tripName = rs.getString("tripName");
            String tripLoca = rs.getString("tripLoca");
            String tripPerson = rs.getString("tripPerson");
            String tripParking = rs.getString("tripParking");
            String tripTel = rs.getString("tripTel");
            String tripImg = rs.getString("tripImg");
            String tripContent = rs.getString("tripContent");
    %>
<div class="container mt-4">
    <h3>여행 정보 수정✈</h3><br>
    <form action="tripChangeAction.jsp" method="POST">
    
		<input type="hidden" name="tripNum" value="<%= tripNum %>">
    	<p>종류 : <select name="tripSort">
    				<option value="tour" <%= rs.getString("tripSort").equals("tour") ? "selected" : "" %>> tour </option>
        			<option value="rest" <%= rs.getString("tripSort").equals("rest") ? "selected" : "" %>> rest </option>
    			</select>
    	<p>지역 : <select name="tripCode">
    				<option value="서울" <%= rs.getString("tripCode").equals("서울") ? "selected" : "" %>> 서울 </option>
    				<option value="경기" <%= rs.getString("tripCode").equals("경기") ? "selected" : "" %>> 경기 </option>
    				<option value="인천" <%= rs.getString("tripCode").equals("인천") ? "selected" : "" %>> 인천 </option>
    				<option value="강원" <%= rs.getString("tripCode").equals("강원") ? "selected" : "" %>> 강원 </option>
    				<option value="대전" <%= rs.getString("tripCode").equals("대전") ? "selected" : "" %>> 대전 </option>
    				<option value="부산" <%= rs.getString("tripCode").equals("부산") ? "selected" : "" %>> 부산 </option>
    				<option value="울산" <%= rs.getString("tripCode").equals("울산") ? "selected" : "" %>> 울산 </option>
    				<option value="대구" <%= rs.getString("tripCode").equals("대구") ? "selected" : "" %>> 대구 </option>
    				<option value="광주" <%= rs.getString("tripCode").equals("광주") ? "selected" : "" %>> 광주 </option>
    				<option value="충북" <%= rs.getString("tripCode").equals("충북") ? "selected" : "" %>> 충북 </option>
    				<option value="충남" <%= rs.getString("tripCode").equals("충남") ? "selected" : "" %>> 충남 </option>
    				<option value="경북" <%= rs.getString("tripCode").equals("경북") ? "selected" : "" %>> 경북 </option>
    				<option value="경남" <%= rs.getString("tripCode").equals("경남") ? "selected" : "" %>> 경남 </option>
    				<option value="전북" <%= rs.getString("tripCode").equals("전북") ? "selected" : "" %>> 전북 </option>
    				<option value="전남" <%= rs.getString("tripCode").equals("전남") ? "selected" : "" %>> 전남 </option>
    				<option value="제주도" <%= rs.getString("tripCode").equals("제주도") ? "selected" : "" %>> 제주도 </option>
    			</select>
    	<p>여행지 이름 : <input type="text" name="tripName" value="<%= (request.getParameter("tripName") != null) ? request.getParameter("tripName") : rs.getString("tripName") %>"><br>
    	<p>위치	   : <input type="text" name="tripLoca" value="<%= (request.getParameter("tripLoca") != null) ? request.getParameter("tripLoca") : rs.getString("tripLoca") %>">
    	<p>수용인원	   : <input type="text" name="tripPerson" value="<%= (request.getParameter("tripPerson") != null) ? request.getParameter("tripPerson") : rs.getString("tripPerson") %>">
    	<p>주차가능 수 : <input type="text" name="tripParking" value="<%= (request.getParameter("tripParking") != null) ? request.getParameter("tripParking") : rs.getString("tripParking") %>">
    	<p>전화번호	   : <input type="text" name="tripTel" oninput="autoHyphen2(this)" value="<%= (request.getParameter("tripTel") != null) ? request.getParameter("tripTel") : rs.getString("tripTel") %>">
	    <p>이미지	   : <input type="text" name="tripImg" value="<%= (request.getParameter("tripImg") != null) ? request.getParameter("tripImg") : rs.getString("tripImg") %>">
	    <div class="form-group">
	      	  <label for="comment">여행지 설명:</label>
	       	 <textarea class="form-control" id="tripContent" name="tripContent" rows="3"><%= (request.getParameter("tripContent") != null) ? request.getParameter("tripContent") : rs.getString("tripContent") %></textarea>
	    </div>
	    <input type="submit" class="btn btn-outline-light" style="background-color: #5bc0de;" value ="수정하기">
	    <input type="reset" class="btn btn-outline-light" style="background-color: #5bc0de;" value ="다시쓰기">
	</form>
    	
	<%
			}
			
			con.commit();
			rs.close();
			pstmt.close();
			con.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	%>
	
    	
</body>
<%@ include file="/resources/layout/footer.jsp"%>
</html>