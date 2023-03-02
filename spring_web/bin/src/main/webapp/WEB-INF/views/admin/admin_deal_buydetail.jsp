<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>관리자 전용 :: 구매 상세내역</title> -->
<title>admin_deal_buydetail.jsp</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	$(function() {
		var b_check = "${dto.b_check}";
		if (b_check == "3") {
			$(":radio[name = 'b_check'][value = '3']").attr('checked', true);
		} else if (b_check == "2") {
			$(":radio[name = 'b_check'][value = '2']").attr('checked', true);
		} else if (b_check == "1") {
			$(":radio[name = 'b_check'][value = '1']").attr('checked', true);
		} else {
			$(":radio[name = 'b_check'][value = '0']").attr('checked', true);
		}
		
		var b_progress = "${dto.b_progress}";
		if (b_progress == "1") {
			$(":radio[name = 'b_progress'][value = '1']").attr('checked', true);
		} else if (b_progress == "2") {
			$(":radio[name = 'b_progress'][value = '2']").attr('checked', true);
		} else if (b_progress == "3") {
			$(":radio[name = 'b_progress'][value = '3']").attr('checked', true);
		} else if (b_progress == "4") {
			$(":radio[name = 'b_progress'][value = '4']").attr('checked', true);
		} else if (b_progress == "0") {
			$(":radio[name = 'b_progress'][value = '0']").attr('checked', true);
		}
		
	});

	function check_update() {
		if (confirm("수정사항을 업데이트하시겠습니까?")) {
			var b_check = $("input[name='b_check'][id='b_check']:checked").val();
			var b_progress = $("input[name='b_progress'][id='b_progress']:checked").val();
			document.form1.action = "/admin/buy_update.do";
			document.form1.submit();
		}
	}

/* 	function product_write() {//상품등록 때 사용하자.
		if (confirm("해당 상품을 등록하시겠습니까?")) {
			document.form1.action = "/shop/write/${dto.b_code}";
			document.form1.submit();
		}
	}  */
</script>
</head>
<body>
<%@ include file="../include/menu.jsp"%>
	<h3>구매정보</h3>
	<form name="form1" method="post">
		<table border="1" width="700px">
			<tr>
				<td>주문번호</td>
				<td>${dto.bill_order}</td>
			</tr>
			<tr>
				<td>상품코드</td>
				<td>${dto.b_code}</td>
			</tr>
			<tr>
				<td>거래유저</td>
				<td>${dto.buy_id}</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td>${dto.b_name}</td>
			</tr>
			<tr>
				<td>상품카테고리</td>
				<td>${dto.b_cate}</td>
			</tr>
			<tr>
				<td>구매일자</td>
				<td><fmt:formatDate pattern="yyyy년 MM월 dd일"
						value="${dto.bill_date}" /></td>
			</tr>
			
			<tr>
				<td>상품가격</td>
				<td><fmt:formatNumber pattern="#,###" value="${dto.b_price}" /></td>
			</tr>
			<tr>
				<td>상품검수</td>
				<td><input type="radio" name="b_check" id="b_check" value="3">
					상 <input type="radio" name="b_check" id="b_check" value="2">
					중 <input type="radio" name="b_check" id="b_check" value="1">
					하 <input type="radio" name="b_check" id="b_check" value="0">
					미검수</td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td>${dto.buy_post}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${dto.buy_address}</td>
			</tr>
			<tr>
				<td>진행내역</td>
				<td><c:set var="row.b_progress"/><!--라디오버튼은 name에따라서 같이 움직입니다.  -->
					<input type="radio" name="b_progress" id="b_progress" value="0">
					방문 예정<input type="radio" name="b_progress" id="b_progress" value="1">
					배송중<input type="radio" name="b_progress" id="b_progress" value="2">
					검수중<input type="radio" name="b_progress" id="b_progress" value="3">
					검수완<input type="radio" name="b_progress" id="b_progress" value="4">
					완료				
				</td>
			</tr>
			<tr>
				<td colspan="6"><input
					type="button" value="구매내역"
					onclick="location.href='/admin/admin_deal_buylist.do'">
					<input type="hidden" name="b_code"
					value="${dto.b_code}"> <input type="button"
					value="수정" onclick="check_update()"> 
				<!-- <input type="button" value="등록" onclick="product_write()"> --></td>
			</tr>
		</table>
	</form>
</body>
</html>