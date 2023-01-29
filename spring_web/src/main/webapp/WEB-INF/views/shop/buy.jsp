<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--fn:사용하기 위해 태그 추가  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>buy.jsp</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script>
$(function() {
	fee();
	
});	 
/* function dis(){
	    if($('#jeju2').css('display') == 'none'){    	
	    	  $('#jeju2').hide(); 
	}else{
		 $('#jeju2').show();
	}
} */

//document.cookie = "crossCookie=bar; SameSite=None; Secure";//
var IMP = window.IMP; // 생략 가능
IMP.init("imp54321076");//가맹점 식별코드imp54321076 /rkdhyung4@gamil.com 비밀번호 대문자 포함 특수문자x
var today = new Date();   
var hours = today.getHours(); // 시
var minutes = today.getMinutes();  // 분
var seconds = today.getSeconds();  // 초
var milliseconds = today.getMilliseconds();
var makeMerchantUid = hours +  minutes + seconds + milliseconds;

function requestPay() {

	if($("#zipcode").val()== ""){
		alert("우편번호를 입력해주세요");
		
	}
	else if($("#address2").val()== ""){
		alert("상세주소를 입력해주세요");
		
		
	}
	else{
		alert("배송비 결제");
	    IMP.request_pay({
	        pg : 'kcp',
	        pay_method : 'card',
	        merchant_uid: "IMP"+makeMerchantUid, 
	        name: $("#product_name").val(),
	        //amount: $("#product_price").val(),                         //TEST 끝날시 숫자 타입
	        amount: 100, //테스트용 1원 값은 $("#fee").val()
	        buyer_email: $("#user_email").val(),
	        buyer_name: $("#user_name").val(),
	        buyer_tel: $("#user_phone").val(),
	        buyer_addr: $("#address1").val().concat($("#address2").val()),
	        buyer_postcode: $("#zipcode").val()
	    }, function (rsp) { // callback
	        if (rsp.success) {  // 결제 성공 시 로직   
	       
	        	alert("결제 완료");
	        } else {  // 결제 실패 시 로직
	        	BuyResult();//데이터 잘들어가는지 TEST
	        	alert("결제 실패"); 
             
	        }
	    });
	}
}

function BuyResult(){	
	var url = "/BuyResult.do";
	var bill_order = createOrderNum(); //가맹점 주문번호
	document.getElementById("bill_order").value = bill_order;
		$.ajax({
			url : url, 
			type : 'POST',
			traditional : true,
				data : $("#buyform").serialize(),
			success : function(jdata) {
				if (jdata == "1") {
					return location.href="/BuyResult.page";
				} else {
					alert("오류");
				}

			} 

		});		
}  



</script>
</head>
<script>
//https://cobi-98.tistory.com/20 주문번호 만들기 
function createOrderNum(){
	const date = new Date();
	const year = date.getFullYear();
	const month = String(date.getMonth() + 1).padStart(2, "0");
	const day = String(date.getDate()).padStart(2, "0");  
	let product_code = $("#product_code").val();
	//let product_code2 = "${Pdto.product_code}"; //""안붙히면 오류
	let bill_order = "B" + product_code + year + month + day;
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
<body>
	<%@ include file="../include/menu.jsp"%>
	<h3>판매 상품 정보</h3>
	<form id="buyform" name="buyform" method="post">
		<div><!--상품 정보페이지 원하는 것들 빼서 쓰시면 됩니다.  -->
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
	<fmt:formatNumber value="${Pdto.product_price}"	pattern="#,###원" /><br>	
	배송료 : 
	<input style="border:0"  id="fee2" name="fee2" value="" readonly />원<br>
	<div id='jeju2' style= display:none;>
		<input style=width:500px id="jeju" name="jeju" value=""  readonly />
	</div>
	</div>
		
	<h3>우편번호</h3>
	<div>
		<button type="button" onclick="showPostcode()">우편번호찾기</button><br>
		우편번호<input id="zipcode" name="zipcode" value="" readonly><br>
		주소<input style=width:500px; id="address1" name="address1" value=""  readonly><br>
		상세주소<input style=width:500px; id="address2" name="address2" value="" >
	</div>
	<h3>판매자 정보</h3>
		
		판매자 ID :<input type="text" name="user_id" id="user_id" value="${Udto.user_id}" readonly/><br>
		판매자 Tel : <input type="text" name="user_phone" id="user_phone" value="${Udto.user_phone}" readonly/><br>
		판매자 이름 : <input type="text" name="user_name" id="user_name" value="${Udto.user_name}" readonly/><br>
		판매자 이메일 : <input type="text" name="user_email" id="user_email" value="${Udto.user_email}" readonly/><br>
		
		
	<!--판매 및 목록 버튼-->	
	<input type="button" value="판매" onclick="requestPay()">
	<input type="button" value="목록" onclick="location.href='/shop/list.do'">
	<!--판매 및 목록 버튼-->
		
	<!--폼데이터 전달용 숨기기  -->
		<input type="hidden"  id="bill_order" name="bill_order" value="">
		<input type="hidden" name="product_code" id="product_code" value="${Pdto.product_code}">
		<input type="hidden" style="border:0"  id="fee" name="fee" value="" readonly /> 
	<!--input 대신 button으로 할시 기본값 submit이라 foam 전송 후 새로고침 -> 숨겨놓은 product 값 컨트롤단에서 requestparm으로 받을시 2개받음  -->
		
	</form>	
</body>
</html>
