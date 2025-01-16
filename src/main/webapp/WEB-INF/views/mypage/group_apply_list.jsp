<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 신청 내역</title>

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 시트 -->
<link rel="stylesheet" href="/hobee/resources/css/main.css">

<!-- 신청내역 스타일 시트  -->
<link rel="stylesheet"
	href="/hobee/resources/css/mypage/group_apply_list.css">

<script>
	function apply_cancel(reserveId) {
		if (confirm("정말 취소하시겠습니까?")) {

			alert("취소되었습니다.");
			location.href = 'mypage_apply_delete.do?reserve_id=' + reserveId;
		}
	}
</script>

</head>


<body>

	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>


	<!--메뉴 인클루드  -->
	<jsp:include page="mypage_index.jsp" />


	<!--신청 게시판   -->
	<table>
		<colgroup>
			<col width="10%" />
			<col width="1%" />

			<col width="" />
			<col width="1%" />

			<col width="15%" />
			<col width="1%" />

			<col width="15%" />
			<col width="1%" />

			<col width="5%" />
			<col width="1%" />

			<col width="10%" />
		</colgroup>



		<thead>

			<tr>
				<th class="sin" colspan="11">신청내역</th>

			</tr>

			<tr>
				<th>카테고리</th>
				<th><img src="/hobee/resources/images/sin.png"></th>

				<th>프로그램명</th>
				<th><img src="/hobee/resources/images/sin.png"></th>

				<th>일시</th>
				<th><img src="/hobee/resources/images/sin.png"></th>

				<th>신청일시</th>
				<th><img src="/hobee/resources/images/sin.png"></th>

				<th>가격</th>
				<th><img src="/hobee/resources/images/sin.png"></th>

				<th>참가취소</th>
			</tr>
		</thead>

		<tbody>
			 	<c:forEach var="vo" items="${apply_finish}">

				<tr>
					<td colspan="2">${vo.category_name}</td>
					<td colspan="2">${vo.hb_title}</td>
					<td colspan="2">${vo.hb_date}</td>
					 <td colspan="2">${vo.reserve_date}</td> 
					 <td colspan="2">${vo.price}</td>
					<td colspan="2"><input type="button" value="취소하기"
						onclick="apply_cancel('${vo.reserve_id}')"></td>
				</tr>


			</c:forEach> 
			

		</tbody>

	</table>
	
<!-- 페이징 버튼 -->
<div class="pagination">
    <c:if test="${currentPage > 1}">
        <a href="?page=${currentPage - 1}&user_Id=${sessionScope.loggedInUser.user_Id}">이전</a>
    </c:if>
    
    <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
            <c:when test="${i == currentPage}">
                <span class="current-page">${i}</span>
            </c:when>
            <c:otherwise>
                <a href="?page=${i}&user_Id=${sessionScope.loggedInUser.user_Id}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    
    <c:if test="${currentPage < totalPages}">
        <a href="?page=${currentPage + 1}&user_Id=${sessionScope.loggedInUser.user_Id}">다음</a>
    </c:if>
</div>



	<!--푸터  -->

	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>


</body>
</html>