<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세보기</title>

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_list.css">
<link rel="stylesheet" href="/hobee/resources/css/host/pagination.css">
<!-- 헤더 -->
<script src="/hobee/resources/js/hostFunction.js"></script>
</head>

<script>

    // 모든 rowCheckbox 체크박스 선택/해제
    function toggleCheckboxes(selectAllCheckbox) {
        const checkboxes = document.querySelectorAll('.rowCheckbox');
        checkboxes.forEach(function(checkbox) {
            checkbox.checked = selectAllCheckbox.checked;
        });
    }

    function submitForm(userLevel) {
        let form = document.getElementById('reviewForm');

        // 기본 이벤트 중지 (중복 호출 방지)
        event.preventDefault();

        // 체크된 체크박스들 가져오기
        const checkboxes = document.querySelectorAll('.rowCheckbox:checked');
        const selectedIds = Array.from(checkboxes).map(checkbox => checkbox.value).join(',');

        if (selectedIds.length === 0) {
            alert("삭제할 항목을 선택하세요.");
            return;
        }

        // ✅ 삭제 메시지 동적 설정
        let message = "";
        if (userLevel === "호스트") {
            message = "선택한 리뷰를 삭제 요청하시겠습니까?";
        } else if (userLevel === "일반") {
            message = "선택한 리뷰를 삭제하시겠습니까?";
        } else if (userLevel === "관리자" || userLevel === "총괄관리자") {
            message = "선택한 리뷰를 즉시 삭제하시겠습니까?";
        }

        // ✅ confirm 실행 후 확인 버튼을 누르면 form을 제출
        if (!window.confirm(message)) {
            return; // 사용자가 취소하면 form 제출하지 않음
        }

        // ✅ action 설정 및 form 제출
        form.action = "deleteReview.do";
        form.submit();
    }

</script>

<body>
	<div id="wrapper">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>


		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/detail/review_sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="content">
			<div class="title-box">
				<h3>프로그램 목록</h3>
			</div>

			<!-- 대시보드 영역 -->
			<div class="dashboard">

				<!-- 검색창 시작 -->
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
							onkeypress="if(event.keyCode == 13){enterKey(this.form)}" />

						<!-- 검색 버튼 -->
						<input type="button" class="search-button" onclick="">
					</form>
				</div>

				<!-- 리스트 시작 -->
				<div class="table-container">
					<div class="total-num">
						<p>
							전체 <span>${reviewCount}건</span>
						</p>
					</div>

					<!-- 사용자 레벨에 따라 action URL 결정 -->
					<c:choose>
						<c:when test="${userLevel == '호스트'}">
							<c:set var="actionUrl" value="delmyReview.do" />
						</c:when>
						<c:otherwise>
							<c:set var="actionUrl" value="deleteReview.do" />
						</c:otherwise>
					</c:choose>

					<form id="reviewForm" action="deleteReview.do" method="post">
						<c:if test="${not empty reviews}">
							<table>
								<thead>
									<tr>
										<th><input type="checkbox" id="selall"
											onchange="toggleCheckboxes(this)"></th>
										<th>작성자</th>
										<th>평점</th>
										<th>리뷰 내용</th>
										<th>작성일</th>

										<!-- ✅ 로그인했으며 일반 사용자가 아닌 경우만 "게시 상태" 컬럼 표시 -->
										<c:if
											test="${not empty sessionScope.loggedInUser and sessionScope.loggedInUser.lv != '일반'}">
											<th>게시 상태</th>
										</c:if>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="review" items="${reviews}">
										<tr>
											<td><input type="checkbox" name="review_id"
												value="${review.review_id}" class="rowCheckbox"></td>
											<td>${review.user_name}</td>
											<td>${review.rating}점</td>
											<td>${review.content}</td>
											<td>${review.created_at}</td>

											<!-- ✅ 로그인했으며 일반 사용자가 아닌 경우만 "게시 상태" 값 표시 -->
											<c:if
												test="${not empty sessionScope.loggedInUser and sessionScope.loggedInUser.lv != '일반'}">
												<td><c:choose>
														<c:when test="${review.request_status == '대기'}">
															<span style="color: red;">삭제 요청됨</span>
														</c:when>
														<c:otherwise>
                        게시 중
                    </c:otherwise>
													</c:choose></td>
											</c:if>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:if>

						<!-- ✅ 삭제하기 버튼 유지 -->
						<div class="applybtn-box">
							<input type="hidden" name="hbidx" value="${hbidx}"> <input
								type="button" value="삭제하기" onclick="submitForm('${userLevel}');">

						</div>
					</form>


					<!-- 페이징 시작 -->
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
