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
	    // 모든 메뉴 항목 가져오기
	    const menuItems = document.querySelectorAll('.menu-item');
	
	    // 클릭 이벤트 추가
	    menuItems.forEach(item => {
	        item.addEventListener('click', () => {
	            // 모든 메뉴에서 active 클래스 제거
	            menuItems.forEach(i => i.classList.remove('active'));
	
	            // 클릭된 메뉴에 active 클래스 추가
	            item.classList.add('active');
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
            <div class="info-name">SEOUL BREWERY</div>
        </div>
        
       <ul class="menu">
		    <li class="menu-item">
		        <img src="/hobee/resources/images/host_main.png" alt="메인">
		        <a href="main.do" class="menu-link">홈페이지 바로가기</a>
		    </li>
		    <li class="menu-item">
		        <img src="/hobee/resources/images/host_p.png" alt="호스트 정보">
		        <a href="host_info.do" class="menu-link">호스트 정보</a>
		    </li>
		    <li class="menu-item">
		        <img src="/hobee/resources/images/host_list.png" alt="프로그램 신청">
		        <a href="host_list.do" class="menu-link">프로그램 신청</a>
		    </li>
		    <li class="menu-item">
		        <img src="/hobee/resources/images/host_shop.png" alt="신청자 관리">
		        <a href="rev_list.do" class="menu-link">신청자 관리</a>
		    </li>
		    <li class="menu-item">
		        <img src="/hobee/resources/images/host_inquiry.png" alt="문의 관리">
		        <a href="inq_list.do" class="menu-link">문의 관리</a>
		    </li>
		</ul>

    </div>
	</body>
	</html>
	