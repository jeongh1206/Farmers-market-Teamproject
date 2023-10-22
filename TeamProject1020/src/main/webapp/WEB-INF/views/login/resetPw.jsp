<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<!-- jquery -->
<script src="http://code.jquery.com/jquery.js"></script>
<!-- 유효성 검사 -->
<script type="text/javascript" src="../resources/js/login_resetPw.js"></script>
<!-- font관련 css 추가 -->
<link href="../resources/css/font.css" rel="stylesheet" type="text/css">
<!--  부트스트랩 --> 
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" >

</head>
<body>
<jsp:include page="../common/top.jsp" flush="true"/> <br>

<%
	String user_id= "";
	if(request.getAttribute("user_id")==null){%>
	<script>
	location.href="/app/login/findPwUI";
	</script>
<%	}else{
		user_id = (String)request.getAttribute("user_id"); 
	}//else
	 if(session.getAttribute("mesg")==null){%>

	 <div class="d-flex justify-content-center fontTitle">비밀번호 재설정</div><br>
<br>
<div class="d-flex justify-content-center" >
	<form id="userForm" action ="resetPw" method="post">
			<label for="inputId" class="col-lg-8 control-label">아이디</label><br><br>
	        <input type="text" name="user_id" class="form-control onlyAlphabetAndNumber" id="id" value="<%=user_id%>" readonly="readonly"style="background: #eee" >
	    	<span id="id_message"  style="color:red"></span><br>
		    <label for="inputPassword" class="col-lg-8 control-label">비밀번호</label><br><br>
		        <input type="password" name="user_pw" class="form-control" id="password" name="excludeHangul" data-rule-required="true"maxlength="20"  placeholder="영문,숫자,특수문자8~20자리">
		       	<span id="pw_message1" style="color:red"></span><br>
		    <label for="inputPasswordCheck" class="col-lg-8 control-label">비밀번호 확인</label><br><br>
		        <input type="password" class="form-control " id="passwordCheck" data-rule-required="true" maxlength="30">
		       	<span id="pw_message2" style="color:red"></span><br>
		<br>
	   	    <input type="submit"  class="form-control btn btn-outline-success" value="비밀번호 재설정">
	</form>
</div>
	<br>
<%}else{ //넘어온 출력 값이 있으면%>
메시지: <%=(String)session.getAttribute("mesg")%>  <%
session.removeAttribute("mesg");}%>
	<div class="d-flex justify-content-center">
	<button><a href="/app/login/findIdUI" class="fontBold">아이디 찾기</a></button>&nbsp;<br>
	<button><a href="/app/login/UI" class="fontBold">로그인</a></button><br><br><br>
	<br>
	</div><br>
		<jsp:include page="../common/tempBottom.jsp" flush="true"/> <br>
	
</body>
</html>