<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	   
	<!-- host공통 스크립트-->
	<script src="/hobee/resources/js/hostFunction.js"></script>
	
	<!-- 주소 -->
    <script src="/hobee/resources/js/address.js"></script>
    <script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Summernote -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js"></script>
    
   <!-- 카테고리 -->
   <script src="/hobee/resources/js/category.js"></script>
   
    <script>
    document.addEventListener('DOMContentLoaded', () => {
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
            ],
            callbacks: {
                onImageUpload: function(files) {
                    uploadImage(files[0], this);
                }
            }
        });
    });

    // 이미지 업로드 함수
    function uploadImage(file, editor) {
        const formData = new FormData();
        formData.append("file", file);

        // 이미지 업로드 요청
        $.ajax({
            url: '/uploadImage', // 이미지 업로드를 처리할 서버 엔드포인트
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(url) {
                // 업로드된 이미지 URL을 에디터에 삽입
                $(editor).summernote('insertImage', url);
            },
            error: function() {
                alert('이미지 업로드 실패');
            }
        });
    }


        

        // 폼 제출 함수
        function send(form) {
            // 폼 데이터 가져오기
            
            /*타이틀*/
            let hb_title = form.hb_title.value;
            
            /*가격, 쉼표 제거*/
            let hb_price = form.hb_price.value.trim().replace(/,/g, ''); 
            form.hb_price.value = hb_price; // 제거된 값을 다시 폼에 설정
            
            /*카테고리*/
            let bigcategory = form.bigcategory.value;
            let category_name = form.category_name.value;
            
            /*인원수*/            
            let hb_tot_num = form.hb_tot_num.value; 
            
            /*날짜*/
            let hb_date = form.hb_date.value; 
            
            /*시간*/
            let hb_time = form.hb_time.value; 
            
            /*모임장소*/
		   	// 각 필드 값 가져오기
		    const postcode = document.getElementById('sample6_postcode').value.trim();
		    const address = document.getElementById('sample6_address').value.trim();
		    const detailAddress = document.getElementById('sample6_detailAddress').value.trim();
		    const extraAddress = document.getElementById('sample6_extraAddress').value.trim();
		
		    // 빈 값을 제외하고 주소 병합
		    const fullAddress = [postcode, address, detailAddress, extraAddress]
		        .filter(value => value) // 빈 문자열 제거
		        .join(' '); // 공백으로 병합
		
		    // 숨겨진 필드에 병합된 주소 설정
		    form.hb_address.value = fullAddress;

            /*웹에디터*/            
            // 에디터 내용 가져오기
		    let hb_content = $('#editor').summernote('code');
		
		    // 에디터 내용에서 HTML 태그 제거 후 확인
		    let strippedContent = $('<div>').html(hb_content).text().trim();
		    if (!strippedContent) {
		        alert("프로그램 내용을 입력해 주세요.");
		        return;
		    }
		
		    // 숨겨진 필드에 설정
		    form.hb_content.value = hb_content;

            /* 
            const dateValues = hbDates.map(dateField => dateField.value);
            const postStart = form.hb_poststart.value;
            const postEnd = form.hb_postend.value;
            
            const fileInput = document.getElementById('file-input');*/

            /* 유효성 검사	

            if (!hb_title) {
                alert("프로그램명을 입력해 주세요.");
                return;
            }
            
            if (!hb_price || isNaN(hb_price)) {
                alert("가격을 올바르게 입력해 주세요.");
                return;
            }
            
            if (bigcategory === 'all') {
                alert("카테고리를 선택해 주세요.");
                return;
            }

            if (category_name === 'all') {
                alert("상세 카테고리를 선택해 주세요.");
                return;
            }
            
          
            if (!hb_tot_num) {
                alert("최대 인원 수를 입력해 주세요.");
                return;
            }
            
            if (!hb_date) {
                alert("프로그램 날짜를 선택해 주세요.");
                return;
            }
            
            if (!hb_time) {
                alert("프로그램 시간을 선택해 주세요.");
                return;
            }
            
            if (!address) {
                alert("모임 장소를 입력해 주세요.");
                return;
            }
            */
            
            if (!hb_content || hb_content.trim() === '') {
                alert("프로그램 내용을 입력해 주세요.");
                return;
            }


            form.action = 'host_apply_insert.do'; 
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
		        <div class="form-container">
		            <div class="form-box">
		                <label>프로그램명&nbsp;<b class="req">*</b></label>
		                <input type="text" name="hb_title" placeholder="프로그램명을 입력해 주세요.">
		            </div>
		            
		            <div class="form-box">
				        <label>가격&nbsp;<b class="req">*</b></label>
				        <input type="text" name="hb_price" placeholder="금액을 입력해 주세요."
				            oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" />&nbsp;원
				    </div>

		
		            <div class="form-box">
		                <label>카테고리&nbsp;<b class="req">*</b></label>
		                <select name="bigcategory" id="main-category">
		                    <option value="all">전체</option>
		                    <option value="1">운동/스포츠</option>
		                    <option value="2">음악/악기</option>
		                    <option value="3">공예/만들기</option>
		                    <option value="4">자기계발</option>
		                    <option value="5">게임/오락</option>
		                    <option value="6">사교</option>
		                </select>
		                
		                  <select id="sub-category" name="category_name" disabled>
      					 	 <option value="all">전체</option>
  						  </select>
		            </div>
		            
					<div class="form-box">
		                <label>인원 수&nbsp;<b class="req">*</b></label>
		                <input type="number" name="hb_tot_num" placeholder="0">&nbsp;명
		            </div>
		            
		            <div class="form-box">
		                <label>날짜&nbsp;<b class="req">*</b></label>
		                <input name="hb_date" type="date">
		             </div>
		             
		             <div class="form-box">
		                <label>시간&nbsp;<b class="req">*</b></label>
		                <input name="hb_time" type="time">
		             </div>
		            
		            <div class="form-box addr-container">
					    <label>모임 장소&nbsp;<b class="req">*</b></label>
					    <div class="addr-box">
		         			<input type="hidden" name="hb_address">
					        <input type="text" id="sample6_postcode" name="postcode" placeholder="우편번호">
					        <input type="text" id="sample6_address" name="address" placeholder="주소"><br>
					        <input type="text" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소"><br>
					        <input type="text" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목">
					    </div>
					    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					</div>

		            <!-- Summernote -->
		            <div class="form-box edit-box">
		                <label>프로그램 내용&nbsp;<b class="req">*</b></label>
		                <input type="hidden" name="hb_content">
		                <textarea id="editor" name="hb_content"></textarea>
		            </div>
		
					<!-- 
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
		
		            
		 		-->
		 		
		
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
		                 <input type="button" value="제출하기" onclick="send(this.form);">
		            </div>
		        </div> 
		    </form>
		    <!--신청 폼 끝 -->
			
			</div>
				
		</div>
	</div>
	</body>
</html>