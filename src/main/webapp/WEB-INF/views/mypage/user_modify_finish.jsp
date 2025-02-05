<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 시트 -->
<link rel="stylesheet" href="/hobee/resources/css/main.css">

<!-- 수정완료  스타일시트  -->
<link rel="stylesheet"
 href="/hobee/resources/css/mypage/finish_form.css">

<title>수정 완료</title>

<script>



</script>



</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>

	<!-- 메인 컨텐츠 -->
	<main class="main-content">
		<h1 class="title">수정완료</h1>
		<div class="content-box">
			<div class="icon-wrapper">
				<div class="icon-circle">
					<img src="/hobee/resources/images/fin_icon.png/" alt="완료 아이콘"
						class="icon">
				</div>
			</div>
			<h2 class="top_message">수정완료</h2>
			<p class="message">회원정보 수정이 완료되었습니다.</p>
			
				
			<a href="main.do"  class="main-button">메인페이지로 가기</a>
		</div>
	</main>

	<!--푸터  -->

	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>


</body>
</html>
