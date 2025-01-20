<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>호스트 사이드바</title>
	
	<!-- 스타일 시트 -->
	<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
	<link rel="stylesheet" href="/hobee/resources/css/host/sidebar.css">
	
	<script>
	document.addEventListener('DOMContentLoaded', () => {
	    const menuItems = document.querySelectorAll('.menu-item a'); // 모든 메뉴 링크 선택
	    const currentUrl = window.location.pathname; // 현재 페이지의 URL 경로 가져오기

	    menuItems.forEach(link => {
	        if (link.getAttribute('href') === currentUrl) { // 현재 URL과 비교
	            link.parentElement.classList.add('active'); // li 태그에 active 클래스 추가
	        }
	    });
	});
	</script>
	
	
	
	</head>
	
	<body>
	<div class="sidebar">
        <div class="host-info">
            <div class="info-photo">
                <img src="/hobee/resources/images/host_img.png" alt="프로필 이미지">
            </div>
            <div class="info-name">[호스트]&nbsp;${sessionScope.loggedInUser.user_name}</div>
        </div>
        
      <ul class="menu">
	    <li class="menu-item ${currentUrl == '/hobee/host_main.do' ? 'active' : ''}">
	        <img src="/hobee/resources/images/host_main.png" alt="메인">
	        <a href="/hobee/host_main.do" class="menu-link">호스트센터 바로가기</a>
	    </li>
	    <li class="menu-item ${currentUrl == '/hobee/host_info.do' ? 'active' : ''}">
	        <img src="/hobee/resources/images/host_p.png" alt="호스트 정보">
	        <a href="/hobee/host_info.do" class="menu-link">호스트 정보</a>
	    </li>
	    <li class="menu-item ${currentUrl == '/hobee/host_list.do' ? 'active' : ''}">
	        <img src="/hobee/resources/images/host_list.png" alt="프로그램 신청">
	        <a href="/hobee/host_list.do" class="menu-link">프로그램 신청</a>
	    </li>
	    <li class="menu-item ${currentUrl == '/hobee/res_list.do' ? 'active' : ''}">
	        <img src="/hobee/resources/images/host_shop.png" alt="신청자 관리">
	        <a href="/hobee/res_list.do" class="menu-link">신청자 관리</a>
	    </li>
	    <li class="menu-item ${currentUrl == '/hobee/inq_list.do' ? 'active' : ''}">
	        <img src="/hobee/resources/images/host_inquiry.png" alt="문의 관리">
	        <a href="/hobee/inq_list.do" class="menu-link">문의 관리</a>
	    </li>
	</ul>


    </div>
	</body>
	</html>
	