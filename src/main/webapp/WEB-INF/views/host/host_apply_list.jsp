<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신청페이지</title>

<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_list.css">

</head>
<body>
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
					<th width="5%" class="line">번호</th>
					<th width="10%" class="line">카테고리</th>
					<th width="10%" class="line">상세카테고리</th>
					<th class="line">프로그램명</th>
					<th width="10%" class="line">금액</th>
					<th width="10%" class="line">판매시작일</th>
					<th width="10%" class="line">판매종료일</th>
					<th width="10%" class="line">게시상태</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${apply}">
					<tr>
						<td class="line"><input type="checkbox"></td>
						<td width="5%" class="line">1</td>
						<td width="10%" class="line">운동</td>
						<td width="10%" class="line">스포츠</td>
						<td class="line">test</td>
						<td width="10%" class="line">5000원</td>
						<td width="10%" class="line">2024-00-00</td>
						<td width="10%" class="line">2024-00-00</td>
						<td width="10%" class="line">게시상태</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<!-- 신청 버튼 시작-->
	<div class="applybtn-box">
		<input type="button" value="삭제하기" onclick="loc">
		<input type="button" value="신청하기" onclick="location.href='host_apply_form.do'">
	</div>
	<!-- 신청 버튼 끝 -->
</body>
</html>