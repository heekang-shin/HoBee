<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>&#39;${param.search_text}&#39;&nbsp;검색결과_Hobee</title>

<style>
.wrap {
	width: 1400px;
	height: 500px;
	margin: 120px auto;
	text-align: center;
	background-color: #F8F8F8;
	position: relative;
}

.container {
	width: max-content;
	height: max-content;
	position: absolute;
	top:36%;
	left:32%;
}

.container h1 {
	font-size: 36px;
	font-weight: 400;
	margin-bottom: 24px;
}

.container span {
	font-weight: 800;
}

.container li {
	color: #666666;
	font-size: 18px;
	text-align: left;
	margin-bottom:6px;
}
</style>
</head>
<body>
	<div class="wrap">
		<div class="container">
			<h1>
				<span>&#39;${param.search_text}&#39;</span>&nbsp;검색 결과가 존재하지 않습니다.
			</h1>
			<ul>
				<li>&#45; 철자나 맞춤법 오류가 있는지 확인해 주세요.</li>
				<li>&#45; 여러 단어로 나누거나 다른 검색어로 검색해 주세요.</li>
				<li>&#45; 붙은 단어일 경우 띄어쓰기를 해주세요.</li>
			</ul>
		</div>
	</div>
</body>
</html>