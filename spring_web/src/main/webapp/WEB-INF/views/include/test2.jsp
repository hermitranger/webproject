<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
     $(document).ready(function () {
    	 
         $("#select1").change(function() { 
          if($(this).data('options') == undefined){
           $(this).data('options',$('#select2 option').clone());} 

        var id = $(this).val();
       // alert(id);
        var options = $(this).data('options').filter('[value=' + id + ']');
        //filter() 메서드는 주어진 함수의 테스트를 통과하는 모든 요소를 모아 새로운 배열로 반환합니다.
        //1,2,3

      if(options.val() == undefined){
            $('#select2').prop("disabled",true);
        }else{
            $('#select2').prop("disabled",false);
         $('#select2').html(options);
        }
      });
         
         
   });

</script>
</head>
<body>
 <div class="pageCol1">
    <div class="panel">
    <div class="templateTitle">Request for Items</div>  
    <table class="grid" border="0" cellspacing="0" cellpadding="0">
        <tr class="gridAlternateRow">
            <td><b>Item to be Request</b></td>
            <td>
            <select name="select1" id="select1">
                    <option value="1">--Select--</option>
                    <option value="2">Stationaries</option>
                    <option value="3">Computer Accessories</option>
                    <option value="4">Bottle</option>
                    <option value="5">Chair</option>
                    <option value="6">Office File</option>
                    <option value="7">Phone Facility</option>
                    <option value="8">Other Facilities</option> 
            </select>
          </td></tr>
          <tr><td>
          <b>Category</b>
          </td> 
          <td>  
            <select name="select2" id="select2" >
              <option value="1">--Select--</option>
                <option value="2">Note Books</option>
                <option value="2">Books</option>
                <option value="2">Pen</option>
                <option value="2">Pencil</option>
                <option value="2">Eraser</option>
                <option value="2">Drawing sheets</option>
                <option value="2">Others</option>
                <option value="3">Laptop</option>
                <option value="3">PC</option>
                <option value="3">CPU</option>
                <option value="3">Monitor</option>
                <option value="3">Mouse</option>
                <option value="3">Keyboard</option>
                <option value="3">Mouse Pad</option>
                <option value="3">Hard Disk</option>
                <option value="3">Pendrive</option>
                <option value="3">CD/DVD Writer</option>
                <option value="3">RAM</option>
                <option value="3">Mother Board</option>
                <option value="3">SMPS</option>
                <option value="3">Network Cables</option>
                <option value="3">Connectors</option>
                <option value="7">Land Line</option>
                <option value="7">BlackBerry </option>
                <option value="7">Other</option>
              </select> 
            </td>
        </tr>
        <tr class="gridAlternateRow">
        <td><b>Quantity</b></td>
            <td>
            <input type="text" />
            </td>
        </tr>
        <tr>
            <td>
            <b>Description</b>
            </td>           
            <td>
            <div class="row">
                    <textarea cols="5" rows="3" style="width:650px;"></textarea>
                </div>
            </td>
         </tr>
        <tr class="gridAlternateRow">
        <td><b>Reason</b></td>
            <td>
            <textarea cols="5" rows="3" style="width:650px;"></textarea>
            </td>
        </tr>
        <tr>
        <td><b>File Upload</b></td>
            <td>
              <div class="row">
                   <input type="file" name="somename" size="chars"> 
                 </div>
                </td>
           </tr>
        </table>
    <div class="btnSection">
        <a class="btnPrimary" href="" title="Button">SUBMIT</a>
        <a class="btnPrimary" href="" title="Button">RESET</a>
       </div>
       </div>
      </div>
    </div>
  </div>
</body>
</html>