document.addEventListener('DOMContentLoaded', function () {
    const categories = {
        "1": ["런닝", "자전거", "등산", "배드민턴"],
        "2": ["노래/보컬", "밴드/합주", "피아노", "현악기"],
        "3": ["미술/그림", "캔들/디퓨저/석고", "소품 공예", "자수/뜨개질"],
        "4": ["스터디", "투자/금융", "외국어", "책/독서"],
        "5": ["보드게임", "온라인게임", "콘솔게임", "방탈출"],
        "6": ["나이", "지역", "와인/커피", "맛집"]
    };

    const mainCategory = document.getElementById('main-category');
    const subCategory = document.getElementById('sub-category');

    mainCategory.addEventListener('change', function () {
        const selectedValue = this.value;

        // 하위 카테고리 초기화
        subCategory.innerHTML = '';

        if (selectedValue !== 'all' && categories[selectedValue]) {
            // 하위 카테고리 옵션 추가
            categories[selectedValue].forEach((subcategory) => {
                const option = document.createElement('option');
                option.value = subcategory;
                option.textContent = subcategory;
                subCategory.appendChild(option);
            });
            subCategory.disabled = false; // 활성화
        } else {
            // 상위 카테고리 선택되지 않은 경우
            const option = document.createElement('option');
            option.value = '';
            option.textContent = '전체';
            subCategory.appendChild(option);
            subCategory.disabled = true; // 비활성화
        }
    });
});
