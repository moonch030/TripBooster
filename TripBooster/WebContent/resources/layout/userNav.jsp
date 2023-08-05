<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-md navbar-dark bg-info">
	<div class="container">
		<a class="navbar-brand" href="../index.jsp"><strong>TripBooster</strong></a>
		<form class="d-flex mx-auto">
   		 <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" style="width: 500px;">
   		  <button class="btn btn-outline-light" type="submit">
    		  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 20">
     		   <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
    		  </svg>
  		  </button>
    	</form>
    	<%
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");

			String uId = (String) session.getAttribute("userIdSession");
			String uName = (String) session.getAttribute("userNameSession");
		%>
		<a href="User/myPage.jsp"><strong><%=uName%></strong></a>님 떠나볼까요?✈ &nbsp;&nbsp;
		<div class="ml-auto">
			<a href="logout.jsp" class="btn btn-outline-light" type="submit">로그아웃</a>
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

