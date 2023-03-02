<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고상점-상품정보_detailbuy</title>
<!--하등급 가격 올려 놓고 select 버튼 눌럿을때 가격 변동하게 하는게 좋을것 같다.  -->
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
/* 1. 재고 관련도 설정.
총상품 금액 칸
수량
총계
 */
//서버로 왓다갓다하면 개발하기는 편리하지만, 반응이 느리다.
//아래와 같이 진행하면 속도는 빠르지만 코드 수정이 어렵다. 추가로 jsp를 따로 만들어서 불러오는 작업으로 진행시 더 수월해질 것이다.
let basket = {
		
		 totalCount: 0, 
		 totalPrice: 0,
		 
		 //개별 수량 변경 (+ or -눌럿을때)
		    //상품갯수, 합계금액 업데이트
		    
		    total: function(){
			 this.totalCount = 0;
		     this.totalPrice = 0;
		     document.querySelectorAll(".p_num").forEach(function (item) {
		    			var count = parseInt(item.getAttribute('value'));
		                //alert("count" + count);
		                this.totalCount += count;
		                //alert("totalCount" + this.totalCount);
		                var price = item.parentElement.firstElementChild.nextElementSibling.nextElementSibling.getAttribute('value');
		                //alert("price" + price);
		                this.totalPrice += count * price;
		                //alert("totalPrice" +  this.totalPrice);
		                         
		        }, this); // forEach 2번째 파라메터로 객체를 넘겨서 this가 객체리터럴을 가리키도록 함. - thisArg
		        			// if문 안에 this를 연동시키기 위하여 사용, visual로 켜보면 자세히 보인다.
		      
	        document.querySelector('#sum_p_num').textContent = this.totalCount.formatNumber();
	        document.querySelector('#sum_p_price').textContent = this.totalPrice.formatNumber();
	        document.getElementById("total_price").value=this.totalPrice;
	        document.getElementById("total_count").value=this.totalCount;
	        

		   
		    },
		 delItem: function () { 
		        event.target.parentElement.remove();
		        this.total();
		},
	    changePNum: function (pos) {
	       	   
	        var item = document.querySelector('input[name=p_num'+pos+']');
	        var price = document.querySelector('input[name=product_saleprice'+pos+']').getAttribute('value');
	        var sumprice = document.querySelector('.price'+pos);
	       
	        if(!$("#amount1").val()){
	        	const amount1=0;
	        }
	        else{
	        	 var amount1 = $("#amount1").val();
	        }
	        if(!$("#amount2").val()){
	        	const amount2=0;
	        }
	        else{
	        	 var amount2 = $("#amount2").val();
	        }
	        if(!$("#amount3").val()){
	        	const amount3=0;
	        }
	        else{
	        	 var amount3 = $("#amount3").val();
	        }
	    	var eachprice= 'total_price' + pos;
	        
	        // input박스가 p_num1이렇게 되어있다.
	        // 1)pos는 1~3번 번호, item은 input 박스,  querySelector는 해당 조건의 첫번째 요소만 선택(ex name이 a인 여러개 요소중 제일 앞 a만 선택)
	        var p_num = parseInt(item.getAttribute('value'));
	        // 2)item value의 값을 정수로 변환함
	        var newval = event.target.classList.contains('up') ? p_num+1 : event.target.classList.contains('down') ? p_num-1 : event.target.value;
	        // 3) 클래스에 UP이 포함되어 있으면 P_NUM+1, DOWN이면 P_NUM -1, 아니면 지금 값
	        if (parseInt(newval) < 1 || parseInt(newval) > 99) { return false; }
	        else if(pos==1&& parseInt(newval) > amount1){ 
		    	alert("수량 부족, 현재 재고 :" + amount1);
		    	item.value = amount1;
		    	return false;
		    }
	        else if(pos==2 && parseInt(newval) > amount2){ 
	        	alert("수량 부족, 현재 재고 :" + amount2);
		    	item.value = amount2;
		    	return false;
		    }
	        else if(pos==3&& parseInt(newval) > amount3){ 
	        	alert("수량 부족, 현재 재고 :" + amount3);
		    	item.value = amount3;
		    	return false;
		    }
	        // 3-1) 1~99까지만 선택되게
	        item.setAttribute('value', newval);
	        // 4)item의 value값에 newval을 넣어줌
	        item.value = newval;
	     	// 스크립트 숫자칸에 입력
	     	// 5) 부모요소(  <div class="updown">) -> 부모요소( <div class="num">) -> 바로이전 형제요소(<div class="basketprice">) -> 첫번째 자식(<input type)의 값을 가져옴
	     	// ex) <html>아래에 <head><body>가 있으면 <html>은 부모요소 , <body>,<head>는 자식, <body>,<head>는형제
	     	// previousElementSibling 는 이전형제 , nextElementSibling 다음형제
	     	// https://ko.javascript.info/dom-navigation
	     	// previousSibling() > Element는 물론 #text와 주석까지 node로 카운트하여 반환 , previousElementSibling() > Element만 카운트하여 반환 
	     	sumprice.textContent = (newval * price).formatNumber()+"원";
	        // 5) 부모요소(  <div class="updown">) -> 부모요소( <div class="num">) -> 바로다음 형제요소(div class="sum")의 text를 바꿈	 
	      	        
	        document.getElementById(eachprice).value=newval*price;
	        //각각  	var eachprice= 'total_price' + pos;에 값이 들어감.	        
	        this.total();//총 합계 totalCount, totalPrice 재계산
	        
	    }
		
}

function Arr(){
	//var product_name0 = "${dto.product_name}";
	//var product_name="";
	var ArrP_code = new Array();
	var ArrP_price = new Array();
	var ArrP_saleprice = new Array();
	var ArrP_count = new Array();
	var ArrP_sumprice= new Array();
	var ArrP_name= new Array();
	for(i=1;i<4;i++){
		
	    if($("#total_price"+i).val()==""||$("#total_price"+i).val()==null){
	    }
	    else{
	    	//alert(i+"확인 : "+$("#total_price"+i).val());
	    	/* if(i==1){
	    		product_name = product_name0.concat("(하)");
	    		}
	    	else if(i==2){
	    		product_name = product_name0.concat("(중)");
	    		}
	    	else if(i==3){
	    		product_name = product_name0.concat("(상)");
	    	} */
	    	var product_name=$("#product_name"+i).val();
	    	var product_code = $("#product_code"+i).val();
	    	var product_price = $("#product_price"+i).val();
	    	var product_saleprice = $("#product_saleprice"+i).val();
	    	var count = $("#p_num"+i).val();
	    	var sumprice =$("#total_price"+i).val();    	
	    // 가져온 값을 배열에 담는다.
		    	ArrP_name.push(product_name);
			    ArrP_code.push(product_code); 
			    ArrP_price.push(product_price);
			    ArrP_saleprice.push(product_saleprice);
			    ArrP_count.push(count);
			    ArrP_sumprice.push(sumprice);
        }     
	}

	
	 $("#ArrP_name").val(ArrP_name);
	 $("#ArrP_code").val(ArrP_code);
	 $("#ArrP_price").val(ArrP_price);
	 $("#ArrP_saleprice").val(ArrP_saleprice);
	 $("#ArrP_count").val(ArrP_count);
	 $("#ArrP_sumprice").val(ArrP_sumprice);

}






Number.prototype.formatNumber = function(){
    if(this==0) return 0;
    let regex = /(^[+-]?\d+)(\d{3})/;
    let nstr = (this + '');
    while (regex.test(nstr)) nstr = nstr.replace(regex, '$1' + ',' + '$2');
    return nstr;
};
	
	
	$(function() {
		var top =$("<div id=top>" + 
				/*price일반 */
						"<input type='hidden' id='product_code3' name='product_code3' value='${dto3.product_code}'>" +
						"<input type='hidden' id='product_price3'name='product_price3' value='${dto3.product_price}'>" +
						"<input type='hidden' id='product_saleprice3'name='product_saleprice3'value='${dto3.product_saleprice}'>" +
						"<c:if test='${dto3.product_price eq dto3.product_saleprice}'>" +
							"<h4 style='color:white;display:inline-block;'>상 :</h4>"+	
							"<div class='price3' style='display:inline-block; width:110px; background-color:transparent; border:none; text-align: center; font-size:15pt; color:white;'></div>" +
							"<input class='down' type='button' value='-' onclick='javascript:basket.changePNum(3);'>" +
							"<input type='text' name='p_num3' id='p_num3' size='1' maxlength='2' class='p_num' value='1' onkeyup='javascript:basket.changePNum(3);'>"+
							"<input class='up' type='button' value='+' onclick='javascript:basket.changePNum(3);'>"+
							"<input type='button' value='삭제' class='abutton' onclick='javascript:basket.delItem();'><br>" +
							"<input type='hidden' id='total_price3' name='total_price3'>"+
							"<input type='hidden' id='product_name3' name='product_name3' value='${dto3.product_name}'>"+
						"</c:if>"+
						/*saleprice*/		
						"<c:if test='${dto3.product_price ne dto3.product_saleprice}'>"+	
						"<h4 style='color:white;display:inline-block;'>상 :</h4>" +
						"<div class='price3' style='display:inline-block; width:110px; background-color:transparent; border:none; text-align: center; font-size:15pt; color:white;'></div>" +
						"<input class='down' type='button' value='-' onclick='javascript:basket.changePNum(3);'>" +
						"<input type='text' name='p_num3' id='p_num3' size='1' maxlength='2' class='p_num' value='1' onkeyup='javascript:basket.changePNum(3);'>"+
						"<input class='up' type='button' value='+' onclick='javascript:basket.changePNum(3);'>"+
						"<input type='button' value='삭제' class='abutton' onclick='javascript:basket.delItem();'><br>" +
							"<p align='center' style='color: red; display:inline-block;'>" +
							"(SALE: <c:set var='sale' value='${((dto3.product_price-dto3.product_saleprice)/dto3.product_price)*100}'/>"+
							"<c:out value='${sale}'/>%" + 
							"</p>"+
							"<p style='color:white;display:inline-block;' >,정상가</p>"+
							"<p style='text-decoration:line-through; color:white;display:inline-block;' align='center'>"+
							"<fmt:formatNumber value='${dto3.product_price}' pattern='#,###원' />)</p>"+	
					        "</c:if>"+
					        "<input type='hidden' id='total_price3' name='total_price3'>"+
					        "<input type='hidden' id='product_name3' name='product_name3' value='${dto3.product_name}'>"+
					"</div>"
			);	
		var mid =$("<div id=mid>" + 
					"<input type='hidden' id='product_code2' name='product_code2' value='${dto2.product_code}'>" +
					"<input type='hidden' id='product_price2'name='product_price2' value='${dto2.product_price}'>" +
					"<input type='hidden' id='product_saleprice2'name='product_saleprice2'value='${dto2.product_saleprice}'>" +
					"<c:if test='${dto2.product_price eq dto2.product_saleprice}'>" +
						"<h4 style='color:white;display:inline-block;'>중 :</h4>"+	
						"<div class='price2' style='display:inline-block; width:110px; background-color:transparent; border:none; text-align: center; font-size:15pt; color:white;'></div>" +
						"<input class='down' type='button' value='-' onclick='javascript:basket.changePNum(2);'>" +
						"<input type='text' name='p_num2' id='p_num2' size='1' maxlength='2' class='p_num' value='1' onkeyup='javascript:basket.changePNum(2);'>"+
						"<input class='up' type='button' value='+' onclick='javascript:basket.changePNum(2);'>"+
						"<input type='button' value='삭제' class='abutton' onclick='javascript:basket.delItem();'><br>" +
						"<input type='hidden' id='total_price2' name='total_price2'>"+
						"<input type='hidden' id='product_name2' name='product_name2' value='${dto2.product_name}'>"+
						
					"</c:if>"+
					/*saleprice*/		
					"<c:if test='${dto2.product_price ne dto2.product_saleprice}'>"+	
					"<h4 style='color:white;display:inline-block;'>중 :</h4>" +
					"<div class='price2' style='display:inline-block; width:110px; background-color:transparent; border:none; text-align: center; font-size:15pt; color:white;'></div>" +
					"<input class='down' type='button' value='-' onclick='javascript:basket.changePNum(2);'>" +
					"<input type='text' name='p_num2' id='p_num2' size='1' maxlength='2' class='p_num' value='1' onkeyup='javascript:basket.changePNum(2);'>"+
					"<input class='up' type='button' value='+' onclick='javascript:basket.changePNum(2);'>"+
					"<input type='button' value='삭제' class='abutton' onclick='javascript:basket.delItem();'><br>" +
						"<p align='center' style='color: red; display:inline-block;'>" +
						"(SALE: <c:set var='sale' value='${((dto2.product_price-dto2.product_saleprice)/dto2.product_price)*100}'/>"+
						"<c:out value='${sale}'/>%" + 
						"</p>"+
						"<p style='color:white;display:inline-block;' >,정상가</p>"+
						"<p style='text-decoration:line-through; color:white;display:inline-block;' align='center'>"+
						"<fmt:formatNumber value='${dto2.product_price}' pattern='#,###원' />)</p>"+	
				        "</c:if>"+
				        "<input type='hidden' id='total_price2' name='total_price2'>"+
				        "<input type='hidden' id='product_name2' name='product_name2' value='${dto2.product_name}'>"+
				"</div>"
			);
		
		var bot =$("<div id=bot>" + 
					"<input type='hidden' id='product_code1' name='product_code1' value='${dto1.product_code}'>" +
					"<input type='hidden' id='product_price1'name='product_price1' value='${dto1.product_price}'>" +
					"<input type='hidden' id='product_saleprice1'name='product_saleprice1'value='${dto1.product_saleprice}'>" +
					"<c:if test='${dto1.product_price eq dto1.product_saleprice}'>" +
						"<h4 style='color:white;display:inline-block;'>하 :</h4>"+	
						"<div class='price1' style='display:inline-block; width:110px; background-color:transparent; border:none; text-align: center; font-size:15pt; color:white;'></div>" +
						"<input class='down' type='button' value='-' onclick='javascript:basket.changePNum(1);'>" +
						"<input type='text' name='p_num1' id='p_num1' size='1' maxlength='2' class='p_num' value='1' onkeyup='javascript:basket.changePNum(1);'>"+
						"<input class='up' type='button' value='+' onclick='javascript:basket.changePNum(1);'>"+
						"<input type='button' value='삭제' class='abutton' onclick='javascript:basket.delItem();'><br>" +
						"<input type='hidden' id='total_price1' name='total_price1'>"+
						"<input type='hidden' id='product_name1' name='product_name1' value='${dto1.product_name}'>"+
					"</c:if>"+
					/*saleprice*/
					"<c:if test='${dto1.product_price ne dto1.product_saleprice}'>"+	
					"<h4 style='color:white;display:inline-block;'>하 :</h4>" +
					"<div class='price1' style='display:inline-block; width:110px; background-color:transparent; border:none; text-align: center; font-size:15pt; color:white;'></div>" +
					"<input class='down' type='button' value='-' onclick='javascript:basket.changePNum(1);'>" +
					"<input type='text' name='p_num1' id='p_num1' size='1' maxlength='2' class='p_num' value='1' onkeyup='javascript:basket.changePNum(1);'>"+
					"<input class='up' type='button' value='+' onclick='javascript:basket.changePNum(1);'>"+
					"<input type='button' value='삭제' class='abutton' onclick='javascript:basket.delItem();'><br>" +
						"<p align='center' style='color: red; display:inline-block;'>" +
						"(SALE: <c:set var='sale' value='${((dto1.product_price-dto1.product_saleprice)/dto1.product_price)*100}'/>"+
						"<c:out value='${sale}'/>%" + 
						"</p>"+
						"<p style='color:white;display:inline-block;' >,정상가</p>"+
						"<p style='text-decoration:line-through; color:white;display:inline-block;' align='center'>"+
						"<fmt:formatNumber value='${dto1.product_price}' pattern='#,###원' />)</p>"+	
				        "</c:if>"+
				        "<input type='hidden' id='total_price1' name='total_price1'>"+
				        "<input type='hidden' id='product_name1' name='product_name1' value='${dto1.product_name}'>"+
				"</div>"
			);
		
		

	
		$('input[type=radio][name="method"]').change(function(){
				const a =$(this).val();
				if(a=="card"){
					$("#divAcccount").css("display","none");	
				} else if(a == "account"){
					$("#divAcccount").css("display","block");			
				}		
		});
			
		$("#btnRecommend").click(function() {//일단 skip
			if (confirm("해당 글을 추천하시겠습니까?")) {
				document.form1.action = "/shop/rcheck.do";
				document.form1.submit();
			}
		});
		
		$("#btnBuy").click(function() {		
			if($("#total_price").val()=="")
				{
				alert("선택한 상품이 없습니다.");
				return;	
			}
			else if (confirm("해당 제품을 구매하시겠습니까??")) {
				Arr();
				
				document.formbuy.action = "/OrderSell2.do";
				document.formbuy.submit();
			}
		});
		
		$("#product_check").on("change", function(){
			
			if($(this).val()== '3'){
				if(!$("#amount3").val()||$("#amount3").val()==0){
					alert("재고가 없습니다.")
					return ;
				}
				//alert("top" + $("#top").length);
				else if(!$("#top").length){
					$("#3").append(top);
					var price = Number($("#product_saleprice3").val());
					document.querySelector('.price3').textContent = price.formatNumber() + '원';
					document.getElementById("total_price3").value=price;
					
				}
				else {alert("이미 선택된 항목입니다.");
				}
				
			}
			else if($(this).val()== '2'){
				//alert("mid" + $("#mid").length);
				if(!$("#amount2").val()||$("#amount2").val()==0){
					alert("재고가 없습니다.")
					return ;
				}
				else if(!$("#mid").length){
					$("#2").append(mid);
					var price = Number($("#product_saleprice2").val());
					document.querySelector('.price2').textContent = price.formatNumber() + '원';
					document.getElementById("total_price2").value=price;
				}
				else {alert("이미 선택된 항목입니다.");
				}
				
			}
			else if($(this).val()== '1'){
				//alert("bot" + $("#bot").length);
				if(!$("#amount1").val()||$("#amount1").val()==0){
					alert("재고가 없습니다.")
					return ;
				}
				else if(!$("#bot").length){
					$("#1").append(bot);
					var price = Number($("#product_saleprice1").val());
					document.querySelector('.price1').textContent = price.formatNumber() + '원';
					document.getElementById("total_price1").value=price;
				}
				else {alert("이미 선택된 항목입니다.");
				}		
			}


			/* 
			if($(this).val()== '3'){
				
				
				 $("#top").css("display","block");
				 
				 
			}else if($(this).val()== '2'){
				 $("#mid").css("display","block");
			}else if($(this).val()== '1'){
				 $("#bot").css("display","block");
			} */

			
		/*     $.ajax({
				url : "/Cart.do", 
				type : 'POST',
				traditional : true,
					data : $("#form1").serialize(),
				success : function(jdata) {
					if (jdata == "1") {
						alert("추가")
						//return location.href="/BuyResult.page";
					} else {
						alert("오류");
					}

				} 

			});	 */    
		    //$("option:selected", this).attr("value");
		    //selected option element
		    //$("option:selected", this);
		    //$("option:selected", this).text();
		    
			basket.total();
		});
		
		//checkSale();
	});

	
/* 	function checkSale(){
		
		let price = ${dto.product_price};
		let saleprice = ${dto.product_saleprice};
		if(price != saleprice){
			//$('#salePrice').show();
			$('div[name="salePrice"]').show();
		}
		else{
			//$('#price').show();
			$('div[name="price"]').show();
		}
		
		
	} */
</script>
<style>
.container {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
	gap: 10px;
}

.box {
	border: 3px solid #666;
	background-color: #ddd;
	width: 40%;
	height: 20%;
	padding: 10px;
}

.detail{
	background:darked;
	width:400px; height:400px;
	line-height:400px;
	text-align:center;
	color:#fff;
	font-size:20px;
	margin:0 auto;

}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp"%>
<%-- 	<c:if test="${sessionScope.user_check == null}">
		<%@ include file="../include/menu.jsp"%>
	</c:if>
	<c:if test="${sessionScope.user_check >= 0}">
		<%@ include file="../include/menu.jsp"%>
	</c:if> --%>

	

 		<div class="card">	
				<div class="left">
					<div class="detetail" title="${dto.product_detail}">
					<img src="/resources/images/${dto.filename}" width="300px"
						height="300px" alt="shoe"> <i class="fa fa-long-arrow-left"></i>
					<i class="fa fa-long-arrow-right"></i>
					</div>
				</div>
			<div class="right">
				<div class="product-info">
					<div class="product-name">
						<h1>${dto.product_cate}</h1>
						<i class="fa fa-search"></i> <i class="fa fa-user"></i> <i
							class="fa fa-shopping-cart"></i>
					</div>
					<%-- <div class="details">
						<h3>
							<fmt:formatNumber value="${dto.product_price}" pattern="#,###원" />
						</h3>
						<h2>${dto.product_name}</h2>
						<h4>
							<span class="fa fa-dollar"></span>${dto.product_brand}
						</h4>
					</div>
 --%>				<%-- <ul>
						<li><fmt:formatDate pattern="yyyy년 MM월 dd일"
								value="${dto.product_date}" /> 등록</li>
					</ul> --%>
					
					<div class="details">	
						<h4>${dto.product_name}</h4><br>
						<h4>
							<span class="fa fa-dollar"></span>${dto.product_brand}
						</h4>
						<br>
						<h4>등급</h4>
					
						<%-- <c:if test="${dto.product_check eq 3}">
							<h4>상</h4>
						</c:if>
						<c:if test="${dto.product_check eq 2}">
							<h4>중</h4>
						</c:if>
						<c:if test="${dto.product_check eq 1}">
							<h4>하</h4>
						</c:if> --%>

						 <select id="product_check" name="product_check">
						 	<option value="-">-</option>
							<option value="3" <c:out value="${dto.product_check == '3' ? 'selected' : '' }"/>>상</option>
							<option value="2" <c:out value="${dto.product_check == '2'? 'selected' : '' }"/>>중</option>
							<option value="1" <c:out value="${dto.product_check == '1' ? 'selected' : '' }"/>>하</option>		
						</select> 	
						<br>
						
						<div id="3"></div>
						<div id="2"></div>
						<div id="1"></div>
						<div id="test"></div>
						<div id="total">
						
							<strong style="float: left;">총 수량</strong>
							<em style="float: right; margin-right: 5px">개</em>
							<em id="sum_p_num" style="float: right;">0</em>
							<br>
							<br>
							<em style="float: left;">총 가격</em>
							<em style="float: right; margin-right: 5px">원</em>
							<em id="sum_p_price" style="float: right;">0</em>
						</div>
						<form id="formbuy" name="formbuy" method="post">
						<input type="hidden" name="product_code" value="${dto.product_code}">
						<input type="hidden" name="product_name" value="${dto.product_name}">
						<input type="hidden" id="total_price" name="total_price" value="">
						<input type="hidden" id="total_count" name="total_count" value="">
						<input type="hidden" id="ArrP_code" name="ArrP_code" value="">
						<input type="hidden" id="ArrP_price" name="ArrP_price" value="">
						<input type="hidden" id="ArrP_saleprice" name="ArrP_saleprice" value="">
						<input type="hidden" id="ArrP_count" name="ArrP_count" value="">
						<input type="hidden" id="ArrP_sumprice" name="ArrP_sumprice" value="">
						<input type="hidden" id="ArrP_name" name="ArrP_name" value="">				
						</form>		
						<input type="hidden" id="amount1" name="amount1" value="${dto1.product_amount}">
						<input type="hidden" id="amount2" name="amount2" value="${dto2.product_amount}">
						<input type="hidden" id="amount3" name="amount3" value="${dto3.product_amount}">
						<input type="hidden" id="product_saleprice1" name="product_saleprice1" value="${dto1.product_saleprice}">
						<input type="hidden" id="product_saleprice2" name="product_saleprice2" value="${dto2.product_saleprice}">
						<input type="hidden" id="product_saleprice3" name="product_saleprice3" value="${dto3.product_saleprice}">					
						
					</div>
					<br>
					<br>
					<input type="button" id="btnBuy" value="구매하기"	style="color: black; float:right;">
					<c:if test="${sessionScope.user_check == '1'}">
						<input type="button"
							onclick="location.href='/shop/edit/${dto.product_code}'"
							value="상품수정" style="color: black;">
					</c:if>
					<div>
						<h1>상세설명 <br> 그림 위 마우스를 올려주세요</h1>
					</div>
				</div>
				
			</div>
			
		</div>
		<div class="card"><!--코드왓다갓다함 고쳐야 함 계속 누를시  -->
			<div class="center">
				<div class="container">
					<c:if test="${empty list}"><h5>추천상품이 없습니다</h5></c:if>
					<c:forEach var="row" items="${list}">
						<span> <a href="/shop/detailBuy/${row.product_code}"> <img
								src="/resources/images/${row.filename}" width="50px"
								height="50px"></a><br> 등록일자<fmt:formatDate
								pattern="yyyy년 MM월 dd일" value="${row.product_date}" /><br>
							상품명:${row.product_name}<br> 상품종류:${row.product_cate}<br>
							상품브랜드:${row.product_brand}<br> 상품가격:<fmt:formatNumber
								value="${row.product_price}" pattern="#,###원" /><br> 상품검수:
								<c:if test="${row.product_check eq 3}">상	</c:if> 
								<c:if test="${row.product_check eq 2}">중</c:if> 
								<c:if test="${row.product_check eq 1}">하</c:if>
						</span>
					</c:forEach>
				</div>
			</div>
		</div>
					
	<%-- 	<input type="hidden" name="product_code" value="${dto.product_code}">
 --%>





<div class="box">
<div class="container">
<c:if test="${empty list}">추천상품이 없습니다</c:if>		
		<c:forEach var="row" items="${list}">
		<span>		
		<a href="/shop/detailBuy/${row.product_code}">
		<img src="/resources/images/${row.filename}" width="50px" height="50px"></a><br>
		등록일자<fmt:formatDate pattern="yyyy년 MM월 dd일" value="${row.product_date}" /><br>
		상품명:${row.product_name}<br>
		상품종류:${row.product_cate}<br>
		상품브랜드:${row.product_brand}<br>
		상품가격:<fmt:formatNumber value="${row.product_price}" pattern="#,###원" /><br>
		상품검수:<c:if test="${row.product_check eq 3}">상	</c:if>
		<c:if test="${row.product_check eq 2}">중</c:if>
		<c:if test="${row.product_check eq 1}">하</c:if>
		</span>
		</c:forEach>
</div></div>
	<%-- 	
	<script src="${path}/resources/js/detail.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/detail.css?ver=2" /> --%>


	<link rel="stylesheet" href="${path}/resources/css/detail.css?ver=2" />
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<%-- <script src="${path}/resources/js/main.js?ver=2"></script> --%>
<%-- <link rel="stylesheet" href="${path}/resources/css/search.css?ver=2" />
	<link rel="stylesheet" href="${path}/resources/css/main.css?ver=2" /> --%>
</body>
</html>