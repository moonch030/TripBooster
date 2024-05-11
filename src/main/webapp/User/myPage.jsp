<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>TripBooster</title>
<%@ include file="/resources/layout/head.jsp"%>
</head>
<script>
	function updateformCheck() {
        var pw = document.getElementById('userPw');
        var repwd = document.getElementById('userrePw');
        var name = document.getElementById('userName');
        var mobile = document.getElementById('userTel');

        var pwReg = /^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[@#$%^&+=!]).{5,12}$/; // 영문자와 숫자, 특수기호 5~12자리
        var nameReg = /^[가-힣]+$/; // 한글로만

        if(name.value == "") {
			alert("이름을 입력하세요!");
			name.focus();
    		return false;
    	}
        
        if (!nameReg.test(name.value)) {
            alert('이름은 한글로만 입력해주세요✈');
            return false;
        }

        if (!pwReg.test(pw.value)) {
            alert('비밀번호는 영문자와 숫자, 특수기호 \n 5~12자리로 입력해주세요✈');
            return false;
        }

        if (pw.value !== repwd.value) {
            alert('비밀번호와 비밀번호 확인이 일치하지 않습니다✈');
            return false;
        }

        document.mypageForm.submit();
    }
	 const autoHyphen = (target) => {
	        target.value = target.value
	            .replace(/[^0-9]/g, '')
	            .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
</script>
<body class="text-center">
<%@ include file="/resources/layout/userNav.jsp"%>
<form action="updateUserInfoAction.jsp" name="mypageForm" method="post">
<main class="form-signin w-100 m-auto">
	<p><h1 class="h3 mb-3 fw-normal"><strong>내 정보</strong></h1>
	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			request.setCharacterEncoding("UTF-8");
			
			String url = "jdbc:mysql://localhost:3306/tripbooster?useSSL=false&verifyServerCertificate=false";
			String user = "root"; // 데이터베이스 사용자 이름
		   	String password = "abcd1234"; // 데이터베이스 비밀번호
		   	
			Connection con = DriverManager.getConnection(url, user, password);
			con.setAutoCommit(false);
			
			String sql = "SELECT userName, userTel FROM userTbl WHERE userNum = ?";
			
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userNum);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
	%>
			<div class="form-floating">
				<input type="text" class="form-control" name="userName" value="<%=rs.getString("userName") %>" id="userName" autocomplete="off" placeholder="name" >
			</div>
			<div class="form-floating">
		       	<input type="text" class="form-control" name="userTel" id="userTel" value="<%=rs.getString("userTel") %>" autocomplete="off" oninput="autoHyphen(this)" placeholder="000-0000-0000" maxlength="13">
		   	</div>
   	<%
			}
			
			con.commit();
			rs.close();
			pstmt.close();
			con.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	%>
		<div class="form-floating">
	        <input type="password" class="form-control" name="userPw" id="userPw" placeholder="Password">
	        <label for="floatingPassword">Password</label>
		</div>
		<div class="form-floating">
			<input type="password" class="form-control" name="userrePw" id="userrePw" placeholder="rePassword">
			<label for="floatingrePassword">rePassword</label>
		</div>
		<div class="my-2">
			<input type="button" value="회원정보 수정" class="btn btn-dark" onclick="updateformCheck();">
			<input type="button" value="회원 탈퇴" class="btn btn-dark" onclick="location.href='deleteUser.jsp'">
		</div>
	</form>
</main>
<%@ include file="/resources/layout/footer.jsp"%>
</body>
</html>