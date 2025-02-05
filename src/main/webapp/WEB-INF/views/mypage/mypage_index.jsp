<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 공통 스타일 시트 -->
<link rel="stylesheet" href="/hobee/resources/css/main.css">

<style>

* {
    padding: 0;
    margin: 0;
    font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
}


/*메인타이틀 (찜목록)*/
.main-title{
	width:1400px;
	height: auto;
	margin: 60px auto;
	
}

.main-title p{
	font-size:45px;
	font-weight: 700;
	text-align: center;
}	


		a {
			text-decoration: none;
		}

		li {
			list-style: none;
		}

		.menu {
			width: 1400px;
			height: 54px;
			margin: 0 auto;
		}


		.menu>li {
			width: 275px;
			height: 50px;
			float: left;

		}

		.menu li:nth-child(1) {
			border-left: 1px solid gray;
		}


		.menu li a {
			display: block;
			padding: 15px 90px;
			color: #444;
			text-align: center;
			border-top: 1px solid gray;
			border-right: 1px solid gray;
			border-bottom: 1px solid gray;
			cursor: pointer;

		}

		.menu li:hover a {
			background-color: #222222;
			color: #fff;
			

		}
		
		

</style>

</head>
<body>
		  
		  <div class="main-title">
		<p>마이페이지</p>
	</div>
		  
		  
	<ul class="menu">
		<li>
		<a onclick ="location.href='mypage_heart_form.do?user_Id=${sessionScope.loggedInUser.user_Id}'">찜목록</a>
		</li>
		
		<li>
		<a onclick="location.href='mypage_apply_form.do?user_Id=${sessionScope.loggedInUser.user_Id}'">신청내역</a>
		</li>
		
		
		<li>
			<a onclick="location.href='user_update_form.do?user_Id=${sessionScope.loggedInUser.user_Id}'">회원정보수정
		</a>
		</li>
		
		<li>
		<a onclick="location.href='user_delete_form.do?user_Id=${sessionScope.loggedInUser.user_Id}'">회원탈퇴</a>
		</li>
		<li>
		 <a href="MyReviews.do?hbidx=${hbidx}">작성 한 리뷰</a> <!-- 마이페이지로 뺄 예정  -->
		</li>
	
		
	</ul>
          
</body>
</html>