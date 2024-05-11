<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/Search.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/Dropdown.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<%@ include file="/resources/layout/head.jsp"%>
<title>검색 결과</title>
</head>

<body>
	<% 
    request.setCharacterEncoding("UTF8");
    response.setCharacterEncoding("UTF-8");
    String keyword = request.getParameter("keyword");
    /* keyword = new String(keyword.getBytes("ISO-8859-1"), "UTF-8"); // 디코딩 */

    String userNum = (String) session.getAttribute("userNumSession");
    String userName = (String) session.getAttribute("userNameSession");
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
        String user = "root";
        String password = "abcd1234";
        
        Connection con = DriverManager.getConnection(url, user, password);
        con.setAutoCommit(false);
        
        //"서울시 용산구" 키워드에서 "용산구"를 입력하면 아무것도 안 나옴 그래서 for문 추가
        
        String[] keywords = keyword.split(" "); // 키워드를 공백으로 분리(띄어쓰기하면 다음검색어를 별도로 검색)

        String sql = "SELECT t.*, COUNT(ul.likeNum) AS likeCount" +
                     " FROM triptbl t" +
                     " LEFT JOIN userLiketbl ul ON t.tripNum = ul.tripNum" +
                     " WHERE ";
        for (int i = 0; i < keywords.length; i++) {//keyword입력하면 keywords배열로(띄어쓰기구분) 입력돼서 길이만큼 sql문(띠어쓰기 다음 단어 검색)
            if (i > 0) {
                sql += " AND "; // AND 연산자로 모든 키워드 조건을 만족 레코드 검색
            }
            sql += "t.tripCode LIKE ? OR t.tripName LIKE ? OR t.tripContent LIKE ?";
        }

        sql += " GROUP BY t.tripNum" +
               " ORDER BY likeCount DESC"; // 추가 정렬 조건

        PreparedStatement pstmt = con.prepareStatement(sql);

        // 각 키워드를 바인딩
        for (int i = 0; i < keywords.length; i++) {
            String keyword2 = "%" + keywords[i] + "%";
            pstmt.setString(i * 3 + 1, keyword2); // tripCode 
            pstmt.setString(i * 3 + 2, keyword2); // tripName 
            pstmt.setString(i * 3 + 3, keyword2); // tripContent 
        }
        
        ResultSet rs = pstmt.executeQuery();
        
        if (userName == null) {
            %>
        	<jsp:include page="/resources/layout/nav.jsp"></jsp:include>
        	<%
		}
			if (userName != null) {
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
<div class="album py-5 bg-light">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <div class="text-left">
    		<br><h1 class="display-5"><b><%=keyword%> ✈</b></h1>
    		<br><h4>검색 결과입니다.</h4></a>
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