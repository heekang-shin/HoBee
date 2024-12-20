<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		
<!-- 회원가입 제목 -->
<div id="signupHeader">
    <h1 id="signupTitle">회원가입</h1>
</div>

<!-- 회원가입 폼 -->
<div id="signupContainer">
    <form id="signupForm" name="signupForm">
        <!-- 이름 위에 검은 선 -->
        <div class="black-line"></div>
        <div class="form-group">
            <label for="username">이름 *</label>
            <input id="username" type="text" name="username" required>
        </div>
        <div class="form-group">
            <label for="userId">아이디 *</label>
            <div class="input-with-button">
                <input id="userId" type="text" name="userId" placeholder="아이디 입력" required>
                <button type="button" class="btn-inline" onclick="chk()">중복확인</button>
            </div>
        </div>
        <div class="form-group">
            <label for="password">비밀번호 *</label>
            <input id="password" type="password" name="password" placeholder="문자, 숫자 포함 8자 이상" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">비밀번호 확인 *</label>
            <input id="confirmPassword" type="password" name="confirmPassword" required>
        </div>
        <div class="form-group">
            <label for="email">이메일 *</label>
            <input id="email" type="email" name="email" placeholder="이메일 입력" required>
        </div>
        <div class="form-group">
            <label for="birthdate">생년월일 *</label>
            <input id="birthdate" type="date" name="birthdate" required>
        </div>
    </form>
</div>

<!-- 가입하기 버튼 -->
<div id="signupFooter">
    <button type="submit" form="signupForm">가입하기</button>
</div>




  <!-- 푸터 -->
  <footer>
    <div class="footer_container">
      <div class="footer_left">
        <h1>Hobee</h1>
        <ul class="company_info">
          <li><span>기업명</span>&nbsp;&nbsp;&nbsp;Hobee</li>
          <li><span>사업자번호</span>&nbsp;&nbsp;&nbsp;2024-08-19</li>
          <li><span>주소</span>&nbsp;&nbsp;&nbsp;서울특별시 강남구 테헤란로 14길 6 남도빌딩 7층</li>
          <li><span>대표자</span>&nbsp;&nbsp;&nbsp;신희강</li>
          <li><span>이메일</span>&nbsp;&nbsp;&nbsp;khteam2@gmail.com</li>
        </ul>
      </div>
    </div>
  </footer>
</body>
</html>
