document.addEventListener('DOMContentLoaded', function () {
    const categories = {
        "1": [
            { id: 11, name: "런닝/등산" },
            { id: 12, name: "자전거" },
            { id: 13, name: "요가/헬스" },
            { id: 14, name: "구기종목" }
        ],
        "2": [
            { id: 21, name: "노래/보컬" },
            { id: 22, name: "밴드/합주" },
            { id: 23, name: "클래식" },
            { id: 24, name: "랩/힙합" }
        ],
        "3": [
            { id: 31, name: "제과/제빵" },
            { id: 32, name: "캔들/디퓨저/석고" },
            { id: 33, name: "미술/그림" },
            { id: 34, name: "자수/뜨개질" }
        ],
        "4": [
            { id: 41, name: "스터디" },
            { id: 42, name: "투자/금융" },
            { id: 43, name: "외국어" },
            { id: 44, name: "책/독서" }
        ],
        "5": [
            { id: 51, name: "보드게임" },
            { id: 52, name: "온라인게임" },
            { id: 53, name: "콘솔게임" },
            { id: 54, name: "방탈출" }
        ],
        "6": [
            { id: 61, name: "반려동물" },
            { id: 62, name: "맛집/지역" },
            { id: 63, name: "와인/커피" },
            { id: 64, name: "나이" }
        ]
    };

    const mainCategory = document.getElementById('main-category');
    const subCategory = document.getElementById('sub-category');
    const submitBtn = document.getElementById('submit-btn');

    // 상위 카테고리 선택 시 하위 카테고리 업데이트
    mainCategory.addEventListener('change', function () {
        const selectedValue = this.value;

        // 하위 카테고리 초기화
        subCategory.innerHTML = '';

        if (selectedValue !== 'all' && categories[selectedValue]) {
            // 하위 카테고리 옵션 추가
            categories[selectedValue].forEach((subcategory) => {
                const option = document.createElement('option');
                option.value = subcategory.id;
                option.textContent = subcategory.name;
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

    // 폼 제출
    submitBtn.addEventListener('click', function () {
        const selectedMain = mainCategory.value;
        const selectedSub = subCategory.value;

        if (selectedMain === 'all' || selectedSub === '') {
            alert('카테고리를 선택해주세요.');
            return;
        }

        // 서버로 데이터 전송
        fetch('/saveCategory', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                bigCategory: selectedMain,
                categoryNum: selectedSub
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('카테고리가 저장되었습니다.');
                } else {
                    alert('저장에 실패했습니다.');
                }
            })
            .catch(error => console.error('Error:', error));
    });
});
