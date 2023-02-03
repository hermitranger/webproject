<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Enumeration"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고장터 :: 계정 찾기</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	function changePasswd() {
		console.log($("#user_passwd").val());
		console.log($("#confirmPasswd").val());

		if ($("#user_passwd").val() == $("#confirmPasswd").val()) {

			document.form1.action = "changePasswd.do";
			document.form1.submit();
		}else{
			
			$("#inform").css("color","red");
			$("#inform").html("잘못입력하셨습니다.");
			
		}
		
	}
</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<div class="wrapper fadeInDown">
		<div id="formContent">
			<form name="form1" method="post">
				<h2>변경할 비밀번호를 입력하세요.</h2>
				<br> <input type="text" id="user_passwd" name="user_passwd"
					style="background: black"><br>
				<h2>비밀번호 확인</h2>
				<br> <input type="text" id="confirmPasswd" name="confirmPasswd"
					style="background: black"><br>
				<div id="inform"></div>
				<input type="button" onclick="changePasswd()" value="비밀번호변경"
					style="background: black;"> 
					<input type="hidden" id="user_id" name="user_id" value="${user_id}">
			</form>
			<!-- 	<div id="formFooter">
				<input type="button" class="underlineHover" value="로그인"
					id="btnLogin" style="color:black;">
			</div> -->
		</div>
	</div>
	<link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>