<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Hobee:호스트 신청페이지</title>
	<!-- 파비콘 -->
	<link rel="icon" href="/hobee/resources/images/Favicon.png">
	
	<!-- 공통 스타일 -->
	<link rel="stylesheet" href="/hobee/resources/css/host/common.css">
	<link rel="stylesheet" href="/hobee/resources/css/host/host_apply_form.css">
	   
	<!-- 헤더 스크롤 이펙트-->
	<script src="/hobee/resources/js/hostFunction.js"></script>
	
	<!-- 주소 -->
    <script src="/hobee/resources/js/address.js"></script>
    <script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Summernote -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // 프로그램 날짜 추가 버튼
            const addButton = document.querySelector('.add-btn');
            if (addButton) {
                addButton.addEventListener('click', addDate);
            }

            // 파일 삭제 버튼 초기화
            const deleteButton = document.getElementById('file-delete-btn');
            const fileInput = document.getElementById('file-input');

            if (deleteButton && fileInput) {
                deleteButton.addEventListener('click', () => {
                    if (fileInput.value) {
                        if (confirm("파일을 삭제하시겠습니까?")) {
                            fileInput.value = ""; // 파일 입력 필드 초기화
                            alert("파일이 삭제되었습니다.");
                        } else {
                            alert("파일 삭제가 취소되었습니다.");
                        }
                    } else {
                        alert("삭제할 파일이 없습니다.");
                    }
                });
            }

            // Summernote 초기화
            $('#editor').summernote({
                width: 'calc(100% - 200px)',
                height: 400,
                placeholder: '프로그램 상세 내용을 입력해 주세요.',
                toolbar: [
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['font', ['strikethrough', 'superscript', 'subscript']],
                    ['fontsize', ['fontsize']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['insert', ['link', 'picture', 'video']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ]
            });
        });

        // 프로그램 날짜 추가 함수
        function addDate() {
            const container = document.getElementById('date-container');
            if (!container) return; // 컨테이너가 없으면 종료

            // 현재 입력 필드 수 확인
            const currentCount = container.getElementsByClassName('date-box').length;

            // 최대 5개 제한
            if (currentCount >= 5) {
                alert('날짜 및 시간은 최대 5개까지만 추가할 수 있습니다.');
                return;
            }

            // 새로운 div로 각 입력 필드와 삭제 버튼을 묶음
            const newDiv = document.createElement('div');
            newDiv.className = 'date-box';
            newDiv.style.marginTop = '10px';

            // 날짜 입력 필드 생성
            const dateInput = document.createElement('input');
            dateInput.type = 'date';
            dateInput.name = 'hb_date[]';

            // 시간 입력 필드 생성
            const timeInput = document.createElement('input');
            timeInput.type = 'time';
            timeInput.name = 'hb_time[]';

            // 삭제 버튼 생성
            const deleteButton = document.createElement('button');
            deleteButton.type = 'button';
            deleteButton.textContent = '-삭제';
            deleteButton.style.width = '50px';
            deleteButton.style.height = '42px';
            deleteButton.style.border = '1px solid #D5292F';
            deleteButton.style.color = '#D5292F';
            deleteButton.style.borderRadius = '4px';
            deleteButton.style.backgroundColor = '#FCEEEE';
            deleteButton.onclick = function () {
                container.removeChild(newDiv);
            };

            // div에 입력 필드와 삭제 버튼 추가
            newDiv.appendChild(dateInput);
            newDiv.appendChild(timeInput);
            newDiv.appendChild(deleteButton);

            // 컨테이너에 div 추가
            container.appendChild(newDiv);
        }

        // 폼 제출 함수
        function send(form) {
            // 폼 데이터 가져오기
            const hbTitle = form.hb_title.value.trim();
            const hbPrice = form.hb_price.value.trim().replace(/,/g, '');
            const categoryNum = form.category_num.value;
            const hbDates = Array.from(document.getElementsByName('hb_date[]'));
            const dateValues = hbDates.map(dateField => dateField.value);
            const postStart = form.hb_poststart.value;
            const postEnd = form.hb_postend.value;
            const address = form.address.value.trim();
            const hbContent = $('#editor').summernote('code');
            const fileInput = document.getElementById('file-input');

            const password = form.password.value.trim();
            const confirmPassword = form.confirm_password.value.trim();

            // 유효성 검사
            if (!hbTitle) {
                alert("프로그램명을 입력해 주세요.");
                return;
            }

            if (!hbPrice || isNaN(hbPrice)) {
                alert("가격을 입력해 주세요.");
                return;
            }

            if (categoryNum === 'all') {
                alert("카테고리를 선택해 주세요.");
                return;
            }

            if (hbDates.length === 0 || dateValues.some(date => date === '')) {
                alert("모든 프로그램 날짜를 입력해 주세요.");
                return;
            }

            if (!postStart) {
                alert("모집 시작 날짜를 선택해 주세요.");
                return;
            }

            if (!postEnd) {
                alert("모집 종료 날짜를 선택해 주세요.");
                return;
            }

            if (!address) {
                alert("모임 장소를 입력해 주세요.");
                return;
            }

            if (!hbContent || hbContent.trim() === '') {
                alert("프로그램 내용을 입력해 주세요.");
                return;
            }

            if (!fileInput.value) {
                alert("대표 이미지를 업로드해 주세요.");
                return;
            }

            if (!password) {
                alert("비밀번호를 입력해 주세요.");
                return;
            }

            if (password.length < 6) {
                alert("비밀번호는 최소 6자 이상이어야 합니다.");
                return;
            }

            if (password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다.");
                return;
            }

            // 폼 전송
            form.action = 'apply_insert.do'; 
            form.method = 'post';
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

		<!--대시보드 영역-->
		<div class="dashboard">

		
		    <form enctype="multipart/form-data">
		        <input type="hidden" value="0" name="status"><!-- 게시상태 -->
		        <div class="form-container">
		            <div class="form-box">
		                <label>프로그램명&nbsp;<b class="req">*</b></label>
		                <input type="text" name="hb_title" placeholder="프로그램명을 입력해 주세요.">
		            </div>
		
		            <div class="form-box">
		                <label>가격&nbsp;<b class="req">*</b></label>
		                <input name="hb_price" type="text" placeholder="금액을 입력해 주세요."
		                    oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" />&nbsp;원
		            </div>
		
		            <div class="form-box">
		                <label>카테고리&nbsp;<b class="req">*</b></label>
		                <select name="category_num">
		                    <option value="all">전체</option>
		                    <option value="1">운동/스포츠</option>
		                    <option value="2">음악/악기</option>
		                    <option value="3">공예/만들기</option>
		                    <option value="4">자기계발</option>
		                    <option value="5">게임/오락</option>
		                    <option value="6">사교</option>
		                </select>
		                
		                 <select name="category_num">
		                    <option value="all">전체</option>
		                    <option value="1">운동/스포츠</option>
		                    <option value="2">음악/악기</option>
		                    <option value="3">공예/만들기</option>
		                    <option value="4">자기계발</option>
		                    <option value="5">게임/오락</option>
		                    <option value="6">사교</option>
		                </select>
		            </div>
		            
					<div class="form-box">
		                <label>인원 수&nbsp;<b class="req">*</b></label>
		                <input name="num_of_p" type="text" placeholder="최대 인원수를 입력해 주세요."
		                    oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" />&nbsp;명
		            </div>
		
		            <div class="form-box date-wrap">
		                <label>프로그램 날짜&nbsp;<b class="req">*</b></label>
		                <div id="date-container">
		                    <div class="date-box">
		                        <input type="date" name="hb_date[]">
		                        <input type="time" name="hb_time[]">
		                        <button type="button" class="add-btn">&#43추가</button>
		                    </div>
		                </div>
		            </div>
		
		            <div class="form-box post-box">
		                <label>모집 시작 날짜&nbsp;<b class="req">*</b></label>
		                <input type="date" name="hb_poststart">
		            </div>
		
		            <div class="form-box post-box">
		                <label>모집 종료 날짜&nbsp;<b class="req">*</b></label>
		                <input type="date" name="hb_postend">
		            </div>
		
		            <div class="form-box addr-container">
		                <label>모임 장소&nbsp;<b class="req">*</b></label>
		                <div class="addr-box">
		                    <input type="text" id="sample6_postcode" placeholder="우편번호">
		                    <input type="text" id="sample6_address" name="address" placeholder="주소"><br>
		                    <input type="text" id="sample6_detailAddress" name="detailaddress" placeholder="상세주소"><br>
		                    <input type="text" id="sample6_extraAddress" placeholder="참고항목">
		                </div>
		                <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
		            </div>
		
		            <!-- Summernote -->
		            <div class="form-box edit-box">
		                <label>프로그램 내용&nbsp;<b class="req">*</b></label>
		                <textarea id="editor" name="hb_content"></textarea>
		            </div>
		
		            <!-- 썸네일 -->
		            <div class="form-box">
		                <label>대표이미지&nbsp;<b class="req">*</b></label>
		                <div class="img-box">
		                    <input type="file" id="file-input">
		                    <button type="button" class="delete-btn" id="file-delete-btn">삭제</button>
		                </div>
		            </div>
		
		            <!-- 버튼 -->
		            <div class="btn-box">
		                <input type="button" value="취소하기" onclick="history.back();">
		                 <input type="button" value="제출하기" onclick="location.href='host_apply_insert.do'">
		            </div>
		        </div>
		    </form>
		    <!--신청 폼 끝 -->
			
			</div>
				
		</div>
	</div>
	</body>
</html>