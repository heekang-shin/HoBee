// 헤더 스크롤
function initHeaderScroll() {
    window.addEventListener('scroll', function () {
        const header = document.getElementById('header');
        if (window.scrollY > 0) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });
}

// 파일 삭제 버튼 초기화
function initFileDelete() {
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
}

// 초기화 실행
document.addEventListener('DOMContentLoaded', function () {
    initHeaderScroll();
    initFileDelete();
});
