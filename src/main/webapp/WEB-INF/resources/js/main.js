window.onload = function(){

    //메인배너 슬라이드
    setInterval(function(){
        $("#slide_container>ul").delay('2500');
        $("#slide_container>ul").animate({marginLeft:'-1860'},500);
        $("#slide_container>ul").delay('2500');
        $("#slide_container>ul").animate({marginLeft:'-3720'},500);
        $("#slide_container>ul").delay('2500');
        $("#slide_container>ul").animate({marginLeft:'0'},500);
    });

    //top버튼
    $(document).ready(function() {
      // top 버튼 클릭 시 부드럽게 스크롤
      $("#topBtn").click(function() {
          $('html, body').animate({
              scrollTop: 0
          }, 500); // 500ms 동안 스크롤
          return false;
      });
  
      // 페이지 스크롤에 따라 top 버튼 표시/숨기기
      $(window).scroll(function() {
          if ($(this).scrollTop() > 100) { // 100px 이상 스크롤 시 버튼 표시
              $('#topBtn').fadeIn();
          } else {
              $('#topBtn').fadeOut(); // 100px 이하 스크롤 시 버튼 숨기기
          }
      });
  });

    //AOS 스크립트 시작
    AOS.init({
            easing: 'ease-in-out-sine'
     });


}//window.onload








