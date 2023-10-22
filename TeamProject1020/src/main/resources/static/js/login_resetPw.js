//jquery 통한 이벤트 처리
//MemberAddController와 연결

$(function() {
////////////변수 선언/////////////
	//dom을 변수에 저장
	var password = $("#password");
	var password2 = $("#passwordCheck");
	
///////////이벤트 처리 //////////////
	
	
		//각 태그에서 submit 또는 blur 할 때  유효성 검사
		  validateField(password, pwCheck);
		  validateField(password2, pw2Check); 
		  
		  //유효성 검사 함수 
			//- field: 선택된 html 요소
			//- validationFunction: 
			// 각 입력 필드에 유효성 검사 함수 등록
		  function validateField(field, validationFunction) {
			  field.blur(validationFunction);
			  $("#userForm").submit(validationFunction);
			}//fuction

			
/////////유효성 검사 함수 시작//////////
	
	//비밀번호 검사 - 필수 입력 / 영문, 숫자, 특수문자 8자리 이상
		function pwCheck(){
		
		var p1 = password.val();
		var p2 = password2.val();
		
		//정규표현식: const 이름 = /패턴/
		const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$%*^&+=!])[A-Za-z\d@#*$%^&+=!]{8,}$/;
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
				return false;
			}//else
		}//else
	}//password이벤트
	
	//비밀번호 대조 검사
		function pw2Check(){
		var p1 = password.val();
		var p2 = password2.val();
		const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$%^&+*=!])[A-Za-z\d@#$*%^&+=!]{8,}$/;
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
		
	});//read