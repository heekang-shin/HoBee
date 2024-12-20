<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.create {
	width: 400px;
	height: 400px;
	text-align: center;
	display: flex;
	flex-direction: column; /* 세로 정렬 */
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	background-color: #f4f4f9;
	border: 1px solid #ddd;
	border-radius: 8px;
	margin: 50px auto; /* 페이지 중앙 정렬 */
	font-family: Arial, sans-serif;
}

.button-container {
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="create">
		<b>회원가입 완료! Hobbe 회원이 되신걸 환영합니다!</b>
		<div class="button-container">
			<input type="button" value="돌아가기" onclick="location.href='main.do';">
		</div>
	</div>
</body>
</body>
</html>