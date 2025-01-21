<%@page import="kh.pr.hobee.vo.UsersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신청페이지</title>

<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_list.css">

<script>
	// 검색창 동작
	function enterKey(f) {
	    // 유효성 체크
	    let searchInput = f.search_text.value;
	    if (searchInput === '') {
	        alert('검색어를 입력해 주세요.');
	        return; // 기본 동작 중단
	    }
	
	    f.action = "host_search.do";
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
					<option value="title">제목</option>
					<option value="content">내용</option>
				</select>
			</div>

			<!-- 검색 입력 필드 -->
			<input id="search" type="search" placeholder="검색어를 입력해 주세요."
				name="search_text" class="search-input"
				onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}" />

			<!-- 검색 버튼 -->
			<input type="button" class="search-button" onclick="enterKey(this.form);">

		</form>
	</div>

	<!-- 리스트 시작 -->
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
                <th width="10%" class="line">카테고리</th>
                <th width="25%" class="line" >프로그램명</th>
                <th width="10%" class="line">금액</th>
                <th width="10%" class="line">시작 날짜</th>
                <th width="10%" class="line">시작 시간</th>
                <th width="20%" class="line">작성일</th>
                <th width="10%" class="line">판매상태</th>
            </tr>
        </thead>

        <tbody>
        <!-- 로그인된 id만 동일한 경우만 list 노출  -->
		

            <!-- 신청한 프로그램이 없는 경우 -->
            <c:if test="${empty apply_list && empty search_list}">
			    <tr class="no-search">
			        <td colspan="8" class="line" style="text-align: center;" >검색된 프로그램이 존재하지 않습니다.<br>
			       	 <a href="host_list.do" class="go-list">목록으로</a>
			        </td>
			    </tr>
			</c:if>


            <c:forEach var="vo" items="${apply_list}" varStatus="status">
                <tr>
	               	<!-- totalItems에서 현재 반복 순서를 빼서 최신순으로 표시 -->
        			<td width="5%" class="line">${startIdx - status.index}</td>
	                <td width="10%" class="line">${vo.category_name}</td>
	                <td width="25%" class="line" style="text-align: left;">
	                	<a href="host_apply_detail.do?hb_idx=${vo.hb_idx}">${vo.hb_title}</a>
	                </td>
	                <td width="10%" class="line" ><fmt:formatNumber value="${vo.hb_price}"/> 원</td>
	                <td width="10%" class="line">${vo.hb_date}</td>
	                <td width="10%" class="line">${vo.hb_time}</td>
	                <td width="20%" class="line">${vo.hb_write_date}</td>
	                 
	                 <td width="10%" class="line post-box">
					    <c:choose>
					        <c:when test="${vo.status == 0}">
					           <span class="fin-btn">신청완료</span>
					        </c:when>
					        <c:when test="${vo.status == 1}">
					            <span class="post-btn">게시중</span>
					        </c:when>
					        <c:when test="${vo.status == 2}">
					            <span class="post-reject">게시불가</span>
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


	<!-- 신청 버튼 시작-->
	<div class="applybtn-box">
		<input type="button" value="취소하기" onclick="location.href='host_list.do'">
		<input type="button" value="신청하기" onclick="location.href='host_apply_form.do'">
	</div>
	<!-- 신청 버튼 끝 -->
</body>
</html>