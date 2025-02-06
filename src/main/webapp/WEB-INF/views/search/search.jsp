<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>&#39;${param.search_text}&#39;&nbsp;검색결과_Hobee</title>

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

<link rel="icon" href="/hobee/resources/images/Favicon.png">
<link rel="stylesheet" href="/hobee/resources/css/searchPage.css">
<link rel="stylesheet" href="/hobee/resources/css/header.css">
<link rel="stylesheet" href="/hobee/resources/css/common.css">
<link rel="stylesheet" href="/hobee/resources/css/footer.css">
</head>

<body>
    <%-- <!-- 헤더 시작 -->
    <div id="header">
        <div id="header_inner">
            <h1 class="logo">
                <a href="main.do">Hobee</a>
            </h1>

            <!-- 검색창 시작 -->
            <form onsubmit="return enterKey(this);">
                <div id="search_inner">
                    <input type="search" value="${param.search_text}" name="search_text" 
                        placeholder="검색어를 입력해 주세요." />
                    <img src="/hobee/resources/images/search_icon.png" class="search-icon">
                </div>
            </form>
            <!-- 검색창 끝 -->

            <!-- snb 시작 -->
            <ul class="snb">
                <li><img src="/hobee/resources/images/shop_icon.png" alt="찜" />
                    <a href="shop.do">찜목록</a></li>
                <li><img src="/hobee/resources/images/join_icon.png" alt="회원가입" />
                    <a href="join_form.do">회원가입</a></li>
                <li><img src="/hobee/resources/images/login_form.png" alt="로그인" />
                    <a href="login.do">로그인</a></li>
                <li><a href="host_login.do" class="host">호스트센터</a></li>
            </ul>
            <!-- snb 끝 -->
        </div>
    </div>
    <!-- 헤더 끝 --> --%>
    
    <!--헤더 시작-->
	<div id="header">
		<div id="header_inner">
			<h1 class="logo">
				<a href="main.do">Hobee</a>
			</h1>

			<!--검색창 시작-->
			<form onsubmit="return enterKey(this);">
				<div id="search_inner">
					<input type="search" value="${param.search_text}"
						placeholder="검색어를 입력해 주세요." name="search_text"
						onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}" /> <img
						src="/hobee/resources/images/search_icon.png" class="search-icon">
				</div>
			</form>

			<!--snb 시작-->
			<ul class="snb">
				<!-- ✅ 로그인하지 않은 상태 -->
				<c:if test="${empty sessionScope.loggedInUser}">
					<li><img src="/hobee/resources/images/join_icon.png"
						alt="회원가입" /> <a href="CreateAccount_form.do">회원가입</a></li>
					<li><img src="/hobee/resources/images/login_form.png"
						alt="로그인" /> <a href="login_form.do">로그인</a></li>
					<!-- ✅ 비로그인 상태에서도 호스트센터 표시 -->
					<li><a href="host_main.do" class="host">호스트센터</a></li>
				</c:if>

				<!-- ✅ 로그인한 상태 -->
				<c:if test="${not empty sessionScope.loggedInUser}">
					<!-- ✅ 총괄관리자인 경우 -->
					<c:if test="${sessionScope.loggedInUser.lv == '총괄관리자'}">
						<li><img src="/hobee/resources/images/join_icon.png"
							alt="관리자 계정 생성" /> <a href="create_admin_account.do">관리자 생성</a></li>
					</c:if>

				
					<c:if
						test="${empty sessionScope.loggedInUser.lv or 
            sessionScope.loggedInUser.lv == '일반' or 
            sessionScope.loggedInUser.lv == '호스트' or sessionScope.loggedInUser.lv == '관리자' or sessionScope.loggedInUser.lv == '총괄관리자'}">
						<li><img src="/hobee/resources/images/join_icon.png"
							alt="마이페이지" /> <a
							href="mypage_heart_form.do?user_id=${sessionScope.loggedInUser.user_Id}">마이페이지</a>
						</li>
					</c:if>


					<li><a class="hello">
							${sessionScope.loggedInUser.user_name}님</a></li>
					<li><img src="/hobee/resources/images/loginout.png" alt="로그아웃" />
						<a href="logout.do" class="logout-btn">로그아웃</a></li>

					<!-- ✅ 관리자 또는 총괄관리자일 경우 관리자센터 표시 -->
					<c:if
						test="${sessionScope.loggedInUser.lv == '관리자' or sessionScope.loggedInUser.lv == '총괄관리자'}">
						<li><a href="admin_main.do" class="host">관리자센터</a></li>
					</c:if>
					<!-- ✅ 일반 사용자 또는 호스트인 경우 호스트센터 표시 -->
					<c:if
						test="${empty sessionScope.loggedInUser.lv or 
            sessionScope.loggedInUser.lv == '일반' or 
            sessionScope.loggedInUser.lv == '호스트'}">
						<li><a href="host_main.do" class="host">호스트센터</a></li>
					</c:if>
				</c:if>
			</ul>
			<!--snb 끝-->
		</div>
	</div>
	<!--헤더 끝-->
    

    <!-- 검색결과가 존재하지 않는 경우 -->
	<c:if test="${ empty search_list}">
	    <jsp:include page="search_nopage.jsp"></jsp:include>
	</c:if>
	
	<!-- 검색결과가 존재하는 경우 -->
	<c:if test="${ !empty search_list}">
	    <div id="result">
	        <div class="result_header">
	            <h1>
	                <span>&#39;${param.search_text}&#39;</span>&nbsp;검색 결과
	            </h1>
	        </div>
	
	        <!-- 검색결과 리스트 -->
	        <div class="con_wrapper">
	            <c:forEach var="vo" items="${search_list}">
	                <div class="con_box aboutinner aos-item" data-aos="fade-up">
	                 <img src="/hobee/resources/images/upload/${vo.s_image}" alt="thumbnail"
                             onclick="location.href='hobee_detail.do?hbidx=${vo.hb_idx}'">
	                    <h2>${vo.hb_title}</h2>
	                    <p>
	                        <fmt:formatNumber value="${vo.hb_price}" /> 원
	                    </p>
	                    <span>1인당</span>
	                </div>
	            </c:forEach>
	        </div>
	    </div>
	</c:if>


    <!-- 푸터 시작 -->
    <jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
    <!-- 푸터 끝 -->
</body>
</html>
