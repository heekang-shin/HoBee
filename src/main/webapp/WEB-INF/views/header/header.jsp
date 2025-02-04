<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>header</title>
    <script>
 // 검색창 동작
    function enterKey(f) {
        // 유효성 체크
        let searchInput = f.search_text.value;
        
        if (searchInput.trim() === '') {
            alert('검색어를 입력해 주세요.');
            return false; // 기본 동작 중단
        }
        
        f.action = "search.do";
        f.method = "get";
        f.submit(); 
    }
    </script>
    <link rel="stylesheet" href="/hobee/resources/css/header.css">
</head>
<body>
    <!--헤더 시작-->
    <div id="header">
        <div id="header_inner">
            <h1 class="logo">
                <a href="main.do">Hobee</a>
            </h1>

            <!--검색창 시작-->
            <form onsubmit="return enterKey(this);">
                <div id="search_inner">
                   <input type="search" value="${param.search_text}" placeholder="검색어를 입력해 주세요." name="search_text"
							onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}" />
							 <img src="/hobee/resources/images/search_icon.png" class="search-icon" >
                </div>
            </form>

			<!--snb 시작-->
			<ul class="snb">
				<!-- 로그인하지 않은 상태 -->
				<c:if test="${empty sessionScope.loggedInUser}">
					<li><img src="/hobee/resources/images/join_icon.png"
						alt="회원가입" /> <a href="CreateAccount_form.do">회원가입</a></li>
					<li><img src="/hobee/resources/images/login_form.png"
						alt="로그인" /> <a href="login_form.do">로그인</a></li>
				</c:if>

				<!-- 로그인한 상태 -->
				<c:if test="${not empty sessionScope.loggedInUser}">
					<!-- 총괄관리자인 경우  -->
					<c:if test="${sessionScope.loggedInUser.lv == '총괄관리자'}">
						<li><img src="/hobee/res	ources/images/join_icon.png"
							alt="관리자 계정 생성" /> <a href="create_admin_account.do">관리자 생성</a></li>
					</c:if>

					<!-- 일반 사용자일 경우 -->
					<c:if test="${sessionScope.loggedInUser.lv != '총괄관리자'}">
						<li><img src="/hobee/resources/images/join_icon.png"
							alt="마이페이지" /> <a
							href="mypage_heart_form.do?user_id=${sessionScope.loggedInUser.user_Id}">${sessionScope.loggedInUser.user_name}님&nbsp;마이페이지</a>
						</li>
					</c:if>


					<li>
						<img src="/hobee/resources/images/loginout.png" alt="로그아웃" />
						<a href="logout.do" class="logout-btn">로그아웃</a>
					</li>
				</c:if>

				<!-- 관리자, 총괄관리자일 경우 -->
				<c:if test="${sessionScope.loggedInUser.lv == '관리자' || sessionScope.loggedInUser.lv == '총괄관리자'}">
				    <li><a href="admin_main.do" class="host">관리자센터</a></li>
				</c:if>
				
				<!-- 호스트일 경우 호스트센터로 보이도록 -->
				<c:if test="${sessionScope.loggedInUser.lv == '호스트'}">
				    <li><a href="host_main.do" class="host">호스트센터</a></li>
				</c:if>
			</ul>
			<!--snb 끝-->
		</div>
    </div>
    <!--헤더 끝-->

</body>
</html>
