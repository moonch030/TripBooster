<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>TripBooster</title>
<%@ include file="/resources/layout/head.jsp"%>
</head>
<body>
<%@ include file="/resources/layout/userNav.jsp" %>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    request.setCharacterEncoding("UTF-8");

    String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
    String user = "root"; // 데이터베이스 사용자 이름
    String password = "abcd1234"; // 데이터베이스 비밀번호
	
    Connection con = DriverManager.getConnection(url, user, password);
    con.setAutoCommit(false);

    String sql = "SELECT  userNum, t.tripNum, t.tripName, t.tripLoca, t.tripImg"+
    		" FROM userLikeTbl ul"+
    		" JOIN tripTbl t ON ul.tripNum = t.tripNum"+
    		" WHERE ul.userNum = ?"+
    		" ORDER BY ul.likeNum DESC";

    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, userNum);
    ResultSet rs = pstmt.executeQuery();
%>
<div class="album py-5 bg-light">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <div class="text-left">
    		<br><h1 class="display-5"><b>여기가 좋을 거<br>같네요!  ✈</b></h1>
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
                        <image href="/resources/images/<%= rs.getString("tripImg") %>" width="100%" height="100%" />
                        </a>
                    </svg>
                    <div class="card-body">
                        <p class="card-text"><%=rs.getString("tripName")%></p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick = "location.href='deleteUserlikeAction.jsp?tripNum=<%=rs.getString("tripNum")%>'">삭제</button>
                            </div>
                            <small class="text-muted">✈</small>
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