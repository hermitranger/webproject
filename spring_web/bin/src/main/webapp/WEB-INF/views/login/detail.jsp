<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">

<script src="http://code.jquery.com/jquery-3.6.1.min.js">
	
</script>
<script>
	/* $(document).ready()(function() */

	$(function() {

		var user_gender = "${dto.user_gender}";

		if (user_gender == "남") {

			$(":radio[name='user_gender'][value='남']").attr('checked', true);

		} else {

			$(":radio[name='user_gender'][value='여']").attr('checked', true);
		}//: =>input 요소를 선택함 예 :text 지정한 요소를 선택

	});

	function conf() {

		if (confirm("수정하시겠습니까?")) {
			// /빼먹으면 주소 못찾는다
			document.form1.action = "user_update.do";
			document.form1.submit();
		} else {

		}

	};
</script>

<title>중고장터 :: 회원정보 관리</title>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<h2 class="active">회원 정보 변경</h2>

			<form name="form1" method="post">
				<h2 class="active">아이디</h2>
				<input type="text" id="user_id" name="user_id"
					value="${dto.user_id}" readonly><br>
				<h2 class="active" align="center">비밀번호</h2>
				<input type="text" id="user_passwd" name="user_passwd"
					value="${dto.user_passwd}"><br>
				<h2 class="active" align="center">이름</h2>
				<br> <input type="text" id="user_name" name="user_name"
					value="${dto.user_name}"><br>
				<h2 class="active">생년월일</h2>
				<input type="text" id="user_birth" name="user_birth"
					value="${dto.user_birth}"><br>
				<h2 class="active">성별</h2>
				<input type='radio' id='user_gender' name='user_gender' value='남'>
				<h2 class="active">남</h2>
				<input type='radio' id='user_gender' name='user_gender' value='여'>
				<h2 class="active">여</h2>
				<br>
				<h2 class="active">이메일</h2>
				<input type="text" id="user_email" name="user_email"
					value="${dto.user_email}"><br>
				<h2 class="active">전화번호</h2>
				<input type="text" id="user_phone" name="user_phone"
					value="${dto.user_phone}"><br>
				<h2 class="active">우편번호</h2>
				<input type="text" id="user_zipcode" name="user_zipcode"
					placeholder="우편번호" value="${dto.user_zipcode}" readonly> <input
					type="button" onclick="sample5_execDaumPostcode()" value="우편번호 찾기">

				<br>
				<h2 class="active">주소</h2>
				<input type="text" id="user_addr" name="user_addr"
					value="${dto.user_addr}" readonly><br>
				<h2 class="active">상세주소</h2>
				<input type="text" id="user_addrdetail" name="user_addrdetail"
					value="${dto.user_addrdetail}"><br> <input type="text"
					id="sample5_extraAddress" placeholder="참고항목">

				<div id="map" style="width: 300px; height: 300px; margin-top: 10px;"></div>

				<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
				<script
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f7a963e8223a5f44c62ba4aa9a1ff32f&libraries=services"></script>


				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div
					mapOption = {
						center : new daum.maps.LatLng(37.55496067381771,
								126.93598956791202), // 지도의 중심좌표
						level : 3
					// 지도의 확대 레벨
					};

					//지도를 미리 생성
					var map = new daum.maps.Map(mapContainer, mapOption);
					//주소-좌표 변환 객체를 생성
					var geocoder = new daum.maps.services.Geocoder();
					//마커를 미리 생성
					var marker = new daum.maps.Marker({
						position : new daum.maps.LatLng(37.55496067381771,
								126.93598956791202),
						map : map
					});

					geocoder.addressSearch('${dto.user_addr}', function(result,
							status) {

						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {

							var coords = new kakao.maps.LatLng(result[0].y,
									result[0].x);

							// 결과값으로 받은 위치를 마커로 표시합니다
							var marker = new kakao.maps.Marker({
								map : map,
								position : coords
							});

							// 인포윈도우로 장소에 대한 설명을 표시합니다
							//var infowindow = new kakao.maps.InfoWindow({
							//    content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
							//});
							//infowindow.open(map, marker);

							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
						}
					});

					function sample5_execDaumPostcode() {
						new daum.Postcode(
								{
									oncomplete : function(data) {
										var addr = data.address; // 최종 주소 변수

										var addr = ''; // 주소 변수
										var extraAddr = ''; // 참고항목 변수

										//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
										if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
											addr = data.roadAddress;
										} else { // 사용자가 지번 주소를 선택했을 경우(J)
											addr = data.jibunAddress;
										}

										// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
										if (data.userSelectedType === 'R') {
											// 법정동명이 있을 경우 추가한다. (법정리는 제외)
											// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
											if (data.bname !== ''
													&& /[동|로|가]$/g
															.test(data.bname)) {
												extraAddr += data.bname;
											}
											// 건물명이 있고, 공동주택일 경우 추가한다.
											if (data.buildingName !== ''
													&& data.apartment === 'Y') {
												extraAddr += (extraAddr !== '' ? ', '
														+ data.buildingName
														: data.buildingName);
											}
											// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
											if (extraAddr !== '') {
												extraAddr = ' (' + extraAddr
														+ ')';
											}
											// 조합된 참고항목을 해당 필드에 넣는다.
											document
													.getElementById("sample5_extraAddress").value = extraAddr;

										} else {
											document
													.getElementById("sample5_extraAddress").value = '';
										}

										// 우편번호와 주소 정보를 해당 필드에 넣는다.
										document.getElementById('user_zipcode').value = data.zonecode;
										document.getElementById("user_addr").value = addr;
										// 커서를 상세주소 필드로 이동한다.
										document.getElementById(
												"user_addrdetail").focus();

										// 주소 정보를 해당 필드에 넣는다.
										document.getElementById("user_addr").value = addr;
										// 주소로 상세 정보를 검색
										geocoder
												.addressSearch(
														data.address,
														function(results,
																status) {
															// 정상적으로 검색이 완료됐으면
															if (status === daum.maps.services.Status.OK) {

																var result = results[0]; //첫번째 결과의 값을 활용

																// 해당 주소에 대한 좌표를 받아서
																var coords = new daum.maps.LatLng(
																		result.y,
																		result.x);
																// 지도를 보여준다.
																//mapContainer.style.display = "block";
																map.relayout();
																// 지도 중심을 변경한다.
																map
																		.setCenter(coords);
																// 마커를 결과값으로 받은 위치로 옮긴다.
																marker
																		.setPosition(coords)
															}
														});
									}
								}).open();
					}

					// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
					var mapTypeControl = new kakao.maps.MapTypeControl();

					// 지도 타입 컨트롤을 지도에 표시합니다
					map.addControl(mapTypeControl,
							kakao.maps.ControlPosition.TOPRIGHT);
				</script>





				<!-- 유저체크<input type="number" id="check"  name="check"><br> -->
				<br> <input type='button' value='회원정보수정' onclick="conf()"
					style="color: black;"> <input type='button' value='메인화면'
					onclick="location.href='/'" style="color: black;">
			</form>
		</div>
	</div>
	<link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>