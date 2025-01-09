<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee:문의 답변</title>

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 -->
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet"
	href="/hobee/resources/css/host/host_inq_list.css">

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

				<!-- 리스트  -->
				<div class="inq-container">

					<!-- 사용자 -->
					<div class="inq-question-header">
						<h3>${vo.title}</h3>
					</div>

					<!-- 사용자 정보 -->
					<div calss="inq-detial">
						<div class="inq-writer">
							<h4>작성자</h4>
							<p>${vo.writer}</p>
						</div>

						<div class="inq-date">
							<h4>등록일</h4>
							<p>${vo.created_date}</p>
						</div>

						<div class="inq-answer">
							<h4>답변상태</h4>
							<c:set var="btnClass"
								value="${!empty vo.answer ? 'btn-view' : 'btn-answer'}" />
							<span class="${btnClass}">${!empty vo.answer ? '답변미완료' : '답변완료'}</span>
						</div>
					</div>

					<div class="inq-con">
						<P>${vo.content}</P>
					</div>
						

				</div>

				<!-- 페이징 -->
				<jsp:include page="/WEB-INF/views/host/host_paging.jsp"></jsp:include>
			</div>

		</div>
	</div>
</body>
</html>
