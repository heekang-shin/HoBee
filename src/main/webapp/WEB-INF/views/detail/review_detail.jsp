<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
								<!-- 선택 체크박스 -->
								<th width="5%" class="line">번호</th>
								<!-- review_id -->
								<!-- 리뷰 번호 -->
								<th width="15%" class="line">작성자</th>
								<!-- user_name -->
								<!-- 작성자 이름 -->
								<th width="10%" class="line">별점</th>
								<!-- rating -->
								<!-- 평점 -->
								<th class="line">리뷰 내용</th>
								<!-- content  -->
								<!-- 리뷰 내용 -->
								<th width="15%" class="line">작성일</th>
								<!-- created_at  -->
								<!-- 작성일 -->
								<th width="10%" class="line">게시 상태</th>
								<!-- 게시 상태 -->
								<th width="10%" class="line">삭제</th>
								<!-- 삭제 버튼 -->
							</tr>
						</thead>


					<tbody>
    <c:forEach var="review" items="${reviews}">
        <tr>
            <td class="line"><input type="checkbox"></td>
            <td width="5%" class="line">${review.review_id}</td>
            <td width="10%" class="line">${review.user_name}</td>
            <td class="line">${review.content}</td>
            <td width="10%" class="line">${review.rating}점</td>
            <td width="10%" class="line">${review.created_at}</td>
            <td width="10%" class="line">게시 중</td>
            <td width="10%" class="line">
                <button onclick="deleteReview(${review.review_id})">삭제</button>
            </td>
        </tr>
    </c:forEach>
</tbody>


					</table>
				</div>
				<!-- 리스트 끝 -->

				<!--페이징 시작-->
				<div class="pagination">
					<a href="#" class="first-page">«</a> <a href="#" class="prev-page">‹</a>
					<a href="#" class="active">1</a> <a href="#">2</a> <a href="#">3</a>
					<a href="#">4</a> <a href="#">5</a> <a href="#" class="next-page">›</a>
					<a href="#" class="last-page">»</a>
				</div>
				<!-- 페이징 끝 -->

				<!-- 신청 버튼 시작-->
				<div class="applybtn-box">
					<input type="button" value="삭제하기"> <input type="button"
						value="신청하기" onclick="location.href='apply_form.do'">
				</div>
				<!-- 신청 버튼 끝 -->


			</div>
		</div>
	</div>
</body>
</html>
