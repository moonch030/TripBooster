<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/resources/layout/head.jsp"%>
</head>
<script>
	function deleteformCheck() {
		var id = document.getElementById("userId");
    	var pw = document.getElementById("userPw");
    	
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
		document.deleteForm.submit();
	}
</script>
<body class="text-center">
<%@ include file="/resources/layout/userNav.jsp"%>
<form action="deleteUserAction.jsp" name="deleteForm" method="post">
  <main class="form-signin w-100 m-auto">
      <p><h1 class="h3 mb-3 fw-normal">회원 탈퇴</h1>
      <div class="form-floating">
        <input type="text" class="form-control" name="userId" id="userId" autocomplete="off" placeholder="ID">
        <label for="floatingInput">ID</label>
      </div>
      <div class="form-floating">
        <input type="password" class="form-control" name="userPw" id="userPw" placeholder="Password">
        <label for="floatingPassword">Password</label>
      </div>
      <div class="my-2">
        <input type="button" value="탈퇴" class="btn btn-dark" onclick = "deleteformCheck();">
      </div>
    </form>
  </main>
  <%@ include file="/resources/layout/footer.jsp"%>
</body>
</html>
