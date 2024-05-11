<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/resources/css/Search.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/Dropdown.css" rel="stylesheet" type="text/css">
<nav class="navbar navbar-expand-md navbar-dark bg-info">
	<div class="container d-flex align-items-center"">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp"><strong>TripBooster</strong></a>
		<ul class="navbar-nav navbar-dark">
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">
                    지역
                </a>
                <div class="dropdown-menu">
                	<a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=서울&tripSort=tour">서울</a>
                	<a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=경기&tripSort=tour">경기도</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=인천&tripSort=tour">인천</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=강원&tripSort=tour">강원도</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=대전&tripSort=tour">대전</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=부산&tripSort=tour">부산</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=울산&tripSort=tour">울산</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=대구&tripSort=tour">대구</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=광주&tripSort=tour">광주</a>
					<a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=충북&tripSort=tour">충청북도</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=충남&tripSort=tour">충청남도</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=경북&tripSort=tour">경상북도</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=경남&tripSort=tour">경상남도</a>
		          	<a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=전북&tripSort=tour">전라북도</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=전남&tripSort=tour">전라남도</a>
		            <a class="dropdown-item" href="/Trip/tripindex.jsp?tripCode=제주도&tripSort=tour">제주도</a>
                </div>
            </li>
            
		</ul>
		&nbsp;&nbsp;&nbsp;
		<form action="/Trip/SearchResults.jsp" method="get" name="keyword">
			<div class="container-2 d-flex align-items-center">
				<span class="icon"><i class="fa fa-search"></i></span>
				<input type="search" name="keyword" id="search" placeholder="Search" />
			</div>
		</form>
		<form class="d-flex mx-auto">
   						 
    				</form>	
		
    	<%
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");

			String userNum = (String) session.getAttribute("userNumSession");
			String userName = (String) session.getAttribute("userNameSession");
		%>
		
		
		<div class="ml-auto">
		<a href="/User/myPage.jsp"><strong><%=userName%></strong></a>님✈ &nbsp;&nbsp;
			<a href="/Admin/tripUpload.jsp" class="btn btn-outline-light" type="submit">정보추가</a>&nbsp;
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