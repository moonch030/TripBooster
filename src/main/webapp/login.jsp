<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/resources/layout/head.jsp"%>
</head>
<script>
	function loginFormCheck() {
		var id = document.getElementById("id");
    	var pw = document.getElementById("pw");
    	
		if (id.value == "") {
	    	alert("아이디를 입력해주세요✈");
	    	id.focus();
	    	return false;
	  	}
		if (pw.value == "") {
			alert("비밀번호를 입력해주세요✈");
			pw.focus();
			return false;
	  	}
		document.loginForm.submit();
	}
</script>
<body class="text-center">
<%@ include file="/resources/layout/nav.jsp"%>
<form action="User/loginAction.jsp" name="loginForm" method="post">
  <main class="form-signin w-100 m-auto">
      <p><h1 class="h3 mb-3 fw-normal">로그인</h1>
      <div class="form-floating">
        <input type="text" class="form-control" name="userId" id="id" autocomplete="off" placeholder="ID">
        <label for="floatingInput">ID</label>
      </div>
      <div class="form-floating">
        <input type="password" class="form-control" name="userPw" id="pw" placeholder="Password">
        <label for="floatingPassword">Password</label>
      </div>
      <div class="my-2">
        <input type="button" value="확인" class="btn btn-dark" onclick="loginFormCheck();">
        <input type="button" value="회원가입" class="btn btn-dark" onclick = "location.href='join.jsp'">
      </div>
    </form>
  </main>
  <%@ include file="/resources/layout/footer.jsp"%>
</body>
</html>
