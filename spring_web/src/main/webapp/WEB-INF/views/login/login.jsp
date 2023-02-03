<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고장터 :: 로그인</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	$(function() {
		$("#btnLogin").click(function() {
			var user_id = $("#user_id").val();
			var user_passwd = $("#user_passwd").val();
			if (user_id == "") {
				alert("아이디를 입력하세요.");
				$("#user_id").focus();
				return;
			}
			if (user_passwd == "") {
				alert("비밀번호를 입력하세요.");
				$("#user_passwd").focus();
				return;
			}
			document.form1.action = "/login.do"; //"location.href='URL'"; 형태나 직접 URL형태
			document.form1.submit();
		});
		$("#btnJoin").click(function() {
			document.form1.action = "/join.page";
			document.form1.submit();
		});
		$("#btnFind_id").click(function() {
			document.form1.action = "/findId.page";
			document.form1.submit();
		});
		$("#btnFind_passwd").click(function() {
			document.form1.action = "/findPasswd.page";
			document.form1.submit();
		});
	});
</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>

	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<h2 class="active">로그인하세요.</h2>

			<div class="fadeIn first">
				<img src="/resources/images/user.png" id="icon" alt="User Icon" />
			</div>

			<!-- Login Form -->
			<form name="form1" method="post">
				<input type="text" id="user_id" name="user_id" class="fadeIn second"
					placeholder="userid" > 
				<input type="password" id="user_passwd" name="user_passwd" class="fadeIn third" placeholder="password"> 
				<input type="button" id="btnLogin" value = "로그인" class="fadeIn fourth" style="color:black;">

				<div>
					<c:if test="${message == 'withdrawal' }">
						<p style="color: red;">회원탈퇴한 아이디입니다.</p>
					</c:if>
					<c:if test="${message == 'error' }">
						<p style="color: red;">아이디 또는 비밀번호가 일치하지 않습니다.</p>
					</c:if>
					<c:if test="${message == 'logout' }">
						<p style="color: red;">로그아웃되었습니다.</p>
					</c:if>
					<c:if test="${param.message == 'nologin' }">
						<p style="color: blue;">로그인 하신 후 사용하세요.</p>
					</c:if>
				</div>
			</form>

			<!-- Remind Passowrd -->
			<div id="formFooter">
				<p align="center">아이디나 비밀번호를 잊어버리셨나요?</p>
				<input type="button" class="underlineHover" id="btnFind_id" value = "아이디 찾기" style="color:black;">
				<input type="button" class="underlineHover" id="btnFind_passwd" value = "비밀번호 찾기" style="color:black;">
				<p align="center">아직 계정이 없으신가요?</p>
				<input type="submit" class="underlineHover" id="btnJoin" value = "회원가입하기" style="color:black;">
			</div>

		</div>
	</div>
<link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>