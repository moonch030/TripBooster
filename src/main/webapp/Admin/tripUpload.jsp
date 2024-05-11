<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/resources/layout/head.jsp"%>
</head>
<body>
<jsp:include page="/resources/layout/adminNav.jsp"></jsp:include>

<div class="container mt-4">
    <h3>이곳은 어딘가요?✈</h3><br>
    <form action="tripUploadAction.jsp" method="POST" enctype="multipart/form-data">
    	<p>종류 : <select name="tripSort">
    				<option value="tour"> tour </option>
    				<option value="rest"> rest </option>
    			</select>
    	<p>지역 : <select name="tripCode">
    				<option value="서울"> 서울 </option>
    				<option value="경기"> 경기 </option>
    				<option value="인천"> 인천 </option>
    				<option value="강원"> 강원 </option>
    				<option value="대전"> 대전 </option>
    				<option value="부산"> 부산 </option>
    				<option value="울산"> 울산 </option>
    				<option value="대구"> 대구 </option>
    				<option value="광주"> 광주 </option>
    				<option value="충북"> 충북 </option>
    				<option value="충남"> 충남 </option>
    				<option value="경북"> 경북 </option>
    				<option value="경남"> 경남 </option>
    				<option value="전북"> 전북 </option>
    				<option value="전남"> 전남 </option>
    				<option value="제주도"> 제주도 </option>
    			</select>
    	<p>여행지 이름 : <input type="text" name="tripName"><br>
    	<p>위치	   : <input type="text" name="tripLoca">
    	<p>수용인원	   : <input type="text" name="tripPerson">
    	<p>주차가능 수 : <input type="text" name="tripParking">
    	<p>전화번호	   : <input type="text" name="tripTel" oninput="autoHyphen2(this)">
	    <p>이미지	   : <input type="file" name="tripImg">
	    	<div class="form-group">
	      	  <label for="comment">여행지 설명:</label>
	       	 <textarea class="form-control" id="tripContent" name="tripContent" rows="3"></textarea>
	    </div>
	    <input type="submit" class="btn btn-outline-light" style="background-color: #5bc0de;" value ="추가하기">
	    <input type="reset" class="btn btn-outline-light" style="background-color: #5bc0de;" value ="다시쓰기">
	</form>
</body>
<%@ include file="/resources/layout/footer.jsp"%>
</html>