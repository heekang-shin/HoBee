<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Hobee&nbsp;모임신청완료</title>
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	<link rel="stylesheet" href="/hobee/resources/css/main.css">
	<link rel="stylesheet" href="/hobee/resources/css/apply.css">
	<link rel="stylesheet" href="/hobee/resources/css/apply_fin.css">
	
	</head>
	
	<body>
		<!-- 헤더 시작-->
		<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
		<!-- 헤더 끝 -->
		
		<!-- 메인텍스트 시작-->
		<div class="page-title">
			<h1>모임등록</h1>
		</div>
		<!-- 메인텍스트 끝-->
		
		<!-- 완료 시작 -->
		<div class="fin-container">
		<div class="fin-box">
			<img src="/hobee/resources/images/fin_icon.png">
			<h1>모임등록 완료</h1>
			<p>Hobee 모임등록이 완료되었습니다.</p>
			<input type="button" value="목록으로" onclick="location.href='apply_list.do'">
		</div>
		</div>
		<!-- 완료 끝 -->
		
		
		<!-- 푸터 시작-->
		<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
		<!-- 푸터 끝 -->
	
		<!--top버튼 시작-->
		<a id="toTop" href="#">TOP</a>
		<!--top버튼 끝-->
	</body>
</html>