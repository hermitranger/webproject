<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고상점-상품수정</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	function product_delete() {
		if (confirm("해당 상품을 삭제하시겠습니까?")) {
			document.product_inform.action = "/shop/delete.do";
			document.product_inform.submit();
		}
	}

	function product_update() {
		var product_name = document.product_inform.product_name.value;
		var product_price = document.product_inform.product_price.value;
		var product_detail = document.product_inform.product_detail.value;
		if (product_name == "") {
			alert("상품명을 입력하세요.");
			document.product_inform.product_name.focus();
			return;
		}
		if (product_price == "") {
			alert("가격을 입력하세요.");
			document.product_inform.price.focus();
			return;
		}
		if (product_detail == "") {
			alert("상품설명을 입력하세요.");
			document.product_inform.product_detail.focus();
			return;
		}
		document.product_inform.action = "/shop/update.do";
		document.product_inform.submit();
	}
</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>

	<form name="product_inform" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>상품이미지</td>
				<td><img src="/resources/images/${dto.filename}" width="300px"
					height="300px"> <br> <input type="file" name="file1">
				</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input name="product_name" value="${dto.product_name}"></td>
			</tr>
			<tr>
				<td>상품종류</td>
				<td><select name="product_cate" id="product_cate">
						<option value="난방기구"
							<c:out value="${dto.product_cate == '난방기구' ? 'selected' : '' }"/>>난방기구</option>
						<option value="냉방기구"
							<c:out value="${dto.product_cate == '냉방기구' ? 'selected' : '' }"/>>냉방기구</option>
						<option value="영상기구"
							<c:out value="${dto.product_cate == '영상기구' ? 'selected' : '' }"/>>영상기구</option>
						<option value="음향기구"
							<c:out value="${dto.product_cate == '음향기구' ? 'selected' : '' }"/>>음향기구</option>
						<option value="주방기구"
							<c:out value="${dto.product_cate == '주방기구' ? 'selected' : '' }"/>>주방기구</option>
						<option value="청소기구"
							<c:out value="${dto.product_cate == '청소기구' ? 'selected' : '' }"/>>청소기구</option>
						<option value="컴퓨터"
							<c:out value="${dto.product_cate == '컴퓨터' ? 'selected' : '' }"/>>컴퓨터</option>
						<option value="기타"
							<c:out value="${dto.product_cate == '기타' ? 'selected' : '' }"/>>기타</option>
				</select></td>
			</tr>
			<tr>
				<td>상품브랜드</td>
				<td><input name="product_brand" value="${dto.product_brand}"></td>
			</tr>
			<tr>
				<td>상품수량</td>
				<td><input name="product_amount" type="number"
					value="${dto.product_amount}"></td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><input name="product_price" type="number"
					value="${dto.product_price}"></td>
			</tr>
			<tr>
				<td>세일가격</td>
				<td><input name="product_saleprice" readonly="True"
					value="${dto.product_saleprice}"></td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td><textarea rows="5" cols="60" name="product_detail">${dto.product_detail}</textarea></td>
			</tr>
			<tr>
				<td>상품검수</td>
				<td><select name="product_check" id="product_check">
						<option value="0"
							<c:out value="${dto.product_check == '0' ? 'selected' : '' }"/>>하</option>
						<option value="1"
							<c:out value="${dto.product_check == '1' ? 'selected' : '' }"/>>중</option>
						<option value="2"
							<c:out value="${dto.product_check == '2' ? 'selected' : '' }"/>>상</option>
				</select>
			</tr>
			<tr>
				<td colspan="5" align="center"><input type="hidden"
					name="product_code" value="${dto.product_code}"> <input
					type="button" value="수정" onclick="product_update()"> <input
					type="button" value="삭제" onclick="product_delete()"> <input
					type="button" value="목록" onclick="location.href='/shop/list.do'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>