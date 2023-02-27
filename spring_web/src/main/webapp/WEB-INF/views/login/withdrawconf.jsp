<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고장터 :: 계정 탈퇴</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js">
</script>
<script>
function confirmpasswd(){
	
	document.form1.type="post"
	document.form1.action="withdraw_confirm.do"
	document.form1.submit();
	
};

/* function conf(){
	
	if( confirm("정말 탈퇴하시겠습니까?") ){
		// /빼먹으면 주소 못찾는다
		document.form1.action="user_update.do";
		document.form1.submit();
	}else{
		
		
	}
	
}; */


</script>

</head>
<body>
<%@ include file="../include/menu.jsp"%>
	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<h2 class="active">비밀번호를 입력하세요.</h2>
			<form name="form1" method="post">
				<input type="password" id='user_passwd' name='user_passwd'> <input
					type="button" onclick="confirmpasswd()" value="입력" style = "color:black;">
			</form>
			<div><p style="color: red;">${message}</p></div>
		</div>
	</div>
	<link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>