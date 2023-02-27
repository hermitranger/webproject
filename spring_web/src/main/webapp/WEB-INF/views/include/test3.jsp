<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test3</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>

	$(function() {		
		
		$("#product_check").on("change", function(){
			var top = $("<p id='hi'></p>" +
					"<input  name='product_tem_id' value='상'/>" + 
					"<input  name='product_tem_id' value='상'/>" +
					"<strong style='color:#000;font-weight:normal;font-size:11px;'>안녕</strong>"
			);
			var mid = 
				$("<input type='hidden' name='product_tem_id' value='중'/>");
			var bot = 
				$("<input type='hidden' name='product_tem_id' value='하'/>");	
			
			
			if($(this).val()== '3'){
				alert("children" + $("#hi").children.length);
				alert("hi" + $("#hi").length);
				
				if($("#top").children.length < 3 ){
				$("#top").append(top);
				}else {alert("이미 선택된 항목입니다.")}
				
			}else if($(this).val()== '2'){
				$("#mid").append(mid);
				

			}else if($(this).val()== '1'){
				$("#bot").append(bot);		
			}

		});

});

</script>

</head>
<body>
<%@ include file="../include/menu.jsp"%>


	<form name="form1" method="post">
	
				 <select id="product_check" name="product_check">
				 	<option value="-">-</option>
					<option value="3" <c:out value="${dto.product_check == '3' ? 'selected' : '' }"/>>상</option>
					<option value="2" <c:out value="${dto.product_check == '2' ? 'selected' : '' }"/>>중</option>
					<option value="1" <c:out value="${dto.product_check == '1' ? 'selected' : '' }"/>>하</option>		
				</select> 	
				
				
					<div id="top"></div>
					<div id="mid"></div>
					<div id="bot"></div>
					
					<div id="top2" style= "display:none;" >	
						<c:if test="${dto3.product_price eq dto3.product_saleprice}">	
							<input value=" ${dto3.product_price}"readonly >		
								<input value="${dto3.product_price} :  ${dto3.product_saleprice}원가격 ">원				
							</c:if>
							
							<c:if test="${dto3.product_price ne dto3.product_saleprice}">	
								<h4 style="color:white;display:inline-block;">상</h4>
								<input type="button" value="-">
								<input value="1" readonly  style="width:30px;"  >
								<input type="button" value="+">
								<input value=" ${dto3.product_saleprice}원" style="width:110px; background-color:transparent; border:none;color:white;" readonly ><br>
									<p align="center" style="color: red; display:inline-block;">
									(SALE: <c:set var="sale" value="${((dto3.product_price-dto3.product_saleprice)/dto3.product_price)*100}"/>
									<c:out value="${sale}"/>%</p>
									<p style="color:white;display:inline-block;" >,정상가</p>
									<p style="text-decoration:line-through; color:white;display:inline-block;" align="center">
									<fmt:formatNumber value="${dto3.product_price}"
										pattern="#,###원" />)</p>	
							</c:if>				
					</div>	
			

		<input type="hidden" name="product_code" value="${dto.product_code}">
		<input type="hidden" name="product_code" value="${dto1.product_code}">
		<input type="hidden" name="product_code" value="${dto1.product_price}">
		<input type="hidden" name="product_code" value="${dto1.product_saleprice}">
		<input type="hidden" name="product_code" value="${dto2.product_code}">
		<input type="hidden" name="product_code" value="${dto2.product_price}">
		<input type="hidden" name="product_code" value="${dto2.product_saleprice}">
		<input type="hidden" name="product_code" value="${dto3.product_code}">
		<input type="hidden" name="product_code" value="${dto3.product_price}">
		<input type="hidden" name="product_code" value="${dto3.product_saleprice}">		

	</form>


</body>
</html>