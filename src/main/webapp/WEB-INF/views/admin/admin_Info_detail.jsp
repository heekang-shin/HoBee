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
	
	
	<!-- 헤더 스크롤 이펙트-->
	<script src="/hobee/resources/js/hostFunction.js"></script>

	<script>
		function del(f) {
	
			if (!confirm("정말 삭제 하시겠어요?")) {
				return;
			}
	
			f.method = 'post';
			f.action = 'admin_host_del.do?user_id=${vo.user_id}';
			f.submit();
	
		}
	</script>
	
	<script>
	function approval(status) {
		// 상태에 따른 메시지 설정
		let message = "";
			if (status == 1) {
				message = "승인하시겠습니까?";
			} else if (status == 2) {
				message = "승인 불가 처리하시겠습니까?";
			} else {
				alert("승인 불가능한 상태입니다.");
				return; // 상태가 1 또는 2가 아닐 경우 종료
			}

			// 메시지를 확인 후 진행
			if (!confirm(message)) {
				return; // 확인하지 않으면 함수 종료
			}

			let url = "admin_host_approval.do";
			let param = "user_id=${param.user_id}&status=" + status;
			sendRequest(url, param, resultFn, "post");
		}

		// 콜백 함수
		function resultFn() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let data = xhr.responseText;
				let json = (new Function('return ' + data))();

				if (json[0].res === 'no') {
					alert("승인 처리 불가능합니다.");
				} else {
					alert("승인 처리 완료되었습니다.");
				}
			}

			location.href = "admin_host.do";
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
				<h3>회원 관리</h3>
			</div>

			<!--대시보드 영역 -->
			<div class="dashboard">

				<div class="form-container">
					<form>
						<input type="hidden" name="user_id" value="${vo.user_id}">
						<!-- 호스트 이름 -->
						<div class="form-box">
							<label>호스트 이름 <b class="req">*</b></label> 
							<input type="text" name="host_name" value="${vo.host_name}" readonly>
						</div>

						<!-- 호스트 소개 -->
						<div class="host-info-box">
							<label>호스트 소개 <b class="req">*</b></label> 
							<textarea readonly>${vo.host_info}</textarea>
						</div>

						<!-- 호스트 프로필 -->
						<div class="form-box">
							<label>호스트 프로필 <b class="req">*</b></label>
							<div class="upload-box">
								<div class="image-preview" id="in-thumbnail-preview">
									<img src="/hobee/resources/images/upload/${vo.host_img}" alt="호스트 프로필 미리보기">
								</div>
							</div>
						</div>

						<!-- 버튼 -->
						<div class="btn-box">
							<input type="button" value="돌아가기" onclick="history.back();">
							<input type="button" value="승인하기" onclick="approval(1);">
							<input type="button" value="승인거부" onclick="del(this.form);" class="del-btn">
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
