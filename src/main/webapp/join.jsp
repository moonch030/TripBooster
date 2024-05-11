<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="resources/layout/head.jsp"%>
</head>
<script>
    var idck = 0;
    function validateId(id) {
        var idReg = /^[A-Za-z0-9]{5,10}$/; // 영문자와 숫자로만
        return idReg.test(id);
    }

    function openIdCheckPopup() {
        var id = document.getElementById('id');
        if (id.value === '' || id.value === null) {
            id.focus();
            alert('아이디를 입력해주세요✈');
        } else {
            if (!validateId(id.value)) {
                id.focus();
                alert('아이디는 영문자, 숫자 5~10자리 입력해주세요✈');
                return false;
            }
            idck = 1;
            window.open('User/idValCheck.jsp?userId=' + id.value, '중복 체크', 'width=500,height=400');
        }
    }

    function joinformCheck() {
        var id = document.getElementById('id');
        var pw = document.getElementById('pw');
        var repwd = document.getElementById('repwd');
        var name = document.getElementById('name');
        var mobile = document.getElementById('mobile');

        var idReg = /^[A-Za-z0-9]{5,10}$/; // 영문자와 숫자로만, 5~10자리
        var pwReg = /^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[@#$%^&+=!]).{5,12}$/; // 영문자와 숫자, 특수기호 5~12자리
        var nameReg = /^[가-힣]+$/; // 한글로만

        if (id.value === '') {
            alert('아이디를 입력해주세요✈');
            return false;
        }

        if (!idReg.test(id.value)) {
            alert('아이디는 영문자와 숫자로만 입력해주세요✈');
            return false;
        }

        if (idck === 0) {
            alert('아이디 중복 체크를 해주세요✈');
            return false;
        }

        if (pw.value === '') {
            alert('비밀번호를 입력해주세요✈');
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

        if (name.value === '') {
            alert('이름을 입력해주세요✈');
            return false;
        }

        if (!nameReg.test(name.value)) {
            alert('이름은 한글로만 입력해주세요✈');
            return false;
        }

        if (mobile.value === '') {
            alert('전화번호를 입력해주세요✈');
            return false;
        }

        document.joinForm.submit();
    }

    const autoHyphen = (target) => {
        target.value = target.value
            .replace(/[^0-9]/g, '')
            .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
    }
</script>

<%@ include file="/resources/layout/nav.jsp"%>
<body class="text-center">
    <form action="/User/joinAction.jsp" name="joinForm" method="post">
       <main class="form-signin w-100 m-auto">
      <h1 class="h3 mb-3 fw-normal">회원가입</h1>
        <div class="form-floating">
            <p>아이디 <input type="text" class="form-control" autocomplete="off" id="id" name="userId" placeholder="영문+숫자"> <br>
            <input type="button" class="btn btn-dark" value="중복체크" onclick="openIdCheckPopup();"></p>
            <p>비밀번호 <input type="password" class="form-control" id="pw" name="userPw" placeholder="영문+숫자+특수문자"></p>
            <p>비밀번호 확인 <input type="password"  class="form-control"  id="repwd" name="userPwChk"></p>
            <p>이름 <input type="text" class="form-control" id="name" name="userName"></p>
            <p>전화번호 <input type="text" class="form-control" id="mobile" oninput="autoHyphen(this)" name="userTel" placeholder="000-0000-0000" maxlength="13"></p>
            <p>
                <input type="button" class="btn btn-dark" value="가입하기" class="button special" onclick="joinformCheck();">
            </p>
        </div>
    </form>
</body>
<%@ include file="/resources/layout/footer.jsp"%>
</html>
