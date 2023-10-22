<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-latest.min.js">
 </script><!-- Bootstrap -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <link href="http://61.107.76.13/Li/04_05.html" rel="stylesheet" type="text/css">
    
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    
    <link href="../resources/main.css" rel="stylesheet" type="text/css">

<!-- 이벤트 처리 관련 js파일 연결 -->
	<script>
	//jquery 통한 이벤트 처리
	//MemberAddController와 연결
	
	$(function() {
		//이메일 재전송 버튼 숨기고 시작
		$("#resendDiv").hide();
	////////////변수 선언/////////////
		//dom을 변수에 저장
		var name = $("#name");
		var id = $("#id");
		var password = $("#password");
		var password2 = $("#passwordCheck");
		var nickname = $("#nickname");
		var phone = $("#phoneNumber");
		var email1 = $("#email1");
		var email2 = $("#email2");
		var selectEmail = $("#selectEmail");
		var post = $("#sample4_postcode");
		var ref = $("#user_ref");
		var agmAllChk = $("#agmAllChk");
		var agm1 = $("#provisionYn");
		var agm2 = $("#memberInfoYn");
		var EmailVerification = false;
		var Identification = false;
		//var tf = false;
	
			//각 태그에서 submit 또는 blur 할 때  유효성 검사
			  validateField(name, nameCheck);
			  validateField(id, idCheck);
			  validateField(password, pwCheck);
			  validateField(password2, pw2Check); 
			  validateField(nickname, nicknameCheck); 
			  validateField(phone, phoneCheck); 
			  validateField(ref, refCheck); 
			  
			//submit할 때만 체크
				$("#userForm").submit(addressCheck);//submit
				$("#userForm").submit(agmSubmitChk);//submit
				$("#userForm").submit(emailChk);//submit
				//이메일 인증 검사 
				$("#userForm").submit(checkIdentification);//submit
				
				//인증 여부 tf값만 바꿔줌 
				
	
			  //유효성 검사 함수 
				//- field: 선택된 html 요소
				//- validationFunction: 
				// 각 입력 필드에 유효성 검사 함수 등록
			  function validateField(field, validationFunction) {
				  field.blur(validationFunction);
				  $("#userForm").submit(validationFunction);
				}//fuction
	
				$(selectEmail).change(function(){
					//1.email 선택지 바뀔때마다 값 출력
					email2.val(selectEmail.val());
					$("#email_message").text("");
					//2.change했을 때 직접입력이 아니라면, 입력 못하게
					if(email2.val().length!=0){
						email2.attr('readonly',"readonly");
					}//if
					else{	
						email2.removeAttr('readonly');
					}
				});//change이벤트
				
				//이메일 내용 변경 시 이메일 인증 다시 해야함
				$("#email1").keydown(function(){
					$("#email_message").text("");
					$("#email_message2").text("");
					$("#emailIdentification").val(false);
					//인증 후 이메일 변경 시 인증 버튼 활성화
					$("#chkbtn").removeAttr("disabled");	
					//재전송 버튼 숨김
					$("#resendDiv").hide();
					$("chkbtn").attr("class","btn btn-outline-success");
					
				});
				$("#email2").keydown(function(){
					$("#emailIdentification").val(false);
					$("#chkbtn").removeAttr("disabled");
					$("chkbtn").attr("class","btn btn-outline-success");
					$("#resendDiv").hide();


				});
				
				//이메일 버튼 눌렀을 때 
				$("#chkbtn").click(forbtn);//btn
				
				//이메일 재전송 버튼 클릭 시
				$("#resendDiv").click(forbtn);
	/////////유효성 검사 함수 시작=//////////
		//이름 검사 - 필수 입력/2글자 이상 한글 이름
		function nameCheck(){
			const namePattern = /^[가-힣]{2,}$/;
			if(name.val().length==0){ //이름 미입력
				$("#name_message").text("이름을 입력하세요.");
				return false;
			}else{//이름 입력, 정규식에 맞을 때
				if(namePattern.test(name.val())){
					$("#name_message").text("");
					return true;
				}else{//이름 입력, 정규식에 맞지 않을 때
					$("#name_message").text("이름을 확인해주세요");
					return false;
				}//else
			}//else
		}//name이벤트
			
		
		
		//id 검사 - 포커스 벗어날 때 검사
		function idCheck(){	
		//사용가능한 아이디입니다/ 중복된 아이디입니다/6~14자의 영문/숫자만 입력하세요/ 아이디를 입력하세요 
			const idPattern = /^(?=.*[a-z])[a-z\d]{6,14}$/;
			if(id.val().length==0){
				$("#id_message").text("아이디를 입력하세요.");
				return false;
			}
			else if(!idPattern.test(id.val())){
				$("#id_message").text("6~14자의 영문 소문자와 숫자만 입력하세요(한 개 이상의 영문자를 포함해야합니다.)");
				return false;
			}//else if
			else{//길이 0 이 아니고 패턴도 맞을 때
				$("#id_message").text("");
					$.ajax({
						type : "POST",
						url : "/app/register/add_idCheck",
						dataType : "json",
						data : {
							user_id : id.val()
						},
						success : function(rdata, status, xhr) {
							$("#id_message").html(rdata.str);
							//중복 결과에 따라 t/f 값 반환
							return rdata.result;
						}, 
						error : function(xhr, status, error) {
							console.log("error");
							return false;
						}//error
					});//ajax
			}//else
	}//id 이벤트
		
		
		//비밀번호 검사 - 필수 입력 / 영문, 숫자, 특수문자 8자리 이상
			function pwCheck(){
			
			var p1 = password.val();
			var p2 = password2.val();
			
			//정규표현식: const 이름 = /패턴/
			const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$%^&+*=!])[A-Za-z\d*@#$%^&+=!]{8,}$/;
			if(p1.length==0){//1-1.길이 0인지 아닌지 비교
				$("#pw_message1").text("비밀번호는 필수 입력사항입니다.");
				return false;
				}//if
			else{//1-2.길이 0 아님 +
				if(pwPattern.test(p1)){//2-1. 정규식이 맞음 +
					if(p1==p2){ //3-1. 비밀번호와 확인이 일치(길이 0일 수 없음)
						$("#pw_message1").text("");
						$("#pw_message2").html("<span style='color:blue'>사용 가능한 비밀번호 입니다.</span>");
						return true;
				
					}else{//3-2. 비밀번호와 확인 불일치(비밀번호 확인의 길이가 0일 수 있음)+
						if(p2.length!=0){ //4-1. 비밀번호 확인의 길이가 0이 아닐 떄
							$("#pw_message1").text("");
							$("#pw_message2").text("비밀번호가 일치 하지 않습니다. 다시 확인해 주세요.");
							return false;
						}else{ //4-2. 비밀번호 확인의 길이가 0일 때 
							$("#pw_message1").text("");
							$("#pw_message2").text("비밀번호 확인은 필수 입력사항입니다.");
							return false;
						}//else
					}//else
					
				}//if
				else{// 2-2. 정규식이 틀림 
					$("#pw_message1").text("8~20자 영문 대소문자, 숫자, 특수문자를 사용하세요.(공백 불가)");
					$("#pw_message2").html("");
					return false;
				}//else
			}//else
		}//password이벤트
		
		//비밀번호 대조 검사
			function pw2Check(){
			var p1 = password.val();
			var p2 = password2.val();
			const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$%^&+*=!])[A-Za-z\d@#$%^*&+=!]{8,}$/;
			//1. 비밀번호 확인 미입력
			if(p2.length==0){
				$("#pw_message2").text("비밀번호 확인은 필수 입력사항입니다.");
				return false;
			}else{ //2. 길이 0 아님 
				if(p1.length==0){//2-1.비밀번호 미입력
					$("#pw_message1").text("비밀번호가 입력되지 않았습니다. 먼저 비밀번호를 입력해주세요.");
					return false;
				}//if.
				else if(p1!=p2){//2-2. 비밀번호 입력 + 비밀번호 불일치
					$("#pw_message2").text("비밀번호가 일치하지 않습니다. 다시 확인해 주세요.");
					return false;
				}//else if.  2-3.비밀번호 입력 + 비밀번호 일치
				else if((p1==p2)&&pwPattern.test(p1)){
					$("#pw_message1").text("");
					$("#pw_message2").html("<span style='color:blue'>사용 가능한 비밀번호 입니다.</span>");
					return true;
				}//if
			}//else
		}//password2이벤트
		
		//닉네임 검사.특수문자만 사용할 수는 없도록 하자. 
		function nicknameCheck(){
			if(nickname.val().length==0){
				$("#nickname_message").html("<span style='color:gray'>미입력 시 자동 생성됩니다.</span>");
				return true;
			}//if
			else{//길이가 조건에 맞을 때
				//추후 지우기 필요
				$("#nickname_message").text("");
	//	모음/자음도 허용	const nicknamePattern  = /^[가-힣ㄱ-ㅎ\u314F-\u3163A-Za-z0-9]{1,}$/;
				const nicknamePattern  = /^[가-힣a-zA-Z0-9]+$/;
				const ForbiddenNickPattern = /^user.*/;
				if(nicknamePattern.test(nickname.val())&&!(ForbiddenNickPattern.test(nickname.val()))){
				$.ajax({
					type : "POST",
					url : "/app/register/add_nicknameCheck",
					dataType : "json",
					data : {
						user_nickname : nickname.val()
						},
					success : function(rdata, status, xhr) {
						$("#nickname_message").html(rdata.str);
						return rdata.result;
						}, 
					error : function(xhr, status, error) {
						console.log("error");
						return false;
						}//error
					});//ajax
				}//if
				else if(!nicknamePattern.test(nickname.val())){
					$("#nickname_message").text("별명 입력이 잘못되었습니다. 다시 확인해 주세요. (공백 불가)");
					return false;
				}//else if
				else if(ForbiddenNickPattern.test(nickname.val())){
					$("#nickname_message").text("이 별명은 사용할 수 없습니다. (user~불가)");
					return false;
				}//else if
			}//else
		}//nickname이벤트
		function addressCheck(){
			//Buyer.jsp 의 주소 추가 버튼-인라인 함수 확인하기
			if(post.val().length==0){
				$("#address_message").text("주소를 입력하세요");
				return false;
			}else{
				$("#address_message").text("");
				return true;
			}
		}//addressCheckFunction
		
		//휴대폰 유효성 검사
		function phoneCheck(){
			if(phone.val().length==0){ //길이가 0일 때
				$("#phone_message").text("휴대폰 번호를 입력하세요.");
				return false;
			}else{//길이가 0이 아닐 때 
				//01로 시작하는 번호만 가능
				const phonePattern = /^01\d{8,9}$/;
				if(phonePattern.test(phone.val())){
				$.ajax({ //길이가 0이 아닐 때
					type : "POST",
					url : "/app/register/add_phoneCheck",
					dataType : "json",
					data : {
						user_phone : phone.val()
						},
					success : function(rdata, status, xhr) {
						$("#phone_message").html(rdata.str);
						return rdata.result;
						}, 
					error : function(xhr, status, error) {
						console.log("error");
						return false;
						}//error
					});//ajax
				}//if
				else{
					$("#phone_message").text("번호 입력이 잘못되었습니다. 다시 확인해 주세요.");
					return false;
				}//else
				
			}//else
		}//phone이벤트 function
		
		
		//체크 박스 관련 이벤트
		function refCheck(){//추천인 검사
			if(ref.val().length==0){
				$("#ref_message").text("");
				return true;
	
			}else{
				//기존에 없던 닉네임을 쓰면 걸러지도록.
				const refPattern  = /^[가-힣a-zA-Z0-9]+$/;
				if(refPattern.test(ref.val())){
				$.ajax({
					type : "POST",
					url : "add_refCheck",
					dataType : "json",
					data : {
						user_nickname : ref.val()
						},
					success : function(rdata, status, xhr) {
						$("#ref_message").text(rdata.str);
						return rdata.result;
						}, 
					error : function(xhr, status, error) {
						console.log("error");
						return false;
						}//error
					});//ajax
				}//if
				else{
					$("#ref_message").text("추천인 입력이 잘못되었습니다. 다시 확인해 주세요.(공백 불가)");
					return false;
				}//else
			}//else
		}//method
		//전체선택 클릭 시 
		agmAllChk.click(function(){
			$(".agm").prop('checked',agmAllChk.is(':checked'));
		});
		//두 체크 박스의 t/f값 확인해 하나라도 해제되면 전체선택도 해제되는 함수
		function agmChk(){
			if(agm1.is(":checked")&&agm2.is(":checked")){
				agmAllChk.prop('checked',true);
			}else{
				agmAllChk.prop('checked',false);
			}
		}//agmChk
		
		//위의 agmChk를 각 태그의 클릭 시 호출
		agm1.click(agmChk);
		agm2.click(agmChk);
		
		//전체 동의되었다면 넘어가고 아니라면 경고
		function agmSubmitChk(){ 
			if(agm1.is(":checked")&&agm2.is(":checked")){
				$("#chk_message").text("");
			}else{
				$("#chk_message").text("필수 약관 동의가 필요합니다.");
				return false;
			}
		}//agmSubmitChk
		
		//이메일 검사
	/*	1. 이메일을 입력했는지
		2. 입력했다면 정규식에 맞는지
		3. 정규식에 맞으면 이메일이 중복되는지
		4. 중복 안되면 이메일 인증을 했는지 검사한다.
	*/
		function emailChk(){
			//1. 이메일 입력 확인 함수 호출
			EmailVerification = isEmptyEmail();
			//입력여부에 따라 2. 정규식 맞는지 검사
			if(EmailVerification){
				EmailVerification = emailValidation();
			}
			//만약에 2를 통과했다면 true, 아니면 false 가될거니까 병렬로 if문 써도되겠다.
			return EmailVerification;
		}//function
		
		//1. 이메일 입력했는지 
		function isEmptyEmail(){
			//1. 만약에 email1이나 2를 안씀
			if(email1.val().length==0||email1.val().length==0){
				$("#email_message").text("이메일을 입력하세요.");
				return false;
			}//if
			else{
				$("#email_message").text("");
				return true;
			}//else
		}//function
		
		//2. 입력했다면 정규식에 맞는지
		function emailValidation(){
			var e1Pattern = /^[a-zA-Z0-9._%+-]+$/; 
			var e2Pattern = /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; 
			// email1이 정규식이 안맞거나 email2 가 정규식이 안맞으면
			if((!e1Pattern.test(email1.val()))||(!e2Pattern.test(email2.val()))){
				$("#email_message").text("이메일 형식을 확인하세요.(공백 불가)");
				return false;
			}//if
			else{
				$("#email_message").text("");
				return true;
			}
			
		}//function
			
		
		//3. 이메일이 중복되는지
		async function emailDuplication(){
				var emailValue = email1.val()+"@"+email2.val();
				 await $.ajax({
					type : "POST",
					url : "/app/register/add_emailCheck",
					dataType : "json",
					data : {
						user_email : emailValue
						},
					success : function(rdata, status, xhr) {
						
						if(rdata.result==true){
							$("#user_email").val(emailValue);
							$("#email_message").text("");
							//$("#emailDuplication").val(true);
							}else{
							$("#email_message").text("중복된 이메일입니다.");
							$//("#emailDuplication").val(false);
							}
						EmailVerification = rdata.result;
						}, 
					error : function(xhr, status, error) {
						console.log("error");
						EmailVerification = false;
						}//error
					});//ajax
				return EmailVerification;
			}//function
		
		//4. 이메일 보내기
		async function sendEmailCode(){
			await $.ajax({
				type : "POST",
				url : "/app/mailConfirm",
				dataType : "text",
				data : {
					user_email : email1.val()+"@"+email2.val()
					},
				success : function(rdata, status, xhr) {
					//코드 
					var emailcode = rdata.substring(rdata.length-8);
					window.open('/app/childEmail_verification?emailcode='+emailcode,'target=_blank','width=400,height=300,location=no,status=no,scrollbars=yes');
					//responseentity를 통해서 받아오는 값을 인증코드만 뽑은 후 window.open에 넘겨준다.
				}, 
				error : function(xhr, status, error) {
					console.log("error");
					return false;
					}//error
				});//ajax
				
			Identification = await JSON.parse($("#emailIdentification").val());
			return Identification;
			}//function
			
		//4. 이메일 인증 여부 확인 - 
			function checkIdentification(){
				Identification = JSON.parse($("#emailIdentification").val());
//				if(EmailVerification&&Identification){
				if(Identification){
					$("#email_message2").html("<span style='color:blue'>사용 가능한 이메일 입니다.</span>");
				}else{
					$("#email_message2").text("이메일 인증이 완료되지 않았습니다.");
				}//else
				return Identification;
		}//function
		
		//이메일 인증 버튼 클릭
		async function forbtn(){
			$("#email_message").text("");
			$("#email_message2").text("");
			EmailVerification = emailChk();
			if(EmailVerification){
				//버튼 클릭 이벤트 연결 해제 			
			EmailVerification = await emailDuplication();
			}
			
			//3가지 유효성 검사 통과시에만 disabled
			if(EmailVerification){
				$("#chkbtn").attr("disabled","disabled");	
				$("#resendDiv").show();
				await sendEmailCode();
				//Identification = JSON.parse(Identification);
				}//if'
				return EmailVerification;
			}			//fn		
		});//read
	</script>
</head>

<body>	
	<jsp:include page="../common/tempTop.jsp" flush="true"/> <br>
	<!-- 본문 시작 -->
	<section class="sectionAlign">
	<form class="form-horizontal" id="userForm" role="form" method="post" action="/app/register/addBuyer">
<div class="form-group" id="divName">
    <label for="inputName" class="col-lg-8 control-label">*이름</label>
    <div class="col-lg-6">
        <input type="text" name="user_name" class="form-control onlyHangul" id="name" data-rule-required="true" maxlength="4">
    	<span id="name_message" style="color:red"></span>
    </div>
</div>
<div class="form-group" id="divId">
    <label for="inputId" class="col-lg-6 control-label">*아이디</label>
    <div class="col-lg-6">
        <input type="text" name="user_id" id="id" class="form-control onlyAlphabetAndNumber" id="id" data-rule-required="true" maxlength="14"  placeholder="영문소문자,숫자 6~14자리">
    	<span id="id_message"  style="color:red"></span>
   	
    </div>
</div>
<div class="form-group" id="divPassword">
    <label for="inputPassword" class="col-lg-4 control-label">*비밀번호</label>
    <div class="col-lg-6">
        <input type="password" name="user_pw" class="form-control" id="password" name="excludeHangul" data-rule-required="true"maxlength="20"  placeholder="영문,숫자,특수문자 8~20자리"  autocomplete="off">
       	<span id="pw_message1" style="color:red"></span>
    </div>
</div>
<div class="form-group" id="divPasswordCheck">
    <label for="inputPasswordCheck" class="col-lg-4 control-label">*비밀번호 확인</label>
    <div class="col-lg-6">
        <input type="password" class="form-control" id="passwordCheck" data-rule-required="true" maxlength="30" autocomplete="off">
       	<span id="pw_message2" style="color:red"></span>
    </div>
</div>

<div class="form-group" id="divNickname">
    <label for="inputNickname" class="col-lg-4 control-label">별명</label>
    <div class="col-lg-6">
        <input type="text" name="user_nickname" class="form-control" id="nickname" data-rule-required="true" maxlength="15" placeholder="(선택) 한글, 영문, 숫자 입력" >
        <span id="nickname_message"  style="color:red"></span>
    
    </div>
</div>

<div class="form-group" id="divAddress">
    <label for="inputAddress"  class="col-lg-4 control-label">*주소</label>
    <div class="col-lg-6">
    <input type="text" class="col-xs-6	" name="user_post" id="sample4_postcode" placeholder="우편번호" readonly="readonly" style="background: #eee"	>
    <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
    <input type="text" class="col-lg-12" name="user_address1" id="sample4_roadAddress"readonly="readonly" style="background: #eee">
    <input type="text" class="col-lg-12" name="user_address2" id="sample4_jibunAddress" readonly="readonly" style="background: #eee">
    <input type="text" class="col-lg-12" name="user_address3" id="addr3" placeholder="상세주소">
    <span id="guide" style="color:#999"></span>
    <span id="address_message" style="color:red"></span>
   	
    </div>
</div>  

<div class="form-group" id="divPhoneNumber">
    <label for="inputPhoneNumber" class="col-lg-4 control-label">*휴대폰 번호</label>
    <div class="col-lg-6">
        <input type="tel" class="form-control onlyNumber" id="phoneNumber" name="user_phone" data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11">
    	<span id="phone_message"  style="color:red"></span>
    </div>
</div>
<div class="form-group" id="divEmail">
    <label for="inputEmail1" class="col-lg-4 control-label">*이메일</label>
    <div class="col-lg-6">
    	<!-- name통해 값 전달 목적의 hidden -->
      	<input type="hidden" name="user_email" id="user_email">
      	<input type="hidden" id="emailIdentification" value="false"> 
      	
		<!-- 브라우저 통해 보이는 부분 --> 
       <input type="text" class="form-control"  data-rule-required="true" maxlength="24" id="email1">@
    </div>
    <div class="col-lg-6">
        <input type="text" class="form-control" data-rule-required="true" maxlength="320" id="email2">
  		<br><select  id="selectEmail" class="form-control" data-rule-required="true" >
			    <option value="" selected="selected">직접 입력</option>
		        <option value="naver.com">naver.com</option>
		        <option value="gmail.com">gmail.com</option>
		        <option value="nate.com">nate.com</option>
		        <option value="hanmail.net">hanmail.net</option>
		        <option value="kakao.com">kakao.com</option>
       	</select>
   	    <br><br>
   	    <div id="forbtn">
   	    <input type='button' id='chkbtn' class='btn btn-outline-success' value='이메일 인증'><br>
   	    <div id="resendDiv"><br><input type='button' id='resendBtn' class=' btn btn-success' value='인증번호 재전송'><br></div>
	       	</div></div><br>
       	
       	
       	<div style="height:30px">
       		<span id="email_message" style="color:red"></span><br>
       		<span id="email_message2" style="color:red"></span>
       	</div>
    </div>
    <div class="form-group" id="divRef">
    <label for="inputRef" class="col-lg-4 control-label">추천인</label>
    <div class="col-lg-6">
        <input type="tel" class="form-control" id="user_ref" name="user_ref" placeholder="(선택)" maxlength="11">
    	<span id="ref_message" style="color:red"></span>
    </div>
</div>
</div>
<div class="form-group">
    <label for="provision" class="col-lg-4 control-label">
    	<input type="checkbox" id="agmAllChk">전체동의하기
    </label>
</div>
<div class="form-group">
    <label for="provision" class="col-lg-6 control-label">
    	회원가입약관
    	<a href="#">[이용약관보기]</a>
    </label>
    <div class="col-lg-10" id="provision">
        <div class="checkbox">
            <label>
                <input type="checkbox" class="agm" id="provisionYn" name="provisionYn" autofocus="autofocus">
                	동의합니다.
            </label>
        </div>
    </div>
</div>
<div class="form-group">
    <label for="memberInfo" class="col-lg-6 control-label">
    	개인정보취급방침
    	<a href="#">[이용약관보기]</a>
    </label>
    <div class="col-lg-10" id="memberInfo">
        <div class="checkbox">
            <label>
                <input type="checkbox" class="agm" id="memberInfoYn" name="memberInfoYn">
                동의합니다.
            </label>
            <br><span id="chk_message" style="color:red"></span>
        </div>
    </div>
</div>
<!-- 성별 -->
<!-- <div class="form-group">
    <label for="inputPhoneNumber" class="col-lg-2 control-label">성별</label>
    <div class="col-lg-10">
        <select class="form-control" id="gender">
            <option value="F">여</option>
            <option value="M">남</option>
        </select>
    </div>
</div -->
    <div class="col-lg-offset-2 col-lg-10">
        <button type="submit" class="btn btn-success">가입하기</button>
    </div>
</div>
</form>
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- daum 우편번호 검색 서비스 -->
<script>
//도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample4_roadAddress').value = fullRoadAddr;
            document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                //예상되는 도로명 주소에 조합형 주소를 추가한다.
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

            } else {
                document.getElementById('guide').innerHTML = '';
            }//else
            	//유효성 관련 이 부분 추가함 -주소 추가 시에만 틀렸다고 띄운 메세지를 없앰
            if($("#sample4_postcode").val().length!=0){
        		$("#address_message").text("");
        	}
        }//function
    }).open();
   
}
</script>
</section>
<!-- 푸터 들어가는 부분 -->
	<jsp:include page="../common/tempBottom.jsp" flush="true"/> <br>

</body>
</html>