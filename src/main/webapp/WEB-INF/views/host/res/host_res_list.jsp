<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의페이지</title>

<!-- 스타일 시트 -->
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet" href="/hobee/resources/css/host/host_res_list.css">

<script>
function enterKey(f) {
    // 유효성 체크
    let searchInput = f.search_text.value;
    if (searchInput === '') {
        alert('검색어를 입력해 주세요.');
        return; // 기본 동작 중단
    }

    f.action = "res_search.do";
    f.method = "get";
    f.submit(); 
}
</script>

</head>
<body>
	<!-- 검색창 시작-->
	<div class="search-container">
		<form>
			<!-- 드롭다운 메뉴 -->
			<div class="select-box">
				<select class="search-select" name="search_category">
					<option value="all">전체</option>
					<option value="title">프로그램명</option>
					<option value="content">신청자명</option>
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

	<!-- 리스트  -->
	<div class="table-container">
		<div class="total-num">
			<p>
				전체<span>&nbsp;${totalItems}</span>건
			</p>
		</div>

		<table>
			<thead>
				<tr>
					<th width="10%" class="line">번호</th>
					<th width="30%" class="line">프로그램명</th>
					<th width="15%" class="line">신청자명</th>
					<th width="15%" class="line">신청자 아이디</th>
					<th width="15%" class="line">신청일</th>
					<th width="15%" class="line">신청 금액</th>
				</tr>
			</thead>

			<tbody>
				<!-- 신청한 프로그램이 없는 경우-->
				<c:if test="${empty res_list and not empty search_list }">
				    <tr class="no-search">
				        <td colspan="6" class="line" style="text-align: center;">
				            등록된 신청자가 존재하지 않습니다.<br> 
				            <a href="res_list.do" class="go-list">목록으로</a>
				        </td>
				    </tr>
				</c:if>
				 

				<!-- 검색된 리스트가 없는 경우 -->
				<c:if test="${empty res_list and empty search_list}">
				    <tr class="no-search">
				        <td colspan="6" class="line" style="text-align: center;">
				            검색된 신청 내역은 존재하지 않습니다.<br> 
				            <a href="res_list.do" class="go-list">목록으로</a>
				        </td>
				    </tr>
				</c:if>


				<c:forEach var="vo" items="${res_list}" begin="0" end="11" varStatus="status">
					<tr>
						<!-- totalItems에서 현재 반복 순서를 빼서 최신순으로 표시 -->
	        			<td width="10%" class="line">${startIdx - status.index}</td>
						<td width="30%" class="line">${vo.hb_title}</td>
						<td width="15%" class="line">${vo.user_name}</td>
						<td width="15%" class="line">${vo.user_id}</td>
						<td width="15%" class="line">${vo.reserve_date}</td>
						<td width="15%" class="line"><fmt:formatNumber value="${vo.price}"/> 원</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>



	</div>



</body>
</html>