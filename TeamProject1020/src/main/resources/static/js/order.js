//결제 예정
$(function() {
	
	//장바구니에서 삭제할 목록
	var cartnoList = [];
	
	$(".cart_no").each(function(){
		cartnoList.push($(this).val());
	});
	$('input[name=cart_noList]').val(cartnoList);
	
	//편의점 배송 form 기본적으로 안보이게 설정
		$("#CVSForm").hide();
		
		var first = $("#firstName").val();
		var size = $("#pSize").val();
		var pName = first;
		var post = $("#sample4_postcode").val();
		var receiver = $("#Receiver").val();
		var check = true;
		if(size>1){
			pName=first+" 포함 총"+size+"개";
		}
		var list = $(".sum");
		var listSum = 0;
		for (var i = 0; i < list.length; i++) {
			listSum += parseInt($(list[i]).val())
		}
		//소숫점 자릿수 표시
		var option = {
				  maximumFractionDigits: 4
				};
		var clistSum = listSum.toLocaleString('ko-KR', option);
		$("#orderPrice").text(clistSum+"원");
		$('input[name=order_price]').val(listSum);
		
		//주소, 수령하시는분, 수령인 전화번호  작성여부 확인
		function addressCheck(){
			var post = $("#sample4_postcode").val();
			var receiver = $("#Receiver").val();
			if(post.length==0||receiver.length==0){
				alert("수취인과 주소를 입력해주세요");
				check = false;
			}else check=true;
		}//addressCheckFunction
		
		//편의점이름, 수령하시는분, 수령인 전화번호  작성여부 확인
		function CVScheck(){
			var CVSname = $("#CVSname").val();
			var receiver = $("#Receiver2").val();
			var receiverPhone = $("#ReceiverPhone").val();
			if(CVSname.length==0||receiver.length==0||receiverPhone.length==0){
				alert("수취인, 편의점 이름, 전화번호를 확인해주세요");
				check = false;
			}else check=true;
		}//CVScheckFunction
		
		//배송방법 변경시 보여줄 form 변경
		$('input[type=radio]').on('change', function () {
		    if ($("#DeliveryMethod2").prop('checked')) {
		        $("#delForm").hide();
		        $("#CVSForm").show();
		    }else{
		    	$("#delForm").show();
		    	$("#CVSForm").hide();
		    }
		});
		
// 아임포트 결제
$(document).ready(function(){
	//카드결제
	$("#inicisPayment").click(function(){
		if ($("#DeliveryMethod2").prop('checked')) {
			CVScheck();
		}else{
			addressCheck();
		}
		if(check){
		inicisPay();
		}
	});
	//카카오페이 결제
	$("#kakaoPayment").click(function(){
		if ($("#DeliveryMethod2").prop('checked')) {
			CVScheck();
		}else{
			addressCheck();
		}
		if(check){
		kakaoPay();
		}
	});
	//무통장입금
	$("#Deposit").click(function(){
		if ($("#DeliveryMethod2").prop('checked')) {
			CVScheck();
		}else{
			addressCheck();
		}
		if(check){
	    	  $('input[name=order_paymethod]').val("무통장입금");
		  		if ($("#DeliveryMethod2").prop('checked')) {
		  			$('input[name=order_delmethod]').val("택배");
		  			$("#CVSForm").attr("action","orderDone");
		  			$("#CVSForm").submit();
		  			
				}else{
					$('input[name=order_delmethod]').val("편의점픽업");
					$("#delForm").attr("action","orderDone");
		  			$("#delForm").submit();
				}
		}
	});
});
var IMP = window.IMP; // 생략가능
IMP.init('imp42482388'); // <-- 본인 가맹점 식별코드 삽입

function inicisPay() {
	  IMP.init('imp42482388'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
	  IMP.request_pay({
	    pg: "html5_inicis",
	    pay_method: "card",
	    merchant_uid : 'iamport_test_id_'+new Date().getTime(),
	    name : pName,
	    amount : listSum,
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456'
	  }, function (rsp) { // callback
	      if (rsp.success) {
	    	  $('input[name=order_paymethod]').val("카드결제");
	  		if ($("#DeliveryMethod2").prop('checked')) {
	  			$('input[name=order_delmethod]').val("택배");
	  			$("#CVSForm").attr("action","orderDone");
	  			$("#CVSForm").submit();
	  			
			}else{
				$('input[name=order_delmethod]').val("편의점픽업");
				$("#delForm").attr("action","orderDone");
	  			$("#delForm").submit();
			}
	        
	      } else {
	    	  var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		        alert(msg);
	        // 결제 실패 시 로직,
	       
	      }
	  });
	}
function kakaoPay() {
	  IMP.init('imp42482388'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
	  IMP.request_pay({
	    pg: "kakaopay",
	    pay_method: "card",
	    merchant_uid : 'iamport_test_id_'+new Date().getTime(),
	    name : pName,
	    amount : listSum,
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456'
	  }, function (rsp) { // callback
	      if (rsp.success) {
	        
	    	  $('input[name=order_paymethod]').val("카카오페이");
		  		if ($("#DeliveryMethod2").prop('checked')) {
		  			$('input[name=order_delmethod]').val("택배");
		  			$("#CVSForm").attr("action","orderDone");
		  			$("#CVSForm").submit();
		  			
				}else{
					$('input[name=order_delmethod]').val("편의점픽업");
					$("#delForm").attr("action","orderDone");
		  			$("#delForm").submit();
				}
	    	  
	        
	      } else {
	    	  var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		        alert(msg);
	        // 결제 실패 시 로직,
	       
	      }
	  });
	}
});


//편의점 선택 페이지
function openCVS() {
	window.open('map', 'post', 'width=780,height=600').focus();
}

//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
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