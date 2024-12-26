<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>header</title>
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
						 
						<img src="/hobee/resources/images/search_icon.png" class="search-icon">
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
	</body>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>header</title>
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
						 
						<img src="/hobee/resources/images/search_icon.png" class="search-icon">
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
	</body>
>>>>>>> refs/heads/JS
</html>