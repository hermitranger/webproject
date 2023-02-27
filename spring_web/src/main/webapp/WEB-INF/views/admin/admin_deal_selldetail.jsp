<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
$(function() {
	var s_progress = "${dto.s_progress}";
	if (s_progress == "1") {
		$(":radio[name = 's_progress'][value = '1']").attr('checked', true);
	} else if (s_progress == "2") {
		$(":radio[name = 's_progress'][value = '2']").attr('checked', true);
	} else if (s_progress == "0") {
		$(":radio[name = 's_progress'][value = '0']").attr('checked', true);
	}
	
});

function check_update() {
	if (confirm("수정사항을 업데이트하시겠습니까?")) {
		var s_progress = $("input[name='s_progress'][id='s_progress']:checked").val();
		document.form1.action = "/admin/sell_update.do";
		document.form1.submit();
	}
}

</script>

<body>
<%@ include file="../include/menu.jsp"%>
	<h3>판매정보</h3>
	<form name="form1" method="post">
		<table border="1" width="700px">
			<tr>
				<td>주문번호</td>
				<td>${dto.bill_order}</td>
			</tr>
			<tr>
				<td>상품코드</td>
				<td>${dto.s_code}</td>
			</tr>
			<tr>
				<td>거래유저</td>
				<td>${dto.sell_id}</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td>${dto.s_name}</td>
			</tr>
			<tr>
				<td>상품카테고리</td>
				<td>${dto.s_cate}</td>
			</tr>
			<tr>
				<td>등록일자</td>
				<td><fmt:formatDate pattern="yyyy년 MM월 dd일"
						value="${dto.bill_date}" /></td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><fmt:formatNumber pattern="#,###"
						value="${dto.s_price}" /></td>
			</tr>
			<c:if test="${dto.s_check eq 3}">
				<tr>
					<td>상품검수</td>
					<td>상</td>
				</tr>
			</c:if>
			<c:if test="${dto.s_check eq 2}">
				<tr>
					<td>상품검수</td>
					<td>중</td>
				</tr>
			</c:if>
			<c:if test="${dto.s_check eq 1}">
				<tr>
					<td>상품검수</td>
					<td>하</td>
				</tr>
			</c:if>
			<tr>
				<td>우편번호</td>
				<td>${dto.sell_post}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${dto.sell_address}</td>
			</tr>
			<tr>
				<td>진행내역</td>
				<td><c:set var="row.s_progress"/><!--라디오버튼은 name에따라서 같이 움직입니다.  -->
					<input type="radio" name="s_progress" id="s_progress" value="0">
					결제완료<input type="radio" name="s_progress" id="s_progress" value="1">
					배송중<input type="radio" name="s_progress" id="s_progress" value="2">
					완료			
				</td>
			</tr>
			<tr>
				<td colspan="8"><input type="hidden" name="s_code"
					value="${dto.s_code}"> 
					<input
					type="button" value="판매내역"
					onclick="location.href='/admin/admin_deal_selllist.do'">
					 <input type="button"
					value="수정" onclick="check_update()"> 				
					</td>			
			</tr>
		</table>
	</form>
</body>
</html>