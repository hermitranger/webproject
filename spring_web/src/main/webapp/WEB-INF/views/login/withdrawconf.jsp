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
<form name="form1">
비밀번호 확인<input type="password" id='user_passwd' name='user_passwd'>
<input type="button" onclick="confirmpasswd()" value="입력">
</form>
${message}
</body>
</html>