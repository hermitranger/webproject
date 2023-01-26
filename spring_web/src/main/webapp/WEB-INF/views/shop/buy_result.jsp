<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>buy.jsp</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
<%@ include file="../include/menu.jsp"%>
	<h3>판매 완료</h3>
	<div>
		<input type="button" value="판매 목록" onclick="location.href='/user/user_deal_buylist.do'">
		<input type="button" value="상품 목록" onclick="location.href='/shop/list.do'">
	</div>
	
</body>
</html>
