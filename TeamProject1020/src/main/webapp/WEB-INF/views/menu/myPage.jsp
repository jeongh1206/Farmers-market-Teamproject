<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.example.dto.UserDTO"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>카테고리</title>
	<link rel="stylesheet" href="https://res.kurly.com/_next/static/css/d59287ec5b86dc49.css" data-n-g />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" 
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<link rel="stylesheet" href="resources/css/cart.css">
	<link href="https://www.flaticon.com/free-icons/tool-tips" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>

	<div class="css-1pz4b76 er0tf675">
		<h2 class="css-1n2hipb er0tf674">마이페이지</h2>

			<div class="css-8wfj4z3 er0tf672" style="float: left;">
				<div class="css-50ad82 er0tf670" id="pet">
					<div class="css-1t6so8j2 em21elb0">
						<div class="css-1t6so8j4">
							마이페이지
						</div>
<!-- 						한셋트 -->
						<div class="css-1t6so8j3">
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1" id="shopInfo" >쇼핑정보</span>  
							</div>
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1" id="buyInfo" >주문내역</span> 
							</div>
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1" id="giftInfo" >선물내역</span> 
							</div>
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1">취소/반품/교환</span> 
							</div>
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1" id="testInfo">찜상품</span> 
							</div>
						</div>
<!-- 						한셋트 -->
						<div class="css-1t6so8j3">
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1">나의활동</span> 
							</div>
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1">1:1문의</span> 
							</div>
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1">상품문의</span> 
							</div>
						</div>
						<div class="css-1t6so8j3">
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1">회원정보</span> 
							</div>
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1">포인트</span> 
							</div>
							<div class="css-8jmoub ea1mry77">
								<span class="css-vmo0an2 ea1mry76 mp1">상품권/예치금</span> 
							</div>
						</div>
					</div>

					<div class="css-8qz8ia e1mybczi1">
<!-- 						<button class="css-fwelhw e4nu7ef3" type="button" onclick="" height="56"> -->
<!-- 							<span class="css-13budib e4nu7ef1">구매하기</span> -->
<!-- 						</button> -->
						<ul class="css-19kxq7d">
<!-- 							<li class="css-1741abm ejr204i0">[주문완료] 상태일 경우에만 주문 취소 가능합니다.</li> -->
<!-- 							<li class="css-1741abm ejr204i0">[파머스 &gt;주문내역 상세페이지] 에서 직접 취소하실 수 있습니다.</li> -->
						</ul>
					</div>
				</div>
			</div>
			
			<!-- 카테고리 클릭시 아래 적용 -->
			<div style="float: left;">
				<iframe id="main_frame" src="" width="850px" height="850px">
					<p>사용 중인 브라우저는 iframe을 지원하지 않습니다.</p>
				</iframe>
			</div>
			
	</div>
	    <div class="quickMenuWrap"> 
            <button type="button" onclick="chat()">
               	<img src="resources/img/cha.png" style="width:50px;" >
			</button>
       		<button onclick="gotoScrollTop()">
            	<img src="resources/img/GoTop.png" style="width:50px; hight:50px;" >
        	</button>
    	</div>
	
	
	
	
	<script type="text/javascript">
		
		//화면 진입시 호출하는 이벤트 모음
		$(document).ready(function() {
			
// 			if(window.localStorage.getItem('testname') != null){
// 				const testname = window.localStorage.getItem('testname');
// 				alert(testname);
// 			}
			 
// 			contentSet("shopInfo");
			// 카테고리 이벤트 모음
			$('.mp1').on({
				mouseover: function(){ 
					$(this).css({"color":"red", "font-size":"30px"});
			    },
				mouseout: function(){ 
					$(this).css({"color":"","font-size":""});
				},
				click: function(){ 
					var param="";
					var id=$(this).attr('id');
					
					if(id == "shopInfo"){
		 				param = "https://www.youtube.com/embed/P6u4Gb4Vhyk";
					}else if(id == "buyInfo"){
						param = "";
					}else if(id == "testInfo"){
// 						param = "menu/productList";
						param = "productList?keyword=ifm";
					}
					setContentLink(param);
				}
			});
			
		});
		function setContentLink(param){
			document.getElementById("main_frame").src = param;
		}
		// 컨텐트 클릭시 이벤트인데 태그에 이벤트 여러개 걸어야 해서 그냥 위로 올렸음.
// 		function contentSet(id){
// 			var param = "";
// 			if(id == "shopInfo"){
// 				param = "https://www.youtube.com/embed/P6u4Gb4Vhyk";
// 			}else if(id == "buyInfo"){
// 				param = "#";
// 			}else if(id == "go"){
// 				param="#";
// 			}
// 			setContentLink(param);
// 		}
		
		
		function gotoScrollTop() {
	    	$('html, body').animate({ scrollTop: '0' }, 0);
		};
		function chat(){ 
			 <%if(session.getAttribute("login")==null){%>
			 alert("로그인이 필요");
			 <%}else{
					UserDTO user = (UserDTO)session.getAttribute("login");%>
					window.open('room','window_name', 'width=680, height=690, location=no, status=no, scrollbars=yes');
			<%}%>
		};
		
		
	</script>


</html>