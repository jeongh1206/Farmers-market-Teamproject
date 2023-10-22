<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<!-- font관련 css 추가 -->
<link href="../resources/css/font.css" rel="stylesheet" type="text/css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" >
</head>
<body>
<jsp:include page="../common/tempTop.jsp" flush="true"/> <br>

        <%if(request.getAttribute("findId")==null){ %>

	<!-- 아이디 정보가 없을 경우 -->
	<!-- jquery -->
<script src="http://code.jquery.com/jquery.js"></script>
<!-- 유효성 검사 -->
<script type="text/javascript" src="../resources/js/login_Buyer.js"></script>

	<div class="d-flex justify-content-center fontTitle"> <span>아이디 찾기</span></div>
    <div class="d-flex justify-content-center">
	<form action="/app/login/findId" method="post" id="userForm"><br>
        <input type="text" name="user_name" id="name" class="form-control onlyHangul" id="name" data-rule-required="true" maxlength="4" placeholder="이름입력">
    	<span id="name_message" style="color:red"></span><br>
		<!-- 브라우저 통해 보이는 부분 --> 
         <span> 이메일 </span> <br><input type="text" class="form-control "  data-rule-required="true" maxlength="24" id="email1" name="email1">@
         <input type="text" class="form-control" data-rule-required="true" maxlength="320" id="email2" name="email2">
  		 <br><br><select  id="selectEmail" class="form-control" data-rule-required="true" >
			    <option value="" selected="selected">직접 입력</option>
		        <option value="naver.com">naver.com</option>
		        <option value="gmail.com">gmail.com</option>
		        <option value="nate.com">nate.com</option>
		        <option value="hanmail.net">hanmail.net</option>
		        <option value="kakao.com">kakao.com</option>
       	</select>
       	<span id="email_message" style="color:red"></span>
       	<br><br>
		<button type="submit" class="form-control btn btn-success"> 아이디 찾기 </button>
	</form>	
	<br>
	</div>
	<% }else{%>
	<div>
		<!-- 아이디를 찾아와 이 페이지로 돌아오면 -->
		<span class="fontBold"> <%=request.getAttribute("findId") %></span>
	<%}%>
	</div>
<div class="d-flex justify-content-center">
<br><br>
	<button><a href="/app/login/findPwUI" class="fontBold">비밀번호 찾기</a><br></button>&nbsp;
	<button><a href="/app/login/UI" class="fontBold">로그인</a></button><br>
	</div><br>
	<jsp:include page="../common/tempBottom.jsp" flush="true"/> <br>

<br>
</body>
</html>