<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <!-- 필요한 스크립트와 스타일 -->
    <script src="/team/resources/js/httpRequest.js"></script>
    <meta charset="UTF-8">
    <title>아이디|비밀번호 찾기</title>
    <link rel="stylesheet" href="resources/css/main.css">
    <link rel="stylesheet" href="resources/css/find_form.css">
    <link rel="stylesheet" href="resources/css/modal.css">
    <script>
    let res = null; // 서버에서 받은 인증 코드 저장 변수

    // 아이디 찾기 모달을 여는 함수
    function openModalForId() {
        let nameInput = document.getElementById('find_name');
        let emailInput = document.getElementById('find_email');
        let nameValue = nameInput.value.trim();
        let emailValue = emailInput.value.trim();

        let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!nameValue) {
            nameInput.setCustomValidity("이름을 입력하세요.");
            nameInput.reportValidity();
            return;
        } else {
            nameInput.setCustomValidity("");
        }

        if (!emailValue) {
            emailInput.setCustomValidity("이메일을 입력하세요.");
            emailInput.reportValidity();
            return;
        } else if (!emailRegex.test(emailValue)) {
            emailInput.setCustomValidity("유효하지 않은 이메일 형식입니다.");
            emailInput.reportValidity();
            return;
        } else {
            emailInput.setCustomValidity("");
        }

        // 이메일 인증 요청
        mailCheck(emailValue);

        // 모달 창 열기 및 이메일 설정
        document.getElementById('auth_email').value = emailValue;
        document.getElementById('emailModal').style.display = 'flex';
    }

    // 인증 코드를 이메일로 요청하는 함수
    function mailCheck(userEmail) {
        let url = "mailCheck.do";
        let param = "email=" + encodeURIComponent(userEmail);

        sendRequest(url, param, resultMail, "POST");
    }

    // 서버에서 인증 코드를 받은 후 처리
    function resultMail(responseText) {
        alert("인증코드가 이메일로 전송됐습니다.");
        let checkInput = document.getElementById("auth_code");
        checkInput.disabled = false;
        res = responseText; // 서버에서 받은 인증번호 저장
    }

    // 인증 코드 확인 함수
    function change_input() {
        let checkInput = document.getElementById("auth_code"); // 인증 코드 입력 필드
        let mailCheckWarn = document.getElementById("mail_check_warn"); // 결과 메시지 표시 영역
        let nameInput = document.getElementById("find_name").value.trim(); // 이름 입력 값
        let emailInput = document.getElementById("find_email").value.trim(); // 이메일 입력 값

        if (checkInput.value === res) {
            mailCheckWarn.innerHTML = "인증 성공";
            //조회된 id 호출 함수
            findUserId(nameInput, emailInput);
        } else {
            mailCheckWarn.innerHTML = "인증 코드 불일치";
        }
    }

    function openModalForPassword() {
        let idInput = document.getElementById('find_id');
        let emailInput = document.getElementById('find_email_pw');
        let idValue = idInput.value.trim();
        let emailValue = emailInput.value.trim();

        let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!idValue) {
            idInput.setCustomValidity("아이디를 입력하세요.");
            idInput.reportValidity();
            return;
        } else {
            idInput.setCustomValidity("");
        }

        if (!emailValue) {
            emailInput.setCustomValidity("이메일을 입력하세요.");
            emailInput.reportValidity();
            return;
        } else if (!emailRegex.test(emailValue)) {
            emailInput.setCustomValidity("유효하지 않은 이메일 형식입니다.");
            emailInput.reportValidity();
            return;
        } else {
            emailInput.setCustomValidity("");
        }

        // 이메일 인증 요청
        mailCheckForPassword(emailValue);

        // 모달 창 열기 및 이메일 설정
        document.getElementById('auth_email_pw').value = emailValue;
        document.getElementById('emailModalPw').style.display = 'flex';
    }


    function mailCheckForPassword(userEmail) {
        let url = "mailCheckPassword.do";
        let param = "email=" + encodeURIComponent(userEmail);

        sendRequest(url, param, resultMailPw, "POST");
    }

    // 서버에서 비밀번호 인증 코드를 받은 후 처리
    function resultMailPw(responseText) {
        alert("인증코드가 이메일로 전송됐습니다.");
        let checkInput = document.getElementById("auth_code_pw");
        checkInput.disabled = false;
        res = responseText; // 서버에서 받은 인증번호 저장
    }

    function verifyPasswordAuthCode() {
        let checkInput = document.getElementById("auth_code_pw");
        let mailCheckWarn = document.getElementById("mail_check_warn_pw");
        let idInput = document.getElementById("find_id").value.trim();
        let emailInput = document.getElementById("find_email_pw").value.trim();

        if (checkInput.value === res) {
            mailCheckWarn.innerHTML = "인증 성공";
            findPassword(idInput, emailInput);
        } else {
            mailCheckWarn.innerHTML = "인증 코드 불일치";
        }
    }
    
    function findPassword(id, email) {
        let url = "findPassword.do";
        let param = "id=" + encodeURIComponent(id) + "&email=" + encodeURIComponent(email);

        sendRequest(url, param, pwResultText, "POST");
    }

    function pwResultText(responseText) {
        let pwResultText = document.getElementById("pwResultText");

        if (responseText.startsWith("success:")) {
            let password = responseText.split(":")[1];
            pwResultText.innerText = "조회된 비밀번호: " + password;
        } else if (responseText === "fail") {
            pwResultText.innerText = "조회된 비밀번호가 없습니다.";
        }

        document.getElementById('pwResultModal').style.display = 'flex';
    }


    // 공통 AJAX 요청 함수
    function sendRequest(url, param, callback, method) {
        let xhr = new XMLHttpRequest();
        xhr.open(method, url, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                callback(xhr.responseText);
            }
        };

        xhr.send(param);
    }

    function findUserId(name, email) {
        let url = "findUserId.do";
        let param = "name=" + encodeURIComponent(name) + "&email=" + encodeURIComponent(email);

        sendRequest(url, param, idResultText, "POST");
    }

    function idResultText(responseText) {
        let idResultText = document.getElementById("idResultText");

        if (responseText.startsWith("success:")) {
            let id = responseText.split(":")[1];
            idResultText.innerText = "조회된 아이디: " + id;
        } else if (responseText === "fail") {
            idResultText.innerText = "조회된 ID가 없습니다.";
        }

        document.getElementById('idResultModal').style.display = 'flex';
    }

    // 모달 창 닫기 함수들
    function closeIdResultModal() {
        document.getElementById('idResultModal').style.display = 'none';
    }

    function closePasswordModal() {
        document.getElementById('emailModalPw').style.display = 'none';
        document.getElementById('auth_code_pw').value = '';
        document.getElementById('mail_check_warn_pw').innerHTML = '';
    }

    function closePwResultModal() {
        document.getElementById('pwResultModal').style.display = 'none';
    }

    function closeModal() {
        document.getElementById('emailModal').style.display = 'none';
        document.getElementById('auth_code').value = '';
        document.getElementById('mail_check_warn').innerHTML = '';
    }
</script>

</head>
<body>
   <jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
    <!-- 아이디 찾기 섹션 -->
    <div class="find">
        <h2>아이디 찾기</h2>
        <div class="form-group">
            <label for="find_name">이름</label>
            <input type="text" id="find_name" name="find_name" placeholder="이름을 입력하세요">
        </div>
        <div class="form-group">
            <label for="find_email">이메일</label>
            <input type="email" id="find_email" name="find_email" placeholder="Email을 입력하세요">
        </div>
        <button type="button" onclick="openModalForId()">아이디 찾기</button>
    </div>

    <!-- 비밀번호 찾기 섹션 -->
    <div class="find">
        <h2>비밀번호 찾기</h2>
        <div class="form-group">
            <label for="find_id">아이디</label>
            <input type="text" id="find_id" name="find_id" placeholder="아이디를 입력하세요">
        </div>
        <div class="form-group">
            <label for="find_email_pw">이메일</label>
            <input type="email" id="find_email_pw" name="find_email_pw" placeholder="Email을 입력하세요">
        </div>
        <button type="button" onclick="openModalForPassword()">비밀번호 찾기</button>
    </div>

    <!-- 이메일 인증 모달 -->
    <div id="emailModal" class="modal" style="display: none;">
        <div class="modal-content">
            <h2>이메일 인증</h2>
            <form id="emailAuthForm">
                <div class="form-group">
                    <label for="auth_email">이메일</label>
                    <input type="email" id="auth_email" name="auth_email" readonly>
                </div>
                <div class="form-group">
                    <label for="auth_code">인증 코드</label>
                    <input type="text" id="auth_code" name="auth_code" placeholder="인증 코드를 입력하세요." required>
                </div>
                <div class="form-group">
                    <button type="button" onclick="change_input()">인증 코드 확인</button>
                </div>
                <div id="mail_check_warn"></div>
                <button type="button" onclick="closeModal()">닫기</button>
            </form>
        </div>
    </div>

    <!-- 이메일 인증 모달 (비밀번호 찾기용) -->
    <div id="emailModalPw" class="modal" style="display: none;">
        <div class="modal-content">
            <h2>이메일 인증</h2>
            <form id="emailAuthFormPw">
                <div class="form-group">
                    <label for="auth_email_pw">이메일</label>
                    <input type="email" id="auth_email_pw" name="auth_email_pw" readonly>
                </div>
                <div class="form-group">
                    <label for="auth_code_pw">인증 코드</label>
                    <input type="text" id="auth_code_pw" name="auth_code_pw" placeholder="인증 코드를 입력하세요." required>
                </div>
                <div class="form-group">
                    <button type="button" onclick="verifyPasswordAuthCode()">인증 코드 확인</button>
                </div>
                <div id="mail_check_warn_pw"></div>
                <button type="button" onclick="closePasswordModal()">닫기</button>
            </form>
        </div>
    </div>

    <!-- 새로운 모달 창 -->
    <div id="idResultModal" class="modal" style="display: none;">
        <div class="modal-content">
            <h2>확인된 아이디</h2>
            <p id="idResultText">결과 조회 테스트 중</p>
            <button type="button" onclick="closeIdResultModal()">닫기</button>
        </div>
    </div>

    <!-- 비밀번호 찾기 결과 모달 -->
    <div id="pwResultModal" class="modal" style="display: none;">
        <div class="modal-content">
            <h2>확인된 비밀번호</h2>
            <p id="pwResultText">결과 조회 테스트 중</p>
            <button type="button" onclick="closePwResultModal()">닫기</button>
        </div>
    </div>
    
    	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
	
		<!--top버튼 시작-->
		<a id="toTop" href="#">TOP</a>
		<!--top버튼 끝-->
    
</body>
</html>
