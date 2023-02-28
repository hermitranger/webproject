
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
/* $(function() {
	$("#btnSearch").click(function() {
		
		var keyword= $(#id).val 
		location.href = "/shop/list.do?keyword="+keyword;
	});
}); */
$(function(){
	
	$("#keyword").keyup(function(){
		
		var keyword=$("#keyword").val();
		
		$.ajax({
			
			type:"post",
			url:"/shop/search.do",
			data:{"keyword":keyword},
			success:function(html){
				
				//$("#keyword").val(html);
				$("#result1").html(html);			
				$("#result1").css("background-color","white");
				var width=$("#keyword").width();
				console.log(width);
				$("#result1").css("width",width);
				
			}			
		});		
	});	
});



</script>
<div id="header">
	<div class="logo">
		<a href="/">중고장터 ::</a>
	</div>
	<nav>
		<%-- <select name="search_option">
			<option value="all"
				<c:out value="${map.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
			<option value="product_name"
				<c:out value="${map.search_option == 'product_name' ? 'selected' : '' }"/>>상품명</option>
			<option value="product_cate"
				<c:out value="${map.search_option == 'product_cate' ? 'selected' : '' }"/>>상품카테고리</option>
			<option value="product_brand"
				<c:out value="${map.search_option == 'product_brand' ? 'selected' : '' }"/>>상품가격</option>
		</select> --%>
		<form class="search" action="/shop/list.do">
						
			<textarea name="keyword" id="keyword" rows="2" autocomplete="off" 
			style="resize:none;vertical-align:center;" placeholder="상품검색"></textarea>
		    <div id="result1"></div>
		    <input type="submit" value="조회" style="color: black">
		    
			<!-- <input name="keyword" type="search" id="keyword">  -->			
			
			
		
		</form>
		<ul>
	
			<!-- <li><a href="/test.do">트랜잭션 테스트</a> -->
			<li><a href="/" >홈페이지</a></li>
			<li><a href="/shop/list.do">상품 목록</a>
			<li><a href="/board/list.do">게시판</a>
			<!-- <ul>
				<li><a href="#">인기상품</a></li>
				<li><a href="/shop/new_list.do">신규상품</a></li>
				<li><a href="#">카테고리별 목록</a></li>
			</ul> -->
			</li>
			<c:choose>
				<c:when test="${sessionScope.user_check == null }">
					<li class="dropdown"><a href="#">회원메뉴</a>
						<ul>
							<li><a href="/login.page">로그인</a></li>
							<li><a href="/join.page">회원가입</a></li>
						</ul></li>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${sessionScope.user_check == 0 }">
					<li class="dropdown"><a href="#">회원메뉴</a>
						<ul>
							<li><a href="/user.page">내정보</a></li>
							<li><a href="/user_deal.do">거래내역</a></li>
							<li><a href="/userwithdraw.page">회원탈퇴</a>
						</ul></li>
					<li><a href="/logout.do">로그아웃</a></li>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${sessionScope.user_check == 1 }">
					<li><a href="#">회원관리</a>
						<ul>
							<li><a href="/admin_user_list.do" style="color: white;">회원관리</a></li>
							<li><a href="/admin_deal.do" style="color: white;">거래내역</a></li>
							<li><a href="/board/list.do" style="color: white;">게시판</a>
						</ul></li>
					<li><a href="#">상품관리</a>
						<ul>
							<!-- <li><a href="/shop/list.do" style="color: white;">상품목록</a></li> -->
							<li><a href="/soldout.do" style="color: white;">매진물품관리</a></li>
							<li><a href="/admin_sale_list.do" style="color: white;">세일상품</a></li>
							<li><a href="/admin_product.page" style="color: white;">상품매입페이지</a>
						</ul>
					<li><a href="/admin_manage.page">관리페이지</a><li>
					<li><a href="/logout.do">로그아웃</a></li>
				</c:when>
			</c:choose>
		</ul>
	</nav>
</div>
<hr>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script src="${path}/resources/js/menu.js?ver=2"></script>
<link rel="stylesheet" href="${path}/resources/css/menu.css?ver=2" />