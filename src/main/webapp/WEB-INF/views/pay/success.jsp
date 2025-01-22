<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>결제 성공</title>
  <script>
    // 부모 창으로 데이터 전달 및 새 창 닫기
    window.onload = function () {
      // 결제 성공 데이터를 부모 창에 전달
      const paymentData = {
        orderId: "${user.id}", // 결제 정보 예시
        orderName: "${hobee.hb_title}",
        price: "${price}",
      };

      // 부모 창의 함수 호출 (opener가 부모 창을 참조)
      if (window.opener && !window.opener.closed) {
        window.opener.receivePaymentData(paymentData); // 부모 창 함수 호출
        window.close(); // 현재 창 닫기
      } else {
        alert("부모 창이 열려 있지 않습니다.");
      }
    };
  </script>
</head>
<body>
  <h1>결제가 성공적으로 완료되었습니다!</h1>
</body>
</html>