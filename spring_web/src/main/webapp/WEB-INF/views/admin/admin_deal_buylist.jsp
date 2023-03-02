<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>관리자 전용 구매목록</title> -->
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<title>admin_deal_buylist</title>
<script>

$(function(){
	$("button[name='registration']").click(function(){
		alert("확인")
		 if(confirm("물건을 등록하시겠습니까.")){
	     var that = $(this);
	     var tr = that.parent().parent();
	     var td = tr.children();
	     var bill_order = tr.find('td:eq(0)').text();
	     var product_code = tr.find('td:eq(1)').text();
	     var check = tr.find('td:eq(5)').text();
	    /*  alert(bill_order);
	     alert(product_code);
	     alert(check); */
	     
	    $.ajax({
	       url :"/admin/Registration.do",                    // 전송 URL
	       type : 'POST',                // GET or POST 방식
	      traditional : true,   
	       cache:false,
	       data : {
	    	   bill_order : bill_order,
	    	   product_code : product_code,
	    	   check : check
	    	   
	          // 보내고자 하는 data 변수 설정
	       },
	       dataType : "json",
	         success: function(data){
	            //console.log('jdata:'+jdata);
	             if(data == "1") {
	                 alert("등록 완료");
	                 location.replace("admin_deal_buylist.do");
	             }else if(data=="2"){
	            	 alert("이미 적용된 품목입니다.");
	             }else{
	            	 
	             }
	         }
	 	  }); 
		 }
		 else{}
		});
});
	function list(page) {
		location.href = "/admin/admin_deal_buylist.do?curPage=" + page
				+ "&search_option=${map.search_option}&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<!-- 구매내역 검색창 -->
<%@ include file="../include/menu.jsp"%>
<div id="table_">
		<div id="wrapper2" style="width:1650px;">
	<h4>구매목록</h4>
	<form name="form1" method="post" action="/admin/admin_deal_buylist.do">
		<select name="search_option">
			<option value="all"
				<c:out value="${buymap.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
			<option value="b_code"
				<c:out value="${buymap.search_option == 'b_code' ? 'selected' : '' }"/>>상품코드</option>
			<option value="buy_id"
				<c:out value="${buymap.search_option == 'buy_id' ? 'selected' : '' }"/>>유저아이디</option>
			<option value="b_name"
				<c:out value="${buymap.search_option == 'b_name' ? 'selected' : '' }"/>>상품명</option>
			<option value="b_cate"
				<c:out value="${buymap.search_option == 'b_cate' ? 'selected' : '' }"/>>상품카테고리</option>
			<option value="b_check"
				<c:out value="${buymap.search_option == 'b_check' ? 'selected' : '' }"/>>검수등급</option>
			<option value="b_price"
				<c:out value="${buymap.search_option == 'b_price' ? 'selected' : '' }"/>>상품가격</option>
		</select> <input name="keyword" value="${buymap.keyword}"> <input
			type="submit" value="조회 ">
	</form>

	<!-- 구매내역 나열 -->
	<form name="userForm">
		<!-- <form name="form" method="post" action="/admin_sale_list.do"> -->
		<table id="keywords2" cellspacing="0" cellpadding="0">
		<thead>
			<tr>
				<th><span>주문번호</span></th>
				<th><span>상품코드</span></th>
				<th><span>유저아이디</span></th>
				<th><span>상품명</span></th>
				<th><span>상품카테고리</span></th>
				<th><span>검수등급</span></th>
				<th><span>상품가격</span></th>
				<th><span>진행내역</span></th>
				<th><span>상품등록</span></th>
				<th><span>편집</span></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="row" items="${buymap.list}">
				<tr>
					<td align="center">${row.bill_order}</td>
					<td align="center">${row.b_code}</td>
					<td align="center">${row.buy_id}</td>
					<td align="center">${row.b_name}</td>
					<%-- <td align="center"><a
						href="/admin/admin_deal_buydetail/${row.b_code}">${row.b_name}</a></td> --%>
					<td align="center">${row.b_cate}</td>
				
					<c:if test="${row.b_check eq 3}">
						<td align="center">상</td>
					</c:if>
					<c:if test="${row.b_check eq 2}">
						<td align="center">중</td>
					</c:if>
					<c:if test="${row.b_check eq 1}">
						<td align="center">하</td>
					</c:if>
						<c:if test="${row.b_check eq 0}">
						<td align="center">미검수</td>
					</c:if>
					<td align="center"><fmt:formatNumber pattern="#,###원"
							value="${row.b_price}" /></td>
					<%-- <td align="center"><a href="/shop/write/${row.b_code}">[편집]</a></td> 상품 내용 수정때 사용. --%>
					<td align="center"><c:set var="row.b_progress" value="" />
								<c:choose>
									<c:when test="${row.b_progress eq  0}">방문 예정</c:when>
									<c:when test="${row.b_progress eq  1}">배송중</c:when>
									<c:when test="${row.b_progress eq  2}">검수중</c:when>
									<c:when test="${row.b_progress eq  3}">검수완</c:when>
									<c:when test="${row.b_progress eq  4}">완료</c:when>
								</c:choose>
					</td>
					<td align="center">
						<c:if test="${row.b_progress eq 4}">
								<button name="registration">물건등록</button>
								<%-- <a href="/admin/Registration.do/${row.b_code}/${row.b_check}" style="color: blue;">[등록]</a> --%>														
								<%-- <input type="button"  value="상품등록" onclick="location.href='/admin/Registration.do?product_code='+${row.b_code}+'check='${row.b_check};"> --%>
						</c:if>
					</td>
					<td align="center"><a href="/admin/admin_deal_buydetail/${row.b_code}" style="color: blue;">[편집]</a></td>
				</tr>
			</c:forEach>

			<!-- 페이지 나눔 -->
			<tr>
				<td colspan="8" align="center">
					<div align="center">
				<c:if test="${buymap.page_info_b.curPage > 1 }">
						<a href="javascript:list('1')">[처음]</a>
					</c:if> 
					<c:if test="${buymap.page_info_b.curPage > 1}">
						<a href="javascript:list('${buymap.page_info_b.prevPage}')">[이전]</a>
					</c:if> 
					<c:forEach var="num" begin="${buymap.page_info_b.blockBegin}" end="${buymap.page_info_b.blockEnd}">
						<c:choose>

							<c:when test="${num == buymap.page_info_b.curPage}">
								<span style="color: red">${num}</span>&nbsp; <!--현재 페이지 빨간색으로  -->
							</c:when>
							<c:otherwise>
								<a href="javascript:list('${num}')">${num}</a>&nbsp;
						</c:otherwise>
						</c:choose>
					</c:forEach> <c:if
						test="${buymap.page_info_b.curPage < buymap.page_info_b.totPage}">
						<a href="javascript:list('${buymap.page_info_b.nextPage}')">[다음]</a>
					</c:if> <c:if
						test="${buymap.page_info_b.curPage < buymap.page_info_b.totPage}">
						<a href="javascript:list('${buymap.page_info_b.totPage}')">[끝]</a>
					</c:if>
				</div>
				</td>
			</tr>
			</tbody>
		</table>
	</form>
	</div>
	</div>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<script src="${path}/resources/js/table.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/table.css?ver=2" />
</body>
</html>