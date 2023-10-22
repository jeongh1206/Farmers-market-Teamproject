<%@page import="com.example.dto.FAQDTO"%>
<%@page import="com.fasterxml.jackson.databind.node.ArrayNode"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="com.example.dto.noticeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<!--부트 스트랩 css-->
	<link type = "text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!--부트 스트랩 js-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<!-- 외부 css 불러오기 -->
	<link rel="stylesheet" href="../resources/css/csMain.css"/>
	<link rel="stylesheet" href="../resources/css/notice.css"/>
	<link rel="stylesheet" href="../resources/css/csPageFooter.css"/>
	<link rel="stylesheet" href="../resources/css/font.css"/>
	<link rel="stylesheet" href="../resources/css/main.css"/>
	
	<!-- jquery cdn -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
 <script>
 // 
 


<%if(request.getAttribute("result")!=null){%>//검색된 값이 있다면
 $(document).ready(function(){
	 <%if(request.getAttribute("FAQ_type")!=null){%>//배송/취소/회원 등 카테고리를 눌렀다면 페이지에서 그 카테고리값을 저장하고 시작.
	 $("#FAQ_typeBtn").val("<%=request.getAttribute("FAQ_type")%>");
	 console.log($("#FAQ_typeBtn").val());
	 <%}%>
	 
	 FAQfn(0,1);
	 
		$(".type").click(	
				function (){
					$("#FAQ_typeBtn").val($(this).val());
					console.log($("#FAQ_typeBtn").val());
					$("#FAQSearch").submit();
				});
 });
 
<%}else{%>//불러온 레코드 정보가 없으면 경고창 띄우기 
alert("정보가 없습니다.");
location.href="cs/FAQUI";
<%}%>
///////function////////
 function FAQfn(curPageBarNo,pageIndex){
	 //요청 파라미터:pageIndex -  페이지번호
	 
	 //request로 결과 배열 받고 그걸 json의 배열로 옮겼다.
	 <% ArrayList<FAQDTO> FAQlist =  (ArrayList)request.getAttribute("result"); %>
	var  list = [];
	<%for(FAQDTO dto:FAQlist){
	String title = dto.getFAQ_title();
	title = title.replaceAll("\\\"","\\\\\"");
	String title2 = title.replaceAll("\\\'","\\\\\'");
	dto.setFAQ_title(title2);
	
	String content = dto.getFAQ_content();
	content = content.replaceAll("\\\"","\\\\\"");
	//받아온 데이터 json으로 저장하기 전에 줄바꿈 없애주기
	content = content.replace("\n","<br>");
	String content2 = content.replaceAll("\\\'","\\\\\'");
	dto.setFAQ_content(content2);
	
	
	%>
		
	var tempjson =  {
			"title": '<%=dto.getFAQ_title()%>',
			"content": '<%=dto.getFAQ_content()%>',
			"FAQ_type": '<%=dto.getFAQ_type()%>'
		};
		list.push(tempjson);
	<%}%>

	//테이블 입력 시작
	var str = "<table class='table'>";
	//기본으로 10번씩 나온다. 
	for(var i=0;(i<10);i++){
	var index = parseInt(curPageBarNo+""+(pageIndex-1)+""+i);
	if(index==list.length){break;}//레코드 전체 개수가 10보다 작을 경우 바로 탈출	

	//console.log("i"+i);
	//console.log("index"+index);
	
	//제목: 
	var title = list[index].title;
	var content = list[index].content;
 	var no = list[index].no;
 	var FAQ_type=list[index].FAQ_type;
   	
 	//아코디언 클래스를 위한 arr 
 	accordionArr = ["One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten"];
 	
 	
 	str +="<tr>";
 	str +="<td>";
   	//pageIndex는 10~100의 자리, i가 1의 자리로 구성되고,
   	//parseIndt를 통해 01,02처럼 출력되는걸 피한다.	
   	str+="<div class='accordion accordion-flush' id='accordionFlushExample'>";
   	str+="<div class='accordion-item'>";
    str+="<h2 class='accordion-header'>";
    str+="<button class='accordion-button collapsed FAQtableBtn'  type='button' data-bs-toggle='collapse' data-bs-target='#flush-collapse"+accordionArr[i]+"' aria-expanded='false' aria-controls='flush-collapse"+accordionArr[i]+"'>";
	str+="<span>"+parseInt((pageIndex-1)*10+(i+1))+"<span class='fontTitle'>\t"+FAQ_type+"&emsp;</span><span class='fontLg'>"+title+"</span>";
	str+= "</button></h2>";
	str+="<div id='flush-collapse"+accordionArr[i]+"' class='accordion-collapse collapse' data-bs-parent='#accordionFlushExample'>";
    str+="<div class='accordion-body FAQtableBody'><span class='fontLg'>"+content+"</span>";
	str+="</div></div></div>";
   	
	str +="</td>";
   	str += "</tr>";	
	}//end for
	str += "</table>";
		$("#recordTable").html(str);
		str = "";
		//////테이블 입력 끝///////	
		var totalCnt = list.length;
		//////페이징////////////
			//페이징 처리 관련 변수
/*pageIndex: 페이지 번호('n번째 페이지'에서 'n'에 해당)
 totalCnt: 전체 레코드 개수
 ---여기까진 api에서 기본 지정된 변수
 curPageIndex : 호출된 시점의 pageIndex
 listarr: 한 페이지에서 보이는 레코드의 배열
 totalPage:전체 페이지 번호
 pageBarNo:페이지 10개 묶음의 개수 (310개의 레코드면 4개의 페이지바)
*/		//0. curPageIndex: 현재 페이지 번호(a태그에 링크 없앨 때 사용)
		var curPageIndex = pageIndex;
				//1. 제일 큰 단위  - 전체 레코드 개수
		if(totalCnt%10==0){
			totalPage = totalCnt / 10;
		}else{
			totalPage =  parseInt(totalCnt / 10) + 1;
		}
			//3. pageBar가 몇 개 있는지 계산. 0부터 시작해야해서 -1해줬음.
			if(totalPage%10==0){
				var pageBarNo = totalPage / 10 - 1;
		}else if(totalPage){
			var pageBarNo = parseInt(totalPage / 10) ;
		}
			
		//4. 현재 페이지 bar 를 계산한다.(이건 함수 인자로 받도록 하자.)

		//5. 개별 페이지 번호: pageIndex (10 레코드)
			//(api 통해 실질적으로 요청을 보내 외부에서 레코드 호출하는 변수)
		
		//6. 개별 레코드 번호: 게시글 번호 지정 위해 필요
		//var recordNo = 1;
       var pStr = "";
		//본격적으로 페이지 출력 . 한 화면에 보여지는 페이지에 대한 내용 
				for(i=1;i<=10;i++){
						//api통해 레코드 제대로 뽑아오기 위한 pageIndex 계산(10을 누를경우는 올림계산되도록 처리)									
						if(i<10){
							//parseInt하면 01,02,03..과 같이 안나오고 1,2,3으로 나온다.
							pageIndex = parseInt(curPageBarNo+""+i);
						}else{
							pageIndex = (curPageBarNo+1)+""+0;
						}
						//console.log("pageIndex="+pageIndex);
						//a 링크 관련 - 현재 페이지로는 링크 안걸리게
						pStr +="<li class='page-item'><a class='page-link'";
						if(curPageIndex == pageIndex){
							//background-color 통해 현재 페이지를 알 수 있게끔 했음. css를 활용하고자하면 이 부분 고치면 된다.
							//rgba의 마지막 숫자는 투명도
							pStr += "style='color: black; background-color: rgba(106, 163, 56, 0.5);' id='page"+pageIndex+"'>"+pageIndex+"</a></li>";
						}
						else{
							pStr +=" href='#' onclick='FAQfn("+curPageBarNo+","+pageIndex+")' style='color: black;' id='page"+pageIndex+"'>"+pageIndex+"</a></li>";
						}
						//뽑아온 레코드 수보다 페이지수가 넘어가려고하면 break
						if(pageIndex>=totalPage){break;}
				}

				//설정한 html 출력
				 $("#pagination").html(pStr);
	}//function
	
	
</script>
             
</head>
<body>   
<section id="wrapper">
   	<div class="row csBody">
        <jsp:include page="csMenu.jsp" flush="true"/> <br>
    
        <div class="col-sm-8 divCsMain row">
        <div class="col-sm-4">
			    <p class="textTitle">자주 묻는 질문</p>
			</div>
			
			<div class="col-sm-4"></div>
	        <div class="col-sm-4 divCsSearch flexwrapper">
    	        <div id="spinnerSearch"></div>
    	        
	       		<form action="/app/cs/FAQUI" id="FAQSearch" method="get">
	       		<select  id = "selectNtcSearch" class="selectCsSearch" name="type">
	       			<option value="full" selected>전체</option>
	       			<option value="title">제목</option>
	       			<option value="content">내용</option>
	       		</select>
	       		<!-- hidden -->
	       		<input type="hidden" id="FAQ_typeBtn" name="FAQ_type">
	            <input type="text" name="keyword" placeholder="검색어 입력" class="inputCsSearch" id="inputNtcSearch">
				<button type="submit" class="btn btn-light btnCsSearch " id="btnNtcSearch" style="overflow:hiddlen; white-space:nowrap;">
                    	검색
                </button>
           		</form>
           		<br>
            </div>
            	<!-- 카테고리 버튼 한 줄로 배치 -->
        	<div class=" col-sm-12 flexwrapper row">
        		<input type="button" class="btn btn-outline-success type" id="dlv" style="width:100px" value="배송">&nbsp;
        		<input type="button" class="btn btn-outline-success type" id="cancel" style="width:200px" value="취소/교환/환불">&nbsp;
        		<input type="button" class="btn btn-outline-success type" id="pmt" style="width:100px" value="주문/결제">&nbsp;
        		<input type="button" class="btn btn-outline-success type" id= "mmb" style="width:100px" value="회원">&nbsp;
        		<input type="button" class="btn btn-outline-success type" id="etc" style="width:100px" value="기타">
        	</div><!-- 카테고리 버튼 div 끝 -->
        	        
        	
            	<div id="recordTable"></div>
        </div><!--csMain row-->
    </div><!--csBody row-->
</section><!-- page 관련 코드-->   
  <div class="col-sm-12" id="footer">
        <nav aria-label="Page navigation example" class="navPagination" style=" border-radius: 10px;">
            <ul class="pagination" style="justify-content : center;" id="pagination">
            </ul>
          </nav>
    </div><!-- page용 footer 끝-->
    <!-- jsp bottom include 있던 곳  -->
</body>
</html>