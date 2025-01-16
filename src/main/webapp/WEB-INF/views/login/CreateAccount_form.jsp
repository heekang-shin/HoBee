<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">

  <title>회원가입</title>
  <link rel="stylesheet" href="resources/css/CreateAccount_form.css">
  <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    integrity="sha384-eVWmY1Vz02L/uIBq0e4F5rj2Xg3TUZ3I7sAxvnN4+7xj2pkF5+pw0PPxWtrGvFnZ"
    crossorigin="anonymous">

  <script>
    let isIdAvailable = false; // 아이디 중복 체크 여부 플래그

    // 중복 체크 함수
    function chk() {
        let id = document.getElementById('id').value.trim();
        let checkResultLabel = document.getElementById('checkResult');

        if (!id) {
            // 아이디 입력 유효성 검사
            checkResultLabel.innerText = "아이디를 입력해주세요.";
            checkResultLabel.style.color = "red"; // 경고 메시지 스타일
            return;
        }

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "check_duplicate.do", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                let result = xhr.responseText.trim();
                console.log("중복 체크 응답:", result); // 디버깅용 서버 응답 출력
                if (result === "fail") {
                    checkResultLabel.innerText = "이미 사용 중인 아이디입니다.";
                    checkResultLabel.style.color = "red";
                    isIdAvailable = false;
                } else if (result === "true") {
                    checkResultLabel.innerText = "사용 가능한 아이디입니다.";
                    checkResultLabel.style.color = "green";
                    isIdAvailable = true;
                } else {
                    checkResultLabel.innerText = "알 수 없는 오류가 발생했습니다.";
                    checkResultLabel.style.color = "red";
                }
            }
        };

        xhr.send("id=" + encodeURIComponent(id)); // 서버로 요청 데이터 전송
    }

    
    // 입력값 검증 함수
    function validateForm() {
        let user_name = document.getElementById("user_name");
        let id = document.getElementById("id");
        let user_pwd = document.getElementById("user_pwd");
        let confirmPassword = document.getElementById("confirmPassword");
        let user_email = document.getElementById("user_email");
        let birth_date = document.getElementById("birth_date");
        let phone = document.getElementById('phone');

        // 이름 검증
        if (!user_name.value.trim()) {
            user_name.setCustomValidity("이름을 입력해주세요.");
        } else {
            user_name.setCustomValidity("");
        }
        
        // 휴대폰 번호 검증
        let phoneValue = phone.value.trim();
        let phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;
        if (!phoneValue) {
            phone.setCustomValidity("휴대폰 번호를 입력해주세요.");
        } else if (!phoneRegex.test(phoneValue)) {
            phone.setCustomValidity("올바른 휴대폰 번호 형식을 입력해주세요. 예: 010-1234-5678");
        } else {
            phone.setCustomValidity("");
        }

        // 아이디 검증
        if (!id.value.trim()) {
            id.setCustomValidity("아이디를 입력해주세요.");
        } else if (!isIdAvailable) {
            id.setCustomValidity("아이디 중복 체크를 진행해주세요.");
        } else {
            id.setCustomValidity("");
        }

        // 비밀번호 검증
        let passwordRegex = /^(?=.*[0-9])(?=.*[#?!@$%^&*-]).{8,}$/;
        if (!user_pwd.value.trim() || !passwordRegex.test(user_pwd.value)) {
            user_pwd.setCustomValidity("비밀번호는 최소 8자 이상이어야 하며, 숫자와 특수문자를 각각 1개 이상 포함해야 합니다.");
        } else {
            user_pwd.setCustomValidity("");
        }

        // 비밀번호 확인 검증
        if (user_pwd.value !== confirmPassword.value) {
            confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다.");
        } else {
            confirmPassword.setCustomValidity("");
        }

        // 이메일 검증
        let emailRegex = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!user_email.value.trim() || !emailRegex.test(user_email.value)) {
            user_email.setCustomValidity("유효한 이메일 주소를 입력해주세요.");
        } else {
            user_email.setCustomValidity("");
        }

        // 생년월일 검증
        if (!birth_date.value.trim()) {
            birth_date.setCustomValidity("생년월일을 입력해주세요.");
        } else {
            birth_date.setCustomValidity("");
        }

        // 모든 입력 필드 검증 결과 반환
        return document.getElementById("signupForm").reportValidity();
    }

    // 회원가입 처리 함수
    function submitForm() {
        if (!validateForm()) {
            return;
        }

        let form = document.getElementById("signupForm");
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "create_account.do", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                let result = xhr.responseText.trim();
                if (result === "success") {
                    alert("회원가입이 성공적으로 완료되었습니다.");
                    window.location.href = "createAccount.do"; // 회원가입 성공 시 리다이렉션
                } else if (result === "error") {
                    alert("회원가입 중 오류가 발생했습니다.");
                }
            }
        };

        let formData = new FormData(form);
        let params = new URLSearchParams(formData).toString();
        xhr.send(params); // 폼 데이터 전송
    }
  </script>
</head>
<body>

<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>

  <!-- 회원가입 제목 -->
  <div id="signupHeader">
    <h1 id="signupTitle">회원가입</h1>
  </div>

  <!-- 회원가입 폼 -->
  <div id="signupContainer">
    <form id="signupForm" name="signupForm" novalidate>
      <div class="black-line"></div>
      <div class="form-group">
        <label for="user_name">이름 *</label>
        <input id="user_name" type="text" name="user_name" required>
      </div>
      <div class="form-group input-with-button">
        <label for="id">아이디 *</label>
        <input id="id" type="text" name="id" placeholder="아이디 입력" required>
        <button type="button" class="btn-inline" onclick="chk();">중복확인</button>
      </div>
      <div id="checkResult"></div>
      <div class="form-group">
        <label for="phone">휴대폰 번호 *</label>
        <input id="phone" type="tel" name="phone" placeholder="010-1234-5678" required>
      </div>
      <div class="form-group">
        <label for="user_pwd">비밀번호 *</label>
        <input id="user_pwd" type="password" name="user_pwd" placeholder="문자, 숫자 포함 8자 이상" required>
      </div>
      <div class="form-group">
        <label for="confirmPassword">비밀번호 확인 *</label>
        <input id="confirmPassword" type="password" name="confirmPassword" required>
      </div>
      <div class="form-group">
        <label for="user_email">이메일 *</label>
        <input id="user_email" type="email" name="user_email" placeholder="이메일 입력" required>
      </div>
      <div class="form-group">
        <label for="birth_date">생년월일 *</label>
        <input id="birth_date" type="date" name="birth_date" required>
      </div>
      <div id="signupFooter">
        <button type="button" onclick="submitForm()">가입하기</button>
      </div>
    </form>
  </div>
  
  <jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
  
</body>
</html>
