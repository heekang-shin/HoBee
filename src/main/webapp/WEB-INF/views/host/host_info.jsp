<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Hobee:호스트 정보페이지</title>
	<!-- 파비콘 -->
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	
	<!-- 공통 스타일 -->
	<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
	<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_form.css">
	
	<!-- host 공통 스크립트 -->
	<script src="/hobee/resources/js/hostFunction.js"></script>
	
	<!-- ajax -->
	<script type="/hobee/resources/js/httpRequest.js"></script>
	
	<script>
	
	function modify(form) {
	    // 폼 데이터 가져오기
	    let host_name = form.host_name.value;
	    let host_info = form.host_info.value;
	
	    
	    
	    // 유효성 검사
	    if (!host_name) {
	        alert("호스트 네임을 입력해 주세요.");
	        document.getElementsByName("host_name")[0].focus();
	        return;
	    }
	    
	    if (!host_info) {
	        alert("호스트 소개를 입력해 주세요.");
	        document.getElementsByName("host_info")[0].focus();
	        return;
	    }
	
	    const host_img = document.getElementsByName("host_image_filename")[0].files;
	    if (!host_img && host_img.length === 0) {
	        alert("프로필 사진을 업로드해 주세요.");
	        document.getElementsByName("host_image_filename")[0].focus();
	        return;
	    }
	    
	    if (!confirm("정말 수정하시겠어요?")) {
	        return;
	    }
	    
	    form.method = 'post';
	    form.action = 'host_modify.do';
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
					<h3>호스트 정보</h3>
				</div>
	
				<!-- 대시보드 영역 -->
				<div class="dashboard">
					<form enctype="multipart/form-data">
						<!-- <input type="hidden" name="status" value="${vo.status}">
						<input type="hidden" name="user_id" value="${vo.user_id}">
						<input type="hidden" name="num_of_p" value="${vo.num_of_p}">
						<input type="hidden" name="hb_idx" value="${vo.hb_idx}"> -->
										
						<div class="form-container">
							<input type="hidden" name="user_id" value="${hostInfo.user_id}">
							<!-- 호스트 명 -->
							<div class="form-box">
								<label>호스트 네임 <b class="req">*</b></label> <input type="text"
									name="host_name" placeholder="호스트 이름을 입력해 주세요." value="${hostInfo.host_name}">
							</div>
							
							<!-- 호스트 소개 -->
							<div class="form-box edit-box">
								<label>호스트 소개 <b class="req">*</b></label>
								<textarea name="host_info" placeholder="호스트님의 소개를 해 주세요.">${hostInfo.host_info}</textarea>
							</div>
	
							<!-- 호스트 프로필 이미지 -->
							<div class="form-box">
							    <label>프로필 이미지 <b class="req">*</b></label>
							    <div class="upload-box">
							        <div class="image-preview" id="thumbnail-preview">
							            <img src="/hobee/resources/images/upload/${hostInfo.host_img}" alt="썸네일 미리보기">
							        </div>
							        <div class="upload-inner">
							            <p>프로필<span> (권장크기 : 60x60px)</span></p>
							            <div class="button-group">
							                <input type="file" name="host_image_filename" id="host-thumbnail-input" accept=".png" onchange="updateImage('thumbnail-preview', 'host-thumbnail-input', 'preview')">
							                <button type="button" class="delete-btn" onclick="updateImage('thumbnail-preview', 'host-thumbnail-input', 'remove')">삭제</button>
							            </div>
							        </div>
							    </div>
							</div>
	
	
							<!-- 버튼 -->
							<div class="btn-box">
								<input type="button" value="취소하기" onclick="history.back();">
								<input type="button" value="수정하기" onclick="modify(this.form);">
							</div>
	
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>
