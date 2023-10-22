<%@page import="com.example.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" /> -->
<!-- <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" /> -->

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/top.css" />
<link href="<%=request.getContextPath()%>/resources/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/search.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
$(function() {
	$("#cart").on("click",function(){ // 장바구니 버튼 이벤트 
		$(location).attr("href","cart");
	})
})
</script>

<link rel="stylesheet" href="https://res.kurly.com/_next/static/css/d59287ec5b86dc49.css" data-n-g />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/top.css" />

<div class="top_fixed"> 
   <div id="__next" data-reactroot>
         <div class="css-t79vuj e15sbxqa2"> 
            <div class="css-fexq9b eo7pjfk4">
               <%if(session.getAttribute("login")==null){%>
	               <div class="css-xygizb eo7pjfk22">
	                  <a class="css-xygizb eo7pjfk2" href="/app/register/addBuyerUI">회원가입</a>&nbsp;&nbsp;
	               </div>

	               <div class="css-xygizb eo7pjfk22">
	                  <a class="css-xygizb eo7pjfk2" href="/app/login/UI">로그인</a>&nbsp;&nbsp;
	               </div>
            	<%	}else{//로그인 시 뿌릴 정보
				UserDTO user = (UserDTO)session.getAttribute("login");%>
					<div class="css-xygizb eo7pjfk22">
						<a class="css-xygizb eo7pjfk2" href="/app/logout">로그아웃</a>&nbsp;&nbsp;
					</div>
					<sec:authorize access="hasAnyRole('ROLE_USER')">
					<div class="css-xygizb eo7pjfk22">
						<a class="css-xygizb eo7pjfk2" href="myPage">마이페이지</a>&nbsp;&nbsp;
					</div>
					</sec:authorize>
					<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
					<div class="css-xygizb eo7pjfk22">
						<a class="css-xygizb eo7pjfk2" href="">관리자 페이지</a>&nbsp;&nbsp;
					</div>
					</sec:authorize>					
					<div class="css-xygizb eo7pjfk22">
						<a class="css-xygizb eo7pjfk2" href="orderList">주문조회</a>&nbsp;&nbsp;
					</div>
				<%}%>
					<div class="css-xygizb eo7pjfk22">
	                  <a class="css-xygizb eo7pjfk2" href="cs/notice">공지사항</a>&nbsp;&nbsp;
	               </div>
            </div>
<!-- 여기까지 로그인 경우에 따라 회원가입/ 로그인 / 로그아웃 / 마이페이지 / 주문조회 -->
            <div class="css-r7wmjj e15sbxqa3"> <!--  여기부터 로고, 검색창, 찜목록, 장바구니  -->
               <div class="css-boc80u ekdqe1a2">
                  <img src="<%=request.getContextPath()%>/resources/img/logo.png" width="100" aria-label="로고"/>
                  <button onclick="location.href='/app/main'" class="active css-j0ug0x ekdqe1a1">파머스 마켓</button>
               </div>
            <div class="css-pqw0uk e1493ofl4">
                  <div class="css-w444a2 e1493ofl1">
                  	<form name="frmSearch" action="searchGoods" >
                  		<input id="gnb_search" name="searchWord" placeholder="검색어를 입력" 
                  		class="css-11ntk83 e1493ofl3" onkeyup="keywordSearch()" aria-label="검색창"/>
                     	<button class="css-ywxmlw e1493ofl0" id="searchBtn" aria-label="돋보기버튼"></button>
                     	</form>
                     	<div id="suggest" class="searchSuggest" style="display: none">
							<div id="suggestList"></div>
						</div>
            </div>
            <div class="css-pqw0uk e15sbxqa1">
            	<div class="css-c4pbxv e15sbxqa0">
            		 <button class="css-231fw3 etxxzpc0" aria-label="찜목록" ></button>&nbsp;&nbsp;
                     <button class="css-g25h97 e14oy6dx1" aria-label="장바구니" id="cart">
                    	 <%if(session.getAttribute("login") != null){//로그인한 경우 카트에 담긴 상품갯수 출력%>
                         <span class="css-testaaa">40</span>
                         <%}%>
                     </button>&nbsp;&nbsp;
                </div>
            </div>
               </div>
            </div> <!--  여기까지 로고, 검색창, 찜목록, 장바구니  -->
         </div> <!-- 여기까지 로그인 경우에 따라 보여줄 버튼 + 기본 버튼 -->
   </div>
   
	<div style="background-color : white;">
		<div class="dropdown">
		    <button class="dropbtn"><span class="dropbtn_icon">전체 카테고리</span></button>
		    <div class="dropdown-content">
		        <a href="productList">고기</a>
		        <a href="#">생선</a>
		        <a href="#">야채</a>
		        <a href="#">야채</a>
		        <a href="#">야채</a>
		        <a href="#">야채</a>
		    </div>
		</div>
		<div class="dropdown">
		    <button class="dropbtn"> 
		        <span class="dropbtn_icon">이달의 베스트</span>
		    </button>
<!-- 		    <div class="dropdown-content"> -->
<!-- 		        <a href="#">profile</a> -->
<!-- 		        <a href="#">write a post</a> -->
<!-- 		        <a href="#">settings</a> -->
<!-- 		    </div> -->
		</div>
		<div class="dropdown">
		    <button class="dropbtn"> 
		        <span class="dropbtn_icon">지역특산물</span>
		    </button>
<!-- 		    <div class="dropdown-content"> -->
<!-- 		        <a href="#">profile</a> -->
<!-- 		        <a href="#">write a post</a> -->
<!-- 		        <a href="#">settings</a> -->
<!-- 		    </div> -->
		</div>
		<div class="dropdown">
		    <button class="dropbtn"> 
		        <span class="dropbtn_icon">상품후기</span>
		    </button>
<!-- 		    <div class="dropdown-content"> -->
<!-- 		        <a href="#">profile</a> -->
<!-- 		        <a href="#">write a post</a> -->
<!-- 		        <a href="#">settings</a> -->
<!-- 		    </div> -->
		</div>
		<div class="dropdown">
		    <button class="dropbtn"> 
		        <span class="dropbtn_icon">지역커뮤니티</span>
		    </button>
<!-- 		    <div class="dropdown-content"> -->
<!-- 		        <a href="#">profile</a> -->
<!-- 		        <a href="#">write a post</a> -->
<!-- 		        <a href="#">settings</a> -->
<!-- 		    </div> -->
		</div>
		<div class="dropdown">
		    <button class="dropbtn" onclick="location.href='cs'"> 
		       <span class="dropbtn_icon">고객센터</span>
		    </button>
		    <div class="dropdown-content">
		        <a href="/app/cs/notice">공지사항</a>
		        <a href="#">1:1문의</a>
		        <a href="#">aa</a>
		    </div>
		</div>
	</div>
	
</div> <!-- 여기까지 메인 최상단에 고정 -->


