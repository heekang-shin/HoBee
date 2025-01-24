<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Hobee:관리자 페이지</title>
	
	<!-- 파비콘 -->
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	
	
<!-- 공통 스타일 -->
<link rel="stylesheet" href="/hobee/resources/css/admin/admin_main.css">
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet"
	href="/hobee/resources/css/host/host_apply_list.css">

<!-- 헤더 스크롤 이펙트-->
<script src="/hobee/resources/js/hostFunction.js"></script>
<!-- <script>
	function enterKey(f) {
	    // 유효성 체크
	    let searchInput = f.search_text.value;
	    if (searchInput === '') {
	        alert('검색어를 입력해 주세요.');
	        return; // 기본 동작 중단
	    }
	
	    f.action = "admin_user_search.do"; 
	    f.method = "get";
	    f.submit(); 
	}
	</script>
 -->
</head>

<body>
	<div id="wrapper">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/admin/admin_header.jsp"></jsp:include>

		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/admin/admin_sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="content">
			<div class="title-box">
				<img src="/hobee/resources/images/admin_title_icon.png">
				<h3>호스트 관리</h3>
			</div>

			<!--대시보드 영역 -->
			<div class="dashboard">

				<!-- 검색창 시작-->
				<div class="search-container">
					<form>
						<!-- 드롭다운 메뉴 -->
						<div class="select-box">
							<select class="search-select" name="search_category">
								<option value="all">전체</option>
								<option value="title">이름</option>
								<option value="content">아이디</option>
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
								<th width="5%" class="line">번호</th>
								<th width="15%" class="line">호스트 이름</th>
								<th width="15%" class="line">유저 번호</th>
								<th width="15%" class="line">유저 이름</th>
								<th width="15%" class="line">연락처</th>
								<th width="20%" class="line">이메일</th>
								<th width="15%" class="line">등급</th>
								
							</tr>
						</thead>
						
						<tbody>
						
						<!-- user_list만 비어 있는 경우 -->
						<c:if test="${empty all_host_list and not empty search_list}">
						    <tr class="no-search">
						        <td colspan="7" class="line" style="text-align: center;">
						            등록된 호스트가 존재하지 않습니다.<br> 
						            <a href="admin_host.do" class="go-list">목록으로</a>
						        </td>
						    </tr>
						</c:if>
						
						<!-- search_list만 비어 있는 경우 -->
						<c:if test="${empty all_host_list && empty search_list}">
						    <tr class="no-search">
						        <td colspan="7" class="line" style="text-align: center;">
						            검색된 호스트가 존재하지 않습니다.<br> 
						            <a href="admin_host.do" class="go-list">목록으로</a>
						        </td>
						    </tr>
						</c:if>


						<!-- 리스트 조회 -->
						<c:forEach var="vo" items="${all_host_list}" varStatus="status">
							<tr>
								<!-- idx 계산: 전체 항목에서 현재까지 노출된 항목을 뺀 값 -->
								<td width="5%" class="line">
									${startIdx - status.index}
								</td>
								<td width="15%" class="line">
									<a href="hostInfo_detail.do?user_id=${vo.user_id}">${vo.user_id}</a>
								</td>
								<td width="15%" class="line">
									<a href="hostInfo_detail.do?user_id=${vo.user_id}">${vo.host_name}</a>
								</td>
								<td width="15%" class="line">
									<a href="hostInfo_detail.do?user_id=${vo.user_id}">${vo.user_name}</a>
								</td>
								<td width="15%" class="line">
									<a href="hostInfo_detail.do?user_id=${vo.user_id}">${vo.phone}</a>
								</td>
								<td width="15%" class="line">
									<a href="hostInfo_detail.do?user_id=${vo.user_id}">${vo.user_email}</a>
								</td>
								
								<td width="10%" class="line post-box">
									<c:choose>
									<c:when test="${vo.lv.toString() == '호스트'}">
										<span class="fin-btn">호스트</span>
									</c:when>
									<c:when test="${vo.lv ne '호스트'}">
										<span class="post-btn">심사대기</span>
									</c:when>
									<c:otherwise>
										<span class="post-no">확인 불가</span>
									</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
					</table>
					
				</div>
				<!-- 리스트 끝 -->
				
				<!-- 페이징 -->
				<jsp:include page="/WEB-INF/views/admin/admin_paging.jsp"></jsp:include>
			</div>
		</div>
	</div>
</body>
</html>