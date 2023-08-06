<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-md navbar-dark bg-info">
	<div class="container">
		<a class="navbar-brand" href="index.jsp">TripBooster</a>
		<%
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");

			String uId = (String) session.getAttribute("userIdSession");
			String uName = (String) session.getAttribute("userNameSession");
		%>
		<div class="ml-auto">
			<a href="/User/myPage.jsp"><strong><%=uName%></strong></a>님✈ &nbsp;&nbsp;
			<a href="#" class="btn btn-outline-light" type="submit">관리자</a>
			<a href="/logout.jsp" class="btn btn-outline-light" type="submit">로그아웃</a>
		</div>
		<button class="navbar-toggler" type="button"
			data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
			aria-controls="navbarCollapse" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	</div>
</nav>
<div class="container">
</div>
</body>
</html>
