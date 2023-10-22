//jquery 통한 이벤트 처리
//MemberAddController와 연결

$(function() {
////////////변수 선언/////////////
	//dom을 변수에 저장
	var id = $("#id");
	var email1 = $("#email1");
	var email2 = $("#email2");
	var selectEmail = $("#selectEmail");

	//이메일 인증했는지 확인하는 변수
	var EmailVerification = false;
	
///////////이벤트 처리 //////////////
	
	
	//submit 시 이메일 본인인증 하지 않으면 false 나온다.
	$("#userForm").submit(function(){
		emailValCheck();
		EmailVerification = $("#tf").val();
		if(EmailVerification=='false'){
			$("#email_message").text("이메일 인증을 확인해주세요.");
			return false;
		}
	});//submit
	
	//이메일 내용 변경 시 이메일 인증 다시 해야함
	$("#email1").keydown(function(){
		$("#tf").val(false);
	});
	$("#email2").keydown(function(){
		$("#tf").val(false);
	});
	
	//이메일 본인인증 클릭시 
	$("#buttonEmail").click(EmailVerificationClick);
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
			
/////////유효성 검사 함수 시작//////////
	
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
	
	

		//이메일 통한 유효성과 db검사
		function emailValCheck(){
			$("#email_message").text("");

			var e1Pattern = /^[a-zA-Z0-9._%+-]+$/; 
			var e2Pattern = /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; 
			//1. 만약에 email1이나 2를 안씀
			if(email1.val().length==0||email1.val().length==0){
				$("#email_message").text("이메일을 입력하세요.");
				return false;
			}
			//2 email1과 2 모두 입력했는데
			// email1이 정규식이 안맞거나 email2 가 정규식이 안맞으면
			else if((!e1Pattern.test(email1.val()))||(!e2Pattern.test(email2.val()))){
				$("#email_message").text("이메일 형식을 확인하세요.(공백 불가)");
				return false;
				//3. 둘 다 정규식이 맞음
			}else if(e1Pattern.test(email1.val())&&e2Pattern.test(email2.val())){
				//그러면 db검사 - 중복확인
				var emailValue = email1.val()+"@"+email2.val();
				$.ajax({
					type : "POST",
//					url : "add_emailCheck", 경로 수정 예정
					url : "../add_emailCheck",
					dataType : "json",
					data : {
						user_email : emailValue
						},
					success : function(rdata, status, xhr) {
						//중복될 때에만 적용되어야한다.
						//console.log(emailValue);	
						if(rdata.result==false){$("#user_email").val(emailValue);
						return true;}
						
						else{
							$("#email_message").text("없는 이메일입니다.");
							return false;
						}
						}, 
					error : function(xhr, status, error) {
						console.log("error");
						return false;
						}//error
					});//ajax
			}//elseif
		}//emailValCheckFunction
		
		//이메일 본인인증
	function EmailVerificationClick(){
		$("#email_message").text("");

		//이메일 체크 시 기본적으로 유효성 검사는 하고 넘어가야 진행
		if(emailValCheck()==false){
			EmailVerification = false;
			return false;
		}else{
			//이메일 인증 전 false로 두고 
			EmailVerification = false;
			
		//비동기로 안해도됨. 이메일 인증번호만 받아오면 되는데 암튼 수정하기
		$.ajax({
			type : "POST",
			url : "../mailConfirm",
			dataType : "text",
			data : {
				user_email : email1.val()+"@"+email2.val()
				},
			success : function(rdata, status, xhr) {
				//코드 
				var emailcode = rdata.substring(rdata.length-8);
//				window.open('../childEmail_verification?emailcode='+emailcode,'target=_blank','width=400,height=300,location=no,status=no,scrollbars=yes');
				window.open('../childEmail_verification?emailcode='+emailcode,'target=_blank','width=400,height=300,location=no,status=no,scrollbars=yes');
				//responseentity를 통해서 받아오는 값을 인증코드만 뽑은 후 window.open에 넘겨준다.
			//	EmailVerification = <%=session.get%>;
				//boolean값인 EmailVerification이 true/false
				//자식창의 값을 받아서 그걸로 t/f
				//console.log("EmailVerification"+EmailVerification);
				EmailVerification = $("#tf").val();
				//console.log("EmailVerification"+EmailVerification);
				return EmailVerification;
				}, 
			error : function(xhr, status, error) {
				
				console.log("error");
				$("#email_message").text("이메일을 확인하세요.");
				return false;
				}//error
			});//ajax
		}//else
	}//function
		
	});//read