<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="/hobee/resources/css/inven.css">
<link rel="icon" href="/hobee/resources/images/Favicon.png">
<link rel="stylesheet" href="/hobee/resources/css/main.css">

<script src="/hobee/resources/js/httpRequest.js"></script>

<script>
	window.onload = function(){
		let search = document.getElementById("array_select");
		search.value = '${param.arr}';
	  }

	        function open_payment() {
	            // 새 창의 URL 설정
	            const url = 'payment.do'; // 스프링 컨트롤러에서 처리할 URL
	            const options = 'width=680,height=700,top=150,left=580';
	            window.open(url, '_blank', options);
	        }
	        
	        document.addEventListener('DOMContentLoaded', () => {
	            const buttons = document.querySelectorAll('.nav ul li button');
	            const sections = document.querySelectorAll('.content');
	
	            // 기본적으로 '전체 보기' 버튼 활성화
	            const defaultButton = document.querySelector('.nav ul li button[data-category="all"]');
	            defaultButton.classList.add('active');
	
	            // 모든 섹션 활성화
	            sections.forEach(section => section.classList.add('active'));
	
	            buttons.forEach(button => {
	                button.addEventListener('click', () => {
	                    const category = button.getAttribute('data-category');
	
	                    // 모든 버튼에서 'active' 클래스 제거
	                    buttons.forEach(btn => btn.classList.remove('active'));
	
	                    // 현재 클릭된 버튼에 'active' 클래스 추가
	                    button.classList.add('active');
	
	                    // 섹션 필터링
	                    sections.forEach(section => {
	                        if (category === 'all' || section.getAttribute('data-category') === category) {
	                            section.classList.add('active');
	                        } else {
	                            section.classList.remove('active');
	                        }
	                    });
	                });
	            });
	        });
	     
	        function changeArr() {
	        	let selArr = document.getElementById("array_select").value;
	        	let bigcategory = (${cate_list[0].bigcategory});
	        	
	        	location.href="select_list.do?category="+bigcategory+
			      "&arr="+selArr;
	        	
	        }
	        
	        
	    </script>

</head>
<body>

	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
	<!--카테고리 시작-->
	<div class="menu_wrap">
		<div class="menu_container">
			<ul class="menu_box aboutinner aos-item" data-aos="fade-up">
				<li><img src="/hobee/resources/images/sport_icon.png"
					alt="sport" onclick="location.href='select_list.do?category=1'">
					<a href="select_list.do?category=1">운동&#47;스포츠</a></li>

				<li><img src="/hobee/resources/images/music_icon.png"
					alt="music" onclick="location.href='select_list.do?category=2'">
					<a href="select_list.do?category=2">음악&#47;악기</a></li>

				<li><img src="/hobee/resources/images/crafts_icon.png"
					alt="craft" onclick="location.href='select_list.do?category=3'">
					<a href="select_list.do?category=3">공예&#47;만들기</a></li>

				<li><img src="/hobee/resources/images/self_icon.png" alt="self"
					onclick="location.href='select_list.do?category=4'"> <a
					href="select_list.do?category=4">자기계발</a></li>

				<li><img src="/hobee/resources/images/game_icon.png" alt="game"
					onclick="location.href='select_list.do?category=5'"> <a
					href="select_list.do?category=5">게임&#47;오락</a></li>

				<li><img src="/hobee/resources/images/gathering_icon.png"
					alt="gathering" onclick="location.href='select_list.do?category=6'">
					<a href="select_list.do?category=6">사교</a></li>
			</ul>
		</div>
	</div>
	<!--카테고리 끝-->
	<div class="inven_container">
		<div class="sidebar">
			<nav class="nav">
				<ul>
					<li><button data-category="all">전체 보기</button></li>
					<c:forEach var="vo" items="${cate_list}">
						<li><button data-category="${vo.category_num}">${vo.category_name}</button></li>
					</c:forEach>
				</ul>
			</nav>
		</div>

		<main class="main-content">

			<select id="array_select" onchange="changeArr();">
				<option value="new">최신순</option>
				<option value="best">인기순</option>
			</select>

			<c:forEach var="vo" items="${hobee_list}">
				<section class="content" id="select-cate"
					data-category="${vo.category_num}">
					<div class="con_box aboutinner aos-item" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/${vo.s_image}.png"
							alt="thumbnail">
						<h2>${vo.hb_title}</h2>
						<p>${vo.hb_price}원</p>
						<span>1인당</span>
					</div>
				</section>
			</c:forEach>
		</main>
	</div>
	<br>

	<input type="button" value="결제하기" onclick="open_payment()">
	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
</body>
</html>