<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	$(function() {
		$("#btnFindpasswd").click(function() {
			document.form1.action = "findpasswd_check.do";
			document.form1.submit();

		});
		$("#btnLogin").click(function() {
			document.form1.action = "login.do";
			document.form1.submit();
		});
	});
</script>
<title>중고장터 :: 비밀번호 찾기</title>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>

	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<h2 class="active">아이디 찾기</h2>
			<form name="form1" method="post">

				<div>
					<input type="text" id="user_name" name="user_name"
						class="fadeIn first" placeholder="name">
				</div>
				<div>
					<input type="text" id="user_id" name="user_id"
						class="fadeIn second" placeholder="id">
				</div>
				<div>
					<input type="text" id="user_email" name="user_email"
						class="fadeIn third" placeholder="email">
				</div>

			</form>
			<div id="formFooter">
				<input type="button" class="underlineHover"
					value="비밀번호 찾기" id="btnFindpasswd" style="color:black;"> 
				<input type="button" class="underlineHover" value="로그인"
					id="btnLogin" style="color:black;">
				<div style="color: red">${message}</div>
			</div>
			<link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>