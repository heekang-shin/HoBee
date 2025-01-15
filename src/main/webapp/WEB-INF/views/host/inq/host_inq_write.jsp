<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee:문의글 답변</title>

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 -->
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_form.css">

<!-- 헤더 스크롤 이펙트-->
<script src="/hobee/resources/js/hostFunction.js"></script>

<script>
function send(f) {
    // 제목과 답변 내용 가져오기
    let title = f.title.value.trim(); // 입력값의 공백 제거
    let answer = f.answer.value.trim();

    // 제목과 답변 내용 검증
    if (title === '') {
        alert("답변 제목을 입력해 주세요.");
        f.title.focus();
        return false;
    }

    if (answer === '') {
        alert("답변 내용을 입력해 주세요.");
        f.answer.focus();
        return false;
    }

    // 폼 전송 설정
    f.method = 'post';
    f.action = 'inq_update.do';
    f.submit();
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
				<h3>문의 관리</h3>
			</div>

			<!--대시보드 영역 -->
			<div class="dashboard">
				<form>
					<input type="hidden" name="id" value="${vo.id}">
					<div class="form-container">
						<div class="form-box">
							<label>답변 제목</label>
							<input type="text" name="title" value="${vo.title}" placeholder="답변 제목을 입력해 주세요.">
						</div>
						
						<div class="form-box edit-box">
							<label>답변 내용 <b class="req">*</b></label>
							<textarea name="answer" cols="10" rows="25" placeholder="답변을 입력해 주세요." ></textarea>
						</div>

						<div class="form-box edit-box">
							<label>작성자 <b class="req">*</b></label>
							<input type="text" name="answer_writer">
						</div>
					
						
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
