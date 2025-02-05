<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세보기</title>

<!-- 리스트 -->
<link rel="stylesheet" href="/hobee/resources/css/host/pagination.css">

<!-- 신청내역 스타일 시트  -->
<link rel="stylesheet"
	href="/hobee/resources/css/mypage/mypage_review.css">

<script src="/hobee/resources/js/hostFunction.js"></script>




<script>
	function toggleCheckboxes(selectAllCheckbox) {
		const checkboxes = document.querySelectorAll('.rowCheckbox');
		checkboxes.forEach(function(checkbox) {
			checkbox.checked = selectAllCheckbox.checked;
		});
	}

	function submitDeleteForm() {
	    const form = document.getElementById('reviewForm');
	    const checkboxes = document.querySelectorAll('.rowCheckbox:checked');

	    if (checkboxes.length === 0) {
	        alert("삭제할 항목을 선택하세요.");
	        return;
	    }

	    if (confirm("선택한 리뷰를 삭제하시겠습니까?")) {
	        form.action = "delmyReview.do";
	        form.method = "post";
	        form.submit();
	    }
	}
</script>

</head>

<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>

	<!--메뉴 인클루드  -->
	<jsp:include page="/WEB-INF/views/mypage/mypage_index.jsp" />

	<div id="wrapper">

		<div class="content">
			<div class="title-box"></div>


			<div class="table-container">

				<h2>작성한 리뷰</h2>
				<form id="reviewForm" method="post">
					<table>
						<thead>
							<tr>
								<th width="5%" class="line"><input type="checkbox"
									id="selall" onchange="toggleCheckboxes(this)"></th>
								<th width="15%" class="line">모임명</th>
								<th width="5%" class="line">평점</th>
								<th width="25%" class="line">리뷰 내용</th>
								<th width="10%" class="line">작성일</th>
								<th width="10%" class="line">게시 상태</th>
							</tr>
						</thead>

						<tbody>
							<c:choose>
								<c:when test="${not empty reviews}">
									<c:forEach var="review" items="${reviews}">
										<tr>
											<td><input type="checkbox" name="review_id"
												value="${review.review_id}" class="rowCheckbox"></td>
											<td>${review.hb_title}</td>
											<td>${review.rating}점</td>
											<td>${review.content}</td>
											<td>${review.created_at}</td>
											<td>게시 중</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6">작성된 리뷰가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>

					<div class="applybtn-box">
						<input type="button" value="삭제하기" onclick="submitDeleteForm();">
					</div>
				</form>

			</div>
		</div>
		</div>
	
		
</body>
</html>
