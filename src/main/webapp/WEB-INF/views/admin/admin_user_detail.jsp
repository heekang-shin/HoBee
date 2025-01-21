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
		function modify(form) {
			// 폼 데이터 가져오기
			let id = form.id.value;
			let user_name = form.user_name.value;
			let phone = form.phone.value;
			let user_email = form.user_email.value;
			let lv = form.lv.value;
	
			//유효성 검사
			if (!id) {
				alert("아이디를 입력해 주세요.");
				document.getElementsByName("id")[0].focus();
				return;
			}
	
			if (!user_name) {
				alert("이름을 입력해 주세요.");
				document.getElementsByName("user_name")[0].focus();
				return;
			}
	
			if (!phone) {
				alert("연락처를 입력해 주세요.");
				document.getElementsByName("phone")[0].focus();
				return;
			}
	
			if (!user_email) {
				alert("이메일을 입력해 주세요.");
				document.getElementsByName("user_email")[0].focus();
				return;
			}
	
			if (!lv) {
				alert("회원 레벨을 입력해 주세요.");
				document.getElementsByName("lv")[0].focus();
				return;
			}
			
			if (!confirm("정말 수정 하시겠어요?")) {
				return;
			}
	
			form.method = 'post';
			form.action = 'user_admin_update.do';
			form.submit();
	
		}
	</script>
	
	<script>
		function del(f) {
	
			if (!confirm("정말 삭제 하시겠어요?")) {
				return;
			}
	
			f.method = 'post';
			f.action = 'user_admin_del.do';
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
				<h3>회원 관리</h3>
			</div>

			<!--대시보드 영역 -->
			<div class="dashboard">

				<div class="form-container">
					<form>
						<input type="hidden" name="user_Id" value="${vo.user_Id}">

						<!-- 아이디 -->
						<div class="form-box">
							<label>아이디 <b class="req">*</b></label> <input type="text"
								name="id" value="${vo.id}" readonly>
						</div>

						<!-- 회원 이름 -->
						<div class="form-box">
							<label>이름 <b class="req">*</b></label> <input type="text"
								name="user_name" value="${vo.user_name}">
						</div>

						<!-- 연락처 -->
						<div class="form-box">
							<label>연락처 <b class="req">*</b></label> <input type="text"
								name="phone" value="${vo.phone}">
						</div>

						<!-- 이메일 -->
						<div class="form-box">
							<label>이메일 <b class="req">*</b></label> <input type="text"
								name="user_email" value="${vo.user_email}">
						</div>

						<!-- 등급 -->
						<div class="form-box">
							<label>등급 <b class="req">*</b></label> <input type="text"
								name="lv" value="${vo.lv}" placeholder="등급을 입력해 주세요.">
						</div>
						<!-- 버튼 -->
						<div class="btn-box">
							<input type="button" value="취소하기" onclick="history.back();">
							<input type="button" value="수정하기" onclick="modify(this.form);">
							<input type="button" value="강제탈퇴" onclick="del(this.form);">
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
