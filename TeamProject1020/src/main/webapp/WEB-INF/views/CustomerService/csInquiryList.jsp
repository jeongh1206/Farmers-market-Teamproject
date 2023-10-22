<%@page import="com.example.dto.CsInqDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 부트스트랩 css -->
	<link type = "text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!--부트 스트랩 js-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<!-- jquery -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- 외부 css 불러오기 -->
	<link rel="stylesheet" href="../resources/css/csMain.css"/>
	<link rel="stylesheet" href="../resources/css/csPageFooter.css"/>
	<link rel="stylesheet" href="../resources/css/font.css"/>
	<link rel="stylesheet" href="../re	sources/css/top.css"/>
	<link rel="stylesheet" href="../resources/css/writeForm.css"/>

</head>
<body>

 <script>
 /*개인이 남긴 문의를 목록으로 보여주는 페이지
	0. 로그인한 계정의 문의만 보여주고 비로그인 시 로그인하도록 출력함. (컨트롤러에서 처리)
 	1. 문의 내역이 없으면 없다는 메세지 출력
 	2. 문의 내역이 있으면 내역을 보여준다.
 	2-1. 내역은 한 행이 아코디언인 테이블 형식으로 보여준다. 답변이 달리면 문의 내역 아래 표시한다.
 	2-2. 내역의 종류는 답변 대기, 답변 완료 두가지로 나뉜다.
 	2-3. 답변 대기 중에는 삭제가 가능하고 답변 완료되면 삭제가 불가능하다.(삭제 버튼이 사라진다.)
 	2-4. 삭제는 비동기로 처리한다.
 	
 */
 	//문의한 내역이 없을 경우 
	<%if(request.getAttribute("inquiry")==null){%>
		 $(document).ready(function(){
			$("#recordTable").attr("class","fontTitle");
			$("#recordTable").html("문의 내역이 없습니다.");
	 });
	//문의 내역 존재하면 리스트 출력
	<%}else{%>
		 $(document).ready(function(){
				Inqfn(0,1);
		
			
		
 });//ready
			//문의 내역의 삭제 버튼 클릭
			function InqDelBtnfn(seq,pageIndex){
				$.ajax({
					type:"get",
					url:"csInqDel",//서버요청 주소
					dataType:"text",
					data: {"seq":seq},
					success:function(data,status,xhr){
						location.href="/app/cs/InquiryList?pageIndex="+pageIndex;
					},//success
					error: function(xhr,status,e){
					console.log("error",e);
					console.log("xhr",xhr.status);
						}//error
					});//ajax
			};//button event fn
			
			function Inqfn(curPageBarNo,pageIndex){
				<%
			ArrayList<CsInqDTO> Inqlist =  (ArrayList)request.getAttribute("inquiry"); %>
			var  list = [];
			<%for(CsInqDTO dto:Inqlist){
			String title = dto.getInq_title();
			title = title.replaceAll("\\\"","\\\\\"");
			String title2 = title.replaceAll("\\\'","\\\\\'");
			dto.setInq_title(title2);
			
			String content = dto.getInq_content();
			content = content.replaceAll("\\\"","\\\\\"");
			//받아온 데이터 json으로 저장하기 전에 줄바꿈 없애주기
			content = content.replace("\n","<br>");
			String content2 = content.replaceAll("\\\'","\\\\\'");
			dto.setInq_content(content2);%>
			var Inqjson =  {
					"seq": <%=dto.getInq_no()%>,
					"title": '<%=dto.getInq_title()%>',
					"content": '<%=dto.getInq_content()%>',
					"state": '<%=dto.getInq_state()%>'
					//문의에 대한 답변이 있다면
					<%if(dto.getInq_answer()!=null){%>
					,"answer":'<%=dto.getInq_answer()%>'
					<%}%>
				};
			
				list.push(Inqjson);
			<%}%>
			
				//테이블 입력 시작
				var str = "<table class='table'>";
				//기본으로 10번씩 나온다. 
				for(var i=0;(i<10);i++){
				var index = parseInt(curPageBarNo+""+(pageIndex-1)+""+i);
				
				if(index==list.length){break;}//레코드 전체 개수가 10보다 작을 경우 바로 탈출	
				//if(list==undefined){break;}//레코드 전체 개수가 10보다 작을 경우 바로 탈출	

				var seq = list[index].seq;
				var title = list[index].title;
				var content = list[index].content;
			 	var state=list[index].state;
			 	var answer = list[index].answer;
			 	//아코디언 클래스를 위한 arr 
			 	accordionArr = ["One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten"];
			 	
			 	
			 	str +="<tr>";
			 	str +="<td>";
			   	//pageIndex는 10~100의 자리, i가 1의 자리로 구성되고,
			   	//parseIndt를 통해 01,02처럼 출력되는걸 피한다.	
			   	str+="<div class='accordion accordion-flush' id='accordionFlushExample'>";
			   	str+="<div class='accordion-item'>";
			    str+="<h2 class='accordion-header'>";
			    str+="<button class='accordion-button collapsed InqtableBtn'  type='button' data-bs-toggle='collapse' data-bs-target='#flush-collapse"+accordionArr[i]+"' aria-expanded='false' aria-controls='flush-collapse"+accordionArr[i]+"'>";
				str+="<span>"+parseInt((pageIndex-1)*10+(i+1))+"<span class='fontTitle'>\t"+state+"&emsp;</span><span class='fontLg'>"+title+"</span>";
				str+= "</button></h2>";
				str+="<div id='flush-collapse"+accordionArr[i]+"' class='accordion-collapse collapse' data-bs-parent='#accordionFlushExample'>";
			    str+="<div class='accordion-body InqtableBody'>";
			    //문의 내용
			    str+="<div><span class='fontTitle'>Q</span>&nbsp;<span class='fontLg'>"+content+"</span></div>";
			    //답변
			    //답변이 있을때만 답변 div 생성
			    if(answer!=undefined){
			    str+="<div class='blank'><br><br></div><div class='answer'><span class='fontTitle'>A</span>&nbsp;<span class='fontLg'>"+answer+"</span></div>"
			    }else{
			    //삭제 - 답변 없을때만 삭제 가능
			    str+="<div class='d-flex flex-row-reverse'><button id='InqDelBtn' class='InqDelBtn' href='#' onclick='InqDelBtnfn("+seq+","+pageIndex+")'>삭제</button></div>"
			    }
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
										pStr +=" href='#' onclick='Inqfn("+curPageBarNo+","+pageIndex+")' style='color: black;' id='page"+pageIndex+"'>"+pageIndex+"</a></li>";
									}
									//뽑아온 레코드 수보다 페이지수가 넘어가려고하면 break
									if(pageIndex>=totalPage){break;}
							}

							 $("#pagination").html(pStr);
				}//function
		
				
		
			<%}%>

 </script>
    
<section id="wrapper">
   	<div class="row csBody">
    	<jsp:include page="csMenu.jsp" flush="true"/> <br>
 	<div class="col-sm-8 divCsMain row">
			<div class="col-sm-4">
			    <p class="textTitle">1:1문의</p>
			</div>
           	<div id="recordTable"></div>
           	<!-- 부트스트랩 이용한 오른쪽 정렬 p-2와 같이 씀 -->
			<div class="d-flex flex-row-reverse">
				<button type="button" class="btn btn-success p-2" style="width:130px" onclick="location.href='/app/cs/WriteInquiry'">글쓰기</button>
			</div>
        </div><!--csMain row-->
    </div><!--csBody row-->
</section>
 <div class="col-sm-12" id="footer">
        <nav aria-label="Page navigation example" class="navPagination">
            <ul class="pagination" style="justify-content : center;" id="pagination">
              
            </ul>
          </nav>
    </div><!-- page용 footer 끝-->   
</body>
</html>