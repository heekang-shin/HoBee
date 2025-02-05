<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>호스트 신청</title>
        
        <!-- 파비콘 -->
        <link rel="icon" href="${pageContext.request.contextPath}/resources/images/Favicon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/host/host_apply.css">
        
        <!-- contextPath 변수 정의 및 hostFunction.js 포함 -->
        <script>
            const contextPath = '${pageContext.request.contextPath}';
        </script>
        <script src="${pageContext.request.contextPath}/resources/js/hostFunction.js"></script>
        <script>
        let isIdAvailable = false; // 아이디 중복 체크 여부 플래그

        // 중복 체크 함수
        async function chk() {
            let hostname = document.getElementById('host_name_input').value.trim();
            let checkResultLabel = document.getElementById('checkResult');

            if (!hostname) {
                checkResultLabel.innerText = "호스트 이름을 입력해 주세요.";
                checkResultLabel.style.color = "red";
                checkResultLabel.style.marginBottom = "10px";
                return;
            }

            try {
                let response = await fetch(contextPath + "/check_host_duplicate.do", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "host_name=" + encodeURIComponent(hostname)
                });

                let result = await response.text();
                console.log("중복 체크 응답:", result.trim());

                if (result.trim() === "fail") {
                    checkResultLabel.innerText = "이미 사용 중인 아이디입니다.";
                    checkResultLabel.style.color = "red";
                    isIdAvailable = false;
                } else if (result.trim() === "true") {
                    checkResultLabel.innerText = "사용 가능한 아이디입니다.";
                    checkResultLabel.style.color = "green";
                    isIdAvailable = true;
                } else {
                    checkResultLabel.innerText = "알 수 없는 오류가 발생했습니다.";
                    checkResultLabel.style.color = "red";
                }

                checkResultLabel.style.marginBottom = "10px";
            } catch (error) {
                console.error("오류 발생:", error);
                checkResultLabel.innerText = "서버와의 통신 중 오류가 발생했습니다.";
                checkResultLabel.style.color = "red";
                checkResultLabel.style.marginBottom = "10px";
            }
        }

        // 수정된 submitForm 함수
        async function submitForm() {
            if (!isIdAvailable) {
                alert("아이디 중복 확인을 해주세요.");
                return;
            }

            // 폼 요소 가져오기
            const form = document.getElementById('signupForm');
            const formData = new FormData(form);

            try {
                let response = await fetch(contextPath + "/add_host.do", {
                    method: "POST",
                    body: formData
                });

                let result = await response.text();
                console.log("호스트 신청 응답:", result.trim());

                if (result.trim() === "success") {
                    alert("호스트 신청이 완료되었습니다.");
                    // 성공 시 원하는 페이지로 이동
                    window.location.href = contextPath + "/main.do"; // 예: 성공 페이지
                } else {
                    alert("호스트 신청 중 오류가 발생했습니다: " + result);
                }
            } catch (error) {
                console.error("오류 발생:", error);
                alert("서버와의 통신 중 오류가 발생했습니다.");
            }
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
            <form id="signupForm" name="signupForm" novalidate enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/add_host.do">
                <div class="notice">
                    <p>
                        Hobee에서 호스트 관리 승인까지 <span>2~3일</span> 소요됩니다.
                    </p>
                </div>
                
                <div class="form-group black-line name-box">
                    <input type="hidden" name="user_id" value="${sessionScope.loggedInUser.user_Id}">
                    <input type="hidden" name="approval" value="0">
                    <label for="host_name_input">호스트 네임<b class="req">*</b></label>
                    <input type="text" id="host_name_input" name="host_name" placeholder="호스트 이름을 입력해 주세요" required>
                    <input type="button" id="check_btn" value="중복확인" onclick="chk();">
                </div>
                
                <div id="checkResult"></div>
                
                <div class="form-group">
                    <label for="host_info">호스트 소개 <b class="req">*</b></label>
                    <textarea rows="15" cols="90" placeholder="호스트 소개 내용을 입력해 주세요." name="host_info" id="host_info" required></textarea>
                </div>

                <!-- 호스트 프로필 -->
                <div class="form-group host_img">
                    <label>호스트 사진 <b class="req">*</b></label>
                    <div class="upload-box">
                        <div class="image-preview" id="host-thumbnail-preview">
                            <img src="${pageContext.request.contextPath}/resources/images/img_icon.png" alt="상세이미지 미리보기">
                        </div>
                        <div class="upload-inner">
                            <p>
                                호스트 사진<span> (권장크기 : 60x60px)</span>
                            </p>
                            <div class="button-group">
                                <input type="file" name="host_image_filename" id="host-thumbnail-input" accept=".png" required
                                    onchange="updateImage('host-thumbnail-preview', 'host-thumbnail-input', 'preview')">
                                <button type="button" class="delete-btn"
                                    onclick="updateImage('host-thumbnail-preview', 'host-thumbnail-input', 'remove')">삭제</button>
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
