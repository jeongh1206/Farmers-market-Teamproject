<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<!-- Bootstrap -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>

$(function() {
////////////변수 선언/////////////
	//dom을 변수에 저장
	var name = $("#name");
	var phone = $("#phoneNumber");
	var post = $("#sample4_postcode");
	var ref = $("#user_ref");
	
	//이메일 인증했는지 확인하는 변수
	
///////////이벤트 처리 //////////////
	function validateField(field, validationFunction) {
		  field.blur(validationFunction);
		  $("#userForm").submit(validationFunction);
		}//fuction

	
	//각 태그에서 submit 또는 blur 할 때  유효성 검사
	  validateField(name, nameCheck);
	  validateField(phone, phoneCheck); 
	  validateField(ref, refCheck); 
	  validateField(post, addressCheck); 
	 
	  $("#userForm").submit(addressCheck);
/////////유효성 검사 함수 시작//////////
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
		
	
	

	function addressCheck(){
		//Buyer.jsp 의 주소 추가 버튼
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
				url : "register/add_phoneCheck",
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
				url : "register/add_refCheck",
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
	
	});//read
</script>
</head>
<body>	
	<jsp:include page="../common/top.jsp" flush="true"/> <br>
	<!-- 본문 시작 -->
	<section class="sectionAlign">
	    <label class="col-lg-8 control-label">회원가입이 완료되었습니다.<br></label><br><br><br>
	    
		<form class="form-horizontal" id="userForm" role="form" method="post" action="/app/addDone">
		
			<div class="form-group" id="divName">
			    <label for="inputName" class="col-lg-8 control-label">이름</label>
			    <div class="col-lg-6">
			        <input type="text" name="user_name" class="form-control onlyHangul" id="name" data-rule-required="true" maxlength="15">
			    	<span id="name_message" style="color:red"></span>
			    </div>
			</div>
	
			<div class="form-group" id="divAddress">
			    <label for="inputAddress"  class="col-lg-4 control-label">주소</label>
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
			    <label for="inputPhoneNumber" class="col-lg-4 control-label">휴대폰 번호</label>
			    <div class="col-lg-6">
			        <input type="tel" class="form-control onlyNumber" id="phoneNumber" name="user_phone" data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11">
			    	<span id="phone_message"  style="color:red"></span>
			    </div>
			</div>
			
			<div class="form-group" id="divRef">
			    <label for="inputRef" class="col-lg-4 control-label">추천인</label>
			    <div class="col-lg-6">
			        <input type="tel" class="form-control" id="user_ref" name="user_ref" placeholder="(선택)" maxlength="11">
			    	<span id="ref_message" style="color:red"></span>
			    </div>
			</div>
			
		    <div class="col-lg-offset-2 col-lg-10">
		        <button type="submit" class="btn btn-success">입력하기</button><br><br>
		        <hr>
		    </div>
		</form>

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
            }
        }
    }).open();
}
</script>
</section>
<!-- 푸터 들어가는 부분 -->
	<jsp:include page="../common/bottom.jsp" flush="true"/> <br>

</body>
</html>