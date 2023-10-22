<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">

//편의점 이름, 전화번호 데이터 부모창에 전달
function setParentText(){
	var cName = document.getElementById("CVSname").value;
	var cContact = document.getElementById("CVScontact").value;
	opener.document.getElementById("CVSname").value = document.getElementById("CVSname").value;
	opener.document.getElementById("CVScontact").value = document.getElementById("CVScontact").value;
	//부모창 함수 호출
	//결제페이지로 편의점 정보 전달
	opener.parent.CVSdata();
	window.close();
	window.opener.close();
}

</script>

    <style>
      .btn { 
        position: relative;
        left: 80px;
        top: 20px;
      }
    </style>
<title>배송편의점</title>
</head>
<body>
	<img src="resources/delcvs.gif" width="324" height="90">
	<form>
	점포명&nbsp;&nbsp;&nbsp; <input type="text" id="CVSname" readonly value="${delCVS.place_name}"><br>
	전화번호 <input type="text" id="CVScontact" readonly placeholder="번호없음" value="${delCVS.phone}"><br>
	주소&emsp;&nbsp;&nbsp;&nbsp; <input type="text" readonly value="${delCVS.address_name}"><br>
	<br>
	상기점포로 배송요청을 하시겠습니까?<br>
	<div class="btn">
	<input type='button' value='확인' onclick="setParentText()">
	<input type='button' value='취소' onclick="window.close()">
	</div>	
	</form>
</body>
</html>