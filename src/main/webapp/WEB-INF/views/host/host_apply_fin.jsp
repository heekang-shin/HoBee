<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>호스트 신청 완료</title>
	
	<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
	<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_fin.css">
	
	
	</head>
	<body>
		<div id="wrapper">
			<!-- 헤더 -->
			<jsp:include page="/WEB-INF/views/host/host_header.jsp"></jsp:include>
	
			<!-- 사이드바 -->
			<jsp:include page="/WEB-INF/views/host/host_sidebar.jsp"></jsp:include>
	
			<!-- 컨텐츠 영역 -->
			<!-- 완료 시작 -->
			<div class="content">
			<div class="title-box">
				<img src="/hobee/resources/images/title_icon.png">
				<h3>프로그램 신청</h3>
			</div>
			
			<!--대시보드 영역-->
			<div class="dashboard">
			
				<div class="fin-box">
					<img src="/hobee/resources/images/fin_icon.png">
					<h1>모임등록 완료</h1>
					<p>Hobee 모임등록이 완료되었습니다.</p>
					<input type="button" value="목록으로" onclick="location.href='host_login.do'">
				</div>
			</div>
		</div>
		<!-- 완료 끝 -->
		</div>
	</body>	
</html>