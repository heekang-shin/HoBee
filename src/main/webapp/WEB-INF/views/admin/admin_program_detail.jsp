<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_form.css">
		<!-- detail css -->
	<link rel="stylesheet" href="/hobee/resources/css/detail.css">
	
	<!-- 헤더 스크롤 이펙트-->
	<script src="/hobee/resources/js/hostFunction.js"></script>
	
	<script>
		function yes(form) {
		    if (confirm("게시 하시겠습니까?")) {
		    	return;
		    }
		    
		    // status 값을 1로 설정
		    form.status.value = 1;

		    // 폼 전송 설정
		    form.action = "admin_host_post.do"; // 게시 처리를 위한 서버 경로
		    form.method = "post";
		    form.submit(); // 폼 제출
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
				<h3>프로그램 관리</h3>
			</div>

			<!--대시보드 영역 -->
			<div class="dashboard">
				<!-- 왼쪽 컨테이너 -->
			<div class="left_container">
			<img src="/hobee/resources/images/upload/${vo.l_image}">

			<!-- 소개 -->
			<div class="sub-title">
				<h2>프로그램 명</h2>
			</div>

			<div class="content_container">
				<p>${vo.hb_title}</p>
			</div>

			<!-- 소개 -->
			<div class="sub-title">
				<h2>소개</h2>
			</div>

			<div class="content_container">
				<p>${vo.hb_content}</p>
				 <img src="/hobee/resources/images/upload/${vo.in_image}">
			</div>

			<!-- 모임장소 -->
			<div class="sub-title">
				<h2>모임장소</h2>
			</div>

			<div id="map"
				style="width: 1100px; height: 350px; margin-top: 20px; border-radius: 8px;"></div>

			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d4ee71940750a5e126bdb0304ed63c08&libraries=services"></script>
			<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};

				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption);

				// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
				var mapTypeControl = new kakao.maps.MapTypeControl();

				// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
				// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
				map.addControl(mapTypeControl,
						kakao.maps.ControlPosition.TOPRIGHT);

				// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
				var zoomControl = new kakao.maps.ZoomControl();
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();

				// 주소로 좌표를 검색합니다
				geocoder.addressSearch('${hobee.address}',
								function(result, status) {

									// 정상적으로 검색이 완료됐으면 
									if (status === kakao.maps.services.Status.OK) {

										var coords = new kakao.maps.LatLng(
												result[0].y, result[0].x);

										// 결과값으로 받은 위치를 마커로 표시합니다
										var marker = new kakao.maps.Marker({
											map : map,
											position : coords
										});

										// 인포윈도우로 장소에 대한 설명을 표시합니다
										var infowindow = new kakao.maps.InfoWindow(
												{
													content : '<div style="width:150px;text-align:center;padding:6px 0;">${hobee.hb_title}</div>'
												});
										infowindow.open(map, marker);

										// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
										map.setCenter(coords);
									}
								});
			</script>


			<!-- 환불정책 -->
			<div class="sub-title">
				<div id="notice" onclick="openDiv1()">
					<h2>유의사항</h2>
				</div>
			</div>

			<div id="notice-details" style="display: none">
				<p>${vo.hb_notice}</p>
			</div>

			

		</div>
				
				<!-- 버튼 -->
				<div class="btn-box">
					<input type="button" value="취소하기" onclick="history.back();">
					<input type="button" value="게시하기" onclick="yes(this.form);">
					<input type="button" value="게시불가" onclick="no(this.form);">
				</div>
				</form>
			</div>
			</div>
				
		</div>
	</div>
</body>
</html>
