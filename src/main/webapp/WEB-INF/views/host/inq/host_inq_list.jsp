<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>문의페이지</title>
	
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
				<input type="button" class="search-button" onclick="enterKey(this.form);">
	
			</form>
		</div>
	</body>
</html>