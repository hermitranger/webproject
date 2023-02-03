<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../include/menu.jsp" %>


<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
/* $(function(){
		
	$(".box").on("dragenter dragover", function(e){
		e.preventDefault();
	});
	
	$(".box").on("drop",function(e){
		
		e.preventDefault();
		var data = e.dataTransfer.getData("html");
		$("#second").html(data);
		
		
		
	});
	
})
 */
 
//https://kyung-a.tistory.com/18  iframe 단점
function drag(event){
	
	
	event.dataTransfer.setData("text", event.target.value);
		
}

function drop(event){
	
	event.preventDefault();
	var data = event.dataTransfer.getData("text");
	console.log(data);
	
			var iframe= $("<iframe class='iframe' style='boarder:none' width='100%' height='100%' src="+data+" value='"+data+"'></ifram>");
	
						/* $("#content").append("<div id='"+data+"'></div>");
	
						var here=document.getElementById(data);  */
						
	var count= $("#content").children().length;
	
	console.log(count);
	
	if(count > 0 & count<2){
		
		$(".content").css("grid-template-columns","1fr 1fr");
	}
	
	if(count >= 2){
		

		$(".content").css("grid-auto-rows", "minmax(100%, auto)");
				
	}
	
	if(count == 4){
		
		return;
	}
	
	/* count += 1;
	console.log(count);
	console.log(typeof(count));
	for(var i=0; i<count ; i++){
		
	html+="<div id='del' class='content' value='"+i+"'></div>";
	
	}
	$("#content").html(html);
	
	iframe.appendTo("#del");*/
	
	
										/* $.ajax({
		
												url: data,
												type: "post",
												success : function(html){
			
			
												$(here).html(html);
												
												
												}
		
										});   */

	
			iframe.appendTo("#content");
	
	
	//var del=$(".iframe[value='"+data+"']");
	//console.log(del);
	
	//btn.appendTo(".iframe[value='"+data+"']");
	
	
	//location.href=data;
	//$("#second").html(data);
	
	//event.target.append(data);
	//event.target.appendChild(document.getElementById(data));
	
}

function allowdrop(event){
	
	event.preventDefault();
}

</script>

<style>
.container{
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
}
.content{
  display: grid;  
  grid-template-columns: 1fr;
  grid-auto-rows: minmax(450%, auto);  
  gap: 10px;
}


.box{
  border: 3px solid #666;
  background-color: #ddd;
  border-radius: .5em;
  padding: 10px;
  cursor: move;
}

</style>
</head>
<body>
<div class="container" id="container">
<div class="box" id="first">

<button id="btnGotoBoard" name="btn1" draggable="true" onclick="location.href='board/list.do'"
value="/board/listM.do" ondragstart="drag(event)" >게시판으로 이동</button></div>
<div class="box" id="second" >

<button id="btnGotoUser" name="btn2" draggable="true" onclick="location.href='admin_user_list.do'"
value="/admin_user_list.do" ondragstart="drag(event)" >유저관리로 이동</button></div>

<div class="box" id="second" ><button id="btnGotoProduct" name="btn3" draggable="true" onclick="location.href='admin_deal.do'"
value="/admin_deal.do" ondragstart="drag(event)" >거래내역으로 이동</button></div>
<br>
<div class="box" id="third" ><button id="btnGotoSoldout" name="btn4" draggable="true" onclick="location.href='soldout.do'"
value="/soldout.do" ondragstart="drag(event)" >매진물품관리로 이동</button></div>

<div class="box" id="fourth" ><button id="btnGotoSale" name="btn5" draggable="true" onclick="location.href='admin_sale_list.do'"
value="/admin_sale_list.do" ondragstart="drag(event)" >세일물품관리로 이동</button></div>
<div draggable="true" class="box" id="third" ondrop="drop(event)" ondragover="allowdrop(event)">
멀티관리모드(창을 끌어다 놓으세요)</div>
<div class="box">
<label for="btnmultioff">멀티관리모드종료</label>
<button id="btnmultioff" onclick="location.href='admin_manage.page'"></button>
</div>
</div>

<div class="content" id="content"></div>

</body>
</html>

<!-- <html>
<head>
<style>
/* 드래그해 놓을 상자의 모양을 정합니다. 지금은 신경쓰지 않으셔도 됩니다. */
#div1 {width:350px;height:135px;padding:10px;border:1px solid #999;}
</style>
<script>
function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("text", ev.target.id);
}

function drop(ev) {
    ev.preventDefault();    
    var data = ev.dataTransfer.getData("text");
    console.log(data);//drag1 만 가져온 거... value로 하면 될 듯
    console.log(document.getElementById(data));
    ev.target.appendChild(document.getElementById(data));
}
</script>
</head>
<body>

<p>아래 노트북 이미지를 위 상자로 끌어넣어 보세요:</p>

<div id="div1" ondrop="drop(event)" ondragover="allowDrop(event)"></div>
<br>
<img id="drag1" src="comp1.png" draggable="true" ondragstart="drag(event)" width="128" height="128">

</body>
</html>
 -->