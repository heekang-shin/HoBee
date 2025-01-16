<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>호스터 헤더</title>
	
	<script src="/hobee/resources/js/hostFunction.js"></script>
	
	<link rel="stylesheet" href="/hobee/resources/css/host/header.css">
	<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
	
	</head>
	<body>
		<div id="header">
		<div class="container">
			<!-- logo -->
			<h1 class="logo">
				<a href="main.do">Hobee</a>
			</h1>
	
			<!-- user menu 시작-->
			<div class="user">
				<div class="user-info">
					반갑습니다 <b class="user-name">${sessionScope.loggedInUser.user_id}</b>님
				</div>
			
				<input type="button" value="로그아웃">
			</div>
			<!-- user menu 끝 -->
		</div>
	</div>
	</body>
</html>