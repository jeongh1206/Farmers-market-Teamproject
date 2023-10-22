<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
	<!--부트 스트랩 css-->
	<link type = "text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!--부트 스트랩 js-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<!-- css 받아오기 -->
	<link rel="stylesheet" href="../resources/css/csMain.css"/>
	<link rel="stylesheet" href="../resources/css/csPageFooter.css"/>
	<link rel="stylesheet" href="../resources/css/notice.css"/>
	
	<!-- jquery cdn -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
 <script>
 <%if(session.getAttribute("mesg")!=null){%>
 	alert('<%=session.getAttribute("mesg")%>');
 <%session.removeAttribute("mesg");}%>
 
 $(document).ready(function(){
	 //첫 페이지바는 0, 첫 페이지번호는 1
	 noticeListfn(0,1);
	 
	 //스피너 관련
	 $("#btnNtcSearch").click(function(){
		 $("#spinnerSearch").html(
			 "<div class='spinner-border text-success' id='spinnerSearch' role='status'>"
			 +"<span class='visually-hidden'>Loading...</span></div><br><br>");
	 
	 });//onclick
 	});//ready
 	
 ///////////function //////
				
				
 function noticeListfn(curPageBarNo,pageIndex){
	 //요청 파라미터:pageIndex -  페이지번호
	 $.ajax({
		type:"get",
		url:"https://www.gogung.go.kr/openApiNoti.do",//서버요청 주소
		dataType:"xml",
		data: {
				"pageIndex":pageIndex
				},
		success:function(data,status,xhr){
			//data를 통해 받아온 정보 추출///
			
			//한번에 보여주는 레코드 수:10. 결과 파라미터 pageUnit으로 이미 지정됨
//			var pageUnit = $(data).find("pageUnit").text();	
			
			//xml 데이터 - list 10개(레코드 10개)
			var listArr = $(data).find("list");
			
				
			//테이블 입력 시작
			var str = "<table class='table'>";
			str += "<tr class='trTitle'><th>번호</th><th>내용</th><th>작성자</th><th>등록일</th></tr>";
			
			//기본으로 10번씩 나온다. 
				for(var i=1;i<=10;i++){
      		var list = listArr[i-1];
      		//여기서는 list가 배열이 아니고 <list>태그다.
				//제목: 
				var title = $(list).find("title").text();
				//작성자: 
				var writer = $(list).find("writer").text();
				//수정일자: 
				var regDate = $(list).find("regDate").text();
	      		//날짜만 자르기(시간 안보이게)
	      		regDate = regDate.substring(0,10);
      			
	      		var seq = $(list).find("seq").text();
	      		//var index = parseInt(curPageBarNo+""+(pageIndex-1)+""+i);
	      		var index = parseInt(curPageBarNo+""+(pageIndex-1)+""+i);
    		//  if(index==list.length){break;}//레코드 전체 개수가 10보다 작을 경우 바로 탈출	
				if(list==undefined){break;}//레코드 전체 개수가 10보다 작을 경우 바로 탈출	

          	str +="<tr>";
          	//pageIndex는 10~100의 자리, i가 1의 자리로 구성되고,
          	//parseInt를 통해 01,02처럼 출력되는걸 피한다.	
          	str +="<td>"+parseInt((pageIndex-1)*10+i)+"</td>";
          	str +="<td>"+"<a href='/app/cs/noticeRetreive?seq="+seq+"&pageIndex="+pageIndex+"'>"+title+"</a>"+"</td>";
          	str +="<td>"+writer+"</td>";
          	str +="<td>"+regDate+"</td>";
          	str += "</tr>";	

				}
      	str += "</table>";
			$("#recordTable").html(str);
          	
			str = "";
			//////테이블 입력 끝///////
			var totalCnt = $(data).find("totalCnt").text();
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
			//console.log("totalCnt="+totalCnt);
			if(totalCnt%10==0){
				var totalPage = totalCnt / 10;
			}else{
				var totalPage =  parseInt(totalCnt / 10) + 1;
			}

				//console.log("totalPage="+totalPage);
				//3. pageBar가 몇 개 있는지 계산. 0부터 시작해야해서 -1해줬음.
				if(totalPage%10==0){
					var pageBarNo = totalPage / 10 - 1;
			}else if(totalPage){
				var pageBarNo = parseInt(totalPage / 10) ;
			}
				
			//	console.log("pageBarNo="+pageBarNo);
			//4. 현재 페이지 bar 를 계산한다.(이건 함수 인자로 받도록 하자.)

			//5. 개별 페이지 번호: pageIndex (10 레코드)
				//(api 통해 실질적으로 요청을 보내 외부에서 레코드 호출하는 변수)
			
			//6. 개별 레코드 번호: 게시글 번호 지정 위해 필요
			//var recordNo = 1;
				//이 부분은 이전 페이지바로 되돌아가도록함. 
				//페이지바가 1보다 클 때만 작동
				if(curPageBarNo>=1){
					//이전 페이지바의 첫 페이지로 이동
					//이전 페이지바를 호출한다음에 저장해야하는데, 
					//함수 호출하지 않고 전위 연산자 쓰면 무조건 적용이 되어버려서 계속 페이지번호가 1이 됨.
					//함수를 통해 onclick, 즉 직접 눌렀을 때만 curPageBarNo가 바뀌도록 해줬음.
					var pStr = "<li class='page-item'><a class='page-link' href='#'  onclick='noticeListfn("+(curPageBarNo-1)+","+(curPageBarNo-1)+"1"+")' aria-label='Previous' style='color: black;'>";
				}else{
					var pStr = "<li class='page-item'><a class='page-link' aria-label='Previous' style='color: black;'>";
				}
	        pStr +="<span aria-hidden='true'>&laquo;</span></a></li>";	

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
								pStr +=" href='#' onclick='noticeListfn("+curPageBarNo+","+pageIndex+")' style='color: black;' id='page"+pageIndex+"'>"+pageIndex+"</a></li>";
							}
							//뽑아온 레코드 수보다 페이지수가 넘어가려고하면 break
							if(pageIndex>=totalPage){break;}
					}

			 //다음페이지바 이동 >> 링크(현재 페이지바가 전체 페이지바보다 숫자가 작을때만 작동)
					if(curPageBarNo>=pageBarNo){
	 				 pStr +="<li class='page-item'><a class='page-link' aria-label='Next' style='color: black;'>";
	             }else{
	            	 //다음 페이지바의 첫 페이지로 이동                         
	 				 pStr +="<li class='page-item'><a class='page-link' href='#' onclick='noticeListfn("+(curPageBarNo+1)+","+(curPageBarNo+1)+"1"+")' aria-label='Next' style='color: black;'>";
	                 }
				 pStr +="<span aria-hidden='true'>&raquo;</span></a></li>";
				 	//console.log("curPageBarNo"+curPageBarNo);
					//설정한 html 출력
					 $("#pagination").html(pStr);
		},//success
		error: function(xhr,status,e){
		console.log("error",e);
		console.log("xhr",xhr.status);
		}//error
	});//ajax
	 
	}//function
		
             
             
/*function pBarPrev(curPageBarNo){
	 curPageBarNo -=1;
			return curPageBarNo;
	}
	function pBarNext(curPageBarNo){
	 curPageBarNo +=1;
	 return curPageBarNo;
 	}
*/	
	
		
</script>
             
</head>
<body>   
<jsp:include page="../common/top.jsp" flush="true"/> <br>
<section id="wrapper">
   	<div class="row csBody">
        <jsp:include page="csMenu.jsp" flush="true"/> <br>
    
        <div class="col-sm-8 divCsMain row">
        	
			<div class="col-sm-4">
			    <p class="textTitle">공지사항</p>
			</div>
			<div class="col-sm-4"></div>
	        <div class="col-sm-4 divCsSearch" id="divCsSearch">
	        <div id="spinnerSearch"></div>
	        <form action = "/app/cs/NtcSearchKeyWord" id="noticeSearch" method="get">
	       		<select  id = "selectNtcSearch" class="selectCsSearch" name="type">
	       			<option value="full" selected>전체</option>
	       			<option value="title">제목</option>
	       			<option value="content">내용</option>
	       		</select>
	            <input type="text" name="keyword" placeholder="검색어 입력" class="inputCsSearch" id="inputNtcSearch">
				<button type="submit" class="btn btn-light btnCsSearch" id="btnNtcSearch">
                    	검색
                </button>
           		</form>
           		<br>
            </div>
            <div id="recordTable" class="csTable">
             </div>
        </div><!--csMain row-->
    </div><!--csBody row-->
</section><!-- page 관련 코드-->   
 <div class="col-sm-12" id="footer">
        <nav aria-label="Page navigation example" class="navPagination">
            <ul class="pagination" style="justify-content : center;" id="pagination">
              
            </ul>
          </nav>
    </div><!-- page용 footer 끝-->   
	<jsp:include page="../common/bottom.jsp" flush="true"/> <br>
</body>
</html>