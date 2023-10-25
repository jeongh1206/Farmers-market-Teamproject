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
		
		<!-- css 수정 파일 -->        
        <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admCs.css">
        
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
   	 <!-- jquery -->
   	 <script src="https://code.jquery.com/jquery-latest.min.js"></script>
   	<script>
   	//post 로 뿌리면서 시작하기 
   	function ckfnc(Inq_no){
   		// inq_no를 넘기는 ajax 로 수정해서 모달창 띄우도록 해야한다.
   		//"/app/adm_csInqRetrieve
   	}
   	$(function() {
   		
   		
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
							tableStr += "<td><a href='#' onclick='ckfnc(<%=dto.getInq_no()%>)'>"+'<%=dto.getInq_title()%>'+"</a></td>";
							tableStr += "<td>"+'<%=dto.getInq_type()%>'+"</td>";
							tableStr += "<td>"+'<%=dto.getInq_update()%>'+"</td>";
							tableStr += "<td>"+'<%=dto.getInq_state()%>'+"</td>";
							tableStr += "</tr>";
							
						<%}//for
					}//if%>
				$("tbody").html(tableStr);	
				
				//전체목록 끝
				
				//모달창
		//띄워주는 창
		const btn = $('tr');
		const modal = $('#modalWrap');
		const closeBtn = $('#closeBtn');
		
		btn.onclick = function() {
		  modal.style.display = 'block';
		}
		closeBtn.onclick = function() {
		  modal.style.display = 'none';
		}
		
		window.onclick = function(event) {
		  if (event.target == modal) {
		    modal.style.display = "none";
		  }
		}
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
                                            <th>번호</th>
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
				       
				        <p>제목</p>
				         <hr>
				           	작성자 일시<br>
				         <hr>
				         	내용
				         <hr>
				         
				         
				         <textarea id="csAnswer" placeholder="답변 입력">
				         </textarea>
				         <a href="#">파일</a>
				         <a href="#">파일</a><br>
				         <div class="d-flex flex-row-reverse">
				<button type="button" id="answerBtn"class="btn btn-secondary p-2">작성하기</button>
			</div>
			        </div><!-- modalBody -->
		        </div><!-- modalContent -->
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
