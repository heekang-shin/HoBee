<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${hobee.hb_title}&nbsp상세페이지</title>
<!-- 공통 css -->
<link rel="stylesheet" href="/hobee/resources/css/main.css">
<!-- detail css -->
<link rel="stylesheet" href="/hobee/resources/css/detail.css">
<!-- footer css -->
<link rel="stylesheet" href="/hobee/resources/css/footer.css">
<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<style>
.hidden {
	display: none; /* 요소를 숨기는 스타일 */
}
</style>

<script>

document.addEventListener("DOMContentLoaded", function () {
    let reviewGroup = document.getElementById("review-group");
    let ratingInput = document.getElementById("rating"); // 추가된 hidden 필드 가져오기

    // 별점 클릭 시 rating 값을 설정
  window.rateStar = function(starNumber) {
    document.getElementById("rating").value = starNumber; // 값 설정
    console.log("[디버그] rateStar 호출 - 설정된 rating 값: " + document.getElementById("rating").value);
    reviewGroup.style.display = "block";
    console.log(starNumber + "점을 선택했습니다.");
};


    // 리뷰 입력란 숨기기 처리
    document.addEventListener("click", function (event) {
        if (
            !reviewGroup.contains(event.target) &&
            !event.target.closest(".star-rating")
        ) {
            reviewGroup.style.display = "none";
            console.log("리뷰 입력란이 숨겨졌습니다.");
        }
    });
});

// 등록 버튼 클릭 처리
function registration(f) {
    let reviewContent = f.reviewContent.value; // name="reviewContent"
    console.log("[디버그] 리뷰 내용: " + reviewContent); // 디버깅용

    let rating = f.rating.value; // name="rating"
    console.log("[디버그] 별점 값: " + rating); // 디버깅용

    let hbidx = f.hbidx.value; // name="hbidx"
    console.log("[디버그] 게시글 ID (hbidx): " + hbidx); // 디버깅용

    if (!reviewContent.trim()) {
        alert("내용을 입력하세요");
        return;
    }
    if (!rating) { // rating 값이 없는 경우 처리
        alert("별점을 선택하세요");
        return;
    }
    if (!hbidx) { // hbidx 값이 없는 경우 처리
        alert("게시글 정보가 없습니다. 새로고침 후 다시 시도하세요.");
        return;
    }

    f.method = "post";
    f.action = "Review.do";
    f.submit();
}




</script>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>

	<div class="detail_container">
		
		<!-- 상세 페이지 제목 -->
		<h2>${hobee.hb_title }</h2>

	<form id="reviewForm">
    <!-- 별점 버튼 -->
    <div class="star-rating">
        <input type="hidden" id="hbidx" name="hbidx" value="${hbidx}">
         <input type="hidden" id="rating" name="rating">
        <input type="button" value="★" id="star1" onclick="rateStar(1);">
        <input type="button" value="★" id="star2" onclick="rateStar(2);">
        <input type="button" value="★" id="star3" onclick="rateStar(3);">
        <input type="button" value="★" id="star4" onclick="rateStar(4);">
        <input type="button" value="★" id="star5" onclick="rateStar(5);">
    </div>
 
    <!-- 평균 별점 및 누적 리뷰 -->
<div class="rating-info">
    <span>${formattedAverageRating}/5</span>
    <span>(${reviewCount})</span>
</div>

    <!-- 리뷰 입력란 -->
    <div id="review-group" class="hidden">
        <textarea name="reviewContent" id="reviewContent" placeholder="리뷰 내용을 입력하세요..." required></textarea>
        <input type="button" value="등록하기" onclick="registration(this.form)">
    </div>
</form>

    
	</div>


	<!-- top 버튼 -->
	<a id="toTop" href="#">TOP</a>

	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
</body>
</html>
