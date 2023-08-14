<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>TripBooster</title>
<%@ include file="/resources/layout/head.jsp"%>
<style>
.trip-content-cell {
    max-height: 100px; /* 적절한 높이 조정 */
    overflow: auto;   /* 스크롤 가능하도록 설정 */
}
.page-container {
    margin-bottom: 100px; /* 푸터 높이만큼 여백 확보 */
}
</style>
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

    String url = "jdbc:mysql://localhost:3306/TripBooster";
    String user = "root"; // 데이터베이스 사용자 이름
    String password = "abcd1234"; // 데이터베이스 비밀번호
	
    String tripNum = request.getParameter("tripNum");
    
    Connection con = DriverManager.getConnection(url, user, password);
    con.setAutoCommit(false);

    String sql = "SELECT *"+
            " FROM tripTbl"+
    		" WHERE tripNum = ?";

    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt = con.prepareStatement(sql);
	pstmt.setString(1,tripNum);

    ResultSet rs = pstmt.executeQuery();
    
    while(rs.next()){
%>
<div id="demo" class="carousel slide mb-6" data-ride="carousel">
	<img class="d-block w-100" src="/resources/images/<%= rs.getString("tripImg") %>"
		alt="<%=rs.getString("tripName")%>" style="height: 600px;">
			<div class="carousel-caption d-none d-md-block">
                <h2><b><%=rs.getString("tripName")%></b></h2>
                <p><%=rs.getString("tripLoca")%></p>
			</div>
</div>
<div class="table-container">
    <table class="table">
        <thead>
            <tr>
                <th>지역</th>
                <th>여행지 이름</th>
                <th>여행지 위치</th>
                <th>수용 인원</th>
                <th>주차 가능 수</th>
                <th>여행지 설명</th>
                <th>전화번호</th>
            </tr>
        </thead>
        <tbody>
                <tr>
                    <td><%= rs.getString(2) %></td>
                    <td><%= rs.getString(4) %></td>
                    <td><%= rs.getString(5) %></td>
                    <td><%= rs.getString(7) %></td>
                    <td><%= rs.getString(8) %></td>
                    <td>
                    	<div class="trip-content-cell">
                         <% 
                        String tripContent = rs.getString(9);
                        int text = 30; // 30글자마다 나누기
                        for (int i = 0; i < tripContent.length(); i += text) {
                            int endIndex = Math.min(i + text, tripContent.length());
                            out.println(tripContent.substring(i, endIndex) + "<br>");
                        }
                        %>
                  		  </div>
               		 </td>
                    <td><%= rs.getString(10) %></td>
                </tr>
        </tbody>
    </table>
  <div style="text-align: right;">
        <a href="/User/userLikeAction.jsp?tripNum=<%=rs.getString("tripNum")%>" class="btn btn-outline-light" style="background-color: #5bc0de;">찜 ❤</a>&nbsp;&nbsp;
  </div>
</div>

<!-- 댓글 -->
<div class="container mt-4">
    <h3>이곳은 어떤가요?✈</h3>
    <form action="/Comments/commentsAction.jsp" method="post">
	    <input type="hidden" name="tripNum" value="<%=rs.getString("tripNum")%>">
	    	<div class="form-group">
	      	  <label for="comment">리뷰 작성:</label>
	       	 <textarea class="form-control" id="comments" name="comments" rows="3"></textarea>
	    </div>
	    <button type="submit" class="btn btn-outline-light" style="background-color: #5bc0de;">작성</button>
	</form>

            <%
    }
			rs.close();
			pstmt.close();
			con.close();
			
        } catch(Exception e) {
            e.printStackTrace();
        }
%>
    <!-- 댓글 테이블 -->
    <table class="table mt-4">
        <thead>
            <tr>
                <th>작성자</th>
                <th>내용</th>
                <th>작성일</th>
                <th></th>
            </tr>
        </thead>
<%
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    request.setCharacterEncoding("UTF-8");
	
	    String url = "jdbc:mysql://localhost:3306/TripBooster";
	    String user = "root"; // 데이터베이스 사용자 이름
	    String password = "abcd1234"; // 데이터베이스 비밀번호
	    
	    Connection con = DriverManager.getConnection(url, user, password);
	    con.setAutoCommit(false);
	
	    String tripNum = request.getParameter("tripNum");
	
	    String sql = "SELECT c.commentNum, c.comments, u.userNum, u.userName, c.tripNum, c.createdAt"+
	    	         " FROM commentsTbl c"+
	    	         " INNER JOIN userTbl u ON c.userNum = u.userNum"+
	    	         " WHERE c.tripNum = ?"+
  					 " ORDER BY createdAt DESC"; // 최신순으로 정렬

  		PreparedStatement pstmt = con.prepareStatement(sql);
	    pstmt = con.prepareStatement(sql);
	    
		pstmt.setString(1,tripNum);
	
	    ResultSet rs = pstmt.executeQuery();
	    
		while(rs.next()){
%>     
	<tbody>
		<td><%=rs.getString("userName")%></td>
		<td><%=rs.getString("comments")%></td>
		<td><%=rs.getString("createdAt")%></td>
<%
	if (userNum != null) {
   	 	String commentUserNum = rs.getString("userNum");
    	if (userNum.equals(commentUserNum)) { // 본인 댓글만 삭제 가능
%>
		<td style="text-align: right;">
		<a href="/Comments/updateCommentsAction.jsp?commentNum=<%=rs.getString("commentNum")%>&tripNum=<%=rs.getString("tripNum")%>" class="btn btn-outline-light" style="background-color: #5bc0de;">수정</a>
		<a href="/Comments/deleteCommentsAction.jsp?commentNum=<%=rs.getString("commentNum")%>&tripNum=<%=rs.getString("tripNum")%>" class="btn btn-outline-light" style="background-color: #5bc0de;">삭제</a>
		</td>
<%
    }
	}
%>
	</tbody>
<%
    }
			rs.close();
			pstmt.close();
			con.close();
			
        } catch(Exception e) {
            e.printStackTrace();
        }
%>
    </table>
    <br><br><br>
</div>
<%@ include file="/resources/layout/footer.jsp"%>
</body>
</html>
