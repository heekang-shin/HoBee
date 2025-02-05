<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세보기</title>

<!-- 공통 css -->
<link rel="stylesheet" href="/hobee/resources/css/common.css">

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- review detail css -->
<link rel="stylesheet" href="/hobee/resources/css/detail_review.css">

<!-- 스크립트 -->
<script src="/hobee/resources/js/hostFunction.js"></script>

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
            event.preventDefault();

            // 체크된 체크박스 가져오기
            const checkboxes = document.querySelectorAll('.rowCheckbox:checked');
            const selectedIds = Array.from(checkboxes).map(checkbox => checkbox.value).join(',');

            if (selectedIds.length === 0) {
                alert("삭제할 항목을 선택하세요.");
                return;
            }

            // 삭제 메시지 설정
            let message = "";
            if (userLevel === "호스트") {
                message = "선택한 리뷰를 삭제 요청하시겠습니까?";
            } else if (userLevel === "일반") {
                message = "선택한 리뷰를 삭제하시겠습니까?";
            } else if (userLevel === "관리자" || userLevel === "총괄관리자") {
                message = "선택한 리뷰를 즉시 삭제하시겠습니까?";
            }

            if (!window.confirm(message)) {
                return;
            }

            // 폼 전송
            form.action = "deleteReview.do";
            form.submit();
        }
    </script>
</head>

<body>
	
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>

		<!-- 사이드바 
        <jsp:include page="/WEB-INF/views/detail/review_sidebar.jsp"></jsp:include>-->

		<!-- 컨텐츠 영역 -->
		<div class="content">
			<div class="title-box">
				<h3>리뷰</h3>
			</div>

			<!-- 대시보드 영역 -->
			<div class="dashboard">
				<!-- 리스트 시작 -->
				<div class="table-container">
					<div class="total-num">
						<p>
							리뷰&nbsp;<span>${reviewCount}건</span>
						</p>
					</div>

					<form id="reviewForm" action="deleteReview.do" method="post">
						<c:if test="${not empty reviews}">
							<table>
								<thead>
									<tr>
										<th width="5%" class="line"><input type="checkbox"
											id="selall" onchange="toggleCheckboxes(this)"></th>
										<th width="15%" class="line">작성자</th>
										<th width="10%" class="line">평점</th>
										<th width="40%" class="line">리뷰 내용</th>
										<th width="15%" class="line">작성일</th>

										<!-- ✅ 게시 상태 표시 조건 -->
										<c:if
											test="${not empty sessionScope.loggedInUser 
                                                     and (sessionScope.loggedInUser.lv != '일반' 
                                                     or sessionScope.loggedInUser.id == hostUserId)}">
											<th width="15%">게시 상태</th>
										</c:if>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="review" items="${reviews}">
										<tr>
											<td width="5%"><input type="checkbox" name="review_id"
												value="${review.review_id}" class="rowCheckbox"></td>
											<td width="15%">${review.user_name}</td>
											<td width="10%">${review.rating}점</td>
											<td width="40%" style="text-align: left;">${review.content}</td>
											<td width="15%">${review.created_at}</td>

											<!-- ✅ 게시 상태 표시 -->
											<c:if
												test="${not empty sessionScope.loggedInUser 
                                                         and (sessionScope.loggedInUser.lv != '일반' 
                                                         or sessionScope.loggedInUser.id == hostUserId)}">
												<td width="15%"><c:choose>
														<c:when
															test="${not empty review.request_status and review.request_status == '대기'}">
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

						<!-- ✅ 삭제 버튼 -->
						<div class="applybtn-box">
							<input type="hidden" name="hbidx" value="${hbidx}"> <input
								type="button" value="삭제하기"
								onclick="submitForm('${userLevel}', '${hostUserId}');">
						</div>
					</form>


				</div>



			</div>
		</div>

	
 <!-- 푸터 -->
        <jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>

	
</body>
</html>
