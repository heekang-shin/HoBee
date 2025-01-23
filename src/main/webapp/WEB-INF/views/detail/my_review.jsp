<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세보기</title>

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">

<!-- 헤더 -->
<script src="/hobee/resources/js/hostFunction.js"></script>
</head>


<script>
function toggleCheckboxes(selectAllCheckbox) {
    // 클래스가 'rowCheckbox'인 모든 하위 체크박스를 선택
    const checkboxes = document.querySelectorAll('.rowCheckbox');
    // 상단 체크박스의 상태에 따라 하위 체크박스 체크/해제
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = selectAllCheckbox.checked;
    });
}

function submitForm() {
    // 폼 객체 가져오기
    const form = document.getElementById('reviewForm');

    // 체크된 체크박스들 가져오기
    const checkboxes = document.querySelectorAll('.rowCheckbox:checked');

    // 체크된 체크박스에서 값 수집
    const selectedIds = Array.from(checkboxes).map(checkbox => checkbox.value);

    // 체크박스 값 확인
    if (selectedIds.length === 0) {
        alert("삭제할 항목을 선택하세요.");
        return;
    }

    // 확인 메시지 표시
    if (confirm("선택한 리뷰를 삭제하시겠습니까?")) {
        form.submit(); // 폼 제출
    }
}


// 컨트롤러에서 전달된 errorMessage 확인
<c:if test="${not empty errorMessage}">
    alert('${errorMessage}');
</c:if>
</script>

<body>
	<div id="wrapper">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/host/host_header.jsp"></jsp:include>

		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/detail/review_sidebar.jsp"></jsp:include>

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
							전체<span>${reviewCount}건</span>
						</p>
					</div>

					<form id="reviewForm" action="deleteReview.do" method="post">
						<table>
							<thead>
								<tr>
									<th><input type="checkbox" id="selall"
										onchange="toggleCheckboxes(this)"></th>
									<th>번호</th>
									<th>작성자</th>
									<th>평점</th>
									<th>리뷰 내용</th>
									<th>작성일</th>
									<th>게시 상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="review" items="${reviews}">
									<tr>
										<td><input type="checkbox" name="review_id"
											value="${review.review_id}" class="rowCheckbox"></td>
										<td>${review.review_id}</td>
										<td>${review.user_name}</td>
										<td>${review.rating}점</td>
										<td>${review.content}</td>
										<td>${review.created_at}</td>
										<td>게시 중</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="applybtn-box">
							<input type="hidden" name="hbidx" value="${hbidx}"> <input
								type="button" value="삭제하기" onclick="submitForm();">
						</div>
					</form>



					<!--페이징 시작-->
					<div class="pagination">
						<a href="#" class="first-page">«</a> <a href="#" class="prev-page">‹</a>
						<a href="#" class="active">1</a> <a href="#">2</a> <a href="#">3</a>
						<a href="#">4</a> <a href="#">5</a> <a href="#" class="next-page">›</a>
						<a href="#" class="last-page">»</a>
					</div>
					<!-- 페이징 끝 -->

				</div>
			</div>
		</div>
	</div>
</body>
</html>
