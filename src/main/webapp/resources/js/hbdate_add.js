     // 프로그램 날짜 추가 버튼
            const addButton = document.querySelector('.add-btn');
            if (addButton) {
                addButton.addEventListener('click', addDate);
            }
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
