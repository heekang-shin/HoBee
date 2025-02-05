<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>호스트 사이드바</title>
	<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
	<link rel="stylesheet" href="/hobee/resources/css/host/sidebar.css">
	</head>
	
	<body>
	<div class="sidebar">
        <div class="host-info">
            <div class="info-photo">
                <img src="/hobee/resources/images/host_img.png" alt="프로필 이미지">
            </div>
            <div class="info-name">SEOUL BREWERY</div>
        </div>
        <ul class="menu">
            <li>
                <img src="/hobee/resources/images/host_main.png" alt="메인">
                <a href="main.do">홈페이지 바로가기</a>
            </li>
            <li>
                <img src="/hobee/resources/images/host_p.png" alt="게시글 보기">
                <a href="hobee_detail.do?hbidx=${hbidx}">모임 정보</a>
            </li>
            <li>
                <img src="/hobee/resources/images/host_list.png" alt="리뷰 삭제">
                <a href="MyReviews.do?hbidx=${hbidx}">작성 한 리뷰</a> <!-- 마이페이지로 뺄 예정  -->
            </li>
        </ul>
    </div>
	</body>
	</html>
	