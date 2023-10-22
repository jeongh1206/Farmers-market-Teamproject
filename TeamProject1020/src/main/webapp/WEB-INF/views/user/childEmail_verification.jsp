<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증 확인</title>
<script src="http://code.jquery.com/jquery.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous"><script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script>
var emailcode = '<%=request.getAttribute("emailcode")%>';
$(function() {
	$("#emailForm").submit(function(){
		var email2 = $("#InputEmail1").val().trim();
		if(email2!=emailcode){
		$("#emailCheck").text("인증코드가 잘못되었습니다.");
		return false;
		//true/false값을 부모로 넘겨주려고한다.
		opener.$("#emailIdentification").val(false);
		//return false;
		}//if
		else{
			opener.$("#emailIdentification").val(true);
			opener.$("#email_message2").html("<span style='color:blue'>인증 완료</span>");
			//비활성화
			opener.$("#chkbtn").attr("class","form-control btn btn-success");	
			//재전송 버튼 숨김
			opener.$("#resendDiv").hide();	
			window.close();
		}
		//return false;
	});//submit

/*	$("#emailCheckBtn").click(function(){
		//$("#emailCheck").text("인증코드가 잘못되었습니다.");
		console.log("클릭은 됨?");
		return false;
	});//submit*/
});
</script>
</head>
<body>
<div class="container-fluid" style="margin-top:50px">
		<div class="text-center">
			<h3 class="text-center">
				이메일 인증
			</h3>
			<span style="text-align: center" class="">인증 메일이 발송되었습니다.<br> 이메일에 있는 인증코드를 입력해주세요.</span>
			<form role="form" class="form-inline" id="emailForm">
			<div class="row">
			<div class="col-sm-4"></div><!-- 정렬 위한 빈 태그 -->
				<div class="col-sm-4" class="text-center">
					<label for="exampleInputEmail1" >
						인증 코드:&nbsp;
					</label>
					<input type="text" class="form-control" id="InputEmail1" style="margin-left:30%;width:200px" value="">
					<span id="emailCheck" style="color:red;font:weight:bold;"></span>
				</div>
			</div><!-- row -->
			
			<div class="row">
					<div class="col-sm-4"></div><!-- 정렬 위한 빈 태그 -->
					<div class="col-sm-4">
					&nbsp;<button type="submit" class="btn btn-success" id="emailCheckBtn">
					인증하기  </button>
					</div>
	    	</div>	<!-- row -->	
			</form>
		</div><!-- 여기까지는 전체 div -->
	</div>
</body>
</html>