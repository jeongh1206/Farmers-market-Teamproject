<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>카테고리</title>
	<link rel="stylesheet" href="https://res.kurly.com/_next/static/css/d59287ec5b86dc49.css" data-n-g />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<link rel="stylesheet" href="resources/css/cart.css">
	<link href="https://www.flaticon.com/free-icons/tool-tips" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
	<link rel="stylesheet" href="resources/css/toast.css">
<!-- <body> -->
	<div class="css-1pz4b76 er0tf675">
		<h2 class="css-1n2hipb er0tf674">신상품</h2>

		<div class="css-a6t9xs er0tf673">
<!-- 			<div class="css-8wfj4z er0tf672"> -->
			<div class="">
				<div class="css-20o6z0 e149z643">
					<div class="css-zbxehx e149z642">
						<label class="css-1vf8o8s e1dcessg3"> 
							<input type="checkbox" class="css-agvwxo e1dcessg2">
							<span style="color:rgb(51, 51, 51); ">필터</span>
						</label>
						<span class="css-454d5e e149z641"></span>
						<button class="css-0 e149z640">초기화</button>
					</div>
					
					<div class="css-zbxehx e149z642" style="margin-right: 50px;">
						<button class="css-0 e149z640" id="newProduct" onclick="reloadProduct(this.id)">신상품순</button>
						<span class="css-454d5e e149z641"></span>
						<button class="css-0 e149z640" id="manyProduct" onclick="reloadProduct(this.id)">판매량</button>
						<span class="css-454d5e e149z641"></span>
						<button class="css-0 e149z640" id="lowSalProduct" onclick="reloadProduct(this.id)">낮은가격순</button>
						<span class="css-454d5e e149z641"></span>
						<button class="css-0 e149z640" id="highSalProduct" onclick="reloadProduct(this.id)">높은가격순</button>
					</div>
				</div>
				
				<div id="productListData"> </div>
				
			</div>
			<div class="css-1dta0ch er0tf671">
				<div class="css-50ad8x er0tf670" id="pet">
					<div class="css-1t6so8j em21elb0">
						<div class="css-8jmoub ea1mry77">
							<span class="css-vmo0an ea1mry76">상품금액</span>
							<span class="css-iinokh ea1mry74" id="salVal"> 0
 							<span class="css-hfgifi ea1mry72">원</span>
							</span>
						</div>
						<div class="css-t4mc5m ea1mry77">
							<span class="css-vmo0an ea1mry76">상품할인금액</span> <span
								class="css-iinokh ea1mry74"> 0<span
								class="css-hfgifi ea1mry72">원</span>
							</span>
						</div>
						<div class="css-7ygxxm eepcpbj4">
							<span class="css-vmo0an eepcpbj3">결제예정금액</span>

							<span class="css-da7gr8 eepcpbj2">
								 <strong class="css-xmbce4 eepcpbj0">0</strong>
								 <span class="css-aro4zf eepcpbj1">원</span>
							</span>
						</div>
					</div>

					<div class="css-8qz8ia e1mybczi1">

						<button class="css-fwelhw e4nu7ef3" type="button" onclick="" height="56">
							<span class="css-13budib e4nu7ef1">구매하기</span>
						</button>
						<ul class="css-19kxq7d">
							<li class="css-1741abm ejr204i0">[주문완료] 상태일 경우에만 주문 취소 가능합니다.</li>
							<li class="css-1741abm ejr204i0">[파머스 &gt;주문내역 상세페이지] 에서 직접 취소하실 수 있습니다.</li>
						</ul>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		
		var productList = [];
		var cartList = [];
		var salMoney = 0;
		
		//화면 진입시 호출하는 이벤트 모음
		$(document).ready(function() {
			getProductList();
		});
		
		function over(val) {
			var target = document.getElementsByName("tooltip-text"+val)[0];
			target.style='display:block;'
			target.classList.remove("tooltip-text:before");
			target.classList.add("tooltip-text");
		}
		
		function leave(val) {
			var target = document.getElementsByName("tooltip-text"+val)[0];
			target.style='display:none;'
			target.classList.add("tooltip-text:before");
			target.classList.remove("tooltip-text");

		}
		
		//페이지 이동, 테스트중 
		function movePage() {
// 			location.href='http://localhost:8093/app/main';
		};
		
		//상품리스트 출력
		function getProductList(val){
			//상품리스트 초기화
// 			$("#productListData").html();
			
			var setParam = {};
			if(val != null){
				setParam.filter = val; 
			}
			//리스트 
			$.ajax({
				type : "POST",
				url : "getProductList",
				dataType : "json",
				data : setParam,
				success : function(rdata, status, xhr) {
					productList = rdata.productList;
					if(rdata.cartList != null){
						cartList = rdata.cartList;
					}
					
					rdata = rdata.productList;
						
					console.log("리스트받아와지나 : "+rdata);
					
					//전체 DIV태그를 만드는 변수
					var productDiv = "";
					//상품 스타일
					var productStyle = "border-radius:5px; width:23%; height:380px; float: left; margin-right: 5px; margin-left: 5px;";
					//상품 담기 스타일
					var productSaveStyle = "text-align: center; border-radius:5px; width:100%; height:12%; float: left; margin:5px; padding: 10px 15px 15px 5px;";
					var productSaveStyle2 = "text-align: center; border-radius:5px; width:27%; height:12%; float: left; margin:5px; padding: 10px 15px 15px 5px;";
					var productSaveStyle3 = "text-align: center; border-radius:5px; width:25%; height:12%; float: left; margin:5px; padding: 10px 15px 15px 5px;";
					
					var bool = true;
					//전체 상품에 대한 루프
					for (var i = 0; i < rdata.length; i++) {
						productDiv += "<div class='css-1t6so8j em21elb0' style='"+productStyle+"'>";
						if(rdata[i].PRODUCT_NAME.length >= 13){
							productDiv += "<div class='tooltip-container'>";
							productDiv += "<p class='tooltip-text' name='tooltip-text"+i+"' style='display:none;'>"+rdata[i].PRODUCT_NAME+"</p>";
							productDiv += "<p name='tooltip-button"+i+"' onmouseleave='leave("+i+")' onmouseover='over("+i+")'>"+rdata[i].PRODUCT_NAME.substr(0,13)+"..."+"</p>";
							productDiv += "</div>";
						}else{
							productDiv += rdata[i].PRODUCT_NAME;
						}
						var productCd = "'"+rdata[i].PRODUCT_CODE+"'";
						//잠시 테스트
// 						productDiv += '<img src="resources/images/items/'+rdata[i].PRODUCT_IMG+'.gif" border="0" align="center" onclick="productDetail('+productCd+')" width="200">';
						productDiv += '<img src="'+rdata[i].PRODUCT_IMG+'" border="0" align="center" onclick="productDetail('+productCd+')" width="200">';
						
						if(cartList.length != 0){
							for (var j = 0; j < cartList.length; j++) {
								if(rdata[i].PRODUCT_CODE == cartList[j].PRODUCT_CODE){
									productDiv += '<div id=div'+i+'>';
									productDiv += "<div class='css-1t6so8j em21elb0' style='"+productSaveStyle2+"'>";
// 									productDiv += "<img src='resources/img/cha.png' style='width:30%;' >";
									var productPrice = "'"+rdata[i].PRODUCT_PRICE+"'";
									productDiv += '<button id=btn'+i+' style="center;" onclick="productSave('+productPrice+','+i+','+productCd+','+1+')"><img src="resources/img/icon-plus.svg"></button>';
									productDiv += "</div>";
									
									productDiv += "<div class='css-1t6so8j em21elb0' style='"+productSaveStyle3+"'>";
									productDiv += cartList[j].CART_COUNT;
									productDiv += "</div>";
									
									productDiv += "<div class='css-1t6so8j em21elb0' style='"+productSaveStyle2+"'>";
// 									productDiv += "<img src='resources/img/cha.png' style='width:30%;' >";
									productDiv += '<button id=btn2'+i+' style="center;" onclick="productSave('+productPrice+','+i+','+productCd+','+2+')"><img src="resources/img/icon-minus.svg"></button>';
									productDiv += "</div>";
									bool = false;
									break;
								}else{
									bool = true;
								}
							}
						}
						
						if(bool){
							productDiv += '<div id=div'+i+'>';
							productDiv += "<div class='css-1t6so8j em21elb0' style='"+productSaveStyle+"'>";
							productDiv += "<img src='resources/img/cha.png' style='width:10%;' >";
							var productPrice = "'"+rdata[i].PRODUCT_PRICE+"'";
							productDiv += '<button id=btn'+i+' style="center;" onclick="productSave('+productPrice+','+i+','+productCd+','+1+')">담기</button>';
							productDiv += "</div>";
							bool = true;
						}
						
						productDiv += '<div id="toast" name="toastNm'+i+'"> '+rdata[i].PRODUCT_NAME+'을 담았습니다.</div>';
						productDiv += "</div>";
// 						productDiv += "<span><p>"+rdata[i].PRODUCT_CONTEXT+"</p></span>";
						var price = rdata[i].PRODUCT_PRICE;
						productDiv += "<span><p>"+price.toLocaleString()+"원</p></span>";
						productDiv += "</div>";
					}
					$("#productListData").html(productDiv);
					
					var sumData = 0;
					for (var i = 0; i < rdata.length; i++) {
						for (var j = 0; j < cartList.length; j++) {
							if(rdata[i].PRODUCT_CODE == cartList[j].PRODUCT_CODE){
								sumData += rdata[i].PRODUCT_PRICE * cartList[j].CART_COUNT;
							}
						}
					}
					$("#salVal").text(sumData.toLocaleString());
					salMoney = sumData;
					
				}, 
				error : function(xhr, status, error) {
					console.log("error");
					return false;
				}
			});
		}
		

		// 장바구니
		 function productSave(val, numVal, proCd, status) {
			
         var setParam = {}
         setParam.product_code = proCd;       	//상품코드
         setParam.cart_count = 1;          		//숫자무조건 한개씩넘김 갯수를 조절하는 부분이 없기때문임
         <%if (session.getAttribute("login")==null){%>
            alert("로그인이 필요합니다");
            location.href='http://localhost:8093/app/login/UI';
            return false;
         <%}%>
         var status=status;
//          debugger;
         if(status == 1){
        	 status="cartAdd"
         }else{
        	 status="cartUpdate"
         }
         $.ajax({
            type : "POST",
//             url : "cartAdd",
            url : status,
            dataType : "text",
            data : setParam,
            success : function(rdata, status, xhr) {
               val = parseInt(val);
               salMoney += val;
               $("#salVal").text(salMoney.toLocaleString());
                     $.ajax({
                         type : "POST",
                         url : "getCartList",
                         dataType : "json",
                         data : {},
                         success : function(rdata, status, xhr) {
                        	 console.log(rdata);
                        	 var productSaveStyle = "text-align: center; border-radius:5px; width:30%; height:12%; float: left; margin:5px; padding: 10px 15px 15px 5px;";
                        	 var productSaveStyle2 = "text-align: center; border-radius:5px; width:25%; height:12%; float: left; margin:5px; padding: 10px 15px 15px 5px;";
                        	 var len = productList.length;
                        	 for (var i = 0; i < rdata.length; i++) {
                        		 var pdCd = rdata[i].PRODUCT_CODE;
                        		 var productDiv = "";
								 chk : for (var j = 0; j < len; j++) {
									 if(productList[j].PRODUCT_CODE == pdCd){
										 productDiv += "<div class='css-1t6so8j em21elb0' style='"+productSaveStyle+"'>";
// 										 productDiv += "<img src='resources/img/cha.png' style='width:30%;' >";
										 var productCd = "'"+rdata[i].PRODUCT_CODE+"'";
										 var productPrice = "'"+productList[j].PRODUCT_PRICE+"'";
										 productDiv += '<button id=btn'+j+' style="center;" onclick="productSave('+productPrice+','+j+','+productCd+','+1+')"><img src="resources/img/icon-plus.svg"></button>';
										 productDiv += "</div>";
										 
										 productDiv += "<div class='css-1t6so8j em21elb0' style='"+productSaveStyle2+"'>";
										 productDiv += rdata[i].CART_COUNT;
										 productDiv += "</div>";
											
										 productDiv += "<div class='css-1t6so8j em21elb0' style='"+productSaveStyle+"'>";
// 										 productDiv += "<img src='resources/img/cha.png' style='width:30%;' >";
										 productDiv += '<button id=btn2'+j+' style="center;" onclick="productSave('+productPrice+','+j+','+productCd+','+2+')"><img src="resources/img/icon-minus.svg"></button>';
										 productDiv += "</div>";
										 
										 productDiv += '<div id="toast" name="toastNm'+j+'"> '+productList[j].PRODUCT_NAME+'을 담았습니다.</div>';
										 productDiv += "</div>";
										 $("#div"+j).html(productDiv);
										 productDiv = "";
										 break chk;
									 }
								 }
							}
                        	 var showId = "toastNm"+numVal;
                             // 아래 테스트중 상품담으면 토스트 메세지 on
                             const toast = document.getElementsByName(showId);
                             let isToastShown = false;
                             if (isToastShown) return;   // 토스트 메시지가 띄어져 있다면 함수를 끝냄
                             isToastShown = true;
                             var addClass = toast[0];
                             addClass.classList.add('show');    // show라는 클래스를 추가해서 토스트 메시지를 띄우는 애니메이션을 발동시킴
                             setTimeout(function () {
                                 // 2700ms 후에 show 클래스를 제거함
                                 addClass.classList.remove('show'); 
                                 isToastShown = false;
                             }, 2700);
                         }, 
                         error : function(xhr, status, error) {
                            console.log("error");
                            return false;
                         }
                      });
               
            }, 
            error : function(xhr, status, error) {
               console.log("error");
               return false;
            }
         });
      };
		
      
      	function commonProductSave(url) {
			
		}
      	
		// 필터값 new/many/high/low, 중에 하나 받아서 리스트 출력
		function reloadProduct(id){
			var param = "";
			if(id == "manyProduct"){
				param = "many";
			}else if(id == "lowSalProduct"){
				param = "low";
			}else if(id == "highSalProduct"){
				param = "high";
			}
			getProductList(param);
		}
		
		//테스트중
		function productDetail(val) { 
			var param = val;
			location.href="productDetails?product_code="+param;
		};
		
		
	</script>
<!-- </body> -->

</html>