<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
    <title>Hobee</title>
    <link rel="stylesheet" href="resources/css/main.css">
</head>
<body>
    <header class="header">
        <div class="logo">Hobee</div>
        <nav class="nav">
            <a href="#">모임 등록</a>
            <a href="#">찜목록</a>
            <a href="#">회원가입</a>
            <a href="#">로그인</a>
        </nav>
    </header>

    <!-- 배너 -->
    <section class="banner">
        <div class="banner-content">
            <h1>테니스 모임도 Hobee에서!</h1>
            <p>서브텍스트 자리</p>
            <button>더 알아보기</button>
        </div>
        <img src="resources/img/banner.png" alt="배너 이미지" class="banner-img">
    </section>

    <!-- 카테고리 -->
    <section class="categories">
        <div class="category">
            <img src="resources/img/badminton.png" alt="운동">
            <p>운동 / 스포츠</p>
        </div>
        <div class="category">
            <img src="resources/img/badminton.png" alt="음악">
            <p>음악 / 악기</p>
        </div>
        <div class="category">
            <img src="resources/img/badminton.png" alt="공예">
            <p>공예 / 만들기</p>
        </div>
        <div class="category">
            <img src="resources/img/badminton.png" alt="자기계발">
            <p>자기계발</p>
        </div>
        <div class="category">
            <img src="resources/img/badminton.png" alt="게임">
            <p>게임 / 오락</p>
        </div>
        <div class="category">
            <img src="resources/img/badminton.png" alt="사교">
            <p>사교</p>
        </div>
    </section>

    <!-- BEST 프로그램 -->
    <section class="best">
        <h2>주간 인기 BEST</h2>
        <div class="cards">
            <div class="card">
                <img src="resources/img/badminton.png" alt="카드1">
                <p>BEST 프로그램 이름</p>
            </div>
            <div class="card">
                <img src="resources/img/badminton.png" alt="카드2">
                <p>BEST 프로그램 이름</p>
            </div>
            <div class="card">
                <img src="resources/img/badminton.png" alt="카드3">
                <p>BEST 프로그램 이름</p>
            </div>
        </div>
    </section>

    <!-- HOBEE의 PICK -->
    <section class="pick">
        <h2>HOBEE들의 PICK</h2>
        <div class="cards">
            <div class="card">
                <img src="resources/img/badminton.png" alt="픽1">
                <p>PICK 프로그램 이름</p>
            </div>
            <div class="card">
                <img src="resources/img/badminton.png" alt="픽2">
                <p>PICK 프로그램 이름</p>
            </div>
            <div class="card">
                <img src="resources/img/badminton.png" alt="픽3">
                <p>PICK 프로그램 이름</p>
            </div>
        </div>
    </section>

    <!-- 신규 프로그램 -->
    <section class="new">
        <h2>신규 HOBEE</h2>
        <div class="cards">
            <div class="card">
                <img src="resources/img/badminton.png" alt="신규1">
                <p>신규 프로그램 이름</p>
            </div>
            <div class="card">
                <img src="resources/img/badminton.png" alt="신규2">
                <p>신규 프로그램 이름</p>
            </div>
            <div class="card">
                <img src="resources/img/badminton.png" alt="신규3">
                <p>신규 프로그램 이름</p>
            </div>
        </div>
    </section>

    <footer class="footer">
        <p>Hobee. All rights reserved.</p>
    </footer>
</body>
</html>