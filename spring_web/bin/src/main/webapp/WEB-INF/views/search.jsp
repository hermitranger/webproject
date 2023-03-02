<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.6.1.min.js">
</script>
<script>
$(function(){
	
	$("#search").keyup(function(){
		
		var search= $("#search").val();
		
		if (search.length == 0) { 
			$("#search_search").css("visibility","hidden");
			}else{
			$("#search_search").css("visibility","visible");
			
		
		$.ajax({
			type:"post",
			url:"/controller/search_search.do",
			data:{"search":search},
			success:function(html){
							
				$("#search_search").html(html);  //이 방식 말고 page로 빼는 방법으로 링크 걸어서 추천상품목록 호출
				
/* 				console.log(list);
				console.log(typeof(list));
				console.log(list[1]); */
/* 				console.log(html);
				console.log(typeof(html));

				
								
				
				
				for(var i = 0 ; i<list.size ; i++){
					
					var list=new array();
					list=list[i];
					
					document.write(list.get(i));
					document.write(list[i]+"<br>");
					$("#search_search").append(list[i]+"<br>");
					$("#search_search").append(list+"<br>");
					
				} */
				
			}
			
		
			
		});
		
			}
		
	});
	
	
});

</script>


<meta charset="EUC-KR">
<search>Insert search here</search>
</head>
<body>
<input type="text" id="search" name="search"><br>
&nbsp;<div id="search_search">여기 값이 들어갑니다.</div>

</body>
</html>