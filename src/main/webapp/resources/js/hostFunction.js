// 헤더 스크롤
function initHeaderScroll() {
    window.addEventListener('scroll', function () {
        const header = document.getElementById('header');
        header.classList.toggle('scrolled', window.scrollY > 0);
    });
}

//이미지 미리보기 및 삭제 함수
function updateImage(previewId, inputId, action) {
    const preview = document.getElementById(previewId);
    const input = document.getElementById(inputId);

    if (action === 'preview') {
        const file = input.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                // 선택한 이미지 표시
                preview.querySelector('img').src = e.target.result;
            };
            reader.readAsDataURL(file);
        } else {
            alert("파일이 선택되지 않았습니다.");
        }
    } else if (action === 'remove') {
        const userConfirmed = confirm("파일을 삭제하시겠습니까?");
        if (userConfirmed) {
            // 기본 이미지로 복원
            preview.querySelector('img').src = '/hobee/resources/images/img_icon.png';

            // 파일 선택 초기화
            input.value = '';
            alert("파일이 삭제되었습니다.");
        } else {
            alert("파일 삭제가 취소되었습니다.");
        }
    }
}


// 초기화 실행
document.addEventListener('DOMContentLoaded', function () {
    initHeaderScroll();
});
