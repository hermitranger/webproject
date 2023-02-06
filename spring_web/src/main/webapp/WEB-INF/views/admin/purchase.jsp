<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<script>
$(function(){
	
			
	$("#purchase_cate").on("change",function(){
				
		var cate_val=$("#purchase_cate").val();	
		console.log(cate_val);
		
		if(cate_val!=null){
			
			$("#change").children().css("visibility","hidden");
			$("#purchase_"+cate_val).css("visibility","visible");
						
			$("#purchase_"+cate_val).on("change",function(){
								
				$("#purchase_brand").css("visibility","visible");
					
			});	
			
		}
		if(cate_val=="default"){
			$("#purchase_brand").css("visibility","hidden")
		}
	});

});
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

<h2>매입할 상품</h2><br>
카테고리
<select id="purchase_cate" name="purchase_cate">
	<option value="default">카테고리를 선택하세요</option>
	<option value="000">난방기구</option>
	<option value="100">냉방기구</option>
	<option value="200">영상기구</option>
	<option value="300">음향기구</option>
	<option value="400">주방용</option>
	<option value="500">청소</option>
	<option value="600">컴퓨터</option>
	<option value="700">기타</option>
</select>
<br>
세부항목
<div id="change" name="change">
<select id="purchase_000" name="purchase_000" style="visibility: hidden;">
	<option value="010">소형난방</option>
	<option value="020">중형난방</option>
	<option value="030">대형난방</option>	
</select>
<select id="purchase_100" name="purchase_100" style="visibility: hidden;">
	<option value="110">소형냉방</option>
	<option value="120">중형냉방</option>
	<option value="130">대형냉방</option>
</select>
<select id="purchase_200" name="purchase_200" style="visibility: hidden;">
	<option value="210">소형영상</option>
	<option value="220">중형영상</option>
	<option value="230">대형영상</option>
</select>
<select id="purchase_300" name="purchase_300" style="visibility: hidden;">
	<option value="310">소형음향</option>
	<option value="320">중형음향</option>
	<option value="330">대형음향</option>
</select>
<select id="purchase_400" name="purchase_400" style="visibility: hidden;">
	<option value="410">소형주방</option>
	<option value="420">중형주방</option>
	<option value="430">대형주방</option>
</select>
<select id="purchase_500" name="purchase_500" style="visibility: hidden;">
	<option value="510">소형청소</option>
	<option value="520">중형청소</option>
	<option value="530">대형청소</option>
</select>
<select id="purchase_600" name="purchase_600" style="visibility: hidden;">
	<option value="610">소형컴퓨터</option>
	<option value="620">중형컴퓨터</option>
	<option value="630">대형컴퓨터</option>
</select>
<select id="purchase_700" name="purchase_700" style="visibility: hidden;">
	<option value="710">소형기타</option>
	<option value="720">중형기타</option>
	<option value="730">대형기타</option>
</select>
</div>
<br>
브랜드
<select id="purchase_brand" name="purchase_brand" style="visibility: hidden;">
	<option value="01">삼성</option>
	<option value="02">LG</option>
	<option value="03">한경희</option>
	<option value="11">샤오미</option>
</select>
<br>
<input type="button" id="save_cate" name="save_cate" onclick="addlist()" value="목록만들기">


<textarea id="list" name="list" cols="80%" rows="20"></textarea>

</body>
</html>