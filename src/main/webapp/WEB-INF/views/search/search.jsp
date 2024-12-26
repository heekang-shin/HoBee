<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>&#39;${param.search_text}&#39;&nbsp;검색결과_Hobee</title>
<link rel="icon" href="/hobee/resources/images/Favicon.png">
<link rel="stylesheet" href="/hobee/resources/css/searchPage.css">
<link rel="stylesheet" href="/hobee/resources/css/main.css">
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

					<input type="search" name="search_text"
						value="${param.search_text}"
						onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}" /> <img
						src="/hobee/resources/images/search_icon.png" class="search-icon">
				</div>
			</form>
			<!--검색창 끝-->

			<!--snb 시작-->
			<ul class="snb">
				<li><img src="/hobee/resources/images/registration_icon.png"
					alt="모임등록" /> <a href="form.do">모임등록</a></li>

				<li><img src="/hobee/resources/images/shop_icon.png" alt="찜" />
					<a href="shop.do">찜목록</a></li>

				<li><img src="/hobee/resources/images/join_icon.png" alt="회원가입" />
					<a href="join_form.do">회원가입</a></li>

				<li><img src="/hobee/resources/images/login_form.png" alt="로그인" />
					<a href="login.do">로그인</a></li>

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
	<c:if test="${search_list != null && !empty search_list}">
		
		<div id="result">
			<div class="result_header">
				<h1>
					<span>&#39;${param.search_text}&#39;</span>&nbsp;검색 결과
				</h1>
			</div>

			<!-- 검색결과 끝 -->
			<div class="con_wrapper">
				<c:forEach var="vo" items="${search_list}">

					<div class="con_box aboutinner aos-item best" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/${vo.l_image}.png"
							alt="thumbnail">
						<h2>${vo.hb_title}</h2>
						<p>
							<fmt:formatNumber value="${vo.hb_price}"/>
							원
						</p>
						<span>1인당</span>
					</div>

				</c:forEach>

			</div>
		</div>
	</c:if>

	<!-- 푸터 시작-->
	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
	<!-- 푸터 끝 -->
</body>

=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>&#39;${param.search_text}&#39;&nbsp;검색결과_Hobee</title>
<link rel="icon" href="/hobee/resources/images/Favicon.png">
<link rel="stylesheet" href="/hobee/resources/css/searchPage.css">
<link rel="stylesheet" href="/hobee/resources/css/main.css">
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

					<input type="search" name="search_text"
						value="${param.search_text}"
						onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}" /> <img
						src="/hobee/resources/images/search_icon.png" class="search-icon">
				</div>
			</form>
			<!--검색창 끝-->

			<!--snb 시작-->
			<ul class="snb">
				<li><img src="/hobee/resources/images/registration_icon.png"
					alt="모임등록" /> <a href="form.do">모임등록</a></li>

				<li><img src="/hobee/resources/images/shop_icon.png" alt="찜" />
					<a href="shop.do">찜목록</a></li>

				<li><img src="/hobee/resources/images/join_icon.png" alt="회원가입" />
					<a href="join_form.do">회원가입</a></li>

				<li><img src="/hobee/resources/images/login_form.png" alt="로그인" />
					<a href="login.do">로그인</a></li>

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
	<c:if test="${search_list != null && !empty search_list}">
		
		<div id="result">
			<div class="result_header">
				<h1>
					<span>&#39;${param.search_text}&#39;</span>&nbsp;검색 결과
				</h1>
			</div>

			<!-- 검색결과 끝 -->
			<div class="con_wrapper">
				<c:forEach var="vo" items="${search_list}">

					<div class="con_box aboutinner aos-item best" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/${vo.l_image}.png"
							alt="thumbnail">
						<h2>${vo.hb_title}</h2>
						<p>
							<fmt:formatNumber value="${vo.hb_price}"/>
							원
						</p>
						<span>1인당</span>
					</div>

				</c:forEach>

			</div>
		</div>
	</c:if>

	<!-- 푸터 시작-->
	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
	<!-- 푸터 끝 -->
</body>

>>>>>>> refs/heads/JS
</html>