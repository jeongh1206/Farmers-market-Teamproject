<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.dto.CartProductDTO"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>장바구니</title>
<link rel="stylesheet"
	href="https://res.kurly.com/_next/static/css/d59287ec5b86dc49.css"
	data-n-g />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link rel="stylesheet" href="resources/css/cart.css">
<script>
	//결제 예정
	$(function() {
		var list = $(".sum1");
		var listSum = 0;
		for (var i = 0; i < list.length; i++) {
			listSum += parseInt(list[i].innerText) //태그들이 들어있음
		}
		$("#orderPrice").text(listSum);
		$("#orderPrice1").text(listSum);

		//수량변경
		$(".plus1").on("click", function() {
			var data = $(this).attr("data-xxx");
			var amount = parseInt($("#price-txt" + data).text());
			var gPrice = $("#gPrice").text();
			amount++;
			$.ajax({
				url : 'cartUpdate',
				type : 'get',
				dataType : 'text',
				data : {
					CART_NO : data, //카트 넘버
					CART_COUNT : amount
				},
				success : function(data, status, xhr) {
					$("#price-txt" + data).text(amount); //수량
					var sum = amount * gPrice;
					console.log(sum);
					$("#sum").text(sum);
// 					$("#orderPrice").text(sum);
					location.reload(true);
				},
				error : function(xhr, status, error) {
				}
			});//end ajaxgkgk
		});
		$(".minus1").on("click", function() {
			var data = $(this).attr("data-xxx");
			var amount = parseInt($("#price-txt" + data).text());
			var gPrice = $("#gPrice").text();
			if (amount > 1) {
				amount--;
				$("#price-txt" + data).text(amount);
			}
			$.ajax({
				url : 'cartUpdate',
				type : 'get',
				dataType : 'text',
				data : {
					CART_NO : data, //카트 넘버
					CART_COUNT : amount
				},
				success : function(data, status, xhr) {
					$("#price-txt" + data).text(amount);
					var sum = amount * gPrice;
					$("#sum").text(sum);
// 					$("#orderPrice").text(sum);
					location.reload(true); //브라우저에 캐싱된게 있어서
				},
				error : function(xhr, status, error) {
				}
			});
		});

		//개별 삭제
		$(".delete").on("click", function() {
			var data = $(".delete").attr("data-xxx");
			console.log(data);
			$("#delNum").val(data);
			location.href="cartDel?delnum="+data;
		})
		//전체선택
		$("#allCheck").on("click", function() {
			if ($("#allCheck").prop("checked")) {
				console.log("....")
				$(".selectCheck").prop("checked", true);
			} else {
				$(".selectCheck").prop("checked", false);
			}
		});
		var selected = [];
		var selectCheck = $(".selectCheck");
		//전체 삭제
		$("#allDel").on("click", function() {
			for (var i = 0; i < selectCheck.length; i++) {
				console.log(selectCheck.length);
				if ($(".selectCheck").is(":checked")) {
					selected.push($(".selectCheck")[i].value);
				}
				$("#selC").val(selected);
			}

			$("#myForm").attr("action", "cartAllDel").submit();
		});
		//선택 삭제
		$("#selDel").on("click", function() {
			$("input[type=checkbox]:checked").each(function(){
				selected.push($(this).val());
			})
				console.log(selected);
			location.href="cartCheckDel?cartCheckNum="+selected;
		});
		//주문 페이지 이동
		$("#goOrder").on("click", function() {
			var cnt=0;
			$(".selectCheck:checked").each(function(){
				cnt++;
				selected.push($(this).val());
			})
			console.log(selected);
		//체크된 상품이 없으면 주문페이지로 안넘어가게 설정
			if(cnt==0){
				alert('주문할 상품을 체크하세요');
				return;	
			}
			$("#orderCart").val(selected);
			$("#myForm").attr("action","order");
			$("#myForm").attr("method","post");
			$("#myForm").trigger("submit");
		});

	})
</script>

</head>
<body>

	<div class="css-1pz4b76 er0tf675">
		<h2 class="css-1n2hipb er0tf674">장바구니</h2>
		<div class="css-a6t9xs er0tf673">
			<div class="css-8wfj4z er0tf672">
				<div class="css-20o6z0 e149z643">
					<div class="css-zbxehx e149z642">
						<label class="css-1vf8o8s e1dcessg3" disabled> <input
							type="checkbox" id="allCheck" value="text">&nbsp;&nbsp;전체선택
						</label>
					</div>
				</div>
				<div class="css-2lvxh7 ej77nku0">

					<%
						List<CartProductDTO> list = (List<CartProductDTO>) session.getAttribute("cartList");

						if (list.size() == 0) {
					%>
					<p class="css-l1lu2l eqymnpn0">장바구니에 담긴 상품이 없습니다</p>
					<tr>
						<td colspan="10">
							<hr size="1" color="CCCCCC">
						</td>

						<td height="30">
					</tr>

				</div>
				<div class="css-20o6z0 e149z643">
					<div class="css-zbxehx e149z642">
						<label class="css-1vf8o8s e1dcessg3" disabled> <input
							type="checkbox" disabled class="css-agvwxo e1dcessg2" />
							<div class="css-79hxr7 e1dcessg1">
								<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
									xmlns="http://www.w3.org/2000/svg">
                                <path
										d="M23.5 12C23.5 18.3513 18.3513 23.5 12 23.5C5.64873 23.5 0.5 18.3513 0.5 12C0.5 5.64873 5.64873 0.5 12 0.5C18.3513 0.5 23.5 5.64873 23.5 12Z"
										stroke="#ddd" fill="#f2f2f2"></path>
                                <path d="M7 12.6667L10.3846 16L18 8.5"
										stroke="#ddd" stroke-width="1.5" stroke-linecap="round"
										stroke-linejoin="round"></path>
                            </svg>
							</div> <span>전체선택 (0/0)</span>
						</label> <span class="css-454d5e e149z641"></span>
						<button disabled class="css-0 e149z640">선택삭제</button>
					</div>
				</div>
			</div>
			<div class="css-1dta0ch er0tf671">
				<div class="css-50ad8x er0tf670">
					<div class="css-1t6so8j em21elb0">
						<div class="css-8jmoub ea1mry77">
							<span class="css-vmo0an ea1mry76">상품금액</span> <span
								class="css-iinokh ea1mry74"> 0 <span
								class="css-hfgifi ea1mry72">원</span>
							</span>
						</div>
						<div class="css-t4mc5m ea1mry77">
							<span class="css-vmo0an ea1mry76">상품할인금액</span> <span
								class="css-iinokh ea1mry74"> 0<span
								class="css-hfgifi ea1mry72">원</span>
							</span>
						</div>
						<div class="css-t4mc5m ea1mry77">
							<span class="css-vmo0an ea1mry76">배송비</span> <span
								class="css-iinokh ea1mry74"> 0<span
								class="css-hfgifi ea1mry72">원</span>
							</span>
						</div>
						<div class="css-7ygxxm eepcpbj4">
							<span class="css-vmo0an eepcpbj3">결제예정금액</span> <span
								class="css-da7gr8 eepcpbj2"> <strong
								class="css-xmbce4 eepcpbj0">0</strong> <span
								class="css-aro4zf eepcpbj1">원</span>
							</span>
						</div>
					</div>

					<div class="css-8qz8ia e1mybczi1">

						<button class="css-fwelhw e4nu7ef3" type="button" height="56">

							<span class="css-13budib e4nu7ef1">로그인</span>
						</button>
						<ul class="css-19kxq7d">
							<li class="css-1741abm ejr204i0">[주문완료] 상태일 경우에만 주문 취소
								가능합니다.</li>
							<li class="css-1741abm ejr204i0">[마이컬리 &gt;주문내역 상세페이지] 에서 직접
								취소하실 수 있습니다.</li>
						</ul>
					</div>
					<!-- 					로그인 되었을 때 -->
					<%
						} else {
					%>
					<form id="myForm" action="#">
						<input type="hidden" name="delnum" value="" id="delNum"> 
						 <input type="hidden" name="selectCheck" value="" id="selC">
						 <input type="hidden" id="orderCart" name="cart_noList">
						<c:forEach var="x" items="${cartList}">
							<hr size="1" color="CCCCCC" />
							<tr>
								<td class="td_default" width="80">
									<!-- checkbox는 체크된 값만 서블릿으로 넘어간다.따라서 value에 삭제할 num값을 설정한다. -->
									<input class="selectCheck" type="checkbox" name="check"
									value="${x.getCart_no()}">
									<!-- 주문 클릭시 post 방식으로 넘길 데이터 -->

								</td>
								<td class="td_default" width="75"></td>
								<td class="td_default" width="75"><img
									src="${x.getProduct_img()}" border="0"
									align="center" width="80" /></td>
								<td class="td_default" width="300" style='padding-left: 30px'>
									${x.getProduct_name()}</td>

								<td>

									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button class="minus1" data-xxx="${x.getCart_no()}">
										<img src="resources/img/icon-minus.svg" />
									</button> <span id="price-txt${x.getCart_no()}">${x.getCart_count()}</span>

									<button class="plus1" data-xxx="${x.getCart_no()}">
										<img src="resources/img/icon-plus.svg" />
									</button> &nbsp;&nbsp;&nbsp;
								</td>
								<td class="td_default" align="center" width="110"><span
									id="gPrice">${x.getProduct_price()}</span>&nbsp;&nbsp;&nbsp;</td>
								<td><span id="sum" class="sum1">${x.getProduct_price()*x.getCart_count()}</span>
									&nbsp;&nbsp;&nbsp;
									<button class="delete" data-xxx="${x.getCart_no()}">삭제</button></td>
							</tr>
							<tr>
								<td colspan="10">
																<hr size="1" color="CCCCCC">
								</td>

								<td height="30"></td>
							</tr>
						</c:forEach>
					</form>
				</div>
				<div class="css-20o6z0 e149z643">
					<div class="css-zbxehx e149z642">

						<button id="allDel">전체삭제</button>
						<span class="css-454d5e e149z641"></span>
						<button id="selDel">선택삭제</button>
					</div>
				</div>
			</div>
			<div class="css-1dta0ch er0tf671">
				<div class="css-50ad8x er0tf670">
					<div class="css-1t6so8j em21elb0">
						<div class="css-8jmoub ea1mry77">
							<span class="css-vmo0an ea1mry76">상품금액</span> <span
								class="css-iinokh ea1mry74" id="orderPrice">0<span
								class="css-hfgifi ea1mry72">원</span>
							</span>
						</div>
						<div class="css-t4mc5m ea1mry77">
							<span class="css-vmo0an ea1mry76">상품할인금액</span> <span
								class="css-iinokh ea1mry74"> 0<span
								class="css-hfgifi ea1mry72">원</span>
							</span>
						</div>
						<div class="css-t4mc5m ea1mry77">
							<span class="css-vmo0an ea1mry76">배송비</span> <span
								class="css-iinokh ea1mry74"> 무료 </span>
						</div>
						<div class="css-7ygxxm eepcpbj4">
							<span class="css-vmo0an eepcpbj3">결제예정금액</span> <span
								class="css-da7gr8 eepcpbj2"> <strong
								class="css-xmbce4 eepcpbj0" id="orderPrice1">0</strong> <span
								class="css-aro4zf eepcpbj1">원</span>
							</span>
						</div>
					</div>

					<div class="css-8qz8ia e1mybczi1">

						<button id="goOrder" class="css-fwelhw e4nu7ef3" type="button" height="56">

							<span class="css-13budib e4nu7ef1">결제하기</span>
						</button>
						<ul class="css-19kxq7d">
							<li class="css-1741abm ejr204i0">[주문완료] 상태일 경우에만 주문 취소
								가능합니다.</li>
							<li class="css-1741abm ejr204i0">[마이컬리 &gt;주문내역 상세페이지] 에서 직접
								취소하실 수 있습니다.</li>
						</ul>
					</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>