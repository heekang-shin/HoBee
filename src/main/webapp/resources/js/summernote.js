document.addEventListener('DOMContentLoaded', () => {
    $('#editor').summernote({
        width: 'calc(100% - 200px)',
        height: 400,
        lang: 'ko-KR',
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
            onImageUpload: function (files) {
                for (let i = 0; i < files.length; i++) {
                    uploadImage(files[i], this);
                }
            }
        }
    });

    function uploadImage(file, editor) {
        const data = new FormData();
        data.append('file', file);

        $.ajax({
            url: '/images/upload', // 서버에서 이미지를 처리할 URL
            method: 'POST',
            data: data,
            processData: false,
            contentType: false,
            success: function (response) {
                if (response && response.url) {
                    // 서버로부터 반환된 URL을 에디터에 추가
                    $(editor).summernote('insertImage', response.url);
                    console.log(data);
                } else {
                    alert('이미지 업로드에 실패했습니다.');
                }
            },
            error: function () {
                alert('이미지 업로드 중 오류가 발생했습니다.');
            }
        });
    }
});
