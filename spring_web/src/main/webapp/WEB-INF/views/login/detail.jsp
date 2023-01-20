<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js">
	
</script>
<script>
	function passwdch() {

		document.form1.type = "post"
		document.form1.action = "check_passwd.do"
		document.form1.submit();

	};
</script>

</head>
<body>
<%@ include file="../include/menu.jsp"%>
	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<h2 class="active">비밀번호를 입력하세요.</h2>
			<form name="form1" method="post">
				<input type="text" id='user_passwd' name='user_passwd'> <input
					type="button" onclick="passwdch()" value="입력">
			</form>
			<div><p style="color: red;">${message}</p></div>
		</div>
	</div>
	<link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>