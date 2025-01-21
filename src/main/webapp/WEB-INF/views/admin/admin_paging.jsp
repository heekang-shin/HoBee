<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 스타일 시트 -->
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet" href="/hobee/resources/css/host/pagination.css">

</head>

<body>
	<div class="pagination">
    <!-- 첫 페이지 버튼 -->
    <c:choose>
        <c:when test="${currentPage > 1}">
            <a href="?page=1&user_Id=${user_Id}" class="first-page">&#60;&#60;</a>
        </c:when>
        <c:otherwise>
            <span class="first-page disabled">&#60;&#60;</span>
        </c:otherwise>
    </c:choose>

    <!-- 이전 페이지 버튼 -->
    <c:choose>
        <c:when test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}&user_Id=${user_Id}" class="prev-page">&#60;</a>
        </c:when>
        <c:otherwise>
            <span class="prev-page disabled">&#60;</span>
        </c:otherwise>
    </c:choose>

    <!-- 현재 페이지 -->
    <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
            <c:when test="${i == currentPage}">
                <span class="current-page">${i}</span>
            </c:when>
            <c:otherwise>
                <a href="?page=${i}&user_Id=${user_Id}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 페이지 버튼 -->
    <c:choose>
        <c:when test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}&user_Id=${user_Id}" class="next-page">&#62;</a>
        </c:when>
        <c:otherwise>
            <span class="next-page disabled">&#62;</span>
        </c:otherwise>
    </c:choose>

    <!-- 마지막 페이지 버튼 -->
    <c:choose>
        <c:when test="${currentPage < totalPages}">
            <a href="?page=${totalPages}&user_Id=${user_Id}" class="last-page">&#62;&#62;</a>
        </c:when>
        <c:otherwise>
            <span class="last-page disabled">&#62;&#62;</span>
        </c:otherwise>
    </c:choose>
</div>




</body>
</html>