<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hobee:문의 답변</title>

<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 -->
<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
<link rel="stylesheet" href="/hobee/resources/css/host/host_inq_list.css">

<!-- 헤더 스크롤 이펙트-->
<script src="/hobee/resources/js/hostFunction.js"></script>

<script>
	function del() {
	    if (confirm("정말 삭제 하시겠습니까?")) {
	    	window.location.href = 'inq_del.do?id=${vo.id}';
	    } else {
	       alert("삭제가 취소되었습니다.");
	    }
	}
	
</script>

<script>
function modify(){
	 if (confirm("정말 수정 하시겠습니까?")) {
	    	window.location.href = 'inq_write_update.do?id=${vo.id}';
	    } else {
	       alert("수정 취소되었습니다.");
	    }
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

				<!-- 리스트  -->
				<div class="inq-container">
					<div class="inq-box">
					<!-- 사용자 -->
					<div class="inq-question-header">
						<h3>${vo.title}</h3>
					</div>

					<!-- 사용자 정보 -->
					<div class="inq-detial">
						<div class="inq-writer">
							<h4>작성자</h4>
							<p>${vo.writer}</p>
						</div>

						<div class="inq-date">
							<h4>등록일</h4>
							<p>${vo.created_date}</p>
						</div>

						<div class="inq-answer">
							<h4>답변상태</h4>
							<c:set var="btnClass"
								value="${!empty vo.answer ? 'yes-answer' : 'no-answer'}" />
							<span class="${btnClass}">${!empty vo.answer ? '답변 완료' : '답변 미완료'}</span>
						</div>
					</div>

					<!-- 사용자 질문 -->
					<div class="inq-con">
						<P>${vo.content}</P>
					</div>
					</div>

					<!--답변이 없는 경우 -->
					<c:choose>
						<c:when test="${empty vo.answer}"></c:when>
					
					
					<c:otherwise>
					<!-- host 답변 영역 -->
					<div class=answer-box>
						<div class="answer-title">
							<h4><span>답변</span>${vo.title}</h4>
						</div>
						
						<div class=answer-date>
							<h4>등록일</h4>
							<p>${vo.answer_date}</p>
						</div>
						
						<!-- host 답변 -->
						<div class="answer-con">
							<p>${vo.answer}</p>
						</div>
					</div>
					</c:otherwise>
					</c:choose>
		
					<div class="btn-box">
						<input type="button" class="list-btn" value="목록으로" onclick="location.href='inq_list.do';">


						<div class="btn-right">
							<!-- vo.answer가 null이면 "작성하기" 버튼 -->
							<c:choose>
								<c:when test="${empty vo.answer}">
									<input type="button" class="write-btn" value="작성하기" onclick="location.href='inq_write.do?id=${vo.id}';">
								</c:when>
								<c:otherwise>
									<!-- vo.answer가 null이 아니면 "수정하기","삭제하기" 버튼 -->
									<input type="button" class="mod-btn" value="수정하기" onclick="modify();">
									<input type="button" class="del-btn" value="삭제하기"onclick="del();">
								</c:otherwise>
							</c:choose>
						</div>
					</div>
			
				</div>
				
			</div>

		</div>
	</div>
</body>
</html>
