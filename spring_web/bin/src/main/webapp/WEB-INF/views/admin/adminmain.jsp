<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 홈</title>
</head>
<body>
	<%@ include file="include/adminmenu.jsp"%>

	<c:if test="${sessionScope.user_id != null}">
		<h2>${sessionScope.user_name}( ${sessionScope.user_id} ) 님 어서오세요.</h2>
	</c:if>
</body>
</html>