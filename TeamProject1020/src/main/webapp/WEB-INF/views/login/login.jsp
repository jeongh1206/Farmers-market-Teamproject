<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link href="http://61.107.76.13/Li/04_05.html" rel="stylesheet" type="text/css">
    
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <!-- top관련 css<link href="resources/main.css" rel="stylesheet" type="text/css"> -->
    
    <link rel="stylesheet" href="../resources/css/login.css" />
    <link rel="stylesheet" href="../resources/css/font.css" />
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        
		   <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<meta charset="UTF-8">
<title>팀플젝 메인</title>
   
    <script type="text/javascript">
    $(document).ready(function(){
    
    // 로그인 눌렀을 때 경고창 띄우기 - 키값 mesg로 바꾸자
   
    	<%if(session.getAttribute("warning")!=null){%>
			alert('<%=session.getAttribute("warning")%>');
			<%session.removeAttribute("warning");}%>
	
     //아이디 또는 비밀번호 비었을 경우 메세지 출력
     $("#login-form").submit(function (){
		 if($("#user_id").val().length==0){
    		 event.preventDefault();
    		 $("#id_message").text("아이디를 입력하세요");
    	 }else{
    		 $("#id_message").text("");
    	 }//아이디
		 if($("#user_pw1").val().length==0){
    		 event.preventDefault();
    		 $("#pw_message1").text("비밀번호를 입력하세요");
    	 }else{
    		 $("#pw_message1").text("");
    	 }//비밀번호
     });//submit
    $(".form-control").keyup(function(){
    	$(this).next().text("");
    });//keyup
});//ready
    </script>		
</head>
<body>
  	<!-- 헤더 부분 연결 -->
	<jsp:include page="../common/top.jsp" flush="true"/> <br>
	
	<!-- input width 수정했음.login.css에서 .panel-login input[type="text"] 부분 -->
<div class="container">
    <div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-12">
								<span class="fontTitle" id="login-form-link">로그인</span>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<!-- 회원 로그인 -->
								<form id="login-form" action="/app/login" method="post" role="form" style="display: block;">
									<div class="form-group">
										<input type="text" name="user_id" id="user_id" tabindex="1" class="form-control" placeholder="아이디">
										<span id="id_message"></span>
										
									</div>
									<div class="form-group">
										<input type="password" name="user_pw" id="user_pw1" tabindex="2" class="form-control" placeholder="비밀번호" autocomplete="off" >
										<span id="pw_message1"></span>
									</div>
									<div class="form-group">
									</div>
									<div class="form-group text-center">
										<input type="checkbox" tabindex="3" class="" name="remember" id="remember">
										<label for="remember"> 아이디 저장</label>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit1" tabindex="4" class="form-control btn btn-success" value="로그인"  >
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-lg-12">
												<div class="text-center">
													<a href="/app/login/findIdUI" tabindex="5" class="fontBold">아이디 찾기</a>
													<a href="/app/login/findPwUI" tabindex="5" class="fontBold">비밀번호 찾기</a>
													<a href="/app/register/addBuyerUI" tabindex="5" class="register fontBold">회원가입</a>
												</div>
                        <hr>

												<!-- 카카오 로그인 -->
											<div class="text-center">
												<a id="kakao-login-btn" href="/app/kakaoLogin">
													<img src="../resources/btn_login_kakao.jpg" width="330" height="35"
														alt="카카오 로그인 버튼" />	
												</a>
												<p id="token-result"></p>
												
												<script>
												
													function getCookie(name) {
														var parts = document.cookie.split(name + '=');
														if (parts.length === 2) { return parts[1].split(';')[0]; }
													}
												</script>
												</div>
											</div>
										</div>
									</div>
								</form>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 바닥부분 연결 -->
	<jsp:include page="../common/bottom.jsp" flush="true"/> <br>
</body>
</html>