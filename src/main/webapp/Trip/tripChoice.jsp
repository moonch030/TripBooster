<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>TripBooster</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=u2e9jz3o2l&submodules=geocoder"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!--  <script type="text/javascript" src="/resources/js/map.js" ></script> -->
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

    String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
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
                    <td><%= rs.getString("tripLoca") %></td>
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
        <%-- <a href="/User/userLikeAction.jsp?tripNum=<%=rs.getString("tripNum")%>" class="btn btn-outline-light" style="background-color: #5bc0de;">찜 ❤</a>&nbsp;&nbsp; --%>
		<%if (userName != null) {
			if (userName.equals("관리자")){ %>
        		<button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/Admin/tripChange.jsp?tripNum=<%= rs.getString("tripNum") %>'">수정</button>
				<button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/Admin/tripDeleteAction.jsp?tripNum=<%= rs.getString("tripNum") %>'">삭제</button>&nbsp;&nbsp;&nbsp;
			<%} else { %>
				<button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/User/userLikeAction.jsp?tripNum=<%= rs.getString("tripNum") %>'">❤</button>&nbsp;&nbsp;
			<%} 
		}%>
  </div>
</div>

<div class="container mt-4"> <!-- 지도 -->
	<div id="map" style="width: 100%; height: 60vh;"></div>
	
	<script>
        window.onload = function () {
            var map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(37.5665, 126.9780), // 서울 좌표
                zoom: 16
            });

            var tripLoca = "<%=rs.getString("tripLoca")%>";

            naver.maps.Service.geocode({ address: tripLoca }, function(status, response) {
                if (status === naver.maps.Service.Status.OK) {
                    var location = new naver.maps.LatLng(response.result.items[0].point.y, response.result.items[0].point.x);

                    var marker = new naver.maps.Marker({
                        position: location,
                        map: map
                    });
                    
                    map.setCenter(location); // 지도의 중심을 마커의 위치로 이동
                } else {
                    console.log('주소 변환 실패');
                }
            });
        };
    </script>
    
</div>

<!-- 댓글 -->
<div class="container mt-4">
    <h3>이곳은 어떤가요?✈</h3>
    <form id="comment-form" method="post" action="/Comments/commentsAction.jsp">
	    <input type="hidden" name="tripNum" value="<%=rs.getString("tripNum")%>">
	    <div class="form-group">
	        <label for="comment">리뷰 작성:</label>
	        <textarea class="form-control" id="comments" name="comments" rows="3"></textarea>
	    </div>
	    <input type="submit" class="btn btn-outline-light" id="commentButton" style="background-color: #5bc0de;" value="작성">
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
	
	    String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
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
			String commentNum = rs.getString("commentNum");
			String comments = rs.getString("comments");
	        String tripNum2 = rs.getString("tripNum");
	        String createdAt = rs.getString("createdAt");
%>     
	<tbody id="commentTable">
		<td><%=rs.getString("userName")%></td>
		<td class="comment" id="comment" data-commentnum="<%= commentNum %>"><%= comments %></td>

		<td><%=createdAt%></td>
		<td style="text-align: right;">
<%
	if (userNum != null) {
   	 	String commentUserNum = rs.getString("userNum");
    	if (userNum.equals(commentUserNum)) { // 본인 댓글만 삭제 가능
%>
		<button type="button" class="btn btn-outline-light" style="background-color: #5bc0de;" onclick="updateOnclick('<%= commentNum %>', '<%= rs.getString("tripNum") %>')">수정</button>
		<%-- <a href="/Comments/updateCommentsAction.jsp?commentNum=<%=rs.getString("commentNum")%>&tripNum=<%=rs.getString("tripNum")%>" class="btn btn-outline-light" style="background-color: #5bc0de;">수정</a> --%>
		<button type="button" onclick="location.href='/Comments/deleteCommentsAction.jsp?commentNum=<%=rs.getString("commentNum")%>&tripNum=<%=rs.getString("tripNum")%>'" class="btn btn-outline-light" style="background-color: #5bc0de;">삭제</button>
<%		
        }else if(userName.equals("관리자")){%>
    	<button type="button" onclick="location.href='/Comments/deleteCommentsAction.jsp?commentNum=<%=rs.getString("commentNum")%>&tripNum=<%=rs.getString("tripNum")%>'" class="btn btn-outline-light" style="background-color: #5bc0de;">삭제</button>
<%		}
	}
%>
	</td>
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

<script type="text/javascript">
    function updateOnclick(commentNum, tripNum) {
        var commentElement = document.querySelector('.comment[data-commentnum="' + commentNum + '"]');
        var textareaElement = document.getElementById("comments");
        var form = document.getElementById("comment-form");
        var button = document.getElementById("commentButton");
        
        /* var update = $('tbody#commentTable td#comment').text();
        
        alert(update); */
        
        var commentsValue = commentElement.textContent;
        textareaElement.value = commentsValue;
        
        button.value = "수정";
        
        // 수정 버튼의 클릭 
        button.onclick = function() {
            var newComment = textareaElement.value;
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/updateCommentAction.jsp", true);  // 수정 액션 URL로 변경
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    if (xhr.responseText === "success") { //성공시
                        commentElement.textContent = newComment;
                        button.value = "작성"; //value값 다시 작성으로
                        /* update = update+"(수정됨)"; */
                        button.onclick = function() {
                            updateOnclick(commentNum, tripNum);
                        };
                        form.action = "/Comments/commentsAction.jsp";  // 작성 액션으로 바꿈
                    }
                }
            };
            var params = "commentNum=" + commentNum + "&tripNum=" + tripNum + "&newComment=" + encodeURIComponent(newComment);//총값
            xhr.send(params);
        };
        
        // "작성"
        form.action = "/Comments/updateCommentsAction.jsp?commentNum=" + commentNum + "&tripNum=" + tripNum;
    }
</script>
</body>
</html>