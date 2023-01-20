<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	$(function() {
		$("#btnFindid").click(function() {
			document.form1.action = "findid_check.do";
			document.form1.submit();
		});
		$("#btnFindpasswd").click(function() {
			document.form1.action = "findpasswd.do";
			document.form1.submit();

		});
		$("#btnLogin").click(function() {
			document.form1.action = "login.do";
			document.form1.submit();
		});
	});
</script>
<title>중고장터 :: 아이디 찾기</title>
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
					<input type="text" id="user_email" name="user_email"
						class="fadeIn second" placeholder="email">
				</div>
			
			</form>
			<div id="formFooter">
				<input type="button" class="underlineHover" value="아이디 찾기"
					id="btnFindid">
				<!-- <input type="button" class="underlineHover"
					value="비밀번호 찾기" id="btnFindpasswd"> -->
				<input type="button" class="underlineHover" value="로그인"
					id="btnLogin">
				<div style="color: red">${message}</div>
			</div>
<%-- 			<h2>${sessionScope.user_id}입니다.</h2>
			<%
			session.invalidate();
			%>
			<h2>${sessionScope.user_passwd}입니다.</h2>
			<%
			session.invalidate();
			%> --%>
			<link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>