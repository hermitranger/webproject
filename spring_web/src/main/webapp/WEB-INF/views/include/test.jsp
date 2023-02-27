<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include summernote css/js -->
<link href="/resources/summernote/summernote.min.css" rel="stylesheet">
<script src="/resources/summernote/summernote.min.js"></script>


<script>
$(function() {
//id description summernote 가 인 태그를 로 변경
$("#description").summernote({
height : 300,
width : 800,
});
});

</script>


</head>

<body>


<!-- daum map api -->
<input type="text" id="sample5_postcode" placeholder="우편번호">
<input type="button" onclick="sample5_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="sample5_address" placeholder="주소"><br>
<input type="text" id="sample5_detailAddress" placeholder="상세주소">
<input type="text" id="sample5_extraAddress" placeholder="참고항목">



<!-- <input type="text" id="sample5_address" placeholder="주소" readonly>
<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br> -->
<div id="map" style="width:300px;height:300px;margin-top:10px;"></div>


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> -->
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
                document.getElementById('sample5_postcode').value = data.zonecode;
                document.getElementById("sample5_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample5_detailAddress").focus();
                
                
                
                

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
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

    function getInfo() {
        // 지도의 현재 중심좌표를 얻어옵니다 
        var center = map.getCenter(); 
        
        // 지도의 현재 레벨을 얻어옵니다
        var level = map.getLevel();
        
        // 지도타입을 얻어옵니다
        var mapTypeId = map.getMapTypeId(); 
        
        // 지도의 현재 영역을 얻어옵니다 
        var bounds = map.getBounds();
        
        // 영역의 남서쪽 좌표를 얻어옵니다 
        var swLatLng = bounds.getSouthWest(); 
        
        // 영역의 북동쪽 좌표를 얻어옵니다 
        var neLatLng = bounds.getNorthEast(); 
        
        // 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
        var boundsStr = bounds.toString();
        
        
        var message = '지도 중심좌표는 위도 ' + center.getLat() + ', <br>';
        message += '경도 ' + center.getLng() + ' 이고 <br>';
        message += '지도 레벨은 ' + level + ' 입니다 <br> <br>';
        message += '지도 타입은 ' + mapTypeId + ' 이고 <br> ';
        message += '지도의 남서쪽 좌표는 ' + swLatLng.getLat() + ', ' + swLatLng.getLng() + ' 이고 <br>';
        message += '북동쪽 좌표는 ' + neLatLng.getLat() + ', ' + neLatLng.getLng() + ' 입니다';
        
        // 개발자도구를 통해 직접 message 내용을 확인해 보세요.
        // ex) console.log(message);
        document.write(message);
    }
    
    
</script>
<button onclick="getInfo()">정보확인</button>

<textarea rows="5" cols="60" name="description" id="description"></textarea>

</body>

</html>