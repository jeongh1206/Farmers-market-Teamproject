<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
 <!--  부트스트랩 --> 
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" >
<!-- font관련 css 추가 -->
<link href="../resources/css/font.css" rel="stylesheet" type="text/css">

</head>
<body>
<jsp:include page="../common/top.jsp" flush="true"/> <br>


<script>
//jquery 통한 이벤트 처리
//MemberAddController와 연결

$(function() {
	//이메일 재전송 버튼 숨기고 시작
	$("#resendDiv").hide();
////////////변수 선언/////////////
	//dom을 변수에 저장
	var id = $("#id");
	var email1 = $("#email1");
	var email2 = $("#email2");
	var selectEmail = $("#selectEmail");
	var EmailVerification = false;
	
///////////이벤트 처리 //////////////
	
		//각 태그에서 submit 또는 blur 할 때  유효성 검사
		  validateField(id, idCheck);
		  //유효성 검사 함수 
			//- field: 선택된 html 요소
			//- validationFunction: 
			// 각 입력 필드에 유효성 검사 함수 등록
		  function validateField(field, validationFunction) {
			  field.blur(validationFunction);
			  $("#userForm").submit(validationFunction);
			}//fuction
			
			$("#userForm").submit(emailChk);//submit
			//이메일 인증 검사 
			$("#userForm").submit(checkIdentification);//submit
			
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
				$("chkbtn").attr("class","btn btn-outline-success");
				//재전송 버튼 숨김
				$("#resendDiv").hide();
				
				
			});
			$("#email2").keydown(function(){
				$("#emailIdentification").val(false);
				//인증 후 이메일 변경 시 인증 버튼 활성화
				$("#chkbtn").removeAttr("disabled");	
				$("chkbtn").attr("class","btn btn-outline-success");
				//재전송 버튼 숨김
				$("#resendDiv").hide();

			});
			
			//이메일 버튼 눌렀을 때 
			$("#chkbtn").click(forbtn);//btn
			//이메일 재전송 버튼
			$("#resendDiv").click(forbtn);
/////////유효성 검사 함수 시작//////////
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
//					if(EmailVerification&&Identification){
					if(Identification){
						$("#email_message2").html("<span style='color:blue'>사용 가능한 이메일 입니다.</span>");
					}else{
						$("#email_message2").text("인증이 완료되지 않았습니다.");
					}//else
					return Identification;
			}//function
			
			//이메일 인증 버튼 클릭
			async function forbtn(){
								
				$("#email_message").text("");
				$("#email_message2").text("");
				EmailVerification = emailChk();
				if(EmailVerification){
					$("#chkbtn").attr("disabled","disabled");	
					//이메일 재전송 버튼 숨기고 시작
					$("#resendDiv").show();
					await sendEmailCode();
					//Identification = JSON.parse(Identification);
					}//if'
					return EmailVerification;
				}	
	//id 검사 - 포커스 벗어날 때 검사
	function idCheck(){	
	//사용가능한 아이디입니다/ 중복된 아이디입니다/6~14자의 영문/숫자만 입력하세요/ 아이디를 입력하세요 
		const idPattern = /^(?=.*[a-z])[a-z\d]{6,14}$/;
		if(id.val().length==0){
			$("#id_message").text("아이디를 입력하세요.");
			return false;
		}
		
		else{//길이 0 이 아니고 패턴도 맞을 때
			$("#id_message").text("");
		}//else
}//id 이벤트

		
		
	});//read

<%if(session.getAttribute("mesg")!=null){%>
	alert("<%=(String)session.getAttribute("mesg")%>");
<%
session.removeAttribute("mesg");}%>
</script>
	<div class="d-flex justify-content-center fontTitle"><span>비밀번호 찾기</span><br></div>	
	<br>
	<div class="d-flex justify-content-center">
	<form id="userForm" action="/app/login/findPw" method="post">
      	 <input type="hidden" id="tf" value="false"> 
			        <input type="text" name="user_id" class="form-control onlyAlphabetAndNumber" id="id" data-rule-required="true" maxlength="14" placeholder="아이디">
			    	<span id="id_message"  style="color:red"></span>
		   <br>
		    <label for="inputEmail1" class="col-lg-4 control-label" >이메일</label>
		    	<!-- name통해 값 전달 목적의 hidden -->
      		<br><input type="hidden" id="emailIdentification" value="false"> 
		      	
				<!-- 브라우저 통해 보이는 부분 --> 
		       <input type="text" class="form-control"  data-rule-required="true" maxlength="24" id="email1" name="email1" placeholder="이메일 입력">@
		        <input type="text" class="form-control" data-rule-required="true" maxlength="320" id="email2" name="email2" >
		  		<br><select  id="selectEmail" class="form-control" data-rule-required="true" >
					    <option value="" selected="selected">직접 입력</option>
				        <option value="naver.com">naver.com</option>
				        <option value="gmail.com">gmail.com</option>
				        <option value="nate.com">nate.com</option>
				        <option value="hanmail.net">hanmail.net</option>
				        <option value="kakao.com">kakao.com</option>
		       	</select>
     			<div style="height:30px">
		       		<span id="email_message" style="color:red"></span><br>
		       		<span id="email_message2" style="color:red"></span>
	       		</div><br>
     			<div id="forbtn">
   	    
       	       	<input type="button" id='chkbtn' class="form-control btn btn-outline-success" style="" value="이메일 인증"><br>
   	    		<div id="resendDiv"><br><input type='button' id='resendBtn' class='form-control btn btn-success' value='인증번호 재전송'><br></div>
		       	</div>
		   	    <br><input type="submit" class="form-control btn btn-success" id="submitBtn" value="비밀번호 찾기">
	</form>
	</div>
	<br>
	<div class="d-flex justify-content-center">
	<button><a href="/app/login/findIdUI" class="fontBold">아이디 찾기</a><br></button>&nbsp;
	<button><a href="/app/login/UI" class="fontBold">로그인</a></button>
	<br>
	</div><br>
		<jsp:include page="../common/bottom.jsp" flush="true"/> <br>
	
</body>
</html>