<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee:호스트 신청페이지</title>
<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 -->
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet"
	href="/hobee/resources/css/host/host_apply_form.css">

<!-- host 공통 스크립트 -->
<script src="/hobee/resources/js/hostFunction.js"></script>

<!-- 주소 -->
<script src="/hobee/resources/js/address.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 카테고리 -->
<script src="/hobee/resources/js/category.js"></script>

<script>

	 // 폼 제출 함수
        function send(form) {
        	// 폼 데이터 가져오기
        	
        	/*타이틀*/
        	let hb_title = form.hb_title.value;
        		            
        	/*가격, 쉼표 제거*/
        	let hb_price = form.hb_price.value.trim().replace(/,/g, ''); 
        	form.hb_price.value = hb_price; // 제거된 값을 다시 폼에 설정
        		            
        	/*카테고리*/
        	let bigcategory = form.bigcategory.value;
        	let category_name = form.category_name.value;
        		            
        	/*인원수*/            
        	let hb_tot_num = form.hb_tot_num.value; 
        		            
        	/*날짜*/
        	let hb_date = form.hb_date.value; 
        		            
        	/*시간*/
        	let hb_time = form.hb_time.value; 
        		      
        	/*프로그램 상세*/
        	let hb_content = form.hb_content.value;
        	
        	/*썸네일
        	let s_image = form.s_image.value;*/
        	
        	/*모임장소*/
        	// 각 필드 값 가져오기
        	const postcode = document.getElementById('sample6_postcode').value.trim();
        	const address = document.getElementById('sample6_address').value.trim();
        	const detailAddress = document.getElementById('sample6_detailAddress').value.trim();
        	const extraAddress = document.getElementById('sample6_extraAddress').value.trim();
        				
        	// 빈 값을 제외하고 주소 병합
        	const fullAddress = [postcode, address, detailAddress, extraAddress]
        	.filter(value => value) // 빈 문자열 제거
        	.join(' '); // 공백으로 병합
        				
        	// 숨겨진 필드에 병합된 주소 설정
        	form.hb_address.value = fullAddress;
        		
        		
        	/* 유효성 검사	*/
        		
        	if (!hb_title) {
        		alert("프로그램명을 입력해 주세요.");
        		return;
        	}
        		            
        	if (!hb_price || isNaN(hb_price)) {
        		alert("가격을 올바르게 입력해 주세요.");
        		return;
        	}
        		            
        	if (bigcategory === 'all') {
        		alert("카테고리를 선택해 주세요.");
        		return;
        	}
        		
        	if (category_name === 'all') {
        		alert("상세 카테고리를 선택해 주세요.");
        		return;
        	}
        		            
        	if (!hb_tot_num) {
        		alert("최대 인원 수를 입력해 주세요.");
        		return;
        	}
        		            
        	if (!hb_date) {
        		alert("프로그램 날짜를 선택해 주세요.");
        		return;
        	}
        		            
        	if (!hb_time) {
        		alert("프로그램 시간을 선택해 주세요.");
        		return;
        	}
        		            
        	if (!address) {
        		alert("모임 장소를 입력해 주세요.");
        		return;
        	}
        	
        	
        	if (!hb_content || hb_content === '') {
        		alert("프로그램 내용을 입력해 주세요.");
        		return;
        	}
        	
        	/*
        	if (!s_image) {
        		alert("이미지를 선택해 주세요.");
        		return;
        	}
        	*/

            form.action = 'host_apply_insert.do';
            form.submit();
        }
    </script>
</head>

<body>
	<div id="wrapper">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/host/host_header.jsp"></jsp:include>

		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/host/host_sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="content">
			<div class="title-box">
				<img src="/hobee/resources/images/title_icon.png">
				<h3>프로그램 신청</h3>
			</div>

			<!-- 대시보드 영역 -->
			<div class="dashboard">
				<form method="post" enctype="multipart/form-data">
					<div class="form-container">
						<!-- 프로그램명 -->
						<div class="form-box">
							<label>프로그램명 <b class="req">*</b></label> <input type="text"
								name="hb_title" placeholder="프로그램명을 입력해 주세요.">
						</div>

						<!-- 가격 -->
						<div class="form-box">
							<label>가격 <b class="req">*</b></label> <input type="text"
								name="hb_price" placeholder="금액을 입력해 주세요."
								oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" />
							&nbsp;원
						</div>

						<!-- 카테고리 -->
						<div class="form-box">
							<label>카테고리 <b class="req">*</b></label> <select
								name="bigcategory" id="main-category">
								<option value="all">전체</option>
								<option value="1">운동/스포츠</option>
								<option value="2">음악/악기</option>
								<option value="3">공예/만들기</option>
								<option value="4">자기계발</option>
								<option value="5">게임/오락</option>
								<option value="6">사교</option>
							</select> <select id="sub-category" name="category_name" disabled>
								<option value="all">전체</option>
							</select>
						</div>

						<!-- 인원수 -->
						<div class="form-box">
							<label>인원 수 <b class="req">*</b></label> <input type="number"
								name="hb_tot_num" placeholder="0"> &nbsp;명
						</div>

						<!-- 날짜 -->
						<div class="form-box">
							<label>날짜 <b class="req">*</b></label> <input name="hb_date"
								type="date">
						</div>

						<!-- 시간 -->
						<div class="form-box">
							<label>시간 <b class="req">*</b></label> <input name="hb_time"
								type="time">
						</div>

						<!-- 주소 -->
						<div class="form-box addr-container">
							<label>모임 장소 <b class="req">*</b></label>
							<div class="addr-box">
								<input type="hidden" name="hb_address"> <input
									type="text" id="sample6_postcode" placeholder="우편번호"> <input
									type="text" id="sample6_address" placeholder="주소"><br>
								<input type="text" id="sample6_detailAddress" placeholder="상세주소"><br>
								<input type="text" id="sample6_extraAddress" placeholder="참고항목">
							</div>
							<input type="button" onclick="sample6_execDaumPostcode()"
								value="우편번호 찾기"><br>
						</div>

						<!-- 프로그램 상세내용 -->
						<div class="form-box edit-box">
							<label>프로그램 내용 <b class="req">*</b></label>
							<textarea name="hb_content" placeholder="프로그램 상세 내용을 입력해 주세요."></textarea>
						</div>

						<!-- 프로그램 상세내용 -->
						<div class="form-box edit-box">
							<label>유의내용 <b class="req">*</b></label>
							<textarea name="hb_notice" placeholder="유의내용을 입력해 주세요."></textarea>
						</div>

						<!-- 썸네일 -->
						<div class="form-box">
					    <label>썸네일 <b class="req">*</b></label>
					    <div class="upload-box">
					        
					        <div class="image-preview" id="thumbnail-preview">
					            <img src="/hobee/resources/images/img_icon.png" alt="썸네일 미리보기">
					        </div>
					
					        <div class="upload-inner">
					            <p>썸네일<span> (권장크기 : 1000x1000px)</span></p>
					            <div class="button-group">
					                <input type="file" name="s_image" id="thumbnail-input" accept=".png" onchange="updateImage('thumbnail-preview', 'thumbnail-input', 'preview')">
					                <button type="button" class="delete-btn" onclick="updateImage('thumbnail-preview', 'thumbnail-input', 'remove')">삭제</button>
					            </div>
					        </div>
					    </div>
					</div>
					

						<!-- 버튼 -->
						<div class="btn-box">
							<input type="button" value="취소하기" onclick="history.back();">
							<input type="button" value="제출하기" onclick="send(this.form);">
						</div>

					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
