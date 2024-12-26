<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="resources/css/main.css">
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
        const checkResultLabel = document.getElementById('checkResult');

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
        const username = document.getElementById("username");
        const id = document.getElementById("id");
        const userpwd = document.getElementById("userpwd");
        const confirmPassword = document.getElementById("confirmPassword");
        const useremail = document.getElementById("useremail");
        const birthdate = document.getElementById("birthdate");

        // 이름 검증
        if (!username.value.trim()) {
            username.setCustomValidity("이름을 입력해주세요.");
        } else {
            username.setCustomValidity("");
        }

        //휴대폰 번호 검증
        if(!phone.value.trim())
        // 아이디 검증
        if (!id.value.trim()) {
            id.setCustomValidity("아이디를 입력해주세요.");
        } else if (!isIdAvailable) {
            id.setCustomValidity("아이디 중복 체크를 진행해주세요.");
        } else {
            id.setCustomValidity("");
        }

        // 비밀번호 검증
        if (!userpwd.value.trim() || userpwd.value.length < 8) {
            userpwd.setCustomValidity("비밀번호는 8자 이상이어야 합니다.");
        } else {
            userpwd.setCustomValidity("");
        }

        // 비밀번호 확인 검증
        if (userpwd.value !== confirmPassword.value) {
            confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다.");
        } else {
            confirmPassword.setCustomValidity("");
        }

        // 이메일 검증
        if (!useremail.value.trim()) {
            useremail.setCustomValidity("이메일을 입력해주세요.");
        } else {
            useremail.setCustomValidity("");
        }

        // 생년월일 검증
        if (!birthdate.value.trim()) {
            birthdate.setCustomValidity("생년월일을 입력해주세요.");
        } else {
            birthdate.setCustomValidity("");
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

<!--헤더 시작-->
		<div id="header">
			<div id="header_inner">
				<h1 class="logo">
					<a href="main.do">Hobee</a>
				</h1>
	
				<!--검색창 시작-->
				<form>
					<div id="search_inner">
						
						<input type="search" placeholder="검색어를 입력해 주세요." name="search_text"
							onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}"/>
						 
						<img src="team/resources/images/search_icon.png" class="search-icon">
					</div>
				</form>
				<!--검색창 끝-->

				<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- snb 시작 -->
<ul class="snb">
    <li>
        <img src="/team/resources/images/registration_icon.png" alt="모임등록" />
        <a href="form.do">모임등록</a>
    </li>
    
    <li>
        <img src="/team/resources/images/shop_icon.png" alt="찜" />
        <a href="shop.do">찜목록</a>
    </li>

    <!-- 로로그인하지 않은 상태 -->
    <c:if test="${empty sessionScope.loggedInUser}">
        <li>
            <img src="/team/resources/images/join_icon.png" alt="회원가입" />
            <a href="CreateAccount_form.do">회원가입</a>
        </li>
        <li>
            <img src="/team/resources/images/login_form.png" alt="로그인" />
            <a href="login_form.do">로그인</a>
        </li>
    </c:if>

    <!-- 로그인한 상태 -->
    <c:if test="${not empty sessionScope.loggedInUser}">
        <li>
            <span>환영합니다, ${sessionScope.loggedInUser.username} 님!</span>
        </li>
        <li>
            <a href="logout.do">로그아웃</a>
        </li>
    </c:if>
</ul>
<!-- snb 끝 -->

			</div>
		</div>
		<!--헤더 끝-->
	

  <!-- 회원가입 제목 -->
  <div id="signupHeader">
    <h1 id="signupTitle">회원가입</h1>
  </div>

  <!-- 회원가입 폼 -->
  <div id="signupContainer">
    <form id="signupForm" name="signupForm" novalidate>
      <div class="black-line"></div>
      <div class="form-group">
        <label for="username">이름 *</label>
        <input id="username" type="text" name="username" required>
      </div>
      <div class="form-group">
  		<label for="phone">휴대폰 번호 *</label>
 		 <input id="phone" type="tel" name="phone" placeholder="010-1234-5678" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required>
	</div> 
      <div class="form-group input-with-button">
        <label for="id">아이디 *</label>
        <input id="id" type="text" name="id" placeholder="아이디 입력" required>
        <button type="button" class="btn-inline" onclick="chk();">중복확인</button>
      </div>
      <div id="checkResult" style="font-size: 14px; color: red; text-align: right;"></div>
      <div class="form-group">
        <label for="userpwd">비밀번호 *</label>
        <input id="userpwd" type="password" name="userpwd" placeholder="문자, 숫자 포함 8자 이상" required>
      </div>
      <div class="form-group">
        <label for="confirmPassword">비밀번호 확인 *</label>
        <input id="confirmPassword" type="password" name="confirmPassword" required>
      </div>
      <div class="form-group">
        <label for="useremail">이메일 *</label>
        <input id="useremail" type="email" name="useremail" placeholder="이메일 입력" required>
      </div>
      <div class="form-group">
        <label for="birthdate">생년월일 *</label>
        <input id="birthdate" type="date" name="birthdate" required>
      </div>
      <div id="signupFooter">
        <button type="button" onclick="submitForm()">가입하기</button>
      </div>
    </form>
  </div>
  
  <!--푸터 시작-->
		<footer>
			<div class="footer_container">
	
				<div class="footer_left">
					<h1>Hobee</h1>
	
					<ul class="company_info">
						<li><span>기업명</span>&nbsp;&nbsp;&nbsp;Hobee</li>
						<li><span>사업자번호</span>&nbsp;&nbsp;&nbsp;2024-08-19</li>
						<li><span>주소</span>&nbsp;&nbsp;&nbsp;서울특별시 강남구 테헤란로 14길 6 남도빌딩
							7층 k관</li>
						<li><span>대표자</span>&nbsp;&nbsp;&nbsp;신희강</li>
						<li><span>이메일</span>&nbsp;&nbsp;&nbsp;khteam2@gmail.com</li>
					</ul>
	
					<ul class="terms">
						<li><a href="#">이용약관</a></li>
						<li><a href="#">개인정보 처리방침</a></li>
						<li><a href="#">위치기반 서비스 이용약관</a></li>
					</ul>
	
					<p>Copyright&copy;2024. team. All rights reserved.</p>
				</div>
	
				<div class="footer_right">
					<div class="cs">
						<h3>고객센터</h3>
						<img src="/team/resources/images/kakaotalk_icon.png" alt="고객센터">
					</div>
	
					<div class="sns">
						<h3>SNS</h3>
						<ul>
							<li><a href="https://www.instagram.com/"><img
									src="/team/resources/images/Instagram_icon.png" alt="인스타"></a></li>
							<li><a href="https://www.facebook.com"><img
									src="/team/resources/images/facebook_icon.png" alt="페이스북"></a></li>
							<li><a href="https://www.youtube.com"><img
									src="/team/resources/images/youtube_icon.png" alt="유튜브"></a></li>
						</ul>
					</div>
				</div>
	
			</div>
		</footer>
		<!--푸터 끝-->
	
  
</body>
</html>
