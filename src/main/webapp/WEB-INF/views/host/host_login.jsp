<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>호스트 페이지</title>
	
	<!-- 파비콘 -->
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
	
	<!-- 헤더 -->
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
				<h3>프로그램 목록</h3>
			</div>

			<!--대시보드 영역 -->
			<div class="dashboard">

				<!-- 검색창 시작-->
				<div class="search-container">
					<form>
						<!-- 드롭다운 메뉴 -->
						<div class="select-box">
							<select class="search-select" name="search_category">
								<option value="all">전체</option>
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
						</div>

						<!-- 검색 입력 필드 -->
						<input id="search" type="search" placeholder="검색어를 입력해 주세요."
							name="search_text" class="search-input"
							onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}" />

						<!-- 검색 버튼 -->
						<input type="button" class="search-button" onclick="">

					</form>
				</div>



				<!-- 리스트 시작 -->
				<div class="table-container">
					<div class="total-num">
						<p>
							전체<span>&nbsp;1건</span>
						</p>
					</div>

					<table>
						<thead>
							<tr>
								<th class="line"><input type="checkbox"></th>
								<th width="5%" class="line">번호</th>
								<th width="10%" class="line">카테고리</th>
								<th width="10%" class="line">상세카테고리</th>
								<th class="line">프로그램명</th>
								<th width="10%" class="line">금액</th>
								<th width="10%" class="line">판매시작일</th>
								<th width="10%" class="line">판매종료일</th>
								<th width="10%" class="line">게시상태</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach begin="1" end="10">
							<tr>
								<td class="line"><input type="checkbox"></td>
								<td width="5%" class="line">1</td>
								<td width="10%" class="line">운동</td>
								<td width="10%" class="line">스포츠</td>
								<td class="line">test</td>
								<td width="10%" class="line">5000원</td>
								<td width="10%" class="line">2024-00-00</td>
								<td width="10%" class="line">2024-00-00</td>
								<td width="10%" class="line">게시상태</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- 리스트 끝 -->
				
				<!--페이징 시작-->
				<div class="pagination">
			    <a href="#" class="first-page">«</a>
			    <a href="#" class="prev-page">‹</a>
			    <a href="#" class="active">1</a>
			    <a href="#">2</a>
			    <a href="#">3</a>
			    <a href="#">4</a>
			    <a href="#">5</a>
			    <a href="#" class="next-page">›</a>
			    <a href="#" class="last-page">»</a>
				</div>
				<!-- 페이징 끝 -->
				
				<!-- 신청 버튼 시작-->
				<div class="applybtn-box">
					<input type="button" value="삭제하기">
					<input type="button" value="신청하기" onclick="location.href='apply_form.do'">
				</div>
				<!-- 신청 버튼 끝 -->


			</div>
		</div>
	</div>
</body>
</html>
