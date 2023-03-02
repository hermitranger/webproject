<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>admin_list.jsp</title>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>

<script>
	/*jquery 체크박스 선택  */
	/*jquery방식 = > $(".title").addClass("selected");   */
	/*javascript 방식 = >var titleElements = document.getElementsByClassName("title"); for (var titleElement in titleElements) { titleElement.className = titleElement.className + " selected"; }  */
	/*jquery내에 ajax가 포함*/
	/*https://jamesdreaming.tistory.com/206  */
	$(function() {
		var chkObj = document.getElementsByName("RowCheck");
		/*네임이 RowCheck인 값들 가져오기  */
		/* name= RowCheck , value= "${row.user_id}"로 설정해놓았다.*/
		var rowCnt = chkObj.length;
		/* 개수 체크  */
		$("input[name='allCheck']").click(function() {
			/*input의 name=allcheck*/
			/*$()는 함수를 호출 한다는 의미. name이 allcheck인 input을 호출 */
			/*https://ktko.tistory.com/entry/jQuery-%EC%9D%98-%EC%9D%98%EB%AF%B8  */
			var chk_listArr = $("input[name='RowCheck']");
			for (var i = 0; i < chk_listArr.length; i++) {/*length  선택요소의 개수*/
				chk_listArr[i].checked = this.checked;/*체크박스 체크상태 .checked*/
			}
			/*alert(chk_listArr.length)  */
			/*!document.getElementsByName("RowCheck")[i].checked 체크 되지 않은것 */

		});
		$("input[name='RowCheck']").click(function() {
			// 하나클릭 했을시 전체 선택이 아니기 때문에 전체선택 체크 없애기 
			if ($("input[name='RowCheck']:checked").length == rowCnt) {
				/* 키 : value */
				$("input[name='allCheck']")[0].checked = true;
			} else {
				$("input[name='allCheck']")[0].checked = false;
			}
		});

	});

	//회원 복구
	function restoreValue() {
		var url = "/admin_restore.do"; // Controller로 보내고자 하는 URL (.dh부분은 자신이 설정한 값으로 변경해야됨)
		//"/restore.do" "restore.do" 상관없음
		var valueArr = new Array();
		var list = $("input[name='RowCheck']");/*체크되어있는 것들을 list에 넣음  */
		for (var i = 0; i < list.length; i++) {
			if (list[i].checked) { //선택되어 있으면 배열에 값을 저장함
				valueArr.push(list[i].value);
			}
		}
		alert(valueArr);/*첫번째 체크결과값 kang */

		if (valueArr.length == 0) {
			alert("선택된 유저가 없습니다.");
		} else {
			if (confirm("복구를 진행하시겠습니까?")) {
				//var ck = confirm("복구를 진행하시겠습니까?");      
				//   console.log('url:'+url);
				$.ajax({
					url : url, // 전송 URL
					type : 'POST', // GET or POST 방식
					traditional : true,
					data : {
						valueArr : valueArr
					// 보내고자 하는 data 변수 설정
					},
					success : function(jdata) {
						//console.log('jdata:'+jdata);
						if (jdata == "1") {
							alert("복구 성공");
							location.replace("admin_user_list.do")
							//https://www.opentutorials.org/module/2919/22904
							//location.replace,기존페이지를 새로운 페이지로 변경시킨다.
						} else {
							alert("복구 실패");
							// 복구 팝업창에서 취소 눌렀음에도 복구 시행되는 경우가 있음. 수정 요망. 
						}
					}
				});
			} else {
				location.replace("admin_user_list.do");
			}
		}
	}

	//회원 탈퇴
	function dropValue() {
		var url = "/admin_drop.do"; // Controller로 보내고자 하는 URL (.dh부분은 자신이 설정한 값으로 변경해야됨)
		var valueArr = new Array();
		var list = $("input[name='RowCheck']");
		for (var i = 0; i < list.length; i++) {
			if (list[i].checked) { //선택되어 있으면 배열에 값을 저장함
				valueArr.push(list[i].value);
			}
		}
		if (valueArr.length == 0) {
			alert("선택된 유저가 없습니다.");
		} else {
			if (confirm("탈퇴를 진행하시겠습니까?")) {
				$.ajax({
					url : url, // 전송 URL
					type : 'POST', // GET or POST 방식
					traditional : true,
					/*Ajax 옵션, Type: Boolean, default: false, 데이터에 배열을 전송할 때 데이터 직렬화를 하는 옵션.  */
					/*https://dev-ohjy.tistory.com/4  */
					/* https://develop-sense.tistory.com/66 */
					data : {
						valueArr : valueArr
					// 보내고자 하는 data 변수 설정
					},
					success : function(jdata) {
						if (jdata == "1") {
							alert("탈퇴 성공");
							location.replace("admin_user_list.do")
						} else {
							alert("탈퇴 실패");
						}

					}

				});
			} else {
				location.replace("admin_user_list.do")
			}
		}
	}
	//페이지 나누기
	//링크 이동 https://chlee21.tistory.com/100
	//location.href="이동할 페이지 주소";
	//location.href="/경로?보낼변수명=" + 값;
	//+) 값 2개 이상 보낼때에는 location.href="/경로?보낼변수명=" + 값 + "&보낼변수명2=" + 값 ..... ;
	//하게되면 url에 값이 넘어가게되고, 컨트롤러단에서
	//request.getParameter("보낼변수명"); 
	function list(page) {
		location.href = "/admin_user_list.do?curPage=" + page
				+ "&search_option=${map.search_option}&keyword=${map.keyword}";
	}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp"%>
	<h2>회원목록</h2>
	<form name="form1" method="post" action="/admin_user_list.do">
		<select name="search_option">
			<option value="all"
				<c:out value="${map.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
			<!--3항식  -->
			<option value="user_id"
				<c:out value="${map.search_option == 'user_id' ? 'selected' : '' }"/>>아이디</option>
			<option value="user_name"
				<c:out value="${map.search_option == 'user_name' ? 'selected' : '' }"/>>이름</option>
			<option value="user_email"
				<c:out value="${map.search_option == 'user_email' ? 'selected' : '' }"/>>이메일</option>
			<option value="user_birth"
				<c:out value="${map.search_option == 'user_birth' ? 'selected' : '' }"/>>생년월일</option>
			<option value="user_check"
				<c:out value="${map.search_option == 'user_check' ? 'selected' : '' }"/>>유저체크</option>
		</select> <input name="keyword" value="${map.keyword}"> <input
			type="submit" value="조회 ">
	</form>
	<input type="button" value="복구" class="btn btn-outline-info"
		onclick="restoreValue();">
	<!--="btn btn-outline-info" 버튼 꾸미기 종류 https://www.codingfactory.net/10731  -->
	<input type="button" value="탈퇴" class="btn btn-outline-info"
		onclick="dropValue();">


	<!--유저 list  -->
	<form name="userForm">
		<table border="1" width="700px">
			<tr>
				<th><input id="allCheck" type="checkbox" name="allCheck" /></th>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
				<th>생년월일</th>
				<!-- <th>유저체크</th> -->
				<th>계정상태</th>
			</tr>

			<c:forEach var="row" items="${map.list}">
				<tr>
					<td align="center"><input name="RowCheck" type="checkbox"
						value="${row.user_id}"></td>
					<!--  value ="${row.user_id}를 사용한 이유 -> userDao , xml 사용,  check박스를 아이디(key)값으로 구분하여 동작 실행
            즉 체크 박스 1번에 대한  같은줄의 아이디를 벨류로 사용하여 이용.  -->
					<td align="center">${row.user_id}</td>
					<td align="center">${row.user_name}</td>
					<td align="center">${row.user_email}</td>
					<td align="center">${row.user_birth}</td>
					<%-- <td align="center">${row.user_check}</td> --%>
					<td align="center"><c:set var="row.user_check" value="" /> <c:choose>
							<c:when test="${row.user_check eq -1}">
                  탈퇴
               </c:when>
							<c:when test="${row.user_check eq 0}">
                  회원
               </c:when>
						</c:choose></td>
				</tr>
			</c:forEach>

			<!--글나누기 페이지  -->
			<!--href "#"관련 자료  -->
			<!--https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=ses1030&logNo=220873334215  -->
			<tr>
				<td colspan="7" align="center"><c:if
						test="${map.page_info.curPage > 1 }">
						<a href="javascript:list('1')">[처음]</a>
					</c:if> <c:if test="${map.page_info.curPage > 1}">
						<a href="javascript:list('${map.page_info.prevPage}')">[이전]</a>
					</c:if> <c:forEach var="num" begin="${map.page_info.blockBegin}"
						end="${map.page_info.blockEnd}">
						<c:choose>

							<c:when test="${num == map.page_info.curPage}">
								<span style="color: red">${num}</span>&nbsp; <!--현재 페이지 빨간색으로  -->
							</c:when>
							<c:otherwise>
								<a href="javascript:list('${num}')">${num}</a>&nbsp;
            </c:otherwise>
						</c:choose>
					</c:forEach> <c:if test="${map.page_info.curPage < map.page_info.totPage}">
						<a href="javascript:list('${map.page_info.nextPage}')">[다음]</a>
					</c:if> <c:if test="${map.page_info.curPage < map.page_info.totPage}">
						<a href="javascript:list('${map.page_info.totPage}')">[끝]</a>
					</c:if></td>
			</tr>
		</table>



	</form>
</body>
</html>