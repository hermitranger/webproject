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
	$(function() {
		$("#btnLogin").click(function() {
			document.form1.action = "login.do";
			document.form1.submit();
		});
	});
</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<div class="wrapper fadeInDown">
		<div id="formContent">
			<form name="form1" method="post">
				<h2>회원님의 비밀번호는</h2>
				<br>
				<h3 class="active">${sessionScope.user_passwd}</h3>
			</form>
			<div id="formFooter">
				<input type="button" class="underlineHover" value="로그인"
					id="btnLogin">
			</div>
		</div>
	</div>
	<link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>