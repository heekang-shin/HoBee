<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hobee</title>

<script src="/hobee/resources/js/main.js"></script>
<script src="/hobee/resources/js/jquery-2.1.3.min.js"></script>
<script src="/hobee/resources/dist/aos.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	var slideIndex = 1;
	showSlides(slideIndex);

	function plusSlides(n) {
		showSlides(slideIndex += n);
	}

	function currentSlide(n) {
		showSlides(slideIndex = n);
	}

	function showSlides(n) {
		var i;
		var slides = document.getElementsByClassName("mySlides");
		var dots = document.getElementsByClassName("dot");
		if (n > slides.length) {
			slideIndex = 1
		}
		if (n < 1) {
			slideIndex = slides.length
		}
		for (i = 0; i < slides.length; i++) {
			slides[i].style.display = "none";
		}
		for (i = 0; i < dots.length; i++) {
			dots[i].className = dots[i].className.replace(" active", "");
		}
		slides[slideIndex - 1].style.display = "block";
		dots[slideIndex - 1].className += " active";
	}
</script>

<script>
	$(document).ready(function() {

		var slideIndex = 0;
		showSlides();

		function showSlides() {
			var i;
			var slides = document.getElementsByClassName("mySlides");
			for (i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			slideIndex++;
			if (slideIndex > slides.length) {
				slideIndex = 1
			}
			slides[slideIndex - 1].style.display = "block";
			setTimeout(showSlides, 6000); // Change image every 2 seconds
		}

	});

	<!--검색창-->
	function enterKey(f) {

		//유효성 체크
		let searchInput = f.search_text.value;
		if (searchInput.trim() === '') {
			alert('검색어를 입력해 주세요.');
			return;
		}

		f.action = "search.do";
		f.method = "get";
		f.sumbit();

		$("#id").reset();
	}
</script>

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- css -->
<link rel="stylesheet" href="/hobee/resources/css/common.css">
<link rel="stylesheet" href="/hobee/resources/dist/aos.css" />

</head>

<body>
	<!-- 헤더 시작-->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
	<!-- 헤더 끝 -->

	<!--슬라이드 배너 시작-->
	<div class="slideshow-container">
		<!--배너1-->
		<div class="mySlides fade">
			<img src="/hobee/resources/images/main_banner1.png" alt="" />

			<div class="text">
				<h1 class="inner aos-item" data-aos="fade-up">스키로 떠나는 겨울 여행!</h1>
				<p class="inner aos-item" data-aos="fade-up">
					새로운 사람들과 함께 즐기는 겨울 스포츠! <br>초보자도 환영, 친구들과 멋진 시간을 보내며 겨울을 만끽해
					보세요.
				</p>
				<a href="#" class="inner aos-item" data-aos="fade-up">더 알아보기</a>
			</div>
		</div>


		<!--배너2-->
		<div class="mySlides fade">
			<img src="/hobee/resources/images/main_banner2.png" alt="" />
			<div class="text">
				<h1 class="inner aos-item" data-aos="fade-up">와인과 함께하는 멋진 밤!</h1>
				<p class="inner aos-item" data-aos="fade-up">
					함께하는 순간이 특별해지는 와인 파티!<br>다양한 와인을 경험하며 소소한 즐거움을 나눠보세요.
				</p>
				<a href="#" class="inner aos-item" data-aos="fade-up">더 알아보기</a>
			</div>
		</div>

		<!--배너3-->
		<div class="mySlides fade">
			<img src="/hobee/resources/images/main_banner3.png" alt="" />

			<div class="text">
				<h1 class="inner aos-item" data-aos="fade-up">보드게임과 함께하는 특별한
					시간!</h1>
				<p class="inner aos-item" data-aos="fade-up">
					전략, 협력, 그리고 웃음이 가득한 시간.<br>게임을 사랑하는 사람들과 함께라면 매 순간이 즐겁습니다.
				</p>
				<a href="#" class="inner aos-item" data-aos="fade-up">더 알아보기</a>
			</div>

		</div>

		<!-- 좌우버튼 -->
		<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a class="next"
			onclick="plusSlides(1)">&#10095;</a>

		<!-- 점 -->
		<div id="dot">
			<span class="dot" onclick="currentSlide(1)"></span> <span class="dot"
				onclick="currentSlide(2)"></span> <span class="dot"
				onclick="currentSlide(3)"></span>
		</div>

	</div>
	<!--슬라이드 배너 끝-->


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

	<!--best 시작-->
	<div class="con_container">

		<div class="con_header">
			<h1>주간 인기 BEST</h1>
			<a href="#">전체보기</a>
		</div>

		<!-- 베스트 제품이 없는 경우-->
		<c:if test="${ empty best_list }">
			<div>등록된 제품이 없습니다.</div>
		</c:if>


		<!-- 베스트 제품이 있는 경우 -->
		<div class="con_wrapper">
			<c:forEach var="vo" items="${best_list}" begin="0" end="3">
				<div class="con_box aboutinner aos-item best" data-aos="fade-up"
					onclick="">
					<img src="/hobee/resources/images/${vo.s_image}.png"
						alt="thumbnail">
					<h2>${vo.hb_title}</h2>
					<p>
						<fmt:formatNumber value="${vo.hb_price}" />
						원
					</p>
					<span>1인당</span>
				</div>
			</c:forEach>
		</div>
	</div>
	<!--best 끝-->

	<!--pick 시작-->
	<div class="con_container">

		<div class="con_header">
			<h1>HOBEE들의 픽</h1>
			<a href="#">전체보기</a>
		</div>

		<!-- pick 제품이 없는 경우-->
		<c:if test="${ empty pick_list }">
			<div>등록된 제품이 없습니다.</div>
		</c:if>

		<!-- pick 제품이 있는 경우 -->
		<div class="con_wrapper">
			<c:forEach var="vo" items="${pick_list}" begin="0" end="3">
				<div class="con_box aboutinner aos-item" data-aos="fade-up"
					onclick="">
					<img src="/hobee/resources/images/${vo.s_image}.png"
						alt="thumbnail">
					<h2>${vo.hb_title}</h2>
					<p>
						<fmt:formatNumber value="${vo.hb_price}" />
						원
					</p>
					<span>1인당</span>
				</div>
			</c:forEach>
		</div>
	</div>
	<!--pick 끝-->


	<!--서브배너 시작-->
	<div class="sub_banner_container menu_box aboutinner aos-item"
		data-aos="fade-up">
		<div class="sub_baneer_box">
			<p>새로운 만남의 기회를 만들어보세요.</p>
			<h3>나만의 모임을 만들고 시작하세요!</h3>
			<img src="/hobee/resources/images/main_sub_banner.png" alt="서브배너">
			<a href="#">더 알아보기</a>
		</div>
	</div>
	<!--서브배너 끝-->


	<!--new 시작-->
	<div class="con_container">


		<div class="con_header">
			<h1>신규 HOBEE</h1>
			<a href="#">전체보기</a>
		</div>

		<!--new 제품이 없는 경우-->
		<c:if test="${ empty new_list }">
			<div>등록된 제품이 없습니다.</div>
		</c:if>

		<!-- pick 제품이 있는 경우 -->
		<div class="con_wrapper">
			<c:forEach var="vo" items="${new_list}" begin="0" end="3">
				<div class="con_box aboutinner aos-item" data-aos="fade-up"
					onclick="">
					<img src="/hobee/resources/images/${vo.s_image}.png"
						alt="thumbnail">
					<h2>${vo.hb_title}</h2>
					<p>
						<fmt:formatNumber value="${vo.hb_price}" />
						원
					</p>
					<span>1인당</span>
				</div>
			</c:forEach>
		</div>
	</div>
	<!--pick 끝-->

	<!-- 푸터 시작-->
	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
	<!-- 푸터 끝 -->

	<!--top버튼 시작-->
	<a id="toTop" href="#">TOP</a>
	<!--top버튼 끝-->
</body>

</html>