<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	//form 서브밋
	
$("input:submit").click(function() {
  
	if ($("#name").val() == 0) {
		alert("이름 입력");
		return false;
		event.preventDefault();
	} // 이름 검사
	
if ($("#id").val() == 0) {
	alert("아이디 입력");
	return false;
	event.preventDefault();
} // 아이디검사

if ($("#password").val() == 0) {
	alert("비밀번호 입력");
	return false;
	event.preventDefault();
	
} //비번검사


if ($("#address").val() == 0) {
	alert("주소 입력");
	return false;
	event.preventDefault();	
}// 주소 검사




if ($("#phoneNumber").val() == 0) {
	alert("가게번호 입력");
	return false;
	event.preventDefault();	
}// 전화번호 검사

if ($("#phoneNumber2").val() == 0) {
	alert("개인번호 입력");
	return false;
	event.preventDefault();	
}// 전화번호 검사

if ($("#Binfo").val() == 0) {
	alert("사업자 정보 입력");
	return false;
	event.preventDefault();	
}// 사업자 정보 검사



if ($("input[name='email']").val() == 0) {
	alert("이메일 입력");
	return false;
	event.preventDefault();	
}// 이메일1 검사

if ($("input[name='email2']").val() == 0) {
	alert("이메일 입력");
	return false;
	event.preventDefault();	
}// 이메일2 검사


if ($("input[name='agree']").is(".checked") == false) {
	alert("약관 동의");
	return false;
	event.preventDefault();	
}// 약관 검사



	}) //end submit
	
	
	$("#password2").keyup(function() {
		
		if($("#password2").val() != $("#password").val()) {
			$("#result").text("비밀번호 불일치");
		}
		if($("#password2").val() == $("#password").val()){
			$("#result").text("비밀번호 일치");
		}
	}); // end keyup  	
	
	$("#password").keyup(function() {
		
		if($("#password2").val() != $("#password").val()) {
			$("#result").text("비밀번호 불일치");
		}
		if($("#password2").val() == $("#password").val()){
			$("#result").text("비밀번호 일치");
		}
	}); // end keyup  
	
	
	
	
	
 
})  // ready


</script>


</head>
<body>

<jsp:include page="../common/top.jsp" flush="true"/><br>
<hr>

회원가입 (판매자)
<hr>
<form action="#" name="seller" method="post">
이름 : <input type="text" name="name" id="name"> <br>
아이디 : <input type="text" name="id" id="id"> <br>
비밀번호 : <input type="text" name="passsword" id="password"> <br>
비밀번호 확인 : <input type="text" name="password2" id="password2"> <span id="result"></span><br>
판매자 주소 : <input type="text" name="address" id="address"> <br>
전화번호 (가게 번호) : <input type="text" name="phoneNumber" id="phoneNumber"> <br>
전화번호 (개인 번호): <input type="text" name="phoneNumber2" id="phoneNumber2"> <br>
이용약관 및 개인정보 수집 및 이용 동의 여부 <input type="checkbox" value="동의" name="agree"> <br>
이메일 : <input type="text" name="email" id="email"> @ <input type="text" name="email2"  id="email2"> <br>
사업자정보 : <input type="text" name="Binfo" id="Binfo"> <br>
<input type="submit" value="회원가입"> <br>
<a href="Member_Buyer.jsp">일반 소비자 회원가입</a>
<hr>
</form>
 <jsp:include page="../common/bottom.jsp" flush="true"/>


</body>
</html>