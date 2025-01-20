<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 파비콘 -->
<link rel="icon" href="/hobee/resources/images/Favicon.png">

<!-- 공통 스타일 시트 -->
<link rel="stylesheet" href="/hobee/resources/css/main.css">

<!-- 회원탈퇴 스타일 시트 -->
<link rel="stylesheet" href="/hobee/resources/css/mypage/user_delete_form.css">


<title>회원탈퇴</title>


<script>
		
		function user_delete(f){
			let user_pwd= f.user_pwd.value;
			 let pwd_c=f.pwd_c.value;
			 
			 
			 
			if(pwd_c ===''){
				alert("비밀번호를 입력하세요");
				return;
			}
			
		
			 f.action="mypage_user_delete.do";
		     f.method='get';  
		     f.submit();
		
		}
		
		
		</script>

</head>
<body>
	  	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/header/header.jsp"></jsp:include>
	


	<jsp:include page="mypage_index.jsp" />

	<form>
	
	<input type="hidden" name="user_Id" value="${vo.user_Id}">
	<input type="hidden" name="user_pwd" value="${vo.user_pwd }">	
		<table>
		
			<colgroup>
			<col width="30%" />
			<col width="70%" />

		</colgroup>
			
		
			<tr>
				<td colspan="2" class="pwd_check">비밀번호 재확인</td>
			</tr>

			<tr>
				<th>아이디</th>
				<td>${vo.id}</td>
				<!-- <input name="id" value="$sw{vo.id}"> -->
			</tr>

			<tr>
				<th>비밀번호</th>
				<td><input name="pwd_c"  type="password"></td>
			</tr>

			
			<tr>
			<td class="check" colspan="2">
				<input type="button" value="확인" onclick="user_delete(this.form);">
			</td>
             </tr>
		</table>
	</form>

	
<!--푸터  -->
	
<jsp:include page="/WEB-INF/views/footer/footer.jsp"></jsp:include>
	


</body>
</html>