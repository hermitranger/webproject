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
	$(function() {

		$("#product_cate").on("change", function() {

			var cate_val = $("#product_cate").val();
			console.log(cate_val);

			if (cate_val != null) {

				$("#change").children().css("visibility", "hidden");
				$("#product_" + cate_val).css("visibility", "visible");

				$("#product_" + cate_val).on("change", function() {

					$("#product_brand").css("visibility", "visible");

				});

			}
			if (cate_val == "default") {
				$("#product_brand").css("visibility", "hidden")
			}
		});

	});

	function product_write(pcode) {

		var product_name = $("#product_name").val();
		var product_price = $("#product_price").val();
		var product_detail = $("#product_detail").val();
		var cate = $("#product_cate").val();
		var cate_detail = $("#product_" + cate).val();
		var product_brand = $("#product_brand option:checked").text();
		var product_size = $("#product_size").val();
		var product_cate = $("#product_cate :selected").text();
		var product_priority = $("#product_priority").val();
		var product_model = $("#product_model").val();

		var important = $("#important").val();
		var dto = new FormData;
		var product_code = pcode;
		alert("product code:" + pcode + " 로 등록됩니다.");
		
		dto.append("product_code", product_code);
		dto.append("product_name", product_name);
		dto.append("product_cate", product_cate);
		dto.append("product_priority", product_priority);
		dto.append("product_price", product_price);
		dto.append("product_check", 0);
		dto.append("product_model", product_model);
		dto.append("product_amount", 1);
		dto.append("product_detail", product_detail);
		dto.append("product_brand", product_brand);
		if($("#file1")[0].files.length > 0){
		 var file1 = $("#file1")[0].files[0];	
			dto.append("file1", file1);
		}

		
				$.ajax({

					type : "post",
					url : "/shop/insert.do",
					enctype:"multipart/form-data",	
					processData : false,
					contentType : false,									
					data : dto,
					success : function(data) {

						$("#result").html(data);
						//$("#header").css("visibility","hidden");
						$("#result").children("#header").css("display", "none");
						$(".ajaxcontainer").children().css("height", "15vh");
						$(".ajaxcontainer").children().css("width", "45vw");
						//$("#ajaxfunction").css("all","unset")
						$("#result").children("#body").css("all", "unset");

						//$("."+product_code).css("border-style","solid");
						//$("."+product_code).css("border-color","red");
						//$("#file1").val("");
						var btnCancel = $("<input type='button' name='btnC' onclick='cancel_list(this)' value='"
								+ product_name
								+ " 삭제' data-src='"
								+ product_code + "'>");
						//var btnCancel=$("<input type='button' onclick='cancel_list(this.value)' value='"+product_name+"삭제'>");
						$("#btnCancel").append(btnCancel);

						if ($("#btnCancel").children().length > 0) {

							var arrlen = $("input[name=btnC]").length;
							var valarr = new Array(arrlen);

							//var val=$("#btnCancel").children(':button[name=btnC]').data('src');

							for (var i = 0; i < arrlen; i++) {
								valarr[i] = $("input[name=btnC]").eq(i).data(
										'src');
								$("." + valarr[i]).css("border-style", "solid");
								$("." + valarr[i]).css("border-color", "red");
								$("#file1").val("");
							}

						}

					},

					error : function(request, status, error, data) {
						console.log("code: " + request.status)
						console.log("message: " + request.responseText)
						console.log("error: " + error);

						console.log(data);

					}
				});

	}

	function cancel_list(btn) {

		if (confirm("정말삭제하시겠습니까")) {

			var product_code = $(btn).data("src");

			
					$.ajax({

						type : "post",
						url : "/shop/delete.do",
						data : {
							"product_code" : product_code
						},
						success : function(data) {

							$("#result").html(data);
							//$("#header").css("visibility","hidden");
							$("#result").children("#header").css("display","none");
							$(".ajaxcontainer").children().css("height", "15vh");
							$(".ajaxcontainer").children().css("width", "45vw");
							//$("#ajaxfunction").css("all","unset")
							$("body").css("all", "unset");
							$(btn).remove();

							if ($("#btnCancel").children().length > 0) {

								var arrlen = $("input[name=btnC]").length;
								var valarr = new Array(arrlen);

								//var val=$("#btnCancel").children(':button[name=btnC]').data('src');

								for (var i = 0; i < arrlen; i++) {
									valarr[i] = $("input[name=btnC]").eq(i).data('src');
								}

								for (var i = 0; i < arrlen; i++) {
									$("." + valarr[i]).css("border-style","solid");
									$("." + valarr[i]).css("border-color","red");
								}

							}

						}

					});
		}
	}

	function insertCheck() {

		var product_name = $("#product_name").val();
		var product_price = $("#product_price").val();
		var product_detail = $("#product_detail").val();
		var cate = $("#product_cate").val();
		var cate_detail = $("#product_" + cate).val();
		var product_brand = $("#product_brand").val();
		var product_size = $("#product_size").val();
		var product_cate = $("#product_cate :selected").text();
		var product_priority = $("#product_priority").val();
		var product_model = $("#product_model").val();

		var product_code = cate + cate_detail + product_brand + product_size+ "000";
		if (product_name == "") {
			alert("상품명을 입력하세요.");
			//document.product_inform.product_name.focus();
			return;
		}
		if (cate == "" || cate == "default") {
			alert("카테고리를 입력하세요.");
			$("#product_cate").focus();
			return;
		}
		if (cate_detail == "" || cate_detail == "default") {
			alert("중분류를 입력하세요.");
			$("#product_" + cate).focus();
			return;
		}
		if (product_brand == "" || product_brand == "default") {
			alert("브랜드를 입력하세요.");
			$("#product_brand").focus();
			return;
		}
		if (product_model == "") {
			alert("제품 모델을 입력하세요.");
			//document.product_inform.product_price.focus();
			return;
		}

		if (product_price == "") {
			alert("가격을 입력하세요.");
			//document.product_inform.product_price.focus();
			return;
		}
		if (product_detail == "") {
			alert("상품설명을 입력하세요.");
			//document.product_inform.product_detail.focus();
			return;
		}

		$.ajax({

			type : "post",
			url : "/shop/insertCheck.do",
			data : {
				"product_model" : product_model,
				"product_name" : product_name
			},
			success : function(data) {

				if (data == "error") {

					alert("상품명 또는 제품코드가 중복입니다.");
					return;
				} else {

					$.ajax({

						type : "post",
						url : "/shop/getProduct_code.do",
						data : {
							"product_code" : product_code
						},
						success : function(data) {

							if (data == "error") {

								alert("입력가능한 상품코드의 번호가 초과되었습니다.");
							}else if(data=="timelimit"){
								
								alert("일정시간 안에 너무 많은 요청을 했습니다. 기다려주세요.");
							}else {

								product_write(data);
							}

						}

					});

				}
			}

		});

	}
</script>
<style>
.container {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 40px;
}

.box {
	border-style: solid;
	border-color: blue;
}
</style>
</head>
<%@ include file="../include/menu.jsp"%>
<body>
	<div class='container'>
		<h2>매입할 상품</h2>
		<br>

		<form id='form1' name='form1' method='post'
			enctype='multipart/form-data'>
			상품명<br> <input type="text" name="product_name" id='product_name'>
			<br> 카테고리 <select id="product_cate" name="product_cate">
				<option value="default">카테고리를 선택하세요</option>
				<option value="1">난방기구</option>
				<option value="2">냉방기구</option>
				<option value="3">영상기구</option>
				<option value="4">음향기구</option>
				<option value="5">주방용</option>
				<option value="6">청소</option>
				<option value="7">컴퓨터</option>
				<option value="8">기타</option>
			</select> <br> 세부항목
			<div id="change" name="change">
				<select id="product_1" name="product_1" style="visibility: hidden;">
					<option value="default">세부항목을 선택하세요</option>
					<option value="11">히터</option>
					<option value="12">전기난로</option>
					<option value="13">난방기</option>
				</select> <select id="product_2" name="product_2" style="visibility: hidden;">
					<option value="default">세부항목을 선택하세요</option>
					<option value="21">선풍기</option>
					<option value="22">벽걸이에어컨</option>
					<option value="23">스탠드에어컨</option>
				</select> <select id="product_3" name="product_3" style="visibility: hidden;">
					<option value="default">세부항목을 선택하세요</option>
					<option value="31">카메라</option>
					<option value="32">빔프로젝트</option>
					<option value="33">TV</option>
				</select> <select id="product_4" name="product_4" style="visibility: hidden;">
					<option value="default">세부항목을 선택하세요</option>
					<option value="41">이어폰</option>
					<option value="42">헤드폰</option>
					<option value="43">스피커</option>
				</select> <select id="product_5" name="product_5" style="visibility: hidden;">
					<option value="default">세부항목을 선택하세요</option>
					<option value="51">전자레인지</option>
					<option value="52">오븐</option>
					<option value="53">냉장고</option>
				</select> <select id="product_6" name="product_6" style="visibility: hidden;">
					<option value="default">세부항목을 선택하세요</option>
					<option value="61">핸디청소기</option>
					<option value="62">로봇청소기</option>
					<option value="63">진공청소기</option>
				</select> <select id="product_7" name="product_7" style="visibility: hidden;">
					<option value="default">세부항목을 선택하세요</option>
					<option value="71">PC기타</option>
					<option value="72">노트북</option>
					<option value="73">데스크탑</option>
				</select> <select id="product_8" name="product_8" style="visibility: hidden;">
					<option value="default">세부항목을 선택하세요</option>
					<option value="81">소형기타</option>
					<option value="82">중형기타</option>
					<option value="83">대형기타</option>
				</select>
			</div>
			<br> 브랜드 <select id="product_brand" name="product_brand"
				id="product_brand" style="visibility: hidden;">
				<option value="default">브랜드를 선택하세요</option>
				<option value="01">삼성</option>
				<option value="02">LG</option>
				<option value="03">한경희</option>
				<option value="04">신일전자</option>
				<option value="05">한일전기</option>
				<option value="06">파세코</option>
				<option value="07">캐리어</option>
				<option value="11">샤오미</option>
				<option value="12">하이얼</option>
				<option value="13">애플</option>
				<option value="14">ASUS</option>
				<option value="15">디월트</option>
			</select> <br> 상품모델 <input type="text" id="product_model"
				name="product_model"> <br> 상품가격 <input type="number"
				name="product_price" id="product_price"> <br> 상품크기 <select
				id="product_size" name="product_size">
				<option value="default">상품크기를 선택하세요</option>
				<option value="1">소</option>
				<option value="2">중</option>
				<option value="3">대</option>
			</select> <br> 상품설명<br>
			<textarea id="product_detail" name="product_detail" cols="80%"
				rows="15"></textarea>
			<br> 첨부파일 등록<br>
			<input type="file" name="file1" id="file1" accept="image/*">		
			<br> 중요도 <select id='product_priority' name='product_priority'>
				<option value="00" selected>00</option>
				<option value="01">01</option>
				<option value="02">02</option>
				<option value="03">03</option>
				<option value="04">04</option>
				<option value="05">05</option>
				<option value="06">06</option>
				<option value="07">07</option>
				<option value="08">08</option>
				<option value="09">09</option>
				<option value="10">10</option>
			</select> <br> <input type="button" id="save_list" name="save_list"
				onclick="insertCheck()" value="물품등록"> <input type="button"
				id="gotolist" name="gotolist"
				onclick="location.href='/shop/list.do'" value="상품리스트 확인"> <br>
			<h4>
			상품매입철회(긴급등록취소)
			</h4>
			<div id="btnCancel"></div>



		</form>
		<div class='box' style="pointer-events: none;">
			<div id="result" class="result" >판매리스트페이지보기</div>
		</div>

	</div>
</body>

</html>