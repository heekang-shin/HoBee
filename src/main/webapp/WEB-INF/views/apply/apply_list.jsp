<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Hobee:모임신청페이지</title>
	
	<script src="/hobee/resources/js/main.js"></script>
	
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	<link rel="stylesheet" href="/hobee/resources/css/main.css">
	<link rel="stylesheet" href="/hobee/resources/css/apply.css">
	</head>

	<body>
	
		<!-- 헤더 시작-->
		<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
		<!-- 헤더 끝 -->
	
		<!-- 메인텍스트 시작-->
		<div class="apply_board_header">
			<h1>모임등록</h1>
		</div>
		<!-- 메인텍스트 끝-->
	
		<!-- 검색창 시작-->
		<form>
			<div class="search_box">
				<select>
					<option value="">전체</option>
					<option value="search_text">검색어</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
				</select>
	
				<!-- input 검색 창 -->
				<input id="search" type="search" placeholder="검색어를 입력해 주세요."
					name="search_text"
					onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}" />
	
				<!-- 검색 버튼 -->
				<input type="button" value="검색" class="serch_btn" onclick="">
			</div>
		</form>
		<!-- 검색창 끝 -->
	
		<!--리스트 시작-->
		<div class="board_header">
			<p>전체 
			<span class="board_header_total_num"></span>
			건
			</p>
		</div>
		
		<table class="board-table">
		
		</table>
		
		<!--리스트 끝-->
	
	
	
	
		<!-- 푸터 시작-->
		<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
		<!-- 푸터 끝 -->
	
		<!--top버튼 시작-->
		<a id="toTop" href="#">TOP</a>
		<!--top버튼 끝-->
	</body>
</html>