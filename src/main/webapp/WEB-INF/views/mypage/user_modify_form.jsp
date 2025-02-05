<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 시트 -->
<link rel="stylesheet" href="/hobee/resources/css/main.css">

<!-- 회원정보 수정 스타일 시트 -->
<link rel="stylesheet"
	href="/hobee/resources/css/mypage/user_modify_form.css">

<title>회원 정보 수정</title>

<script>
	function modify(f) {

		let user_name = f.user_name.value;
		let now_pwd = f.now_pwd.value;
		let pwd_change = f.pwd_change.value;
		let pwd_change_check = f.pwd_change_check.value;
		let user_email = f.user_email.value;
		let phone = f.phone.value;

		if (user_name === '') {
			alert("이름을 입력하세요");
			return;
		}

		if (now_pwd === '') {
			alert("현재 비밀번호를 입력하세요");
			return;
		}

		if (pwd_change === '') {
			alert("변경 비밀번호를 입력하세요");
			return;
		}

		if (pwd_change != pwd_change_check) {
			alert("변경 비밀번호 확인에 입력한 데이터가 변경 비밀번호랑 일치하지않습니다");
			return;
		}

		if (user_email === '') {
			alert("이메일을 입력하세요");
			return;
		}

		f.action = "user_update_fin.do";
		f.method = 'get';
		f.submit();

	}
</script>


</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>


	<!--메뉴  -->
	<jsp:include page="mypage_index.jsp" />



	<form>
		<input type="hidden" name="user_Id" value="${vo.user_Id}"> <input
			type="hidden" name="user_pwd" value="${vo.user_pwd}">
		<table>

			<colgroup>
				<col width="30%" />
				<col width="70%" />

			</colgroup>

			<tr>
				<th colspan="2" class="modify">회원정보수정</th>

			</tr>


			<tr>
				<th>아이디</th>
				<td>${vo.id}</td>
				<!-- <input name="id" value="$sw{vo.id}"> -->
			</tr>

			<tr>
				<th>이름*</th>
				<td><input type="text" name="user_name" value="${vo.user_name}"></td>

			</tr>


			<tr>
				<th>현재 비밀번호*</th>
				<td><input type="password" name="now_pwd"></td>

			</tr>


			<tr>
				<th>변경 비밀번호*</th>
				<td><input type="password" name="pwd_change"></td>

			</tr>


			<tr>
				<th>변경 비밀번호확인*</th>
				<td><input type="password" name="pwd_change_check"></td>

			</tr>

			<tr>
				<th>핸드폰 번호*</th>
				<td><input type="phone" name="phone" value="${vo.phone}"></td>

			</tr>

			<tr>
				<th>이메일*</th>
				<td><input type="email" name="user_email"
					value="${vo.user_email}"></td>

			</tr>

			<tr>
				<td colspan="2" class="button"><input type="button"
					value="회원정보수정" onclick="modify(this.form);"></td>
			</tr>

		</table>
	</form>

	<!--푸터  -->

	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>

</body>
</html>