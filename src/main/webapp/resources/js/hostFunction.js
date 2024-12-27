document.addEventListener('DOMContentLoaded', function () {
    const header = document.getElementById('header');
    const scrollThreshold = 50; // 스크롤 임계값 (px)

    window.addEventListener('scroll', function () {
        if (window.scrollY > scrollThreshold) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });
});
