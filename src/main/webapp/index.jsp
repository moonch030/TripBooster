<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>TripBooster</title>
<%@ include file="/resources/layout/head.jsp"%>
</head>
<%
 //response.setHeader("Cache-Control","no-cache");
 //response.setHeader("Pragma","no-cache");
 //response.setDateHeader("Expires",0);
%>
<body>

<%
    request.setCharacterEncoding("UTF8");
    response.setCharacterEncoding("UTF-8");

    String userNum = (String) session.getAttribute("userNumSession");
    String userName = (String) session.getAttribute("userNameSession");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        request.setCharacterEncoding("UTF-8");

        String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
        String user = "root"; // 데이터베이스 사용자 이름
        String password = "abcd1234"; // 데이터베이스 비밀번호

        Connection con = DriverManager.getConnection(url, user, password);
        con.setAutoCommit(false);

        String sql = "SELECT t.tripNum, t.tripCode, t.tripSort, t.tripName, t.tripLoca, t.tripImg, COUNT(l.likeNum) AS likeCount"+
                " FROM tripTbl t"+
                " LEFT JOIN userLikeTbl l ON t.tripNum = l.tripNum"+
                " GROUP BY t.tripNum"+
                " ORDER BY likeCount DESC"+
                " LIMIT 5;";

        PreparedStatement pstmt = con.prepareStatement(sql);

        ResultSet rs = pstmt.executeQuery();

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

<div id="demo" class="carousel slide mb-6" data-ride="carousel">
    <div class="carousel-inner">
        <%
            int index = 0; // 현재 반복되는 루프의 인덱스
            while (rs.next()) {
                String activeClass = (index == 0) ? "active" : ""; // 첫 번째 슬라이드에 "active" 클래스를 추가하고 나머지 슬라이드에는 클래스를 추가하지 않음
        %>
        <div class="carousel-item <%= activeClass %>"> <!-- 슬라이더의 각 항목을 나타내는 div 요소를 생성 -->
            <img class="d-block w-100" src="resources/images/<%= rs.getString("tripImg") %>"
                alt="<%=rs.getString("tripName")%>" style="height: 600px;">
            <div class="carousel-caption d-none d-md-block">
                <h2><b><%=rs.getString("tripName")%></b></h2>
                <p><%=rs.getString("tripLoca")%></p>
            </div>
        </div>
        <%
                index++;
            }
			rs.close();
			pstmt.close();
			con.close();
			
        } catch(Exception e) {
            e.printStackTrace();
        }
%>
<a class="carousel-control-prev" href="#demo" data-slide="prev">
	        	<span class="carousel-control-prev-icon" aria-hidden="true"></span>
	        <!-- <span>Previous</span> -->
	    	</a>
	    	<a class="carousel-control-next" href="#demo" data-slide="next">
	        	<span class="carousel-control-next-icon" aria-hidden="true"></span>
	        <!-- <span>Next</span> -->
	        </a>
	    	<!-- / 화살표 버튼 끝 -->
	    	<!-- 인디케이터 -->
		    <ul class="carousel-indicators">
		    	<li data-target="#demo" data-slide-to="0" class="active"></li> <!--0번부터시작-->
		    	<li data-target="#demo" data-slide-to="1"></li>
		    	<li data-target="#demo" data-slide-to="2"></li>
		    	<li data-target="#demo" data-slide-to="3"></li>
		    	<li data-target="#demo" data-slide-to="4"></li>
		    </ul>
		    <!-- 인디케이터 끝 -->
    </div>
</div>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    request.setCharacterEncoding("UTF-8");

    String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";


    String user = "root"; // 데이터베이스 사용자 이름
    String password = "abcd1234"; // 데이터베이스 비밀번호

    Connection con = DriverManager.getConnection(url, user, password);
    con.setAutoCommit(false);

    String sql = "SELECT t.tripNum, t.tripCode, t.tripSort, t.tripName, t.tripLoca, t.tripImg, COUNT(l.likeNum) AS likeCount"+
            " FROM tripTbl t"+
            " LEFT JOIN userLikeTbl l ON t.tripNum = l.tripNum"+
            " GROUP BY t.tripNum"+
            " ORDER BY likeCount DESC"+
            " LIMIT 5;";

    PreparedStatement pstmt = con.prepareStatement(sql);

    ResultSet rs = pstmt.executeQuery();
%>
<div class="album py-5 bg-light">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <div class="text-left">
    		<br><h1 class="display-3"><b>국내 여행지 <br>TOP 5 ✈</b></h1>
		</div>
<%
            while (rs.next()) {
%>
	 <div class="col">
	    <div class="card shadow-sm">
	        <svg class="bd-placeholder-img card-img-top" width="100%" height="225"
	             xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail"
	             preserveAspectRatio="xMidYMid slice" focusable="false">
	            <a href="Trip/tripChoice.jsp?tripNum=<%=rs.getString("tripNum")%>&tripSort=<%=rs.getString("tripSort")%>">
	                <image href="resources/images/<%=rs.getString("tripImg")%>" width="100%" height="100%" />
	            </a>
	        </svg>
	        <div class="card-body">
	            <p class="card-text"><%= rs.getString("tripName") %></p>
	            <div class="d-flex justify-content-between align-items-center">
	                <div class="btn-group">
	                    <% if (userName == null || userName.isEmpty()) { %>
			                <!-- 로그아웃 상태일 때 버튼이 표시되지 않도록 처리 -->
			            <% } else if (userName.equals("관리자")) { %>
			                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/Admin/tripChange.jsp?tripNum=<%= rs.getString("tripNum") %>'">수정</button>
			                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/Admin/tripDeleteAction.jsp?tripNum=<%= rs.getString("tripNum") %>'">삭제</button>
			            <% } else { %>
			                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/User/userLikeAction.jsp?tripNum=<%= rs.getString("tripNum") %>'">❤</button>
			            <% } %>

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