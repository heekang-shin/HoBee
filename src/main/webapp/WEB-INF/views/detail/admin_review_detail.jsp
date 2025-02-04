<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 리뷰 삭제 요청 목록</title>

<!-- 스타일 및 스크립트 -->
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<script src="/hobee/resources/js/hostFunction.js"></script>
<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/admin/admin_header.jsp"></jsp:include>

<script>
    function approveDelete(reviewId) {
        if (confirm("이 리뷰 삭제 요청을 승인하시겠습니까?")) {
            location.href = "approveDeleteRequest.do?review_id=" + reviewId;
        }
    }

    function rejectDelete(reviewId) {
        if (confirm("이 리뷰 삭제 요청을 거부하시겠습니까?")) {
            location.href = "rejectDeleteRequest.do?review_id=" + reviewId;
        }
    }
    
</script>

</head>
<body>
	<div id="wrapper">
		<!-- 관리자 사이드바 -->
		<jsp:include page="/WEB-INF/views/admin/admin_sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="content">
			<div class="title-box">
				<h3>삭제 요청된 리뷰 관리</h3>
			</div>

				<table>
					<thead>
						<tr>
							<th>작성자</th>
							<th>평점</th>
							<th>리뷰 내용</th>
							<th>삭제 요청한 호스트</th>
							<th>작성일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="review" items="${deleteRequests}">
							<tr>
								<td>${review.user_name}</td>
								<td>${review.rating}점</td>
								<td>${review.content}</td>
								<td>${review.requested_by}</td>
								<td>${review.created_at}</td>
								<td>
									<button onclick="approveDelete(${review.review_id})">승인</button>
									<button onclick="rejectDelete(${review.review_id})">거부</button>
								</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>

			</div>
		</div>
	</div>
</body>
</html>
