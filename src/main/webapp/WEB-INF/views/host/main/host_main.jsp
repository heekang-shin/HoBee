<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Hobee:호스트 페이지</title>
	
	<!-- 파비콘 -->
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	
	<!-- 공통 스타일 -->
	<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
	<link rel="stylesheet" href="/hobee/resources/css/host/main.css">
	
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
				<h3>호스트 센터</h3>
			</div>

			<!--대시보드 영역 -->
			<div class="dashboard">

				<!-- total  -->
				<div class="host-total">
					<div class="tot-box">
						<h3>프로그램 등록 현황</h3>
						<h2>${totalItems}<span>&nbsp;건</span>
						</h2>
					</div>

					<div class="tot-box">
						<h3>문의 현황</h3>
						<h2>${inqtotalItems}<span>&nbsp;건</span>
						</h2>
					</div>

					<div class="tot-box">
						<h3>문의 미답변 현황</h3>
						<h2>${nullCount}<span>&nbsp;건</span>
						</h2>
					</div>

					<div class="tot-box">
						<h3>신청자 현황</h3>
						<h2>${restotalItems}<span>&nbsp;건</span>
						</h2>
					</div>
				</div>

				<!-- 프로그램 관리 -->
				<div class="list-container">
					<div class="list-box">
						<div class="list-title">
							<h3>프로그램 관리</h3>
							<p>
								기준&nbsp;<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" />
							</p>
						</div>

						<ul>
							<!-- 리스트가 비어 있을 때 -->
							<c:if test="${empty apply_list}">
								<li>등록된 프로그램이 존재하지 않습니다.</li>
							</c:if>

							<!-- 리스트가 있을 때 -->
							<c:forEach var="vo" items="${apply_list}" end="4" step="1">
								<li><a href="host_list.do">&#45;&nbsp;[${vo.category_name}]&nbsp;${vo.hb_title}</a></li>
							</c:forEach>
						</ul>
					</div>


					<!-- 문의 관리 -->
					<div class="list-box">
						<div class="list-title">
							<h3>문의 관리</h3>
							<p>
								기준&nbsp;<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" />
							</p>
						</div>

						<ul>
							<!-- 리스트가 비어 있을 때 -->
							<c:if test="${empty inqList}">
								<li>등록된 1:1 문의가 존재하지 않습니다.</li>
							</c:if>

							<!-- 리스트가 있을 때 -->
							<c:forEach var="vo" items="${inqList}" end="4" step="1">
								<li><a href="inq_list.do">&#45;&nbsp;${vo.hb_title}</a></li>
							</c:forEach>
						</ul>
					</div>


					<!-- 신청 관리 -->
					<div class="list-box">
						<div class="list-title">
							<h3>신청 관리</h3>
							<p>
								기준&nbsp;<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" />
							</p>
						</div>

						<ul>
							<!-- 리스트가 비어 있을 때 -->
							<c:if test="${empty resList}">
								<li>등록된 신청이 존재하지 않습니다.</li>
							</c:if>

							<!-- 리스트가 있을 때 -->
							<c:forEach var="vo" items="${resList}" end="4" step="1">
								<li><a href="res_list.do">&#45;&nbsp;[${vo.hb_title}]&nbsp;${vo.user_name}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>

			</div>

		</div>
	</div>
</body>
</html>
