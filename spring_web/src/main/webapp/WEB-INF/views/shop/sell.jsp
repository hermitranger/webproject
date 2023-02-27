<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sell.jsp</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script>

$(function(){
	fee();
	
	$('input[type=radio][name="method"]').change(function(){
		const a =$(this).val();
		if(a=="card"){
			$("#divAcccount").css("display","none");	
		} else if(a == "account"){
			$("#divAcccount").css("display","block");			
		}		
	});
	

	$('#selectEmail').change(function(){
		   $("#selectEmail option:selected").each(function () {
				if($(this).val()== '1'){ //직접입력일 경우
					 $("#user_email02").val('');                        //값 초기화
					 $("#user_email02").attr("disabled",false); //활성화
				}else{ //직접입력이 아닐경우
					 $("#user_email02").val($(this).text());      //선택값 입력
					 $("#user_email02").attr("disabled",true); //비활성화
				}
		   });
		});
});



//document.cookie = "crossCookie=bar; SameSite=None; Secure";//
var IMP = window.IMP; // 생략 가능
IMP.init("imp54321076");//가맹점 식별코드imp54321076
var today = new Date();   
var hours = today.getHours(); // 시
var minutes = today.getMinutes();  // 분
var seconds = today.getSeconds();  // 초
var milliseconds = today.getMilliseconds();
var makeMerchantUid = hours +  minutes + seconds + milliseconds;


function SellDo(){
	bill_order=createOrderNum();
	const data ={
		imp_uid	: "",
		payMethod : $("input[type='raido']:checked").val(),
		product_code : $("#product_code").val(),
		user_id : $("#user_id").val(),
		selectTel : $("#selectTel").val(),
		userTel01 : $("#userTel01").val(),
		userTel02 : $("#userTel02").val(),
		user_name : $("#user_name").val(),
		user_email01 : $("#user_email01").val(),
		selectEmail : $("#selectEmail").val(),
		bill_order : bill_order,
		zipcode : $("#zipcode").val(),
		address1 : $("#address1").val(),
		address2 : $("#address2").val(),
		fee : $("#fee").val(),
		product_price : $("#product_price").val(),
		amount: 100,
		orderNum: createOrderNum(),
        name: $("#product_name").val(),
        //amount: $("#product_price").val(),                         //TEST 끝날시 숫자 타입
        amount: 100, //테스트용 1원 값은 SellResult()에서 잘 전달 됨
        seller_email: $("#user_email").val(),
        seller_name: $("#user_name").val(),
        seller_tel: $("#user_phone").val(),
        seller_addr: $("#address1").val().concat($("#address2").val()),
        seller_postcode: $("#zipcode").val() 		
	}
	

	var telRule = /^[0-9]{3,4}$/;
	var telRule2 = /^[0-9]{3,4}$/;
	var account = /^[0-9]{11,14}$/;

	if($("input[id='account']:checked").length != 0){
		if(!account.test($("input[id='accountNumber']").val())){ 
			alert("계좌번호를 다시 확인하신 후 재입력해주세요")
		    return false;
		}
	}

	
	if(!telRule.test($("input[id='userTel01']").val())) {
		alert("전화번호 앞자리를 확인하신 후 재입력해주세요")
	    return false;
	}
	
	if(!telRule2.test($("input[id='userTel02']").val())) {
		alert("전화번호 뒷자리를 확인하신 후 재입력해주세요")
	    return false;
	}
	
	

	if($("#zipcode").val()== ""){
		alert("우편번호를 입력해주세요")
		alert("${Pdto.product_code}")
		
	}
	else if($("#address2").val()== ""){
		alert("상세주소를 입력해주세요")		
		
	}
	
	requestPay(data);
	
			
}

function requestPay(data) {
		document.getElementById("bill_order").value = data.orderNum;
	    IMP.request_pay({
	        pg : 'kcp',
	        pay_method : 'card',
	        merchant_uid: data.orderNum,
	        name: data.name,
	        //amount: $("#product_price").val(),                         //TEST 끝날시 숫자 타입
	        amount: 100, //테스트용 1원 값은 SellResult()에서 잘 전달 됨
	        seller_email: "",
	        seller_name: "",
	        seller_tel: data.phone,
	        seller_addr: data.seller_addr,
	        seller_postcode: data.seller_postcode
	    }, function (rsp) { // callback
	        if (rsp.success) {  // 결제 성공 시 로직   
	        	data.imp_uid = rsp.imp_uid;
		        data.merchant_uid = rsp.merchant_uid;
		        document.getElementById("imp_uid").value = rsp.imp_uid;
		        document.getElementById("merchant_uid").value=rsp.merchant_uid;
		        SellResult(data); 
	        	alert("결제완료");
	        	//return location.href="/SellResult.page";
	        } else {  // 결제 실패 시 로직
	        	
	        	alert("결제실패");
	        	sellFail();
	        	//return location.href="/shop/list.do";

	        }
	    });
	
}
	
function sellFail()
{
	return location.href = "/SellFail.do?product_code=${Pdto.product_code}";	
	}



function SellResult(data){

	var url = "/SellResult.do";
		$.ajax({
			url : url, 
			type : 'POST',
			traditional : true,
				data : data,
			success : function(jdata) {
				if (jdata == "1") {
					alert("성공");
					return location.href="/SellResult.page"
				} else {
					alert("매진상품입니다.");
					return "redirect:/shop/list.do";
				}

			} 

		});
}
function Refund(){

	var url = "/SellResult.do";
		$.ajax({
			url : url, 
			type : 'POST',
			traditional : true,
				data : $("#sellform").serialize(),
			success : function(jdata) {
				if (jdata == "1") {
					alert("성공");
					return location.href="/SellResult.page"
				} else {
					alert("매진상품입니다.");
					return "redirect:/shop/list.do";
				}

			} 

		});
}

//https://cobi-98.tistory.com/20 주문번호 만들기 
function createOrderNum(){
	const date = new Date();
	const year = date.getFullYear();
	const month = String(date.getMonth() + 1).padStart(2, "0");
	const day = String(date.getDate()).padStart(2, "0");  
	let product_code = $("#product_code").val();
	//let product_code2 = "${Pdto.product_code}"; //""안붙히면 오류
	let bill_order = "S" + product_code + year + month + day;
	for(let i=0;i<10;i++) {
		bill_order += Math.floor(Math.random() * 8);	
	}
	return bill_order;
}

function fee(){
	let cate="${Pdto.product_code}";
	
	if(cate.slice(-1) =="1"){     
		const price = 5000;
		let result = price.toLocaleString();
		 document.getElementById("fee").value=price;
		 document.getElementById("fee2").value=result;
	 }
	 else if(cate.slice(-1) =="2"){
		const price = 10000;
		let result = price.toLocaleString();
		document.getElementById("fee").value=price;
		document.getElementById("fee2").value=result;
	 }
	 else if(cate.slice(-1) =="3"){ 
		 const price = 20000;
		let result = price.toLocaleString();
		document.getElementById("fee").value=price;
		document.getElementById("fee2").value=result;
	 }
	
}

function jejuFee(fullAddr){
    let jeju=fullAddr.substring(0,2);
    let fee="";
    let size =$("#product_code").val().toString();
    let test = $("#product_code").val(); 
    if(jeju === "제주"){
		document.getElementById("jeju").value="제주도는 기존 배송료에서 배송비가 3000원 추가됩니다. ";
    
   	 if(size.slice(-1) =="1"){
   		const price = 8000;
		let result = price.toLocaleString();
		document.getElementById("fee").value=price;
		 document.getElementById("fee2").value=result;
   	 }
	 	 else if(size.slice(-1) =="2"){ 
	 	const price = 13000;
	 	let result = price.toLocaleString();
	 	document.getElementById("fee").value=price;
		 document.getElementById("fee2").value=result;
   	 }
   	 else if(size.slice(-1) =="3"){ 
   		const price = 23000;
	 	let result = price.toLocaleString();
	 	document.getElementById("fee").value=price;
		 document.getElementById("fee2").value=result;
   	 }     
    }
		else {
			 document.getElementById("jeju").value="기본배송 지역";
   	 if(size.slice(-1) =="1"){ 
   		const price = 5000;
		let result = price.toLocaleString();
		document.getElementById("fee").value=price;
		 document.getElementById("fee2").value=result;
   	 }
   	 else if(size.slice(-1) =="2"){
   		const price = 10000;
		let result = price.toLocaleString();
		document.getElementById("fee").value=price;
		 document.getElementById("fee2").value=result;
   	 }
   	 else if(size.slice(-1) =="3"){
   		const price = 20000;
		let result = price.toLocaleString();
		document.getElementById("fee").value=price;
		 document.getElementById("fee2").value=result;
   	 } 

    }

	
} 

function showPostcode() {
   new daum.Postcode({
      oncomplete : function(data) {
         let fullAddr = ""; 
         let extraAddr = ""; 
         if (data.userSelectedType === "R") { 
            fullAddr = data.roadAddress;
         } else { 
            fullAddr = data.jibunAddress;
         }
         if (data.userSelectedType === "R") {
            if (data.bname !== "") {
               extraAddr += data.bname;
            }
            if (data.buildingName !== "") {
               extraAddr += (extraAddr !== "" ? ", "
                  + data.buildingName : data.buildingName);
            }
            fullAddr += (extraAddr !== "" ? " (" + extraAddr + ")" : "");
         }
         document.getElementById("zipcode").value = data.zonecode; 
         document.getElementById("address1").value=fullAddr;
         document.getElementById("address2").focus();
         $('#jeju2').show();
         jejuFee(fullAddr);
      }
   }).open();
}


</script>
</head>
<body>
<%@ include file="../include/menu.jsp"%>
<form id="sellform" name="sellform" method="post">	
	
<!--상품 정보  시작-->
<div>
<h3>구매 상품 정보</h3>
<div>
<!--상품 정보페이지 원하는 것들 빼서 쓰시면 됩니다.  -->
<%-- 이미지<img src="/resources/images/${Pdto.filename}" width="300px" height="300px"><br> --%>
<%-- 등록일자<fmt:formatDate pattern="yyyy년 MM월 dd일" value="${Pdto.product_date}"/><br> --%>
	상품종류<input type="text" name="product_cate" value="${Pdto.product_cate}" readonly style="border:0"/><br>
	상품브랜드<input type="text" name="product_brand" value="${Pdto.product_brand}" readonly style="border:0"/><br>
	상품명<input type="text" name="product_name" id="product_name" value="${Pdto.product_name}" readonly style="border:0"/><br>
	상세설명<input type="text" name="product_detail" value="${Pdto.product_detail}" readonly style="border:0"/><br>
</div>	
<h3>가격 및 배송료</h3>
	<div>	
	상품가격
	<c:if test="${Pdto.product_price ne Pdto.product_saleprice}">	
		<fmt:formatNumber value="${Pdto.product_saleprice}" pattern="#,###원"/>
		(<p align="center" style="color: red; display:inline;">
		SALE: <c:set var="sale" value="${((Pdto.product_price-Pdto.product_saleprice)/Pdto.product_price)*100}"/>
		<c:out value="${sale}"/>%</p>
		,정상가 <p style="text-decoration:line-through; display:inline;" align="center">
		<fmt:formatNumber value="${Pdto.product_price}"	pattern="#,###원" /></p>)<br>
		<input type="hidden" name="product_price" id="product_price" value="${Pdto.product_saleprice}" readonly style="border:0"/>
			
	</c:if>
	
	<c:if test="${Pdto.product_price eq Pdto.product_saleprice}">
		<input type="text" name="product_price" id="product_price" value="${Pdto.product_price}" readonly style="border:0"/><br>
	</c:if>
	배송료 :
	<input style="border:0"  id="fee2" name="fee2" value="" readonly />원<br>

	<div id='jeju2' style= display:none;>
		<input style=width:500px id="jeju" name="jeju" value=""  readonly />
	</div>
	</div>

</div>
<!--상품 정보  끝-->

<!--결제 방법 카드결제 or 무통장입금  시작-->
<div>
	<div><h3>결제방법</h3><br>  
	<input type="radio" id="card" name="method"	value="card" checked> 카드결제 
	<input type="radio" id="account" name="method" value="account"> 무통장입금
</div>
<div id="divAcccount" style= display:none; >	
	은행<br>
	<select name="selectBank" id="selectBank" >
			<option value="국민은행" selected>국민은행</option>
			<option value="기업은행">기업은행</option>	
			<option value="농협은행">농협은행</option>
			<option value="수협은행">수협은행</option>
			<option value="우리은행">우리은행</option>
			<option value="하나은행">하나은행</option>
			<option value="카카오은행">카카오은행</option>
			</select><br> 
	입금자 성명<br>
	<input	id="accountName" name="accountName" maxlength='10'><br>
	계좌번호(-생략)<br>
	<input id="accountNumber" name="accountNumber" maxlength='14'>
	
	<!-- <label for="cardNumber" class="form-label">은행</label><br>
	<input	class="form-control" id="accountNumber" name="accountNumber"><br> 
		<label for="cardNumber" class="form-label">입금자명</label><br>
	<input	class="form-control" id="accountNumber" name="accountNumber"><br>
	<label for="cardNumber" class="form-label">계좌번호(-생략)</label><br>
	<input	class="form-control" id="accountNumber" name="accountNumber">
	-->
</div>
</div>
<!--결제 방법 카드결제 or 무통장입금 끝-->

<!--구매자 정보  -->
<div>
<h3>구매자 정보</h3>
구매자 Tel : 
<select name="selectTel" id="selectTel" >
			<option value="010" selected>010</option>
			<option value="011">011</option>	
			<option value="019">016</option>
			<option value="019">017</option>
			<option value="019">018</option>
			<option value="019">019</option>
			</select> -
			<input type="text" name="userTel01" id="userTel01" maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> -
			<input type="text" name="userTel02" id="userTel02" maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
</div>
구매자 이름 : <input type="text" name="user_name" id="user_name" maxlength='10'/><br>
구매자 이메일 : <input type="text" name="user_email01" id="user_email01" maxlength='20'/>@
			<input type="text" name="user_email02" id="user_email02" disabled value="naver.com">
			<select name="selectEmail" id="selectEmail">
			<option value="1">직접입력</option>
			<option value="naver.com" selected>naver.com</option>
			<option value="hanmail.net">hanmail.net</option>	
			<option value="gmail.com">gmail.com</option>
			</select><br>
<!--구매자 정보 끝-->

<!--우편번호 시작 -->
<div>
	<h3>우편번호</h3>
우편번호 : <input id="zipcode" name="zipcode" value="" readonly><br>
<button type="button" onclick="showPostcode()">우편번호찾기</button><br>
주소 : <input style=width:500px; id="address1" name="address1" value=""  readonly><br>
상세주소 : <input style=width:500px; id="address2" name="address2" value="" ><br>
</div>
<!--우편번호 끝 -->

	<!--판매 및 목록 버튼-->
	<input type="button" value="구매하기" onclick="SellDo()">
	<input type="button" value="목록" onclick="location.href='/shop/list.do'">
	<input type="text" id="imp_uid"  name="imp_uid" value="" readonly/>
	<input type="hidden"  id="fee" name="fee" value="" readonly />
	<!--판매 및 목록 버튼-->
		
<!--폼데이터 전달용 숨기기  -->
	<input type="hidden"  id="bill_order" name="bill_order" value="">
	<input type="hidden" name="product_code" id="product_code" value="${Pdto.product_code}"> 
	<input type="hidden" name="user_id" id="user_id" value="${Udto.user_id}">
	<input type="hidden" style="border:0"  id="fee" name="fee" value="" readonly />
	<input type="hidden" id="merchant_uid" name="merchant_uid" value="" readonly />

<!--폼데이터 전달용 숨기기 끝  -->

</form>

</body>
</html>
