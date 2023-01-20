<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js">
</script>
<script>
$(function(){
	/* $(".fileDrop").on("dragenter dragover", function(e){
		e.preventDefault();//기본효과 막기
		
	});
	$(".fileDrop").on("drop", function(e){
		e.preventDefault();
		var files=e.originalEvent.dataTransfer.files;//파일
		var file=files[0];//첫번째
		var form_data=new FormData();//폼 객체
		form_data.append("file",file);//폼에 첨부파일 추가
		$.ajax({
			url:"/upload/ajax_upload",
			data: form_data, 
			processData:false,
			contentType:false,
			type:"post",
			//datatype : response데이터 타입 
			//processdata : 일반적으로 서버에 데이터를 보내는 방법 queryString ex)?title=Main_page&action=raw
			//파일 전송의 경우에는 막아야함
			//contenttype :default 값이 "application/x-www-form-urlencoded; charset=UTF-8"
			//파일 전송의 경우 "multipart/form-data"로 보내야 해서 막음
			//첨부파일이름
			success:function(data){
				var fileInfo=getFileInfo(data);
				var html="<a href='"+fileInfo.get_link+"'>"+fileInfo.original_name+"</a><br>";
				html+="<input type='hidden' name='files' value='"+fileInfo.file_name+"'>";
				$("#uploadedList").append(html);
			
			}
			
		});
		
	}); */
	$("#btnSave").click(function(){
		var title=document.form1.title.value;
		if(title==""){
			alert("제목을 입력하세요.")
			document.form1.title.focus();
			return;
		}
		
		
		document.form1.submit();
	});
});


</script>



</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>게시물 작성</h2>
<form id="form1" name="form1" method="post" enctype="multipart/form-data" action="/board/insert.do">
<div>
<input name="title" id="title" size="80" placeholder="제목을 입력하세요.">
</div>
<div style="width:800px">
<textarea rows="5" cols="80" id="contents" name="contents" placeholder="내용을 입력하세요.">
</textarea>
</div>
<div>첨부파일 등록<br>
<input type="file" name="file" id="file" multiple="multiple">
<div id="uploadedList"></div>

</div>
<div style="width:700px; text-align:center;">
<button style="button" id="btnSave">확인</button>
</div>

</form>


</body>
</html>