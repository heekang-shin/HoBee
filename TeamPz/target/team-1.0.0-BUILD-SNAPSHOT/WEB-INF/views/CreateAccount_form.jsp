
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Insert title here</title>
<script
	src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<link rel="stylesheet" href="resources/css/create.css">
    <link rel="stylesheet" href="resources/css/main.css">

<script>
	function chk() {
		let id = document.getElementById("id").value.trim(); // ID 값 가져오기
		//  console.log("중복체크 요청 시작"); // 요청 시작 로그
		if (!id) {
			alert("아이디를 입력해주세요.");
			return;
		}

		// URL 구성
		let url = "Duplicate_check.do?id=" + encodeURIComponent(id); // encodeURIComponent 적용

		sendRequest(url, null, check_result, "get"); // 요청 전송
	}
	function check_result(	) {

		if (xhr.readyState === 4 && xhr.status === 200) {
			let result = xhr.responseText.trim(); // 서버에서 반환된 결과 ("1" 또는 "0")
			console.log("서버 응답:", result); // 응답 데이터를 확인
			if (result === "1") {
				alert("이미 사용 중인 아이디입니다.");
			} else if (result === "0") {
				alert("사용 가능한 아이디입니다.");
			} else {
				alert("오류가 발생했습니다. 다시 시도해주세요.");
			}
		}
	}
</script>
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
						 
						<img src="team/resources/images/search_icon.png" class="search-icon">
					</div>
				</form>
				<!--검색창 끝-->
	
				<!--snb 시작-->
				<ul class="snb">
					<li><img src="/team/resources/images/registration_icon.png"
						alt="모임등록" /> <a href="form.do">모임등록</a></li>
	
					<li><img src="/team/resources/images/shop_icon.png" alt="찜" />
						<a href="shop.do">찜목록</a></li>
	
					<li><img src="/team/resources/images/join_icon.png" alt="회원가입" />
						<a href="CreateAccount_form.do">회원가입</a></li>
	
					<li><img src="/team/resources/images/login_form.png" alt="로그인" />
						<a href="login_form.do">로그인</a></li>
	
				</ul>
				<!--snb 끝-->
			</div>
		</div>
		<!--헤더 끝-->


	<form action="Create.do" method="post">
		<table>
			<tr>
				<th><label for="username">이름 *</label></th>
				<td><input id="username" type="text" name="username"
					placeholder="홍길동" required></td>
			</tr>
			<tr>
				<th><label for="id">아이디 *</label></th>
				<td><input id="id" type="text" name="id" placeholder="아이디 입력"
					required> <input type="button" class="check-button"
					value="중복확인" onclick="chk()"></td>
			</tr>
			<tr>
				<th><label for="userpwd">비밀번호 *</label></th>
				<td><input id="userpwd" type="password" name="userpwd"
					placeholder="문자, 숫자를 포함하여 최소 8자 이상 작성" required></td>
			</tr>
			<tr>
				<th><label for="passwordchk">비밀번호 확인 *</label></th>
				<td><input id="passwordchk" type="password" name="passwordchk"
					placeholder="비밀번호를 다시 입력해주세요" required></td>
			</tr>
			<tr>
				<th><label for="useremail">이메일 *</label></th>
				<td><input id="useremail" type="email" name="useremail"
					placeholder="ex@domain.com" required></td>
			</tr>
			<tr>
				<th><label for="birthdate">생년월일 *</label></th>
				<td><input id="birthdate" type="date" name="birthdate" required></td>
			</tr>
		</table>
		<div class="submit-container">
			<button type="submit">가입하기</button>
		</div>
	</form>
	
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
	
					<p>Copyright&copy;2024. team. All rights reserved.</p>
				</div>
	
				<div class="footer_right">
					<div class="cs">
						<h3>고객센터</h3>
						<img src="/team/resources/images/kakaotalk_icon.png" alt="고객센터">
					</div>
	
					<div class="sns">
						<h3>SNS</h3>
						<ul>
							<li><a href="https://www.instagram.com/"><img
									src="/team/resources/images/Instagram_icon.png" alt="인스타"></a></li>
							<li><a href="https://www.facebook.com"><img
									src="/team/resources/images/facebook_icon.png" alt="페이스북"></a></li>
							<li><a href="https://www.youtube.com"><img
									src="/team/resources/images/youtube_icon.png" alt="유튜브"></a></li>
						</ul>
					</div>
				</div>
	
			</div>
		</footer>
		<!--푸터 끝-->
	
</body>
</html>
