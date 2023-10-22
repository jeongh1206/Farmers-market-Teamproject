<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의하기</title>
<!-- 부트스트랩 css -->
	<link type = "text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!--부트 스트랩 js-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<!-- 외부 css 불러오기 -->
	<link rel="stylesheet" href="../resources/css/csMain.css"/>
	<link rel="stylesheet" href="../resources/css/csPageFooter.css"/>
	<link rel="stylesheet" href="../resources/css/font.css"/>
	<link rel="stylesheet" href="../resources/css/top.css"/>
	<link rel="stylesheet" href="../resources/css/WriteForm.css"/>
	
	<!-- 가장 최신버전의 jquery -->
 <script src="https://code.jquery.com/jquery-latest.min.js">
 </script>
 </head>
<body>
<script>
$(function() {
	$("#writeForm").submit(function(){
		var titleText = $("#title").val();
		titleText = titleText.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		titleText = titleText.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
		titleText = titleText.replaceAll("'", "&#39;");
		titleText = titleText.replaceAll("eval\\((.*)\\)", "");
		titleText = titleText.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		titleText = titleText.replaceAll("script", "");
		titleText = titleText.replaceAll("iframe", "");
		titleText = titleText.replaceAll("embed", "");
		$("#title").val(titleText);

		var contentText = $("#content").val();
		contentText = contentText.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
		contentText = contentText.replaceAll("'", "&#39;");
		contentText = contentText.replaceAll("eval\\((.*)\\)", "");
		contentText = contentText.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		contentText = contentText.replaceAll("script", "");
		contentText = contentText.replaceAll("iframe", "");
		contentText = contentText.replaceAll("embed", "");
		 $("#content").val(contentText);
		
	});//form submit
	
	
	
});

</script>
<section id="wrapper">
   	<div class="row csBody">
        <jsp:include page="csMenu.jsp" flush="true"/> <br>
        <div class="col-sm-8 divCsMain row">
			<div class="col-sm-4">
			    <p class="textTitle">1:1문의</p>
			</div>
			<!-- enctype="multipart/form-data" 없으면 files null -->
			<form action="/app/cs/WriteInquiry" method="post" id="writeForm" class="writeForm" enctype="multipart/form-data">
				<table class="table table-bordered writeFormTable">
				<tr>
					<th class="">상담종류</th>
					<!-- 클래스 이름은 왼쪽 정렬 의미 -->
					<td class="d-flex justify-content-start">
						<select name="inq_type" id="type" class="type form-select form-select-sm">
							<option>배송관련</option>
							<option>상품문의</option>
							<option>주문/결제</option>
							<option>사이트이용</option>
							<option>고객제안</option>
							<option>기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<th class="align-middle">첨부파일</th>
					<td class="d-flex justify-content-start">
					<button class="btn btn-secondary uploadFileBtn" id="uploadFileBtn"><a href="#this">파일추가</a></button>		
						<div class="form-group file-list" id="file-list">
							</div>
					</td>
				</tr>
				
				
				<tr>
				<th class="">제목</th>
				<td class="d-flex justify-content-start title">
					<input type="text" name="inq_title" id="title" class="form-control" placeholder="제목을 입력해주세요" maxlength="100">
				</td>
				</tr>
				
				<tr>
				<!-- class: 회색 배경 수직 정렬 -->
				<th class="align-middle">내용</th>
				<td class="content">
					<textarea name="inq_content" id="content" class="InputContent" maxlength="2000"></textarea>
				</td>
				</tr>
				
				</table>
				 	<!-- 부트스트랩 이용한 오른쪽 정렬 p-2와 같이 씀. 역순으로 간다. -->
			<div class="d-flex flex-row-reverse">
				<button type="submit" class="btn btn-success p-2" style="width:130px" >신청</button>&emsp;
				<button type="reset" class="btn btn-secondary" style="width:130px" >취소</button>
			
			</div>
			</form>
          
        </div><!--csMain row-->
    </div><!--csBody row-->
</section>

<script>
$(document).ready(function(){
	
	
	//파일 추가 버튼 클릭 시 파일 업로드 빈칸 추가됨
	$("#uploadFileBtn").click(addFile);
	
	$("#writeForm").submit(function(){
		if($("#title").val().length==0){
			alert("제목을 입력해주세요.");
		return false;
	}
		if($("#content").val().length==0){
			alert("내용을 입력해주세요.");
		return false;
		}
		var fileArr = $(".files");
		//fi:fileindex
		//반복문으로 파일 리스트에서  파일 없는 div 제거
		for(var fi=0;fi<fileArr.length;fi++){
			var f = fileArr[fi];
			if(f.value.length==0){
				deleteFile($(fileArr[fi]));
			}//if
		}//for
		
	});//ready
	
	$(".file-delete").on("click", function(e) {
		deleteFile($(this));
	});
});	
	/////////////function 목록 
	//파일 추가
	function addFile() {
		event.preventDefault();
		var str = "<div class='file-group'><input type='file' name='files' class='files'><a href='#this' name='file-delete'>삭제</a><br>";
		$("#file-list").append(str);
		$("a[name='file-delete']").on("click", function(e) {
			e.preventDefault();
			deleteFile($(this));
		});
	}
		//파일선택 삭제
		function deleteFile(obj) {
			obj.parent().remove();
			}
		

</script>

</body>
</html>