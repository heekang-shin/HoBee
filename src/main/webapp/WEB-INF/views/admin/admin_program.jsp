<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee:관리자 페이지</title>

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 -->
<link rel="stylesheet" href="/hobee/resources/css/admin/admin_main.css">
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_list.css">

<!-- 헤더 스크롤 이펙트-->
<script src="/hobee/resources/js/hostFunction.js"></script>
</head>

<body>
	<div id="wrapper">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/admin/admin_header.jsp"></jsp:include>

		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/admin/admin_sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="content">
			<div class="title-box">
				<img src="/hobee/resources/images/admin_title_icon.png">
				<h3>프로그램 관리</h3>
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
						<input type="button" class="search-button"
							onclick="enterKey(this.form);">

					</form>
				</div>

				<!-- 리스트 시작 -->
				<div class="table-container">
					<div class="total-num">
						<p>
							전체<span>&nbsp;${totalItems}</span>건
						</p>
					</div>

					<table>
						<thead>
							<tr>
								<th width="5%" class="line">번호</th>
								<th width="10%" class="line">카테고리</th>
								<th width="25%" class="line">프로그램명</th>
								<th width="10%" class="line">금액</th>
								<th width="10%" class="line">시작 날짜</th>
								<th width="10%" class="line">시작 시간</th>
								<th width="20%" class="line">작성일</th>
								<th width="10%" class="line">판매상태</th>
							</tr>
						</thead>

						<tbody>
							<!-- 로그인된 id만 동일한 경우만 list 노출  -->


							<!-- 신청한 프로그램이 없는 경우 -->
							<c:if test="${empty hobee_list && empty search_list}">
								<tr class="no-search">
									<td colspan="8" class="line" style="text-align: center;">검색된
										프로그램이 존재하지 않습니다.<br> <a href="host_list.do"
										class="go-list">목록으로</a>
									</td>
								</tr>
							</c:if>


							<c:forEach var="vo" items="${hobee_list}">
								<tr>
									<!-- totalItems에서 현재 반복 순서를 빼서 최신순으로 표시 -->
									<td width="5%" class="line">${startIdx - status.index}</td>
									<td width="10%" class="line">${vo.category_name}</td>
									<td width="25%" class="line" style="text-align: left;">
									<a href="admin_program_detail.do?hb_idx=${vo.hb_idx}&category_name=${vo.category_name}&status=${vo.status}">${vo.hb_title}</a>
									</td>
									<td width="10%" class="line"><fmt:formatNumber
											value="${vo.hb_price}" /> 원</td>
									<td width="10%" class="line">${vo.hb_date}</td>
									<td width="10%" class="line">${vo.hb_time}</td>
									<td width="20%" class="line">${vo.hb_write_date}</td>

									<td width="10%" class="line post-box">
											  <c:choose>
										        <c:when test="${vo.status == 0}">
										           <span class="fin-btn">심사대기</span>
										        </c:when>
										        <c:when test="${vo.status == 1}">
										            <span class="post-btn">게시중</span>
										        </c:when>
										        <c:when test="${vo.status == 2}">
										            <span class="post-reject">게시불가</span>
										        </c:when>
										        <c:otherwise>
										            <span class="post-no">확인 불가</span>
										        </c:otherwise>
										    </c:choose>
									</td>

								</tr>
							</c:forEach>
						</tbody>
					</table>

					<!-- 페이징 -->
					<jsp:include page="/WEB-INF/views/admin/admin_paging.jsp"></jsp:include>
				</div>


			</div>

		</div>
	</div>
</body>
</html>
