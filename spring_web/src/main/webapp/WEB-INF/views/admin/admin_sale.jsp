<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin_sale.jsp</title>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<!-- https://jamesdreaming.tistory.com/206 -->
<script>

$(function(){
   $("button[name='saleAll']").click(function(){
      
      if($(this).val()=="적용")
      {
         var percent = $("input[name='saleAll_text']").val()
         if(percent <= 0 || percent >=100){
            alert("할인%를 다시 확인해 주세요");
            return
         }
         else {
            var percent = $("input[name='saleAll_text']").val();
            }
         
      }
      else {
         var percent = $(this).val();
      }
      
      var rowData = new Array(); 
        var ArrP_code = new Array();
        var ArrP_price = new Array();
        var ArrP_saleprice = new Array();
        var checkbox = $("input[name=RowCheck]:checked");
        
        checkbox.each(function(i) {
            
            // checkbox.parent() : checkbox의 부모는 <td>이다.
            // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
            var tr = checkbox.parent().parent().eq(i);
            var td = tr.children();
                    
            // 체크된 row의 모든 값을 배열에 담는다.
            rowData.push(tr.text());
                    
            // td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
            var product_code = td.eq(4).text();
         var product_price = td.eq(5).text().replace(",","").replace("원","");
         var product_saleprice = td.eq(6).text().replace(",","").replace("원","");
            
            // 가져온 값을 배열에 담는다.
            ArrP_code.push(product_code);
            ArrP_price.push(product_price);
            ArrP_saleprice.push(product_saleprice);
                 
        });

      
      $.ajax({
          url :"/admin_saleAll.do",                    // 전송 URL
          type : 'POST',                // GET or POST 방식
         traditional : true,   
          cache:false,
          data : {
             ArrP_code : ArrP_code,
             ArrP_price : ArrP_price,
             ArrP_saleprice : ArrP_saleprice,
             percent : percent
             // 보내고자 하는 data 변수 설정
          },
          dataType : "json",
            success: function(data){
               //console.log('jdata:'+jdata);
               if(data == "1") {
                    alert("정상 판매가 복구");
                    location.replace("admin_sale_list.do")
                }   
               else if(data == "2") {
                    alert("5% 적용 성공");
                    location.replace("admin_sale_list.do")
                }
                else if(data == "3") {
                    alert("10% 적용 성공");
                    location.replace("admin_sale_list.do")
                }
                else if(data == "4") {
                    alert("입력 할인가 적용 성공");
                    location.replace("admin_sale_list.do")
                }  
                else{
                    alert("적용 실패"+percent);
                }
            }
      }); 

   });
   
   $("button[name='sale']").click(function(){
         
         if($(this).val()=="적용")
         {
            var percent = $("input[name='sale_text']").val()
            if(percent <= 0 || percent >=100){
               alert("할인%를 다시 확인해 주세요");
               return
            }
            else {
               var percent = $("input[name='sale_text']").val();
               }
            
         }
         else {
            var percent = $(this).val();
         }
      
         //alert("percent" + percent);      
   
         var tdArr = new Array();   // 배열 선언
         var fperBtn = $(this);
      
         var tr = fperBtn.parent().parent();
         var td = tr.children();

         var product_code = td.eq(4).text();
         var product_price = td.eq(5).text().replace(",","").replace("원","");
         var product_saleprice = td.eq(6).text().replace(",","").replace("원","");
         alert(product_code + product_price + product_saleprice);
      
         
         $.ajax({
             url :"/admin_sale.do",                    // 전송 URL
             type : 'POST',                // GET or POST 방식
            traditional : true,   
             cache:false,
             data : {
                product_code : product_code,
                product_price : product_price,
                product_saleprice : product_saleprice,
                percent : percent
                // 보내고자 하는 data 변수 설정
             },
             dataType : "json",
               success: function(data){
                  //console.log('jdata:'+jdata);
                   if(data == "0") {
                       alert("이미 적용된 할인 가격입니다.");
                       location.replace("admin_sale_list.do")
                       //https://www.opentutorials.org/module/2919/22904
                       //location.replace,기존페이지를 새로운 페이지로 변경시킨다.
                   }
                   else if(data == "1") {
                       alert("정상 판매가 복구");
                       location.replace("admin_sale_list.do")
                   }   
                   else if(data == "2") {
                       alert("5% 적용 성공");
                       location.replace("admin_sale_list.do")
                   }
                   else if(data == "3") {
                       alert("10% 적용 성공");
                       location.replace("admin_sale_list.do")
                   }
                   else if(data == "4") {
                       alert("입력 할인가 적용 성공");
                       location.replace("admin_sale_list.do")
                   }  
                   else{
                       alert("적용 실패");
                   }
               }
         }); 
      
   });   
         
   var chkObj = document.getElementsByName("RowCheck");
   var rowCnt = chkObj.length;
   
   $("input[name='allCheck']").click(function(){
      var chk_listArr = $("input[name='RowCheck']");
      for(var i=0; i<chk_listArr.length;i++){
         chk_listArr[i].checked = this.checked;
      }
   });
   $("input[name='RowCheck']").click(function(){
      if($("input[name='RowCheck']:checked").length==rowCnt){
         
         $("input[name='allCheck']")[0].checked =true;
      }
      else{
         $("input[name='allCheck']")[0].checked = false;
      }
         
   });
   
});


function list(page){
   location.href="/admin_sale_list.do?curPage="+page
   +"&search_option=${map.search_option}&keyword=${map.keyword}";
}
</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<div id="table_">
		<div id="wrapper">
			<h3>세일 상품</h3>
			<form name="form" method="post" action="/admin_sale_list.do">

				<select name="search_option">
					<option value="all"
						<c:out value="${map.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
					<!--3항식  -->
					<option value="product_cate"
						<c:out value="${map.search_option == 'product_cate' ? 'selected' : '' }"/>>제품군</option>
					<option value="product_brand"
						<c:out value="${map.search_option == 'product_brand' ? 'selected' : ''}"/>>브랜드</option>
					<option value="product_name"
						<c:out value="${map.search_option== 'product_name' ? 'selected' : '' }"/>>제품명</option>
					<option value="product_code"
						<c:out value="${map.search_option== 'product_code' ? 'selected' :'' }"/>>제품코드</option>
				</select> <input name="keyword" value="${map.keyword}"> <input
					type="submit" value="검색">
			</form>
			할인 : <input name="saleAll_text" type="number" style="width: 50px;"
				MIN='0' MAX='99'>
			<button name="saleAll" value="5">5%</button>
			<button name="saleAll" value="10">10%</button>
			<button name="saleAll" value="0">정상가 복구</button>
			<button name="saleAll" value="적용">전체적용</button>


			<!--세일 상품리스트 list  -->
			<form name="saleForm">
				<table id="keywords" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th rowspan="2"><input id="allCheck" type="checkbox"
								name="allCheck" /></th>
							<th rowspan="2"><span>카테고리</span></th>
							<th rowspan="2"><span>브랜드</span></th>
							<th rowspan="2"><span>제품명</span></th>
							<th rowspan="2"><span>제품코드</span></th>
							<th rowspan="2"><span>가격</span></th>
							<th rowspan="2"><span>할인가</span></th>
							<th rowspan="2"><span>상품등록일자</span></th>
							<th rowspan="2"><span>팔리지않은 날짜</span></th>
							<th colspan="4"><span>세일 적용</span></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td align="center">5%</td>
							<td align="center">10%</td>
							<td align="center">직접 입력</td>
							<td align="center">원상 복구</td>
						</tr>
						<!--  value ="${row.user_id}를 사용한 이유 -> userDao , xml 사용,  check박스를 아이디(key)값으로 구분하여 동작 실행
            즉 체크 박스 1번에 대한  같은줄의 아이디를 벨류로 사용하여 이용.  -->
						<c:forEach var="row" items="${map.list}">
							<tr>
								<td align="center"><input name="RowCheck" type="checkbox"
									value="${row.product_code}"></td>
								<td align="center">${row.product_cate}</td>
								<td align="center">${row.product_brand}</td>
								<td align="center">${row.product_name}</td>
								<td align="center">${row.product_code}</td>
								<%-- <td align="center">${row.product_price}</td>
            <td align="center">${row.product_saleprice}</td> --%>
								<td align="center"><fmt:formatNumber pattern="#,###원"
										value="${row.product_price}" /></td>
								<td align="center"><fmt:formatNumber pattern="#,###원"
										value="${row.product_saleprice}" /></td>
								<td align="center"><fmt:formatDate
										value="${row.product_date}" pattern="yyyy년 MM월 dd일" /></td>
								<td align="center">${row.product_saledate}일</td>
								<!--데이터 저장x  -->
								<td align="center">
									<button name="sale" value="5">5%</button>
								</td>
								<td align="center">
									<button name="sale" value="10">10%</button>
								</td>
								<td align="center"><input name="sale_text" type="number"
									style="width: 50px;" MIN='0' MAX='99'>
									<button name="sale" value="적용">할인적용</button></td>
								<td align="center">
									<button name="sale" value="0">정상가 복구</button>
								</td>

							</tr>
						</c:forEach>

						<!--글나누기 페이지  -->
						<!--href "#"관련 자료  -->
						<!--https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=ses1030&logNo=220873334215  -->
						<tr>
							<td colspan="13" align="center"><div align="center">
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
								</div></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<script src="${path}/resources/js/table.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/table_sale.css?ver=2" />
</body>
</html>