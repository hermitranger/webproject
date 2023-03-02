<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin_deal_selllist</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>

$(function(){
	$("button[name='refund']").click(function(){
		 if(confirm("해당 주문번호 물건들이 모두 함께 취소됩니다.")){
	     var that = $(this);
	     var tr = that.parent().parent();
	     var td = tr.children();
	     var bill_order = tr.find('td:eq(0)').text();
	     alert("bill_order : "+bill_order);
	     $.ajax({
	       url :"/admin/refund.do",                    // 전송 URL
	       type : 'POST',                // GET or POST 방식
	      traditional : true,   
	       cache:false,
	       data : {
	    	   bill_order : bill_order
	          // 보내고자 하는 data 변수 설정
	       },
	       dataType : "json",
	         success: function(data){
	            //console.log('jdata:'+jdata);
	             if(data == "1") {
	                 alert("환불 완료");
	                 location.replace("admin_deal_selllist.do");
	             }else if(data=="2"){
	            	 alert("이미 환불된 품목입니다.");
	             }else{
	            	 
	             }
	         }
	 	  });
		 }
		 else{}
		});
	});
	
	function list(page) {
		location.href = "/admin/admin_deal_selllist.do?curPage="
				+ page
				+ "&search_option=${sellmap.search_option}&keyword=${sellmap.keyword}";
	}
</script>
</head>
<body>
	<!-- 판매내역 검색창 -->
	<%@ include file="../include/menu.jsp"%>
	<div id="table_">
		<div id="wrapper2" style="width:1500px;">
			<h4>판매목록</h4>
			<form name="form1" method="post"
				action="/admin/admin_deal_selllist.do">
				<select name="search_option">
					<option value="all"
						<c:out value="${sellsellmap.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
					<option value="s_code"
						<c:out value="${sellsellmap.search_option == 's_code' ? 'selected' : '' }"/>>상품코드</option>
					<option value="sell_id"
						<c:out value="${sellsellmap.search_option == 'sell_id' ? 'selected' : '' }"/>>유저아이디</option>
					<option value="s_name"
						<c:out value="${sellsellmap.search_option == 's_name' ? 'selected' : '' }"/>>상품명</option>
					<option value="s_cate"
						<c:out value="${sellsellmap.search_option == 's_cate' ? 'selected' : '' }"/>>상품카테고리</option>
					<option value="s_check"
						<c:out value="${sellsellmap.search_option == 's_check' ? 'selected' : '' }"/>>검수등급</option>
					<option value="s_price"
						<c:out value="${sellsellmap.search_option == 's_price' ? 'selected' : '' }"/>>상품가격</option>
				</select> <input name="keyword" value="${sellsellmap.keyword}"> <input
					type="submit" value="조회 ">
			</form>

			<!-- 판매내역 나열 -->
			<form name="userForm">
				<table id="keywords2" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th><span>주문번호</span></th>
							<th><span>상품코드</span></th>
							<th><span>유저아이디</span></th>
							<th><span>상품명</span></th>
							<th><span>상품카테고리</span></th>
							<!-- <th><span>검수등급</span></th> -->
							<th><span>상품가격</span></th>
							<th><span>진행내역</span></th>
							<th><span>환불</span></th>
							<th><span>편집</span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${sellmap.list}">
							<tr>
								<td align="center">${row.bill_order}</td>
								<td align="center">${row.s_code}</td>
								<td align="center">${row.sell_id}</td>
								<td align="center">${row.s_name}	</td>
								<%-- <td align="center"><a
									href="/admin/admin_deal_selldetail/${row.s_code}"
									style="color: black;">${row.s_name}</a></td> --%>
								<td align="center">${row.s_cate}</td>
								
								<%-- <c:if test="${row.s_check eq 3}">
									<td align="center">상</td>
								</c:if>
								<c:if test="${row.s_check eq 2}">
									<td align="center">중</td>
								</c:if>
								<c:if test="${row.s_check eq 1}">
									<td align="center">하</td>
								</c:if>
								<c:if test="${row.s_check eq 0}">
									<td align="center">미검수</td>
								</c:if> --%>
								
								<td align="center"><fmt:formatNumber pattern="#,###원"
										value="${row.s_price}" /></td>
								<td align="center"><c:set var="row.s_progress" value="" />
								<c:choose>
									<c:when test="${row.s_progress eq  0}">결제완료</c:when>
									<c:when test="${row.s_progress eq  1}">배송중</c:when>
									<c:when test="${row.s_progress eq  2}">완료</c:when>
									<c:when test="${row.s_progress eq  3}">환불요청</c:when>
									<c:when test="${row.s_progress eq  4}">환불완료</c:when>
								</c:choose>
								</td>
								<td align="center">
									<button name="refund">환불</button>
								</td>
								<c:if test="${row.s_progress ne 4}">
									<c:if test="${row.s_progress ne 3}">									
										<td align="center"><a
											href="/admin/admin_deal_selldetail/${row.s_code}"
											style="color: blue;">[편집]</a>
										</td>
									</c:if>
								</c:if>
							</tr>
						</c:forEach>
						<!-- 페이지 나눔 -->
						<tr>
							<td colspan="8" align="center">
								<div align="center">
									<c:if test="${sellmap.page_info_s.curPage > 1 }">
										<a href="javascript:list('1')" style="color: black;">[처음]</a>
									</c:if>
									<c:if test="${sellmap.page_info_s.curPage > 1}">
										<a href="javascript:list('${sellmap.page_info_s.prevPage}')"
											style="color: black;">[이전]</a>
									</c:if>
									<c:forEach var="num" begin="${sellmap.page_info_s.blockBegin}"
										end="${sellmap.page_info_s.blockEnd}">
										<c:choose>

											<c:when test="${num == sellmap.page_info_s.curPage}">
												<span style="color: red">${num}</span>&nbsp; <!--현재 페이지 빨간색으로  -->
											</c:when>
											<c:otherwise>
												<a href="javascript:list('${num}')" style="color: black;">${num}</a>&nbsp;
						</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if
										test="${sellmap.page_info_s.curPage < sellmap.page_info_s.totPage}">
										<a href="javascript:list('${sellmap.page_info_s.nextPage}')"
											style="color: black;">[다음]</a>
									</c:if>
									<c:if
										test="${sellmap.page_info_s.curPage < sellmap.page_info_s.totPage}">
										<a href="javascript:list('${sellmap.page_info_s.totPage}')"
											style="color: black;">[끝]</a>
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