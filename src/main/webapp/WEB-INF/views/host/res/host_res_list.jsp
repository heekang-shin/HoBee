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
					<option value="title">이름</option>
					<option value="content">문의 내용</option>
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
				전체<span>1</span>건
			</p>
		</div>

		<table>
			<thead>
				<tr>
					<th width="5%" class="line">번호</th>
					<th width="30%" class="line">프로그램명</th>
					<th width="30%" class="line">문의 제목</th>
					<th width="10%" class="line">작성자</th>
					<th width="10%" class="line">등록일</th>
					<th width="10%" class="line">답변상태</th>
				</tr>
			</thead>

			<tbody>
				<!-- 신청한 프로그램이 없는 경우 -->
				<c:if test="${empty inq_list and not empty search_list}">
				    <tr class="no-search">
				        <td colspan="6" class="line" style="text-align: center;">
				            등록된 1:1문의가 존재하지 않습니다.<br> 
				            <a href="inq_list.do" class="go-list">목록으로</a>
				        </td>
				    </tr>
				</c:if>


				<!-- 검색된 리스트가 없는 경우 -->
				<c:if test="${empty inq_list and empty search_list}">
				    <tr class="no-search">
				        <td colspan="6" class="line" style="text-align: center;">
				            검색된 1:1문의가 존재하지 않습니다.<br> 
				            <a href="inq_list.do" class="go-list">목록으로</a>
				        </td>
				    </tr>
				</c:if>


				<c:forEach var="vo" items="${res_list}">
					<tr>
						<td width="5%" class="line">${vo.id}</td>
						<td width="30%" class="line">${vo.hb_title}</td>
						<td width="30%" class="line">
							<a href="host_inq_detail.do?id=${vo.id}">${vo.title}</a>
						</td>
						<td width="10%" class="line">${vo.writer}</td>
						<td width="10%" class="line">${vo.created_date}</td>
						<td width="10%" class="line">
					    <!-- 답변 상태에 따라 링크 동적으로 설정 -->
						   <c:set var="btnClass" value="${fn:trim(vo.answer) == '' ? 'btn-answer' : 'btn-view'}" />
							<a href="host_inq_detail.do?id=${vo.id}" class="inq_btn ${btnClass}">
							    ${fn:trim(vo.answer) == '' ? '답변하기' : '답변보기'}
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>



	</div>



</body>
</html>