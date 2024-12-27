<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee&nbsp;모임신청페이지</title>

<script src="/hobee/resources/js/main.js"></script>

<script>
    const paginationLinks = document.querySelectorAll('.pagination a');
    
    paginationLinks.forEach(link => {
        link.addEventListener('click', (event) => {
            event.preventDefault();

            // 모든 링크의 active 클래스 제거
            paginationLinks.forEach(item => item.classList.remove('active'));
            
            // 클릭된 링크에 active 클래스 추가
            link.classList.add('active');
        });
    });
</script>

<link rel="icon" href="/hobee/resources/images/Favicon.png">
<link rel="stylesheet" href="/hobee/resources/css/main.css">
<link rel="stylesheet" href="/hobee/resources/css/apply.css">
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
	<!-- 검색창 끝 -->


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
					<th width="8%" class="line">번호</th>
					<th width="10%" class="line">답변여부</th>
					<th width="10%" class="line">카테고리</th>
					<th class="line">제목</th>
					<th width="10%" class="line">작성자</th>
					<th width="10%"class="line">작성일</th>
				</tr>
			</thead>

			<tbody>
			<tr>
			<!-- 리스트가 있는 경우 -->
			<c:forEach begin="1" end="10">
				
			</c:forEach>
			<tr>
			</tbody>
		</table>
	</div>
	<!-- 리스트 끝 -->

	<!-- 신청 버튼 시작-->
	<div class="applybtn-box">
		<input type="button" value="신청하기" onclick="location.href='apply_form.do'">
	</div>
	<!-- 신청 버튼 끝 -->

	<!--페이징 시작-->
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
	<!-- 페이징 끝 -->
	
	
</body>
</html>