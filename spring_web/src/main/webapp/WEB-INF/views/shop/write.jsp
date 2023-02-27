<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고상점-상품등록</title>
<script>
	function product_write() {
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
			document.product_inform.product_price.focus();
			return;
		}
		if (product_detail == "") {
			alert("상품설명을 입력하세요.");
			document.product_inform.product_detail.focus();
			return;
		}
		document.product_inform.action = "/shop/insert.do";
		document.product_inform.submit();
	}
</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<form name="product_inform" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>상품코드</td>
				<td><input name="product_code" value="${dto.b_code}"></td>
			</tr>
			<tr>
				<td>상품이미지</td>
				<td><input type="file" name="file1"></td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input name="product_name" value="${dto.b_name}"></td>
			</tr>
			<tr>
				<td>상품종류</td>
				<td>
					<select name="product_cate" >
						<option value="난방기구"
							<c:out value="${dto.b_cate == '난방기구' ? 'selected' : '' }"/>>난방기구</option>
						<option value="냉방기구"
							<c:out value="${dto.b_cate == '냉방기구' ? 'selected' : '' }"/>>냉방기구</option>
						<option value="영상기구"
							<c:out value="${dto.b_cate == '영상기구' ? 'selected' : '' }"/>>영상기구</option>
						<option value="음향기구"
							<c:out value="${dto.b_cate == '음향기구' ? 'selected' : '' }"/>>음향기구</option>
						<option value="주방기구"
							<c:out value="${dto.b_cate == '주방기구' ? 'selected' : '' }"/>>주방기구</option>
						<option value="청소기구"
							<c:out value="${dto.b_cate == '청소기구' ? 'selected' : '' }"/>>청소기구</option>
						<option value="컴퓨터"
							<c:out value="${dto.b_cate == '컴퓨터' ? 'selected' : '' }"/>>컴퓨터</option>
						<option value="기타"
							<c:out value="${dto.b_cate == '기타' ? 'selected' : '' }"/>>기타</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>상품브랜드</td>
				<td><input name="product_brand"></td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><input type = "number" name="product_price" value="${dto.b_price}"></td>
			</tr>
			<tr>
				<td>상품수량</td>
				<td><input name="product_amount"></td>
			</tr> 
			<tr>
				<td>상품설명</td>
				<td><textarea rows="5" cols="60" name="product_detail"></textarea></td>
			</tr>
			<tr>
				<td>상품검수</td>
				<td>
					<select name="product_check" id="product_check">
					<option value="0"
							<c:out value="${dto.b_check == '0' ? 'selected' : '' }"/>>미검수</option>
						<option value="1"
							<c:out value="${dto.b_check == '1' ? 'selected' : '' }"/>>하</option>
						<option value="2"
							<c:out value="${dto.b_check == '2' ? 'selected' : '' }"/>>중</option>
						<option value="3"
							<c:out value="${dto.b_check == '3' ? 'selected' : '' }"/>>상</option>
						
				</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" value="등록"
					onclick="product_write()"> <input type="button" value="목록"
					onclick="location.href='/admin/admin_deal_buylist.do'"></td>
			</tr>
		</table>
	</form>
</body>
</html>