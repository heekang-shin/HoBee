<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>호스트 신청</title>
	
	<!-- 파비콘 -->
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	<link rel="stylesheet" href="resources/css/common.css">
	<link rel="stylesheet" href="resources/css/host/host_apply.css">
	
	<!-- host 공통 스크립트 -->
	<script src="/hobee/resources/js/hostFunction.js"></script>
	<script>
	let isIdAvailable = false; // 아이디 중복 체크 여부 플래그

    // 중복 체크 함수
    function chk() {
        let hostname = document.getElementById('host_name').value.trim();
        let checkResultLabel = document.getElementById('checkResult');

        if (!hostname) {
            // 아이디 입력 유효성 검사
            checkResultLabel.innerText = "호스트 이름을 입력해 주세요.";
            checkResultLabel.style.color = "red"; // 경고 메시지 스타일
            checkResultLabel.style.marginBottom = "10px";
            return;
        }

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "check_duplicate.do", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                let result = xhr.responseText.trim();
                console.log("중복 체크 응답:", result); // 디버깅용 서버 응답 출력
                if (result === "fail") {
                    checkResultLabel.innerText = "이미 사용 중인 아이디입니다.";
                    checkResultLabel.style.color = "red";
                    checkResultLabel.style.marginBottom = "10px";
                    isIdAvailable = false;
                } else if (result === "true") {
                    checkResultLabel.innerText = "사용 가능한 아이디입니다.";
                    checkResultLabel.style.color = "green";
                    checkResultLabel.style.marginBottom = "10px";
                    isIdAvailable = true;
                } else {
                    checkResultLabel.innerText = "알 수 없는 오류가 발생했습니다.";
                    checkResultLabel.style.color = "red";
                    checkResultLabel.style.marginBottom = "10px";
                }
            }
        };

        xhr.send("host_name=" + encodeURIComponent(host_name)); // 서버로 요청 데이터 전송
    }
	</script>
	
	</head>

	<body>
		<!--헤더-->
		<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
	
		<!-- 회원가입 제목 -->
		<div id="signupHeader">
			<h1 id="signupTitle">호스트 신청</h1>
		</div>
	
		<!-- 호스트 가입 폼 -->
		<div id="signupContainer">
			<form id="signupForm" name="signupForm" novalidate>
			
				<div class="notice">
					<p>
						Hobee에서 호스트 관리 승인까지 <span>2~3일</span> 소요됩니다.
					</p>
				</div>
				
				<div class="form-group black-line name-box">
			        <label for="id">호스트 네임<b class="req">*</b></label>
			        <input type="text" name="host_name" placeholder="호스트 이름을 입력해 주세요"></input>
			        <input type="button" id="host_name"value="중복확인" onclick="chk();"></input>
			      </div>
			      
     	 			<div id="checkResult"></div>
     	 		
				<div class="form-group">
					<label for="id">호스트 소개 <b class="req">*</b></label>
					<textarea rows="15" cols="90" placeholder="호스트 소개 내용을 입력해 주세요." name="host_info"></textarea>
				</div>

			<!-- 호스트 프로필 -->
			<div class="form-group host-img">
				<label>호스트 사진 <b class="req">*</b></label>
				<div class="upload-box">
					<div class="image-preview" id="in-thumbnail-preview">
						<img src="/hobee/resources/images/img_icon.png" alt="상세이미지 미리보기">
					</div>
					<div class="upload-inner">
						<p>
							호스트 사진<span> (권장크기 : 60x60px)</span>
						</p>
						<div class="button-group">
							<input type="file" name="in_image_filename" id="in-thumbnail-input" accept=".png"
								onchange="updateImage('in-thumbnail-preview', 'in-thumbnail-input', 'preview')">
							<button type="button" class="delete-btn"
								onclick="updateImage('in-thumbnail-preview', 'in-thumbnail-input', 'remove')">삭제</button>
						</div>
					</div>
				</div>
			</div>

			<div id="signupFooter">
					<button type="button" onclick="submitForm()">가입하기</button>
				</div>

		</form>
		</div>
	
	
		<!-- 푸터 -->
		<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
	</body>
</html>