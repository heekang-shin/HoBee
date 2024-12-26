<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
  <title>로그인 페이지</title>
    <link rel="stylesheet" href="resources/css/loginform.css">
    <link rel="stylesheet" href="resources/css/main.css">
    <script src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
    
    <script>
    function login() {
        let id = document.getElementById("id").value.trim();
        let password = document.getElementById("password").value.trim();

        // 입력 값 확인
        if (!id || !password) {
            alert("아이디와 비밀번호를 입력하세요");
            return;
        }

        // 로그 출력 (여기서 실행)
  	//	console.log("로그인 요청:", id, password);
        // 이후 로그인 처리 로직 추가...
        
       
	    // URL과 파라미터 구성
	    let url = "Login.do";
	    let param = "id=" + encodeURIComponent(id) + 
                "&password=" + encodeURIComponent(password);

        // AJAX 요청
    //	console.log("여기까지 오나 ?:", id, password);
        sendRequest(url, param, loginResult, "post");
    }

    function loginResult() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            let result = xhr.responseText.trim(); // 서버 응답 처리
            if (result === "success") {
               // console.log("로그인 요청: id = " + id + ", password = " + password);
                window.location.href = `${pageContext.request.contextPath}/main.do`; // 메인 페이지로 이동
            } else {
                alert("아이디 또는 비밀번호가 잘못되었습니다.");
            }
        }
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

    <!-- 로그인하지 않은 상태 -->
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
    <div class="login-container">
        <h1>로그인</h1>
        <form onsubmit="event.preventDefault(); login();">
            <div class="input-group">
                <label for="username">아이디</label>
                <input type="text" id="id" placeholder="아이디를 입력해주세요.">
            </div>
            <div class="input-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" placeholder="비밀번호를 입력해주세요.">
            </div>
            <input type="button" class="login-button" value="로그인" onclick="login();">
        </form>
        <div class="links">
            <a href="find.do">아이디/비밀번호 찾기</a> | <a href="CreateAccount_form.do">회원가입</a>
        </div>
        <div class="social-login">
            <a href="naver_login.do"><img src="resources/images/naver.png" alt="네이버 로그인" class="social-icon"></a>
           <a href="${pageContext.request.contextPath}/kakao/kakao_login.do">
    <img src="${pageContext.request.contextPath}/resources/images/kakao.png" alt="카카오톡 로그인" class="social-icon"></a>

        </div>
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