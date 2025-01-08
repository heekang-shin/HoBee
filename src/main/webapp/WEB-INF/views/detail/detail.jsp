<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${hobee.hb_title}&nbsp상세페이지</title>

<!-- detail css -->
<link rel="stylesheet" href="/hobee/resources/css/detail.css">

<link rel="stylesheet" href="/hobee/resources/css/footer.css">
<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">


<script>
	<!--토글-->
	function openDiv1() {

		if (document.getElementById('notice-details').style.display === 'none') {
			document.getElementById('notice-details').style.display = 'block'
			document.getElementById('arrow1').style.transform = 'rotate(45deg)'
		} else {
			document.getElementById('notice-details').style.display = 'none'
			document.getElementById('arrow1').style.transform = 'rotate(-135deg)'
		}
	}
	
	function openDiv2() {

		if (document.getElementById('refund-details').style.display === 'none') {
			document.getElementById('refund-details').style.display = 'block'
			document.getElementById('arrow2').style.transform = 'rotate(45deg)'
		} else {
			document.getElementById('refund-details').style.display = 'none'
			document.getElementById('arrow2').style.transform = 'rotate(-135deg)'
		}
	}
	
</script>




<script>
	function open_payment() {
		// 새 창의 URL 설정
		const url = 'payment.do'; // 스프링 컨트롤러에서 처리할 URL
		const options = 'width=680,height=700,top=150,left=580';
		window.open(url, '_blank', options);
	}
	function op(o) {
		let pp = parseInt(document.getElementById("people").value); // 문자열 값을 숫자로 변환
		if (isNaN(pp) || pp < 1) { // 초기값이 이상하거나 잘못된 경우를 방지
			pp = 1;
		}

		switch (o) {
		case "+":
			pp++;
			break;
		case "-":
			if (pp > 1) { // 인원수가 1 이하로 내려가지 않도록 제한
				pp--;
			}
			break;
		}

		document.getElementById("people").value = pp; // 업데이트된 인원수 반영

		let res = document.getElementById('res');
		res.innerHTML = pp * ${hobee.hb_price}+" 원"; // 총금액 계산 및 업데이트
		
	}
</script>


</head>
<body>
	<!--헤더-->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>

	<div class="detail_container">

		<!-- 왼쪽 컨테이너 -->
		<div class="left_container">
			<img src="/hobee/resources/images/upload/${hobee.l_image}">

			<!-- 소개 -->
			<div class="sub-title">
				<h2>소개</h2>
			</div>

			<div class="content_container">
				<p>${hobee.hb_content}</p>
				 <img src="/hobee/resources/images/upload/${hobee.in_image}">
			</div>

			<!-- 모임장소 -->
			<div class="sub-title">
				<h2>모임장소</h2>
			</div>

			<div id="map"
				style="width: 910px; height: 350px; margin-top: 20px; border-radius: 8px;"></div>

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

			<!-- 1:1 문의 게시판 -->
			<div class="sub-title">
				<h2>1:1 문의</h2>
			</div>

			<div class="inquiry-board">
				<!-- 문의 작성 -->
				<div class="inquiry-form">
					<h3>문의 작성</h3>
					<form action="submitInquiry.do" method="POST">
						<textarea name="title" id ="inquiry-title" placeholder="문의 제목을 입력하세요." required></textarea>
						<textarea name="content" placeholder="문의 내용을 입력하세요." required></textarea>
						<button type="submit">문의 등록</button>
					</form>
				</div>

				<div class="inquiry-list">
					<h3>문의 목록</h3>
					<ul>
						<c:forEach var="inquiry" items="${inquiries}">
							<li>
								<p><strong>${inquiry.title}</strong></p>
								<p style="text-align:right">
									작성자 | <strong>${inquiry.writer}</strong> (${inquiry.created_date})
								</p>
								<p>${inquiry.content}</p>
							</li>
						</c:forEach>
					</ul>

					<!-- 페이징 버튼 -->
					<div class="pagination">
						<c:if test="${currentPage > 1}">
							<a
								href="hobee_detail.do?hbidx=${hobee.hb_idx}&page=${currentPage - 1}">이전</a>
						</c:if>

						<c:forEach begin="1" end="${totalPages}" var="page">
							<a href="hobee_detail.do?hbidx=${hobee.hb_idx}&page=${page}"
								class="${currentPage == page ? 'active' : ''}">${page}</a>
						</c:forEach>

						<c:if test="${currentPage < totalPages}">
							<a href="hobee_detail.do?hbidx=${hobee.hb_idx}&page=${currentPage + 1}">다음</a>
						</c:if>
					</div>
				</div>

			</div>

			<!-- 환불정책 -->
			<div class="sub-title">
				<div id="notice" onclick="openDiv1()">
					<h2>유의사항</h2>
				</div>
				<div id="arrow1"></div>
			</div>

			<div id="notice-details" style="display: none">
				<p>${hobee.hb_notice}</p>
			</div>

			<!-- 환불정책 -->
			<div class="sub-title">
				<div id="refund" onclick="openDiv2()">
					<h2>환불정책</h2>
				</div>
				<div id="arrow2"></div>
			</div>

			<div id="refund-details" style="display: none">
				<p>
					<b>1. 결제 후 1시간 이내에는 무료 취소가 가능합니다.</b><br> (단, 신청마감 이후 취소 시,
					Hobee 진행 당일 결제 후 취소 시 취소 및 환불 불가)<br>
					<br> <b>2. 결제 후 1시간이 초과한 경우, 아래의 환불규정에 따라 취소수수료가 부과됩니다.</b><br>
					- 신청마감 2일 이전 취소시 : 전액 환불<br> - 신청마감 1일 ~ 신청마감 이전 취소시 : 상품 금액의
					50% 취소 수수료 배상 후 환불<br> - 신청마감 이후 취소시, 또는 당일 불참 : 환불 불가<br>
					※ 여행사 상품의 경우 상품 상세 페이지의 여행사 환불 규정이 우선 적용 됩니다.<br> ※ 여행사 상품,
					숙박, 이벤트 상품 등 객실, 버스 등 사전 예약 확정이 필요한 Hobee은 예약 확정 이후 신청마감일 이전이라도 취소
					및 환불 불가합니다.<br> ※ 취소 수수료는 신청 마감일을 기준으로 산정됩니다.<br> ※ 신청
					마감일은 무엇인가요?<br> 호스트님들이 장소 대관, 강습, 재료 구비 등 Hobee 진행을 준비하기 위해,
					Hobee 진행일보다 일찍 신청을 마감합니다.<br> 환불은 진행일이 아닌 신청 마감일 기준으로 이루어집니다.
					Hobee마다 신청 마감일이 다르니, 꼭 날짜와 시간을 확인 후 결제해주세요! : )<br> ※신청 마감일 기준
					환불 규정 예시<br> - Hobee 진행일 : 10월 27일<br> - 신청 마감일 : 10월 26일<br>
					10월 25일에 취소 할 경우, 신청마감일 1일 전에 해당하며 50%의 수수료가 발생합니다.<br>
					<br> <b>[환불 신청 방법]</b><br> 1. 해당 Hobee 결제한 계정으로 로그인<br>
					2. 마이페이지 - 신청내역 or 결제내역<br> 3. 취소를 원하는 Hobee 상세 정보 버튼 - 취소<br>
					※ 결제 수단에 따라 예금주, 은행명, 계좌번호 입력
				</p>
			</div>


		</div>




		<!--오른쪽 사이드바-->
		<div class="right_container">

			<div class="right_title">
				<h3>${hobee.hb_title}</h3>
				<p>
					<fmt:formatNumber type="number" maxFractionDigits="3"
						value="${hobee.hb_price}" />
					원
				</p>
			</div>

			<div class="option_container">
				<div class="option_inner">
					<h3>날짜</h3>
					<input type="text" value="${hobee.hb_date}" readonly>
				</div>

				<div class="option_inner">
					<h3>시간</h3>
					<input type="text" value="${hobee.hb_time}" readonly>
				</div>

				<div class="option_inner people_num">
					<h3>인원수</h3>
					<input type="text" id="people" value=1 readonly> <input
						type="button" value="-" onclick="op('-');" /> <input
						type="button" value="+" onclick="op('+');" />
				</div>
			</div>

			<div class="total_container">
				<p>총금액</p>
				<h2 id="res">
					${hobee.hb_price}
				<span>원</span>
				</h2>
			</div>
				


			<div class="btn-inner">
				<input type="button" value="신청하기" onclick="open_payment()">
				<input type="button" value="찜하기">
			</div>

		</div>

	</div>

	<!--top버튼 시작-->
	<a id="toTop" href="#">TOP</a>
	<!--top버튼 끝-->

	<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
</body>
</html>