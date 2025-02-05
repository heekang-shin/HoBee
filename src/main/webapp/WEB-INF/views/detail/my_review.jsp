<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세보기</title>
<link rel="icon" href="/hobee/resources/images/Favicon.png">
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_list.css">
<link rel="stylesheet" href="/hobee/resources/css/host/pagination.css">

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
    const selectedIds = Array.from(checkboxes).map(checkbox => checkbox.value);

    if (selectedIds.length === 0) {
        alert("삭제할 항목을 선택하세요.");
        return;
    }

    if (confirm("선택한 리뷰를 삭제하시겠습니까?")) {
        form.action = "delmyReview.do";
        form.method = "post";
        form.submit();
    }
}

function submitEditForm() {
    const form = document.getElementById('reviewForm');
    const checkboxes = document.querySelectorAll('.rowCheckbox:checked');
    const selectedIds = Array.from(checkboxes).map(checkbox => checkbox.value);

    if (selectedIds.length === 0) {
        alert("수정할 항목을 선택하세요.");
        return;
    }

    if (selectedIds.length > 1) {
        alert("한 번에 하나의 리뷰만 수정할 수 있습니다.");
        return;
    }

    form.action = "editmyReview.do";
    form.method = "post";
    form.submit();
}
</script>
</head>

<body>
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/host/host_header.jsp"></jsp:include>
		<jsp:include page="/WEB-INF/views/detail/review_sidebar.jsp"></jsp:include>

		<div class="content">
			<div class="title-box">
				<h3>작성한 리뷰</h3>
			</div>

			<div class="dashboard">
				<div class="search-container">
					<form>
						<div class="select-box">
							<select class="search-select" name="search_category">
								<option value="all">전체</option>
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
						</div>
						<input id="search" type="search" placeholder="검색어를 입력해 주세요."
							name="search_text" class="search-input"
							onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}" /> 
						<input type="button" class="search-button" onclick="">
					</form>
				</div>

				<div class="table-container">
					<div class="total-num">
						<p>
							전체<span>${reviewCount}건</span>
						</p>
					</div>

					<form id="reviewForm">
						<table>
							<thead>
								<tr>
									<th><input type="checkbox" id="selall"
										onchange="toggleCheckboxes(this)"></th>
									<th>작성자</th>
									<th>평점</th>
									<th>리뷰 내용</th>
									<th>작성일</th>
									<th>게시 상태</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty reviews}">
										<c:forEach var="review" items="${reviews}">
											<tr>
												<td><input type="checkbox" name="review_id"
													value="${review.user_name}" class="rowCheckbox"></td>
												<td>${review.user_name}</td>
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
							<input type="hidden" name="hbidx" value="${hbidx}"> 
							<input type="button" value="삭제하기" onclick="submitDeleteForm();">
							<input type="button" value="수정하기" onclick="submitEditForm();">
						</div>
					</form>

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
				</div>
			</div>
		</div>
	</div>
</body>
</html>
