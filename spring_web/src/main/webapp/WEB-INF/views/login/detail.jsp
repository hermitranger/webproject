<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">

<script src="http://code.jquery.com/jquery-3.6.1.min.js">
	
</script>
<script>
	/* $(document).ready()(function() */

	$(function() {

		var user_gender = "${dto.user_gender}";

		if (user_gender == "남") {

			$(":radio[name='user_gender'][value='남']").attr('checked', true);

		} else {

			$(":radio[name='user_gender'][value='여']").attr('checked', true);
		}//: =>input 요소를 선택함 예 :text 지정한 요소를 선택

	});

	function conf() {

		if (confirm("수정하시겠습니까?")) {
			// /빼먹으면 주소 못찾는다
			document.form1.action = "user_update.do";
			document.form1.submit();
		} else {

		}

	};
</script>





<title>중고장터 :: 회원정보 관리</title>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<h2 class="active">회원 정보 변경</h2>

			<form name="form1" method="post">
				<h2 class="active">아이디</h2>
				<input type="text" id="user_id" name="user_id"
					value="${dto.user_id}" readonly><br> 
					<h2 class="active" align = "center">비밀번호</h2>
					<input
					type="text" id="user_passwd" name="user_passwd"
					value="${dto.user_passwd}"><br> 
					<h2 class="active" align = "center">이름</h2>
					<br>
					<input type="text"
					id="user_name" name="user_name" value="${dto.user_name}"><br>
					<h2 class="active">생년월일</h2>
				<input type="text" id="user_birth" name="user_birth"
					value="${dto.user_birth}"><br> 
					<h2 class="active">성별</h2>
					<input type='radio'
					id='user_gender' name='user_gender' value='남'><h2 class="active">남</h2><input
					type='radio' id='user_gender' name='user_gender' value='여'><h2 class="active">여</h2>
				<br><h2 class="active">이메일</h2> <input type="text" id="user_email" name="user_email"
					value="${dto.user_email}"><br> <h2 class="active">전화번호</h2><input type="text"
					id="user_phone" name="user_phone" value="${dto.user_phone}"><br>
				<!-- 유저체크<input type="number" id="check"  name="check"><br> -->
				<br>
				<input type='button' value='회원정보수정' onclick="conf()" style="color:black;"> <input
					type='button' value='메인화면' onclick="location.href='/'" style="color:black;">
			</form>
		</div>
	</div>
	<link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>