<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>호스트 사이드바</title>
	
	<!-- 스타일 시트 -->
	<link rel="stylesheet" href="/hobee/resources/css/admin/common.css">
	<link rel="stylesheet" href="/hobee/resources/css/admin/admin_sidebar.css">
	
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
                <img src="/hobee/resources/images/admin_icon.png" alt="프로필 이미지">
            </div>
            <div class="info-name">[관리자]&nbsp;${sessionScope.loggedInUser.user_name}</div>
        </div>
        
       <ul class="menu">
		    <li class="menu-item">
		        <img src="/hobee/resources/images/host_main.png" alt="메인">
		        <a href="main.do" class="menu-link">홈페이지 바로가기</a>
		    </li>
		    <li class="menu-item">
		        <img src="/hobee/resources/images/banner_icon.png" alt="배너 관리">
		        <a href="admin_banner.do" class="menu-link">배너 관리</a>
		    </li>
		    <li class="menu-item">
		       <img src="/hobee/resources/images/host_p.png" alt="회원 관리">
		        <a href="#" class="menu-link">회원 관리</a>
		    </li>
		    <li class="menu-item">
		        <img src="/hobee/resources/images/admin_host_icon.png" alt="호스트 관리">
		        <a href="#" class="menu-link">호스트 관리</a>
		    </li>
		    <li class="menu-item">
		         <img src="/hobee/resources/images/host_list.png" alt="프로그램 관리">
		        <a href="#" class="menu-link">프로그램 관리</a>
		    </li>
		     <li class="menu-item">
		        <img src="/hobee/resources/images/host_shop.png" alt="결제 관리">
		        <a href="#" class="menu-link">결제 관리</a>
		    </li>
		</ul>

    </div>
	</body>
	</html>
	