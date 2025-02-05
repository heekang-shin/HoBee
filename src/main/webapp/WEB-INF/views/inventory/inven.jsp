<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hobee 프로그램 목록</title>
    <link rel="stylesheet" href="/hobee/resources/css/inven.css">
    <link rel="icon" href="/hobee/resources/images/Favicon.png">
    <script src="/hobee/resources/js/httpRequest.js"></script>
    
    <script>
    // 카테고리 필터링 및 더보기 기능 구현
    document.addEventListener('DOMContentLoaded', () => {
        let visibleCount = 9; // 처음 보여줄 항목 수

        const buttons = document.querySelectorAll('.nav ul li button');
        const sections = document.querySelectorAll('.content');
        const moreBtn = document.getElementById('moreBtn');

        // active 클래스가 부여된 항목 중, 처음 visibleCount개에 visible 클래스를 추가
        function updateVisibility() {
            // 현재 카테고리 필터(active) 상태인 항목만 추출
            const filteredSections = Array.from(sections)
                                          .filter(section => section.classList.contains('active'));

            // filteredSections의 모든 항목에서 visible 클래스를 제거
            filteredSections.forEach(section => section.classList.remove('visible'));

            // filteredSections 중 처음 visibleCount개의 항목에 visible 클래스 추가
            filteredSections.slice(0, visibleCount)
                            .forEach(section => section.classList.add('visible'));

            // 더보기 버튼 노출 여부: 남은 항목이 있으면 보이고 없으면 숨김
            if(filteredSections.length > visibleCount) {
                moreBtn.style.display = 'block';
            } else {
                moreBtn.style.display = 'none';
            }
        }

        // 페이지 로드시 기본적으로 "전체 보기" 버튼 활성화 및 모든 항목 active 설정
        const defaultButton = document.querySelector('.nav ul li button[data-category="all"]');
        defaultButton.classList.add('active');
        sections.forEach(section => section.classList.add('active'));
        updateVisibility();

        // 카테고리 버튼 클릭 이벤트 처리
        buttons.forEach(button => {
            button.addEventListener('click', () => {
                const category = button.getAttribute('data-category');
                // 모든 버튼에서 active 제거 후, 클릭된 버튼만 active 처리
                buttons.forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');

                // 카테고리 변경 시 visibleCount 초기화
                visibleCount = 9;

                // 각 모임 항목의 active 클래스 설정
                sections.forEach(section => {
                    if(category === 'all' || section.getAttribute('data-category') === category) {
                        section.classList.add('active');
                    } else {
                        section.classList.remove('active');
                    }
                });
                updateVisibility();
            });
        });

        // "더보기" 버튼 클릭 시 visibleCount 증가 및 화면 업데이트
        moreBtn.addEventListener('click', () => {
            visibleCount += 9;
            updateVisibility();
        });
    });

    // 정렬방식 선택 (최신순, 인기순) - 기존 기능 유지
    function changeArr() {
        let selArr = document.getElementById("array_select").value;
        let bigcategory = (${cate_list[0].bigcategory});
        location.href="select_list.do?category="+bigcategory+"&arr="+selArr;
    }
    </script>
    
</head>
<body>
    <jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
    
    <!-- 카테고리 메뉴 시작 -->
    <div class="menu_wrap">
        <div class="menu_container">
            <ul class="menu_box aboutinner aos-item" data-aos="fade-up">
                <li>
                    <img src="/hobee/resources/images/sport_icon.png" alt="sport" onclick="location.href='select_list.do?category=1'">
                    <a href="select_list.do?category=1">운동&#47;스포츠</a>
                </li>
                <li>
                    <img src="/hobee/resources/images/music_icon.png" alt="music" onclick="location.href='select_list.do?category=2'">
                    <a href="select_list.do?category=2">음악&#47;악기</a>
                </li>
                <li>
                    <img src="/hobee/resources/images/crafts_icon.png" alt="craft" onclick="location.href='select_list.do?category=3'">
                    <a href="select_list.do?category=3">공예&#47;만들기</a>
                </li>
                <li>
                    <img src="/hobee/resources/images/self_icon.png" alt="self" onclick="location.href='select_list.do?category=4'">
                    <a href="select_list.do?category=4">자기계발</a>
                </li>
                <li>
                    <img src="/hobee/resources/images/game_icon.png" alt="game" onclick="location.href='select_list.do?category=5'">
                    <a href="select_list.do?category=5">게임&#47;오락</a>
                </li>
                <li>
                    <img src="/hobee/resources/images/gathering_icon.png" alt="gathering" onclick="location.href='select_list.do?category=6'">
                    <a href="select_list.do?category=6">사교</a>
                </li>
            </ul>
        </div>
    </div>
    <!-- 카테고리 메뉴 끝 -->
    
    <div class="inven_container">
        <!-- 사이드바: 세부 카테고리 -->
        <div class="sidebar">
            <nav class="nav">
                <ul>
                    <li><button data-category="all">전체 보기</button></li>
                    <c:forEach var="vo" items="${cate_list}">
                        <li><button data-category="${vo.category_num}">${vo.category_name}</button></li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
        
        <!-- 메인 컨텐츠: 모임 목록 및 정렬 -->
        <main class="main-content">
            <!-- 정렬 드롭다운 -->
            <select id="array_select" onchange="changeArr();">
                <option class="option" value="new">최신순</option>
                <option class="option" value="best">인기순</option>
            </select>
            
            <!-- 모임 목록 출력 (각 항목은 CSS의 .content 클래스 적용) -->
            <c:forEach var="vo" items="${hobee_list}">
                <section class="content" id="select-cate" data-category="${vo.category_num}">
                    <div class="con_box aboutinner aos-item" data-aos="fade-up" onclick="">
                        <img src="/hobee/resources/images/upload/${vo.s_image}" alt="thumbnail"
                             onclick="location.href='hobee_detail.do?hbidx=${vo.hb_idx}'">
                        <h2>${vo.hb_title}</h2>
                        <p>${vo.hb_price}원</p>
                        <span>1인당</span>
                    </div>
                </section>
            </c:forEach>
            
            <!-- 더보기 버튼 (초기엔 display:none; updateVisibility()에서 제어) -->
            <div class="more-container" style="text-align:center; margin-top:20px;">
                <button id="moreBtn" style="display:none;">더보기</button>
            </div>
        </main>
    </div>
    <br>
    <jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
</body>
</html>
