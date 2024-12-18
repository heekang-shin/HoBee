<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Hobee&nbsp;모임신청페이지_폼</title>
	
	<!--주소-->
	<script src="/hobee/resources/js/address.js"></script>
	<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
	 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script>
		function send(f){
			let startday = f.startday.value;
			alert(startday);
		}
	</script>
	
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	<link rel="stylesheet" href="/hobee/resources/css/main.css">
	<link rel="stylesheet" href="/hobee/resources/css/applyForm.css">
	
	
	</head>
	
	<body>
		<!-- 헤더 시작-->
		<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
		<!-- 헤더 끝 -->
	
		<!-- 메인텍스트 시작-->
		<div class="page-title">
			<h1>모임등록</h1>
		</div>
		<!-- 메인텍스트 끝 -->
	
		<!-- 신청 폼 시작 -->
		<form enctype="multipart/form-data">
			<div class="form-container">
				<div class="form-box">
					<label>프로그램명&nbsp;<b class="req">*</b></label> 
					<input type="text" name="title" placeholder="프로그램명을 입력해 주세요.">
				</div>
	
				<div class="form-box">
					<label>가격&nbsp;<b class="req">*</b></label> 
					<input name="title" type="text" placeholder="30000">&nbsp;원
				</div>
	
				<div class="form-box">
					<label>카테고리&nbsp;<b class="req">*</b></label> 
					<select>
						<option value="">카테고리를 선택해 주세요.</option>
						<option value="sport">운동/스포츠</option>
						<option value="sport">음악/악기</option>
						<option value="sport">공예/만들기</option>
						<option value="sport">자기계발</option>
						<option value="sport">게임/오락</option>
						<option value="sport">사교</option>
	
					</select>
				</div>
	
				<div class="form-box">
					<div class="box-left">
						<label>시작 날짜&nbsp;<b class="req">*</b></label> 
						<input type="date" name="startday">
					</div>
					
					<div class="box-right">
						<label>종료 날짜&nbsp;<b class="req">*</b></label> 
						<input type="date" name="endday">
					</div>
				</div>
				
		
				
				<div class="form-box">
					<div class="box-left">
					<label>게시 시작&nbsp;<b class="req">*</b></label> 
					<input type="date" name="startday"> 
					</div>
					<div class="box-right">
					<label>게시 종료&nbsp;<b class="req">*</b></label> 
					<input type="date" name="endday" > 
					</div>
				</div>
	
				<div class="form-box">
					<div class="box-left">
					<label>시작 시간&nbsp;<b class="req">*</b></label> 
					<input type="time" name="starttime"> 
					</div>
					
					<div class="box-right">
					<label>종료 시간&nbsp;<b class="req">*</b></label> 
					<input type="time" name="endtime"> 
					<input type="button" value="추가">
					</div>
				</div>
	
				<div class="form-box address">
					<label>모임장소&nbsp;<b class="req">*</b></label> 
					<div class="box">
					<input type="text" id="sample6_postcode" placeholder="우편번호">
					<input type="button" onclick="sample6_execDaumPostcode()"value="우편번호 찾기">
					<input type="text"id="sample6_address" name="address" placeholder="주소">
					<input type="text" id="sample6_detailAddress" name="detailaddress" placeholder="상세주소">
					<input type="text" id="sample6_extraAddress" placeholder="참고항목" >
					</div>
				</div>
	
				<div class="form-box content">
				<label>프로그램 정보&nbsp;<b class="req">*</b></label> 
				<textarea id="content" name="content" cols="80" rows="10" style="resize: none;"></textarea><br>
				</div>	
				
				
				<div class="form-box">
				<label>썸네일&nbsp;<b class="req">*</b></label> 
				<input type="file" name="s_image">
				</div>
				
				
				<div class="form-box">
				<label>대표 이미지&nbsp;<b class="req">*</b></label> 
				<input type="file" name="l_image">
				</div>
				
				<div class="form-box">
				<label>상세 이미지&nbsp;<b class="req">*</b></label> 
				<input type="file" name="in_image">
				</div>
	
			<!-- 버튼 -->
			<input type="button" value="제출하기" onclick="send(this.form);">
			<input type="button" value="취소하기" onclick="history.back();">
			</div>
		</form>
	
		
		<!-- 신청 폼 끝 -->
	
	
	
		<!-- 푸터 시작-->
		<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
		<!-- 푸터 끝 -->
	
		<!--top버튼 시작-->
		<a id="toTop" href="#">TOP</a>
		<!--top버튼 끝-->
	</body>
</html>