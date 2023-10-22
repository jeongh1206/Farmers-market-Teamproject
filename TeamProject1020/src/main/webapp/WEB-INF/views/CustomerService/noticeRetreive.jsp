<%@page import="com.example.dto.noticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<!--부트 스트랩 css-->
	<link type = "text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!--부트 스트랩 js-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="../resources/css/csMain.css"/>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

</head>
<body>   
  <%if(request.getAttribute("notice")==null){
	  session.setAttribute("mesg", "공지사항이 없습니다.");
      //null일때%>
		<script>
		location.href="/app/noticeUI";</script>
  <%}else{//null일때는 공지사항 목록으로 돌아감
		noticeDTO dto = (noticeDTO)request.getAttribute("notice");%>
   			 
<jsp:include page="../common/top.jsp" flush="true"/> <br>
       
         <jsp:include page="csMenu.jsp" flush="true"/> <br>
        
        <div class="col-sm-8 divCsMain">
       
			    			
			      		
       		<div><span class="textTitle" style="margin:auto;"><b>공지사항</b></span></div><br>
       		<div><span class="textTitle" style="margin:auto;"><%=dto.getTitle() %></span></div><br>
      		
      		<div class="csTable">
	      		<table class='table'>
		      	<tr>
			      	<th>작성자:<%=dto.getWriter() %> </th>
			      	<th>등록일: <%=dto.getRegDate()	 %></th>
		      	</tr>
		      	<tr>
		      		<td colspan="2">
			      	<%=dto.getContent() %>	
		      		</td>
		      	</tr>
		      	</table>
      		</div><!-- table관련 div -->
      		
      		 <button type="button" class="col-sm-1 btn btn-success" onclick="location.href='/app/cs/notice'">
                	목록
              </button>
      <!-- 여유가 되면 이전글 다음글 -->
        </div><!--csMain row-->
    </div><!--csBody row-->
   
	<jsp:include page="../common/bottom.jsp" flush="true"/> <br>
	<%} %>
</body>
</html>