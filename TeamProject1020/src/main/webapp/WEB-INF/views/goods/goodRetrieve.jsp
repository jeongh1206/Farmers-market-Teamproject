<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.example.dto.ProductDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상세페이지</title>
<link href="resources/css/page.css" rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Kumbh+Sans:wght@400;700&display=swap"
	rel="stylesheet" />
<link rel="icon" type="image/png" sizes="32x32"
	href="./images/favicon-32x32.png" />
<script>

    $(function() {
    var $tabButtonItem = $('#tab-button li'),
    $tabSelect = $('#tab-select'),
    $tabContents = $('.tab-contents'),
    activeClass = 'is-active';

    $tabButtonItem.first().addClass(activeClass);
    $tabContents.not(':first').hide();

    $tabButtonItem.find('a').on('click', function(e) {
    var target = $(this).attr('href');

    $tabButtonItem.removeClass(activeClass);
    $(this).parent().addClass(activeClass);
    $tabSelect.val(target);
    $tabContents.hide();
    $(target).show();
    e.preventDefault();
});
        
    $("#plus").on("click",function(){
		 var amount= parseInt( $(".price-txt").text());
			 amount++
			$(".price-txt").text(amount)

   	})//수량 증가
   	
	$("#minus").on("click",function(){
		 var amount= parseInt( $(".price-txt").text());
			if(amount>1){
			 amount--
				$(".price-txt").text(amount)
			}
	})//수량 감소
	
	$("#cartAdd").on("click",function(){
		console.log("장바구니");
		<%if (session.getAttribute("login")==null){%>
		alert("로그인이 필요합니다");
		<%}else{%>
		 var gAmount= $(".price-txt").text();	
		 console.log(gAmount);
		 //수량 hidden태그의 value에 amount 설정
		 $("#gAmount").val(gAmount);
		 //form.action
		 //폼 서브밋 이벤트 발생 
		$("#cartForm").attr("action","cartAdd").submit(); //액션은 주소만
	<%}%>
	})//장바구니 담기
	
	//구매하기(주문페이지로 이동)
	$("#orderOne").on("click",function(){
		<%if (session.getAttribute("login")==null){%>
		alert("로그인이 필요합니다");
		<%}else{%>
		 var gAmount= $(".price-txt").text();	
		 console.log(gAmount);
		 //수량 hidden태그의 value에 amount 설정
		 $("#gAmount").val(gAmount);
		 //form.action
		 //폼 서브밋 이벤트 발생 
		$("#cartForm").attr("method","post"); //post방식
		$("#cartForm").attr("action","order").submit(); //액션은 주소만
	<%}%>
	})//장바구니 담기
          
  });//doc

  </script>
<c:if test="${!empty addNum }">
<script>
alert("장바구니에 상품을 담았습니다");
</script>
</c:if>
<% session.removeAttribute("addNum"); %>
</head>

<body>

	<div class="overlay-container">
		<div class="item-overlay">
			<button class="item-overlay__btn">
				<img src="images/icon-close.svg" alt="close image"
					class="item-overlay__btn-img" />
			</button>
			<div class="item-overlay__mainImg">
				<img src="images/image-product-1.jpg" alt=""
					class="item-overlay__img" />
				<button class="item-overlay__btnlft overlay-btn">
					<img src="images/icon-next.svg" alt="next symbol image"
						class="item-overlay__btnlft-img overlay-btn__img" />
				</button>
				<button class="item-overlay__btnrgt overlay-btn">
					<img src="images/icon-next.svg" alt="next symbol image"
						class="item-overlay__btnrgt-img overlay-btn__img" />
				</button>
			</div>
			<div class="overlay-img__btns">
				<button class="overlay-img__btn" data-img="0">
					<img src="images/image-product-1-thumbnail.jpg"
						alt="shoe product image" class="overlay-img__btn-img" />
				</button>
				<button class="overlay-img__btn" data-img="1">
					<img src="images/image-product-2-thumbnail.jpg"
						alt="shoe product image" class="overlay-img__btn-img" />
				</button>
				<button class="overlay-img__btn" data-img="2">
					<img src="images/image-product-3-thumbnail.jpg"
						alt="shoe product image" class="overlay-img__btn-img" />
				</button>
				<button class="overlay-img__btn" data-img="3">
					<img src="images/image-product-4-thumbnail.jpg"
						alt="shoe product image" class="overlay-img__btn-img" />
				</button>
			</div>
		</div>
	</div>
	
	<!-- 메인 -->
	
	<main class="item">
		<section class="img">
			<img src="${product.product_img}" alt=""
				class="img-main" width="450" height="450" />

			<h4 align="center">함께 구매하면 좋은 상품</h4>
			<div class="img-btns">
				<button class="img-btn">
					<img
						src="https://oasisproduct.cdn.ntruss.com/73618/detail/detail_73618_0_58322493-dfc6-4f2b-9104-f199edf6efa4.jpg"
						alt="" class="img-btn__img" />
				</button>
				<button class="img-btn">
					<img
						src="https://oasisproduct.cdn.ntruss.com/66866/detail/detail_66866_0_3f6b3885-a937-47c3-8caf-1ed2b3361927.jpg"
						alt="" class="img-btn__img" />
				</button>
				<button class="img-btn">
					<img
						src="https://oasisproduct.cdn.ntruss.com/73615/detail/detail_73615_0_c29c6fb2-0a7b-44c0-8786-ec1f1a3cf8b8.jpg"
						alt="" class="img-btn__img" />
				</button>
				<button class="img-btn">
					<img
						src="https://oasisproduct.cdn.ntruss.com/77445/detail/detail_77445_0_74778106-0238-4e0e-bcc0-a3ff89a3cffe.jpg"
						alt="" class="img-btn__img" />
				</button>
			</div>
		</section>



		<section class="price">
			<h2 class="price-sub__heading">Farmer's Market Delivery</h2>
			<h1 class="price-main__heading">${product.product_name}</h1>
			<dl>
				<div>
					<dt>보관방법</dt>
					<dd>냉장</dd>
				</div>
				<div>
					<dt>판매단위</dt>
					<dd>1팩</dd>
				</div>
				<dt>중량/용량</dt>
				<dd>200g내외</dd>
				<div>
					<dt>원산지</dt>
					<dd>상품설명/상세정보 참조</dd>
				</div>
				<div>
					<dt>유통기한</dt>
					<dd>농산물은 별도의 유통기한이 없으므로 빠른 시일내 섭취를 권장드립니다.</dd>
				</div>
				<div>
					<dt>배송</dt>
					<dd>무료배송</dd>
				</div>
			</dl>

			<div class="price-box">
				<div class="price-box__main">
					<span class="price-box__main-new">가격 ${product.product_price}원
					</span> <span class="price-box__main-discount"> 할인%</span>
				</div>
				<span class="price-box__old">할인금액 원</span>
			</div>

			<div class="price-btnbox">
				<div class="price-btns">

					<button id="minus">
						<img src="resources/img/icon-minus.svg" />
					</button>
				    <span class="price-txt" id="amount">1</span>
						<button id="plus">
						<img src="resources/img/icon-plus.svg" />
					</button>

				</div>

				<button id="cartAdd" class="price-cart__btn btn--orange">
					<img src="resources/img/icon-cart.svg" alt="cart image"
						class="price-cart__btn-img" /> 장바구니 담기
				</button>
				<button class="heart_btn" type="button">
					<img src="resources/img/heart.png" alt="heart image" width="45"
						height="45" />
				</button>
				<!-- 바로 구매하는 경우 -->
				<button id="orderOne" class="price-cart__btn btn--orange">구매하기</button>
			</div>

		</section>
	</main>
	<form action="" id="cartForm">
		<input type="hidden" name="product_img"  value="${product.product_img}"> 
	    <input type="hidden" name="product_code"  value="${product.product_code}">
<%-- 	    <input type="hidden" name="product_price" value="${product.product_price}"> --%>
	  	<input type="hidden" name="cart_count" value="" id="gAmount">
	    <input type="hidden" name="product_name"  value="${product.product_name}">
	    <input type="hidden" name="product_context"  value="${product.product_context}">
<%-- 	    <input type="hidden" name="cart_no"  value="${cart_no}"> --%>
	</form>
<!--css가 깨져서 폼을 main 밖에 만들었음 -->
	<hr>

	<div class="tabs">
		<div class="tab-button-outer">
			<ul id="tab-button">
				<li><a href="#tab01">상품설명</a></li>
				<li><a href="#tab02">상품상세정보</a></li>
				<li><a href="#tab03">후기</a></li>
				<li><a href="#tab04">문의</a></li>
			</ul>
		</div>


		<div id="tab01" class="tab-contents" align="center">
			<img src="">
		</div>

		<div id="tab02" class="tab-contents"></div>

		<div id="tab03" class="tab-contents">
			<h2>상품후기</h2>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>고객만족도</th>
						<th>구매후기</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>별점</td>
						<td>글내용</td>
						<td>아이디**</td>
						<td>2023.9.11</td>
					</tr>
					<tr>
						<td>별점</td>
						<td>글내용</td>
						<td>아이디**</td>
						<td>2023.9.11</td>
					</tr>
					<tr>
						<td>별점</td>
						<td>글내용</td>
						<td>아이디**</td>
						<td>2023.9.11</td>
					</tr>
				</tbody>
			</table>
			<a class="btn btn-default pull-right">글쓰기</a>
			<div class="text-center">
				<ul class="pagination">
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
				</ul>
			</div>
			<div class="panel-body">
				<div class="tab-content">
					<div class="tab-pane fade" id="tab1default">상품정보</div>
					<div class="tab-pane fade" id="tab2default">상품상세정보</div>
					<div class="tab-pane fade" id="tab3default">후기</div>
					<div class="tab-pane fade" id="tab4default">문의</div>
				</div>
			</div>
		</div>

		<div id="tab04" class="tab-contents">
			<h2>상품문의</h2>
			<div class="review-write">
				<span>총</span> <span class="number" id="num">0</span> &nbsp;개의 상품
				문의가 작성되었습니다.
				<table class="table table-striped">
					<thead>
						<tr>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>답변상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>비밀글입니다.</td>
							<td>아이디**</td>
							<td>2023.9.11</td>
							<td>답변대기</td>
						</tr>
						<tr>
							<td>비밀글입니다.</td>
							<td>아이디**</td>
							<td>2023.9.11</td>
							<td>답변대기</td>
						</tr>
						<tr>
							<td>비밀글입니다.</td>
							<td>아이디**</td>
							<td>2023.9.11</td>
							<td>답변대기</td>
						</tr>
					</tbody>
					<button type="button" class="writeButton pull-right">상품문의
						등록</button>
				</table>
				<div class="text-center">
					<ul class="pagination">
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
					</ul>
				</div>
			</div>
			<div>
				<ul>
					<li>상업성 홍보글, 미풍양속을 해치는 글, 특정병명의 노출 등 상품 문의 외 취지에 어긋나는 글은 삭제될 수
						있으므로 양해바랍니다.</li>
					<li>파머스마켓의 상세한 답변이 필요한 배송, 교환 / 반품, A/S, 주소지변경, 추가 요구 사항 등은
						파머스마켓 고객센터(1:1문의)를 이용 하시면 답변을 받으실 수 있습니다.</li>
				</ul>
			</div>
		</div>

	</div>

</body>
</html>
