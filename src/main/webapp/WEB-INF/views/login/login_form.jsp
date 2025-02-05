<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
  	<title>로그인 페이지</title>
	<link rel="stylesheet" href="/hobee/resources/css/common.css">
    <link rel="stylesheet" href="resources/css/loginform.css">
    <script src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
    
    <script>
    function login() {
        let id = document.getElementById("id").value.trim();
        let password = document.getElementById("password").value.trim();

        // 입력 값 확인
        if (!id || !password) {
            alert("아이디와 비밀번호를 입력하세요");
            return;
        }

        // 로그 출력 (여기서 실행)
  	//	console.log("로그인 요청:", id, password);
        // 이후 로그인 처리 로직 추가...
        
       
	    // URL과 파라미터 구성
	    let url = "Login.do";
	    let param = "id=" + encodeURIComponent(id) + 
                "&password=" + encodeURIComponent(password);

        // AJAX 요청
    //	console.log("여기까지 오나 ?:", id, password);
        sendRequest(url, param, loginResult, "post");
    }

    function loginResult() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            let result = xhr.responseText.trim(); // 서버 응답 처리
            if (result === "success") {
               // console.log("로그인 요청: id = " + id + ", password = " + password);
                window.location.href = `${pageContext.request.contextPath}/main.do`; // 메인 페이지로 이동
            } else {
                alert("아이디 또는 비밀번호가 잘못되었습니다.");
            }
        }
    }
    
    </script>
    
    
    
</head>
<body>
	
		<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
		
		 <div class="login-container">
        <h1>로그인</h1>
        <form onsubmit="event.preventDefault(); login();">
            <div class="input-group">
                <label for="username">아이디</label>
                <input type="text" id="id" placeholder="아이디를 입력해주세요.">
            </div>
            <div class="input-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" placeholder="비밀번호를 입력해주세요.">
            </div>
            <input type="button" class="login-button" value="로그인" onclick="login();">
        </form>
        <div class="links">
            <a href="find.do" class="find">아이디/비밀번호 찾기</a><a href="CreateAccount_form.do">회원가입</a>
        </div>
        
		 </div>
		 
		 <!-- 소셜 -->
		 <div class="social-box">
	        <div class="social-login">
	            <a href="naver_login.do">
	           	 <img src="resources/images/naver.png" alt="네이버 로그인" class="social-icon">
	            </a>
	            
	           	<a href="${pageContext.request.contextPath}/kakao/kakao_login.do">
	    		<img src="${pageContext.request.contextPath}/resources/images/kakao.png" alt="카카오톡 로그인" class="social-icon">
	    		</a>
	        </div>
        </div>
        
        <!-- 푸터 -->
    <jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
    
</body>

</html>