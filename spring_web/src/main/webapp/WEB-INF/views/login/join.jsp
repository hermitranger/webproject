<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">

<script src="http://code.jquery.com/jquery-3.6.1.min.js">
	
</script>
<script>
	/* $(document).ready()(function() */

	function msg() {

		//var message=request.getAttribute("message");
		var message = "${message}";

		if (message == "") {
			return;
		}

		if (message != "") {

			$("#message").html(message);
		}

	};

	$(function() {

		$("#join").click(function() {

			/* 		var user=$("#user_id");
			 console.log(user); */
			if (($("#user_id").val()) == "") {
				alert("아이디를 입력하세요")
				//$("#user_id").focus();
				return;
			}

			//		var expid=/^[a-z0-9]{4,10}$/;

			//		if(!expid.test($("#user_id").val())){
			//			alert("아이디는 영문소문자, 숫자 4~10자리로 입력하세요.");
			//$("#user_id").focus();

			//			return;
			//		}

			if (($("#user_passwd").val()) == "") {
				alert("비밀번호를 입력하세요.")
				//$("#user_passwd").focus();
				return;
			}

			if (($("#user_name").val()) == "") {
				alert("이름을 입력하세요.")
				//$("#user_name").focus();
				return;
			}

			if (($("#user_birth").val()) == "") {
				alert("생년월일을 입력하세요.")
				//$("#user_birth").focus();
				return;
			}

			if (($("#user_gender").val()) == "") {
				alert("성별을 입력하세요.")
				//$("#user_gender").focus();
				return;
			}

			if (($("#user_email").val()) == "") {
				alert("이메일을 입력하세요.")
				//$("#user_email").focus();
				return;
			}
			var expemail = /\w+@\w+\.\w+(\.\w+)?$/;

			if (!expemail.test($("#user_email").val())) {
				alert("이메일 형식: a@a.com을 지켜주세요.");
				$("#message").val("사용할 수 없는 이메일 형식 입니다.");
				$("#user_email").val("");
				$("#user_email").focus();
				return;
			}

			if (($("#user_phone").val()) == "") {
				alert("전화번호를 입력하세요.")
				//$("#user_phone").focus();
				return;
			}

			document.form1.action = "/controller/join.do"
			document.form1.method = "post"
			document.form1.submit();

		});

	});

	function idcheck() {

		var user_id = $("#user_id").val();
		var params = {
			"user_id" : user_id
		};

		var expid = /^[a-z0-9]{4,10}$/;

		if (!expid.test($("#user_id").val())) {
			alert("아이디는 영문자, 숫자 4~10자리로 입력하세요.");
			$("#message").val("사용할 수 없는 아이디 입니다.");
			$("#user_id").val("");
			$("#user_id").focus();
			return;
		}

		/* ajax success:function(리턴값) $("#아이디").html(변수값) */

		$.ajax({
			type : "post",
			url : "/controller/idcheck.do",
			data : params,
			success : function(map) {

				//var message="${message}";
				//$("#message").html(${message});
				$("#message").html(map.message);

				/* var result2="${result2}";
				
				if((result2)!=""){
					$("#user_id").val(result2);
					return;
				} */

				$("#user_id").val(map.userid);
				//$("#user_id").val("");
				$("#user_id").focus();
			}

		});

	};
</script>





<title>중고장터 :: 회원가입</title>
</head>
<body onload="msg()">

<%@ include file="../include/menu.jsp"%>

	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<h2 class="active">회원가입란</h2>

			<!-- Login Form -->
			<form name="form1" method="post">
				 <input type="text" id="user_id" name="user_id"
			value="${dto.user_id}" class="fadeIn second"
					placeholder="아이디"> 
				<input type="button" value="아이디확인"
			onclick="idcheck()" class="fadeIn second">
			<div id = "message"></div>
			<br>
			<input type="text" id="user_passwd" name="user_passwd"
			value="${dto.user_passwd}" class="fadeIn third" placeholder="비밀번호">
			<br>
			<input type="text"
			id="user_name" name="user_name" value="${dto.user_name}" class="fadeIn third" placeholder="이름">
			<br>
			<input type="date" id="user_birth" name="user_birth"
			value="${dto.user_birth}" class="fadeIn forth">
			<br>
			<input type="radio" id="user_gender" name="user_gender" value="남" class="fadeIn forth">남 
			<input type="radio" id="user_gender" name="user_gender" value="여" class="fadeIn forth">여
			<br>
			<input type="text" id="user_email" name="user_email" value="${dto.user_email}" class="fadeIn forth" placeholder="이메일"><br>	
			<input type="text"
			id="user_phone" name="user_phone" value="${dto.user_phone}" class="fadeIn forth" placeholder="전화번호">
			
			<input type = "button" id="join" value = "회원가입">
			</form>

		</div>
	</div>
	<%-- <%@ include file="/menu" %> --%>
	<%-- <form name="form1">
		<h2>회원가입</h2>
		아이디 <input type="text" id="user_id" name="user_id"
			value="${dto.user_id}"><input type="button" value="아이디확인"
			onclick="idcheck()">
		<div id="message"></div>
		<br> 패스워드<input type="text" id="user_passwd" name="user_passwd"
			value="${dto.user_passwd}" class="fadeIn third" placeholder="password"><br> 이름<input type="text"
			id="user_name" name="user_name" value="${dto.user_name}"><br>
		생년월일<input type="text" id="user_birth" name="user_birth"
			value="${dto.user_birth}"><br> 성별<input type="radio"
			id="user_gender" name="user_gender" value="남">남 <input
			type="radio" id="user_gender" name="user_gender" value="여">여
		<br> 이메일<input type="text" id="user_email" name="user_email"
			value="${dto.user_email}"><br> 전화번호<input type="text"
			id="user_phone" name="user_phone" value="${dto.user_phone}"><br>
		<!-- 유저체크<input type="number" id="check"  name="check"><br> -->
		<button id="join">회원가입</button>

	</form>
 --%>
 <link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>