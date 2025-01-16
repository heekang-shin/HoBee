<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
<style>
/* 기본 스타일 */
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
}

/* 제목 스타일 */
.custom-title {
    font-size: 45px; /* 원하는 크기로 설정 */
    font-weight: bold;
    color: #333;
    text-align: center;
    margin-top: 50px; /* 상단 여백 */
    margin-bottom: 30px; /* 하단 여백 */
}

/* 배경과 영역 중앙 정렬 */
.wrapper {
    padding: 50px 0; /* 상하 여유 공간 */
    display: flex;
    justify-content: center;
    align-items: center;
}

/* 카드 스타일 */
.create {
    width: 50%;
    max-width: 800px;
    background-color: #f4f4f9;
    padding: 40px;
    text-align: center;
}

/* 아이콘 스타일 */
.create img {
    width: 120px;
    height: 120px;
    margin-bottom: 20px;
}

/* 내용 제목 스타일 */
.create h1 {
    font-size: 24px;
    color: #333;
    margin-bottom: 10px;
}

/* 설명 텍스트 스타일 */
.create b {
    font-size: 18px;
    color: #555;
    margin-bottom: 30px;
    display: block;
}

/* 버튼 스타일 */
.button-container {
    margin-top: 20px;
}

.button-container input[type="button"] {
    padding: 12px 24px;
    font-size: 16px;
    color: #fff;
    background-color: #333;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.button-container input[type="button"]:hover {
    background-color: #555;
}
</style>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>

    <!-- 회원 가입 제목 -->
    <div class="custom-title">회원 가입</div>

    <!-- 배경과 컨텐츠 영역 -->
    <div class="wrapper">
        <div class="create">
            <img src="/hobee/resources/images/confirmation_icon.png"
                alt="회원가입 완료 아이콘">
            <h1>회원가입 완료!</h1>
            <b>Hobbe 회원가입이 완료되었습니다.</b>
            <div class="button-container">
                <input type="button" value="메인페이지로 가기"
                    onclick="location.href='main.do';">
            </div>
        </div>
    </div>

    <!-- 푸터 포함 -->
    <jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
</body>
</html>