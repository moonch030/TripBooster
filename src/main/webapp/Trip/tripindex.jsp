<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>TripBooster</title>
<%@ include file="/resources/layout/head.jsp"%>
</head>
<body>

<%
    request.setCharacterEncoding("UTF8");
    response.setCharacterEncoding("UTF-8");

    String userNum = (String) session.getAttribute("userNumSession");
    String userName = (String) session.getAttribute("userNameSession");
    
        if (userName == null) {
%>
    <jsp:include page="/resources/layout/nav.jsp"></jsp:include>
<%
        }

        if (userName != null) {
%>
    <%
        if (userName.equals("관리자")) {
    %>
            <jsp:include page="/resources/layout/adminNav.jsp"></jsp:include>
    <%
        } else {
    %>
            <jsp:include page="/resources/layout/userNav.jsp"></jsp:include>
    <%
        }
    }
%>
<%
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    request.setCharacterEncoding("UTF-8");
	
	    String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
	    String user = "root"; // 데이터베이스 사용자 이름
	    String password = "abcd1234"; // 데이터베이스 비밀번호
	    
	    String tripCode = request.getParameter("tripCode");
	    String tripSort = request.getParameter("tripSort");
	
	    Connection con = DriverManager.getConnection(url, user, password);
	    con.setAutoCommit(false);
	
	    String sql = "SELECT t.*, COUNT(ul.likeNum) AS likeCount" +
	            " FROM triptbl t" +
	            " LEFT JOIN userLiketbl ul ON t.tripNum = ul.tripNum" +
	            " WHERE t.tripCode = ? AND t.tripSort = ?" +
	            " GROUP BY t.tripNum"+
	            " ORDER BY likeCount DESC";
	    
	    PreparedStatement pstmt = con.prepareStatement(sql);
	    pstmt = con.prepareStatement(sql);
		pstmt.setString(1,tripCode);
		pstmt.setString(2,tripSort);
		
	    ResultSet rs = pstmt.executeQuery();
%>
<div class="album py-5 bg-light">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <div class="text-left">
    		<br><h1 class="display-5"><b><%=tripCode%> 관광지 ✈</b></h1>
    		<br><a href="tripSort.jsp?tripCode=<%=tripCode%>&tripSort=rest"><h4><%=tripCode%> 맛집을 찾고 계신가요?</h4></a>
		</div>
<% 
	while (rs.next()) {
%>
            <div class="col">
                <div class="card shadow-sm">
                    <svg class="bd-placeholder-img card-img-top" width="100%" height="225"
                         xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail"
                         preserveAspectRatio="xMidYMid slice" focusable="false">
                        <a href="/Trip/tripChoice.jsp?tripNum=<%= rs.getString("tripNum") %>">
                        <image href="resources/images/<%= rs.getString("tripImg") %>" width="100%" height="100%" />
                    </svg>
                    <div class="card-body">
                        <p class="card-text"><%= rs.getString("tripName") %></p>
                        <p class="card-text"><%= rs.getString("tripLoca") %></p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                            	<%if (userName != null) {
                            		if (userName.equals("관리자")){ %>
                            			<button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/Admin/tripChange.jsp?tripNum=<%= rs.getString("tripNum") %>'">수정</button>
					                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/Admin/tripDeleteAction.jsp?tripNum=<%= rs.getString("tripNum") %>'">삭제</button>
					            <% } else { %>
					                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/User/userLikeAction.jsp?tripNum=<%= rs.getString("tripNum") %>'">❤</button>
					            <% } 
                            	}%>
                                
                            </div>
                            <small class="text-muted">✈ <%= rs.getString("likeCount") %></small>
                        </div>
                    </div>
                </div>
            </div>
<% 
                }
            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
%>
    </div>
</div>
<%@ include file="/resources/layout/footer.jsp"%>
</body>
</html>