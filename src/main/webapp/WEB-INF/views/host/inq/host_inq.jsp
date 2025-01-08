<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Hobee:문의 관리</title>
	
	<!-- 파비콘 -->
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	
	<!-- 공통 스타일 -->
	<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
	
	<!-- 헤더 스크롤 이펙트-->
	<script src="/hobee/resources/js/hostFunction.js"></script>
	</head>
	
	<body>
	<div id="wrapper">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/host/host_header.jsp"></jsp:include>

		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/host/host_sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="content">
			<div class="title-box">
				<img src="/hobee/resources/images/title_icon.png">
				<h3>문의 관리</h3>
			</div>

			<!--대시보드 영역 -->
			<div class="dashboard">
				<!-- apply 리스트 -->
				<jsp:include page="/WEB-INF/views/host/inq/host_inq_list.jsp"></jsp:include>
				
				<!-- 페이징 -->
				<jsp:include page="/WEB-INF/views/host/host_paging.jsp"></jsp:include>
			</div>
				
		</div>
	</div>
</body>
</html>
