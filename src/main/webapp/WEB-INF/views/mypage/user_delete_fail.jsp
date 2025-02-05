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

<!-- 탈퇴실패  스타일시트  -->
<link rel="stylesheet"
 href="/hobee/resources/css/mypage/fail_form.css">

<title>탈퇴 실패</title>

<script>



</script>



</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>

	<!-- 메인 컨텐츠 -->
	<main class="main-content">
		<h1 class="title">탈퇴실패</h1>
		<div class="content-box">
			<div class="icon-wrapper">
				<div class="icon-circle">
					<img src="/hobee/resources/images/xxx_icon.PNG/" alt="실패 아이콘"
						class="icon">
				</div>
			</div>
			<h2 class="top_message">탈퇴실패</h2>
			<p class="message">회원탈퇴에 실패했습니다.<br> 비밀번호를 확인하세요.</br></p>
			
				
			<a href="user_delete_form.do?user_Id=${sessionScope.loggedInUser.user_Id}"  class="main-button">다시 입력하러 가기</a>
		</div>
	</main>

	<!--푸터  -->

	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>


</body>
</html>
