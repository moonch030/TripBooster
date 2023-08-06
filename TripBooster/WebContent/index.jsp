<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>TripBooster</title>
<%@ include file="/resources/layout/head.jsp"%>
</head>
<style>
  /* 자동차 아이콘에 대한 애니메이션 */
  @keyframes drivingIcon {
    0% { transform: translateX(-5000%); }
    100% { transform: translateX(5000%); }
}
</style>
<body>
		<%
		request.setCharacterEncoding("UTF8");
		response.setCharacterEncoding("UTF-8");

		String uId = (String) session.getAttribute("userIdSession");
		String uName = (String) session.getAttribute("userNameSession");

		if (uId == null) {
		%>
		<nav class="navbar navbar-expand-md navbar-dark bg-info">
			<div class="container">
				<a class="navbar-brand" href="index.jsp"><strong>TripBooster</strong></a>
					<form class="d-flex mx-auto">
   						 <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" style="width: 500px;">
   		 					 <button class="btn btn-outline-light" type="submit">
    						  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 20">
     		  				  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
    		 				  </svg>
  		  				     </button>
    				</form>	
				<div class="ml-auto">
					<a href="login.jsp" class="btn btn-outline-light" type="submit">로그인</a>
				</div>
				<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
				aria-controls="navbarCollapse" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
				</button>
			</div>
		</nav>
		<%
		}

		if (uId != null) {
		%>
			<%
				if (uId.equals("admin")) {
			%>
					<jsp:include page="resources/layout/adminNav.jsp"></jsp:include>
			<%
				} else {
			%>
					<jsp:include page="resources/layout/userNav.jsp"></jsp:include>
			<%
				}
			}
		%>
		</nav>
	<div class="container">
		<header class="text-center mt-5">
			<h1 class="display-4" id="changeText"
				style="font-weight: 700; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">진행시켜</h1>
			<i class="fas fa-car-side"
				style="animation: drivingIcon 10s linear infinite;"></i>
		</header>
	</div>
	<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<div id="map" style="height: 500px;"></div>
	<script>
		// Initialize the map
		var map = L.map('map').setView([ 35.9078, 127.7669 ], 7); // Center the map on South Korea
		// Add the map tile layer with CartoDB.Voyager style
		L
				.tileLayer(
						'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
						{
							attribution : '&copy; <a href="https://carto.com/">CartoDB</a> contributors'
						}).addTo(map);

		// Array of text to be displayed
		var textArray = [ "신속하고", "빠르게", "진행시켜" ];

		// Function to change the text in the 'lead' class every 1 second
		function changeText() {
			var idx = 0;
			setInterval(
					function() {
						document.getElementById('changeText').innerText = textArray[idx];
						idx = (idx + 1) % textArray.length;
					}, 1000);
		}

		// Call the function to start text change
		changeText();
	</script>
	<%@ include file="resources/layout/footer.jsp"%>
</body>
</html>
