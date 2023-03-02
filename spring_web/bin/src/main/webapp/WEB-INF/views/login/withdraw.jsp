<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
function conf(){
	
	if( confirm("정말 탈퇴하시겠습니까?") ){
		// /빼먹으면 주소 못찾는다
		document.form1.type="post"
		document.form1.action="user_withdraw.do"
		document.form1.submit();
	}else{
		document.location.href="/"
		
	}
	
};
</script>
<meta charset="UTF-8">
<title>중고장터 :: 회원탈퇴</title>
</head>
<body onload="conf()">
<form name="form1">
<input type='hidden' value='${dto }' >
</form>
</body>
</html>