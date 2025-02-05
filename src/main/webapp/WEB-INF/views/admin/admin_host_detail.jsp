<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee:관리자 페이지</title>

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 -->
<link rel="stylesheet" href="/hobee/resources/css/admin/admin_main.css">
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet"
	href="/hobee/resources/css/admin/admin_host_detail.css">


<!-- 헤더 스크롤 이펙트-->
<script src="/hobee/resources/js/hostFunction.js"></script>


<script>
	function host_apply(f) {

		if (!confirm("정말 승인 하시겠어요?")) {
			return;
		}

		f.method = 'post';
		f.action = 'admin_host_apply.do';
		f.submit();

	}
</script>


<script>

 function host_refuse(f){
		if (!confirm("정말 거절 하시겠어요?")) {
			return;
		}

		f.method = 'post';
		f.action = 'admin_host_refuse.do';
		f.submit();

 }
	
</script>

</head>

<body>
	<div id="wrapper">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/admin/admin_header.jsp"></jsp:include>

		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/admin/admin_sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="content">
			<div class="title-box">
				<img src="/hobee/resources/images/admin_title_icon.png">
				<h3>호스트 관리</h3>
			</div>

			<!--대시보드 영역 -->
			<div class="dashboard">

				<div class="form-container">
					<form>
						<input type="hidden" name="user_id" value="${vo.user_id}">

						<!-- 이미지 -->
						<div class="form-box">
							<label>이미지 <b class="req">*</b></label>
							<div>
								<img src="/hobee/resources/images/upload/${vo.host_img}"
									style="width: 60px; height: 60px;">

							</div>
						</div>


						<!-- 호스트 이름 -->
						<div class="form-box">
							<label>호스트이름 <b class="req">*</b></label>
							<div class="host_name">${vo.host_name}></div>


						</div>

						<!--호스트 소개-->
						<div class="form-box">
							<label>호스트소개 <b class="req">*</b></label>
							<div class="host_info">${vo.host_info}></div>

						</div>

						<!-- 등급 -->
						<div class="form-box">
							<label>등급 <b class="req">*</b></label> <span> <c:choose>
									<c:when test="${vo.approval == 0}">일반</c:when>
									<c:otherwise>호스트</c:otherwise>
								</c:choose>
							</span>
						</div>





						<!-- 버튼 -->
						<div class="btn-box">
							<input type="button" value="승인하기"
								onclick="host_apply(this.form);"> <input type="button"
								value="거절하기" onclick="host_refuse(this.form);">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
