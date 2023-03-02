<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">

<script src="http://code.jquery.com/jquery-3.6.1.min.js">
	
</script>
<script>
	/* $(document).ready()(function() */

	function msg() {

		//var message=request.getAttribute("message");
		var message = "${message}";

		if (message == "") {
			return;
		}

		if (message != "") {

			$("#message").html(message);
		}
		
		var user_gender = "${dto.user_gender}";

		if (user_gender == "남") {

			$(":radio[name='user_gender'][value='남']").attr('checked', true);

		} else {

			$(":radio[name='user_gender'][value='여']").attr('checked', true);
		}//: =>input 요소를 선택함 예 :text 지정한 요소를 선택

	

	};

	$(function() {

		$("#join").click(function() {

			/* 		var user=$("#user_id");
			 console.log(user); */
			if (($("#user_id").val()) == "") {
				alert("아이디를 입력하세요")
				//$("#user_id").focus();
				return;
			}

			//		var expid=/^[a-z0-9]{4,10}$/;

			//		if(!expid.test($("#user_id").val())){
			//			alert("아이디는 영문소문자, 숫자 4~10자리로 입력하세요.");
			//$("#user_id").focus();

			//			return;
			//		}

			if (($("#user_passwd").val()) == "") {
				alert("비밀번호를 입력하세요.")
				//$("#user_passwd").focus();
				return;
			}

			if (($("#user_name").val()) == "") {
				alert("이름을 입력하세요.")
				//$("#user_name").focus();
				return;
			}
			
			

			/* if (($("#user_birth").val()) == "") {
				alert("생년월일을 입력하세요.")
				//$("#user_birth").focus();
				return;
			}

			if (($("#user_gender").val()) == "") {
				alert("성별을 입력하세요.")
				//$("#user_gender").focus();
				return;
			} */

			if (($("#user_email").val()) == "") {
				alert("이메일을 입력하세요.")
				//$("#user_email").focus();
				return;
			}
					
			var expemail = /\w+@\w+\.\w+(\.\w+)?$/;

			if (!expemail.test($("#user_email").val())) {
				alert("이메일 형식: a@a.com을 지켜주세요.");
				$("#message").val("사용할 수 없는 이메일 형식 입니다.");
				$("#user_email").val("");
				$("#user_email").focus();
				return;
			}
			
			if (($("#user_phone").val()) == "") {
				alert("전화번호를 입력하세요.")
				//$("#user_email").focus();
				return;
			}		
			
			var expphone = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
			
			if (!expphone.test($("#user_phone").val())) {
				alert("전화번호 형식: 010-xxxx-xxxx 을 지켜주세요.");
				$("#message").val("사용할 수 없는 전화번호 형식 입니다.");
				$("#user_phone").val("");
				$("#user_phone").focus();
				return;

			/* if (($("#user_phone").val()) == "") {
				alert("전화번호를 입력하세요.")
				//$("#user_phone").focus();
				return; */
			}
			
			if (($("#user_zipcode").val()) == "") {
				alert("우편번호를 입력하세요")
				return;
			}
			if (($("#user_addrdetail").val()) == "") {
				alert("상세주소를 입력하세요")				
				return;
			}
			
			
			
			
			

			document.form1.action = "/join.do"
			document.form1.method = "post"
			document.form1.submit();

		});

	});

	function idcheck() {

		var user_id = $("#user_id").val();
		var params = {
			"user_id" : user_id
		};

		var expid = /^[a-z0-9]{4,10}$/;

		if (!expid.test($("#user_id").val())) {
			alert("아이디는 영문자, 숫자 4~10자리로 입력하세요.");
			$("#message").val("사용할 수 없는 아이디 입니다.");
			$("#user_id").val("");
			$("#user_id").focus();
			return;
		}

		/* ajax success:function(리턴값) $("#아이디").html(변수값) */

		$.ajax({
			type : "post",
			url : "/idcheck.do",
			data : params,
			success : function(map) {

				//var message="${message}";
				//$("#message").html(${message});
				$("#message").html(map.message);

				/* var result2="${result2}";
				
				if((result2)!=""){
					$("#user_id").val(result2);
					return;
				} */

				$("#user_id").val(map.userid);
				//$("#user_id").val("");
				$("#user_id").focus();
			}

		});

	};
</script>

<title>중고장터 :: 회원가입</title>
</head>
<body onload="msg()">

<%@ include file="../include/menu.jsp"%>

	<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->
			<h2 class="active">회원가입란</h2>

			<!-- Login Form -->
			<form name="form1" method="post">
				 <input type="text" id="user_id" name="user_id"
			value="${dto.user_id}" class="fadeIn second"
					placeholder="아이디"> 
				<input type="button" value="아이디확인"
			onclick="idcheck()" class="fadeIn second" style="color:black;">
			<div id = "message"></div>
			<br>
			<input type="password" id="user_passwd" name="user_passwd"
			value="${dto.user_passwd}" class="fadeIn third" placeholder="비밀번호">
			<br>
			<input type="text"
			id="user_name" name="user_name" value="${dto.user_name}" class="fadeIn third" placeholder="이름">
			<br>
			<input type="date" id="user_birth" name="user_birth"
			value="${dto.user_birth}" class="fadeIn forth">
			<br>
			<input type="radio" id="user_gender" name="user_gender" value="남" class="fadeIn forth">남 
			<input type="radio" id="user_gender" name="user_gender" value="여" class="fadeIn forth">여
			<br>
			<input type="text" id="user_email" name="user_email" value="${dto.user_email}" class="fadeIn forth" placeholder="이메일"><br>	
			<input type="text"
			id="user_phone" name="user_phone" value="${dto.user_phone}" class="fadeIn forth" placeholder="전화번호"><br>
			
			<!-- daum map api -->
<!-- daum map api -->

<input type="text" id="user_zipcode" name="user_zipcode" placeholder="우편번호" readonly>
<input type="button" onclick="sample5_execDaumPostcode()" value="우편번호 찾기">
<input type="text" id="user_addr" placeholder="주소" name="user_addr" readonly><br>
<input type="text" id="user_addrdetail" name="user_addrdetail" placeholder="상세주소">
<input type="text" id="sample5_extraAddress" placeholder="참고항목">



<!-- <input type="text" id="user_addr" placeholder="주소" readonly>
<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br> -->
<div id="map" style="width:300px;height:300px;margin-top:10px;"></div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f7a963e8223a5f44c62ba4aa9a1ff32f&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.55496067381771, 126.93598956791202), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.55496067381771, 126.93598956791202),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
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
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample5_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample5_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('user_zipcode').value = data.zonecode;
                document.getElementById("user_addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("user_addrdetail").focus();
                
                
                
                

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("user_addr").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        //mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
    
 // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
    var mapTypeControl = new kakao.maps.MapTypeControl();

    // 지도 타입 컨트롤을 지도에 표시합니다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
   
</script>

			
			<input type = "button" id="join" value = "회원가입" style="color:black;">
			</form>
			

		</div>
	</div>
	<%-- <%@ include file="/menu" %> --%>
	<%-- <form name="form1">
		<h2>회원가입</h2>
		아이디 <input type="text" id="user_id" name="user_id"
			value="${dto.user_id}"><input type="button" value="아이디확인"
			onclick="idcheck()">
		<div id="message"></div>
		<br> 패스워드<input type="text" id="user_passwd" name="user_passwd"
			value="${dto.user_passwd}" class="fadeIn third" placeholder="password"><br> 이름<input type="text"
			id="user_name" name="user_name" value="${dto.user_name}"><br>
		생년월일<input type="text" id="user_birth" name="user_birth"
			value="${dto.user_birth}"><br> 성별<input type="radio"
			id="user_gender" name="user_gender" value="남">남 <input
			type="radio" id="user_gender" name="user_gender" value="여">여
		<br> 이메일<input type="text" id="user_email" name="user_email"
			value="${dto.user_email}"><br> 전화번호<input type="text"
			id="user_phone" name="user_phone" value="${dto.user_phone}"><br>
		<!-- 유저체크<input type="number" id="check"  name="check"><br> -->
		<button id="join">회원가입</button>

	</form>
 --%>
 <link rel="stylesheet" href="${path}/resources/css/login.css?ver=2" />
</body>
</html>