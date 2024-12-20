<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hobee 모임신청페이지_폼</title>

    <!-- 주소 -->
    <script src="/hobee/resources/js/address.js"></script>
    <script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // 동적으로 날짜 입력 필드 추가
            function addDate() {
                const container = document.getElementById('date-container');

                // 현재 입력 필드 수 확인
                const currentCount = container.getElementsByClassName('date-box').length;

                // 최대 5개 제한
                if (currentCount >= 5) {
                    alert('날짜 및 시간은 최대 5개까지만 추가할 수 있습니다.');
                    return;
                }

                // 새로운 div로 각 입력 필드와 삭제 버튼을 묶음
                const newDiv = document.createElement('div');
                newDiv.style.marginTop = '10px';
                newDiv.className = 'date-box';

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
                deleteButton.textContent = '삭제';
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

            // 폼 데이터 전송 처리
            function send(f) {
                const hb_title = f.hb_title.value.trim();
                const hb_price = f.hb_price.value.trim();
                const category_num = f.category_num.value;

                const hb_dates = Array.from(document.getElementsByName('hb_date[]'));
                const dateValues = hb_dates.map(dateField => dateField.value);

                const poststart = f.hb_poststart.value;
                const postend = f.hb_postend.value;
                const address = f.address.value;
                const hb_content = f.hb_content ? f.hb_content.value : '';

                // 유효성 체크
                if (hb_title === '') {
                    alert("프로그램명을 입력해 주세요.");
                    return;
                }

                if (hb_price === '') {
                    alert("가격을 입력해 주세요.");
                    return;
                }

                if (category_num === 'all') {
                    alert("카테고리를 선택해 주세요.");
                    return;
                }

                if (hb_dates.length === 0 || dateValues.some(date => date === '')) {
                    alert("모든 프로그램 날짜를 입력해 주세요.");
                    return;
                }

                if (poststart === '') {
                    alert("모집 시작 날짜를 선택해 주세요.");
                    return;
                }

                if (postend === '') {
                    alert("모집 종료 날짜를 선택해 주세요.");
                    return;
                }

                if (address === '') {
                    alert("모임 장소를 입력해 주세요.");
                    return;
                }

                // 폼 전송 처리
                f.action = 'apply_insert.do';
                f.method = 'post';
                f.submit();
            }

            // 추가 버튼에 이벤트 연결
            document.querySelector('.add-btn').addEventListener('click', addDate);

            // 폼 제출 버튼에 이벤트 연결
            const form = document.querySelector('form');
            form.querySelector('input[type="button"][value="제출하기"]').onclick = function () {
                send(form);
            };
        });
    </script>

    <link rel="icon" href="/hobee/resources/images/Favicon.png">
    <link rel="stylesheet" href="/hobee/resources/css/main.css">
    <link rel="stylesheet" href="/hobee/resources/css/applyForm.css">
</head>

<body>
    <!-- 헤더 시작 -->
    <jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
    <!-- 헤더 끝 -->

    <!-- 메인텍스트 시작 -->
    <div class="page-title">
        <h1>모임등록</h1>
    </div>
    <!-- 메인텍스트 끝 -->

    <!-- 신청 폼 시작 -->
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
                    <option value="all">카테고리를 선택해 주세요.</option>
                    <option value="1">운동/스포츠</option>
                    <option value="2">음악/악기</option>
                    <option value="3">공예/만들기</option>
                    <option value="4">자기계발</option>
                    <option value="5">게임/오락</option>
                    <option value="6">사교</option>
                </select>
            </div>

            <div class="form-box date-wrap">
                <label>프로그램 날짜&nbsp;<b class="req">*</b></label>
                <div id="date-container">
                    <div class="date-box">
                        <input type="date" name="hb_date[]">
                        <input type="time" name="hb_time[]">
                        <button type="button" class="add-btn">추가</button>
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

            <!-- 버튼 -->
            <div class="btn-box">
                <input type="button" value="제출하기">
                <input type="button" value="취소하기" onclick="history.back();">
            </div>
        </div>
    </form>

    <!-- 신청 폼 끝 -->

    <!-- 푸터 시작 -->
    <jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
    <!-- 푸터 끝 -->

    <!-- top 버튼 시작 -->
    <a id="toTop" href="#">TOP</a>
    <!-- top 버튼 끝 -->
</body>
</html>
