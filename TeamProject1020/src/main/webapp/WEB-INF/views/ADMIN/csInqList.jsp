<%@page import="java.util.List"%>
<%@page import="com.example.dto.CsInqDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Tables - SB Admin</title>
         <jsp:include page="common/common.jsp" flush="true"></jsp:include>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="<%=request.getContextPath()%>/resources/css/styles.css" rel="stylesheet" />
		
		<!-- css 파일 추가 -->        
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admCs.css">
        <link href="<%=request.getContextPath()%>/resources/css/font.css" rel="stylesheet" />
        
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
   	 <!-- jquery -->
   	 <script src="https://code.jquery.com/jquery-latest.min.js"></script>
   	<script>
   	//post 로 뿌리면서 시작하기 
   			//모달창
		///<a href="#">파일</a>
				         
		 function openfnc(Inq_no) {
   		//모달창 보이게 처리
			 $('#modalWrap').attr("style","display:block");
			 $.ajax({
					type : "POST",
					url : "adm_csInqRetrieve",
					dataType : "json",
					data : {
						"inq_no" : Inq_no
					},
					success : function(rdata, status, xhr) {
						//문의 내용 
						$("#mdTitle").text(rdata.CsInqRetrieve.inq_title);
						$("#mdWriter").text(rdata.CsInqRetrieve.user_name);
						$("#mdDate").text(rdata.CsInqRetrieve.inq_update);
						$("#mdContent").text(rdata.CsInqRetrieve.inq_content);
						
						//파일 읽어오기
						const reader = new FileReader();
						//파일이 없을 수도 있음
						if(rdata.fileList!=null){
							console.log(typeof(rdata.fileList));
							console.log(rdata.fileList);
							var fileStr = "";
							/////////////////
							//////로컬 경로 에러 나는 부분. webconfig 파일 받아야함
							for(var index = 0;index<rdata.fileList.length;index++){
								 var path = rdata.fileList[index];
								fileStr += "<img width='100' height='100' src='"+path+"'>";
							}//for
							
						}//if
						//파일 리스트의 객체를 꺼내서 
						
						//파일 내용
						$("#mdFile").append(fileStr);
					}, 
					error : function(xhr, status, error) {
						console.log("error");
						return false;
					}//error
				});//ajax
		}
		
		
		  
   	$(function() {
   		$('#closeBtn').click(function() {
			$('#modalWrap').attr("style","display:none");
		});
   		
   		//모달 관련
   		if (event.target == $('#modalWrap')) {
			  $('#modalWrap').attr("style","display:none");
		  }//if
   		
			var tableStr = "";
			 <%if(request.getAttribute("CsInq")!=null){
					ArrayList list = (ArrayList)request.getAttribute("CsInq");
					for(int i=0;i<list.size();i++){
						//Object 타입으로되어있어 형변환부터.
					CsInqDTO dto = (CsInqDTO)list.get(i);
					%>
					tableStr += "<tr class=>"
						tableStr += "<td>"+'<%=dto.getInq_no()%>'+"</td>";
						tableStr += "<td>"+'<%=dto.getUser_name()%>'+"</td>";
						tableStr += "<td><a href='#' onclick='openfnc(<%=dto.getInq_no()%>)'>"+'<%=dto.getInq_title()%>'+"</a></td>";
						tableStr += "<td>"+'<%=dto.getInq_type()%>'+"</td>";
						tableStr += "<td>"+'<%=dto.getInq_update()%>'+"</td>";
						tableStr += "<td>"+'<%=dto.getInq_state()%>'+"</td>";
						tableStr += "</tr>";
						
					<%}//for
				}//if%>
			$("tbody").html(tableStr);	
			
			//전체목록 끝
			
		
   	});//ready
   	</script>
    </head>
    <body class="sb-nav-fixed">
    	<jsp:include page="common/top.jsp" flush="true"></jsp:include>
        <div id="layoutSidenav">
        	<jsp:include page="common/leftmenu.jsp" flush="true"></jsp:include>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">1:1 문의 목록</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.html">문의 관리</a></li>
                            <li class="breadcrumb-item active">1:1 문의 관리</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                	고객이 남긴 1:1 문의 목록을 한 번에 볼 수 있습니다.<br>
                                	더블 클릭해 상세보기가 가능합니다.
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                	문의 전체 내역	
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
									 <thead>
                                        <tr>
                                            <th>문의 글 번호</th>
                                            <th>작성자</th>
                                            <th>제목</th>
                                            <th>유형</th>
                                            <th>등록일시</th>
                                            <th>상태</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>No</th>
                                            <th>Writer</th>
                                            <th>Title</th>
                                            <th>Type</th>
                                            <th>Date</th>
                                            <th>State</th>
                                        </tr>
                                    </tfoot>
									<tbody id="InqTbody">
									</tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 모달창 -->
                  <div id="modalWrap">
		        <div id="modalContent">
			        <div id="modalBody">
				        <span id="closeBtn">&times;</span>
				       
				        <span id="mdTitle" class="fontLgBold">제목</span>
				         <hr>
				           	<span id="mdWriter">작성자</span>&nbsp;<span id="mdDate">등록날짜</span><br>
				         <hr>
				         	<span  id="mdContent">내용</span>
				         <hr>
				         
				         <form>
				         <textarea id="csAnswer" placeholder="답변 입력"></textarea>
				         <div id="mdFile">
				         
				         </div>	
				         <br>
				         <div class="d-flex flex-row-reverse">
							<button type="submit" id="answerBtn"class="btn btn-secondary p-2">작성하기</button>
						</div>
						</form>
						
			        </div><!-- modalBody -->
		        </div><!-- modalContent -->
		        <div id="OpenFile">
		      		이부분 파일 보이게 할 예정
  			 			 </div>
		      </div><!-- modalWrap -->
		      <br>
		      <br>
		      <br>
		      
                </main>
                <jsp:include page="common/bottom.jsp" flush="true"></jsp:include>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/resources/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/resources/js/datatables-simple-demo.js"></script>
    </body>
</html>
