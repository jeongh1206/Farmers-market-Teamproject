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
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>

<!-- 이벤트 처리 관련 js파일 연결 -->
<script type="text/javascript" src="resources/js/login_Buyer.js"></script>
<script>
$('a').removeattr('href');
</script>
</head>
<body>	
	<jsp:include page="../common/top.jsp" flush="true"/> <br>
	<!-- 본문 시작 -->
	<section class="sectionAlign">
	    <label class="col-lg-8 control-label">회원가입이 완료되었습니다.<br></label><br><br><br>
	    
		<form class="form-horizontal" id="AddBuyer" role="form" method="post" action="/app/addDone">
		
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