<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고장터 :: 요청게시판</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	$(function() {
		$("#btnWrite").click(function() {
			location.href = "/board/write.do";
		});
	});

	function list(page) {
		location.href = "/board/list.do?curPage=" + page
				+ "&search_option=${map.search_option}&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<div id="table_">
		<div id="wrapper">
			<h3>게시판</h3>
			<h4>${map.count }개의게시물이있습니다.</h4>
			<div align="center">
				<form name="form1" method="post" action="/board/list.do">
					<select name="search_option">
						<option value="all"
							<c:out value="${map.search_option=='all' ? 'selected' : '' }"/>>아이디+내용+제목</option>
						<option value="user_id"
							<c:out value="${map.search_option=='user_id' ? 'selected' : '' }"/>>아이디</option>
						<option value="contents"
							<c:out value="${map.search_option=='contents' ? 'selected' : '' }"/>>제목</option>
					</select> <input name="keyword" value="${map.keyword }"> <input
						type="submit" value="조회">
					<c:if test="${sessionScope.user_id!=null }">
						<button type="button" id="btnWrite">글쓰기</button>
					</c:if>
				</form>
			</div>
			<table id="keywords" cellspacing="0" cellpadding="0">
				<thead>
					<tr>
						<c:if test="${sessionScope.user_check==1 }">
							<th><input type="checkbox" id="allchkbox" name="allchkbox"
								value="allchkbox"></th>
						</c:if>
						<th><span>번호</span></th>
						<th><span>제목</span></th>
						<th><span>아이디</span></th>
						<th><span>날짜</span></th>
						<th><span>조회수</span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="row" items="${map.list}">
						<tr>

							<c:if test="${sessionScope.user_check==1 }">
								<td><input type="checkbox" id="chkbox" name="chkbox"
									value="${row.idx}" onclick="off()"></td>
							</c:if>
							<td>${row.idx }</td>
							<td class="lalign"><a
								href="/board/detail.do?idx=${row.idx }&cur_page=${map.page_info.curPage }
		&search_option=${map.search_option }&keyword=${map.keyword }"
								style="color: black;">${row.title }</a> <c:if
									test="${row.cnt >0 }">
									<span style="color: red">(${row.cnt})</span>
								</c:if></td>
							<td>${row.user_id}</td>
							<td><fmt:formatDate value="${row.regdate }"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${row.hit }</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="5" align="center"><div align="center">
								<c:if test="${map.page_info.curPage > 1 }">
									<a href="javascript:list('1')" style="color: black;">[처음]</a>
								</c:if>
								<c:if test="${map.page_info.curPage > 1}">
									<a href="javascript:list('${map.page_info.prevPage}')"
										style="color: black;">[이전]</a>
								</c:if>
								<c:forEach var="num" begin="${map.page_info.blockBegin}"
									end="${map.page_info.blockEnd}">
									<c:choose>

										<c:when test="${num == map.page_info.curPage}">
											<span style="color: red">${num}</span>&nbsp; <!--현재 페이지 빨간색으로  -->
										</c:when>
										<c:otherwise>
											<a href="javascript:list('${num}')" style="color: black;">${num}</a>&nbsp;
						</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${map.page_info.curPage < map.page_info.totPage}">
									<a href="javascript:list('${map.page_info.nextPage}')"
										style="color: black;">[다음]</a>
								</c:if>
								<c:if test="${map.page_info.curPage < map.page_info.totPage}">
									<a href="javascript:list('${map.page_info.totPage}')"
										style="color: black;">[끝]</a>
								</c:if>
							</div>
				</tbody>
			</table>
		</div>
	</div>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<script src="${path}/resources/js/table.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/table.css?ver=2" />
</body>
</html>