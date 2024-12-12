<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
	
	<head>
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
	            if (n > slides.length) { slideIndex = 1 }
	            if (n < 1) { slideIndex = slides.length }
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
	        $(document).ready(function () {
	
	            var slideIndex = 0;
	            showSlides();
	
	            function showSlides() {
	                var i;
	                var slides = document.getElementsByClassName("mySlides");
	                for (i = 0; i < slides.length; i++) {
	                    slides[i].style.display = "none";
	                }
	                slideIndex++;
	                if (slideIndex > slides.length) { slideIndex = 1 }
	                slides[slideIndex - 1].style.display = "block";
	                setTimeout(showSlides, 6000); // Change image every 2 seconds
	            }
	
	        });
	        
	        <!--검색창-->
	        function enterKey(f){
	       		f.action="search.do";
	       		f.method="get";
	        	f.sumbit();
	        }
	    </script>
	
	<script>

		
	</script>
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	<link rel="stylesheet" href="/hobee/resources/css/main.css">
	<link rel="stylesheet" href="/hobee/resources/dist/aos.css" />
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
		integrity="sha384-eVWmY1Vz02L/uIBq0e4F5rj2Xg3TUZ3I7sAxvnN4+7xj2pkF5+pw0PPxWtrGvFnZ"
		crossorigin="anonymous">
	
	</head>
	
	<body>
		<!--헤더 시작-->
		<div id="header">
			<div id="header_inner">
				<h1 class="logo">
					<a href="main-page.do">Hobee</a>
				</h1>
	
				<!--검색창 시작-->
				<form>
					<div id="search_inner">
						
						<input type="search" placeholder="검색어를 입력해 주세요." name="search_text"
							onkeypress="if( event.keyCode == 13 ){enterKey(this.form)}"/>
						 
						<img src="/hobee/resources/images/search_icon.png" class="search-icon">
					</div>
				</form>
				<!--검색창 끝-->
	
				<!--snb 시작-->
				<ul class="snb">
					<li><img src="/hobee/resources/images/registration_icon.png"
						alt="모임등록" /> <a href="form.do">모임등록</a></li>
	
					<li><img src="/hobee/resources/images/shop_icon.png" alt="찜" />
						<a href="shop.do">찜목록</a></li>
	
					<li><img src="/hobee/resources/images/join_icon.png" alt="회원가입" />
						<a href="join_form.do">회원가입</a></li>
	
					<li><img src="/hobee/resources/images/login_form.png" alt="로그인" />
						<a href="login.do">로그인</a></li>
	
				</ul>
				<!--snb 끝-->
			</div>
		</div>
		<!--헤더 끝-->
	
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
					<h1 class="inner aos-item" data-aos="fade-up">보드게임과 함께하는 특별한 시간!</h1>
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
					<li>
						<img src="/hobee/resources/images/sport_icon.png" alt="sport" onclick="location.href='sport_list.do'"> 
						<a href="#">운동&#47;스포츠</a>
					</li>
	
					<li><img src="/hobee/resources/images/music_icon.png"
						alt="sport" onclick="location.href='sport_list.do'"> <a
						href="#">음악&#47;악기</a></li>
	
					<li><img src="/hobee/resources/images/crafts_icon.png"
						alt="sport" onclick="location.href='sport_list.do'"> <a
						href="#">공예&#47;만들기</a></li>
	
					<li><img src="/hobee/resources/images/self_icon.png"
						alt="sport" onclick="location.href='sport_list.do'"> <a
						href="#">자기계발</a></li>
	
					<li><img src="/hobee/resources/images/game_icon.png"
						alt="sport" onclick="location.href='sport_list.do'"> <a
						href="#">게임&#47;오락</a></li>
	
					<li><img src="/hobee/resources/images/gathering_icon.png"
						alt="sport" onclick="location.href='sport_list.do'"> <a
						href="#">사교</a></li>
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
		
			<!-- 등록된 제품이 없는 경우 
	        <c:if test="${ empty list }">
	        <div>등록된 제품이 없습니다.</div>
	        </c:if>-->
	
	
				<div class="con_wrapper">
					<div class="con_box aboutinner aos-item best" data-aos="fade-up" onclick="">
						<img src="/hobee/resources/images/thumbnail.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
	
					<div class="con_box aboutinner aos-item best" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
	
					<div class="con_box aboutinner aos-item best" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
	
					<div class="con_box aboutinner aos-item best" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
				</div>
	
		</div>
		<!--best 끝-->
	
		<!--pick 시작-->
		<div class="con_container">
	
			<div class="con_header">
				<h1>HOBEE들의 픽</h1>
				<a href="#">전체보기</a>
			</div>
	
			<!--등록된 제품이 없는 경우
	        <c:if test="${ empty list }">
	        <div>등록된 제품이 없습니다.</div>
	        </c:if>-->
	
				<div class="con_wrapper">
					<div class="con_box aboutinner aos-item" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail2.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
	
					<div class="con_box aboutinner aos-item" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail2.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
	
					<div class="con_box aboutinner aos-item" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail2.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
	
					<div class="con_box aboutinner aos-item" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail2.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
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
				<a href="#">더
					알아보기</a>
			</div>
		</div>
		<!--서브배너 끝-->
	
	
		<!--new 시작-->
		<div class="con_container">
	
			<div class="con_header">
				<h1>신규 HOBEE</h1>
				<a href="#">전체보기</a>
			</div>
	
			<!--등록된 제품이 없는 경우
	    <c:if test="${ empty list }">
	    <div>등록된 제품이 없습니다.</div>
	    </c:if>-->
	
				<div class="con_wrapper">
					<div class="con_box aboutinner aos-item" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail3.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
	
					<div class="con_box aboutinner aos-item" data-aos="fade-up"
						" onclick="">
						<img src="/hobee/resources/images/thumbnail3.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
	
					<div class="con_box aboutinner aos-item" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail3.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
	
					<div class="con_box aboutinner aos-item" data-aos="fade-up"
						onclick="">
						<img src="/hobee/resources/images/thumbnail3.png" alt="thumbnail">
						<h2>프로그램 타이틀</h2>
						<p>30,000원</p>
						<span>1인당</span>
					</div>
				</div>
		</div>
		<!--new 끝-->
	
		<!--푸터 시작-->
		<footer>
			<div class="footer_container">
	
				<div class="footer_left">
					<h1>Hobee</h1>
	
					<ul class="company_info">
						<li><span>기업명</span>&nbsp;&nbsp;&nbsp;Hobee</li>
						<li><span>사업자번호</span>&nbsp;&nbsp;&nbsp;2024-08-19</li>
						<li><span>주소</span>&nbsp;&nbsp;&nbsp;서울특별시 강남구 테헤란로 14길 6 남도빌딩
							7층 k관</li>
						<li><span>대표자</span>&nbsp;&nbsp;&nbsp;신희강</li>
						<li><span>이메일</span>&nbsp;&nbsp;&nbsp;khteam2@gmail.com</li>
					</ul>
	
					<ul class="terms">
						<li><a href="#">이용약관</a></li>
						<li><a href="#">개인정보 처리방침</a></li>
						<li><a href="#">위치기반 서비스 이용약관</a></li>
					</ul>
	
					<p>Copyright&copy;2024. Hobee. All rights reserved.</p>
				</div>
	
				<div class="footer_right">
					<div class="cs">
						<h3>고객센터</h3>
						<img src="/hobee/resources/images/kakaotalk_icon.png" alt="고객센터">
					</div>
	
					<div class="sns">
						<h3>SNS</h3>
						<ul>
							<li><a href="https://www.instagram.com/"><img
									src="/hobee/resources/images/Instagram_icon.png" alt="인스타"></a></li>
							<li><a href="https://www.facebook.com"><img
									src="/hobee/resources/images/facebook_icon.png" alt="페이스북"></a></li>
							<li><a href="https://www.youtube.com"><img
									src="/hobee/resources/images/youtube_icon.png" alt="유튜브"></a></li>
						</ul>
					</div>
				</div>
	
			</div>
		</footer>
		<!--푸터 끝-->
	
		<!--top버튼 시작-->
		<a id="toTop" href="#">TOP</a>
		<!--top버튼 끝-->
	</body>
	
</html>