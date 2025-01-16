<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 찜목록 스타일 시트 -->
<link rel="stylesheet" href="/hobee/resources/css/mypage/heart_list.css">



<title>찜목록</title>


</head>
<body>
  	
  	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
	

	<!-- 메뉴 -->
	<jsp:include page="mypage_index.jsp" />


	<div class="heart-wrapper">
		<c:forEach var="vo" items="${ggim_list}">
			<div class="heart_box aboutinner aos-item" data-aos="fade-up" onclick="">
				<img src="/hobee/resources/images/upload/${vo.s_image}"
							alt="thumbnail" onclick="location.href='hobee_detail.do?hbidx=${vo.hb_idx}'">
						<h2>${vo.hb_title}</h2>
						<p><fmt:formatNumber value="${vo.hb_price}" />원
						</p>
						<span>1인당</span>
			</div>

		</c:forEach>
	</div>
	
<!--푸터  -->
	
<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
	
	
</body>
</html>