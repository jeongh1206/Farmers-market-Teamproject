<%@page import="java.util.List"%>
<%@page import="com.example.dto.ProductDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="resources/js/order.js"></script>
<style type="text/css">
    .warning {
        color: red;
    }
        body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        margin: 0;
        padding: 0;
    }
    section#content {
        max-width: 900px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        border-radius: 5px;
    }
        .orderConfirm {
        margin-top: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        padding: 10px;
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
    }

    .label_deduct {
        font-size: 14px;
        color: #555;
    }

    .title {
        font-size: 18px;
        font-weight: bold;
        margin-top: 20px;
    }    
 
</style>

<!-- 주문 결제 페이지 -->
<!-- 편의점 이름 order_addr1, 편의점 번호 order_addr2에 저장-->
<body>
<section id="content">
<div class="orderConfirm">
<!--  상품 리스트 개수 저장 -->
<input type="hidden" id="pSize" value="${cDTO.size()}">
<table>
    <tbody><tr>
      <td>상품 이미지</td>
      <td>상품명</td>
      <td>가격</td>
      <td>수량</td>
    </tr>
<c:forEach var="x" items="${cDTO}" varStatus="status">
		<c:choose>
			<c:when test="${status.first}"><input type="hidden" id="firstName" value="${ x.product_name }"></c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
<tr><td><img src="${x.product_img}" width="200">
</td><td>
<a href="productDetails?product_code=${x.product_code}">${x.product_name }</a><br>
</td><td><fmt:formatNumber pattern="###,###,###" value="${x.product_price}"/>원</td>
<td>${x.cart_count}</td></tr>
<input type="hidden" class="sum" value="${x.product_price*x.cart_count}">
<input type="hidden" class="cart_no" value="${x.cart_no}">
</c:forEach>
  </tbody></table>
  결제예정금액: <span id="orderPrice"></span><br><br><br>
  
  <span class="title">배송 방법 선택</span><br><br>
  
  <table>
      <tbody><tr>
        <td>배송방법</td>
        <td>
        <input type="radio" id="DeliveryMethod1" name="DeliveryMethod" checked><label for="DeliveryMethod1">택배</label>&nbsp;
        <input type="radio" id="DeliveryMethod2" name="DeliveryMethod"><label for="DeliveryMethod12">편의점 방문 픽업</label><br>
        </td>
      </tr>      
    </tbody></table>
 <span>배송지 정보 입력<font color="#f2291f">(*필수 입력 항목)</font></span><br>
 <!-- 일반배송 form  -->
 <form id="delForm" method="post">
 <table id="table1">
		 <tr>
				<td><span class="warning">* </span>주문인</td>
				<td>
				    <input type="text" name="order_name" class="form" value="${mDTO.user_name }" readonly maxlength="20">
 
                     휴대폰 번호 : ${mDTO.user_phone} <br>주문/배송에 관한 문자, 알림톡은 주문인 휴대전화번호로 발송되며,  
                     <a href="" target="_blank">개인정보수정 페이지</a><br>에서 변경 가능합니다.
                   
				    
				</td>
			</tr>
		<tr>
			<td><span class="warning">* </span>받으시는 분</td>
			<td><input class="form" type="text" maxlength="20" id="Receiver" value="${mDTO.user_name}" name="order_receiver"></td>
		</tr>
		<tr>
			<td><span class="warning">*</span>주 소</td>
			<td>
			<!-- 다음주소 시작-->
			<input type="text" name="order_post" id="sample4_postcode" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="order_addr1" id="sample4_roadAddress" placeholder="도로명주소">
			<input type="text" name="order_addr2" id="sample4_jibunAddress" placeholder="지번주소">
			<span id="guide"></span>
			<!-- 다음주소 끝 -->
			</td>	
		</tr>
		<tr>
		<td><span class="warning">* </span>휴대전화번호</td>
		<td><input class="form" type="text" name="order_phone" value="${mDTO.user_phone}"></td>
		</tr>	
 </table>
 		<input type="hidden" name="order_paymethod">
 		<input type="hidden" name="order_price">
 		<input type="hidden" name="cart_noList">
		<!-- 주문 수량(상세페이지에서 바로 주문한 경우, 상품 1개의 상품코드,수량) -->
		<input type="hidden" name="product_code" value="${cDTO.get(0).product_code}">
		<input type="hidden" name="odd_count" value="${cDTO.get(0).cart_count}">	
 </form>
 
 <!-- 편의점 배송 선택시 form -->
 <form id="CVSForm" method="post">
 <table id="table1">
		 <tr>
				<td><span class="warning">* </span>주문인</td>
				<td>
				    <input type="text" name="order_name" class="form" value="${mDTO.user_name }" readonly maxlength="20">
 
                     휴대폰 번호 : ${mDTO.user_phone} <br>주문/배송에 관한 문자, 알림톡은 주문인 휴대전화번호로 발송되며,  
                     <a href="" target="_blank">개인정보수정 페이지</a><br>에서 변경 가능합니다.
                   
				    
				</td>
			</tr>
		<tr>
			<td><span class="warning">* </span>편의점 이름</td>
			<td><input class="form" type="text" maxlength="20" id="CVSname" value="" name="order_addr1">
			<input type="button" value="편의점 선택" onclick="openCVS()">
			</td>
		</tr>
		<tr>
			<td>편의점 연락처</td>
			<td><input class="form" type="text" maxlength="20" id="CVScontact" value="" name="order_addr2"></td>
		</tr>
		<tr>
			<td><span class="warning">*</span>수령하시는분</td>
			<td><input class="form" type="text" maxlength="20" id="Receiver2" value="" name="order_receiver"></td>	
		</tr>
		<tr>
		<td><span class="warning">* </span>수령인 전화번호</td>
		<td><input class="form" type="text" id="ReceiverPhone" name="order_phone" value=""></td>
		</tr>
					
 </table>
 	<input type="hidden" name="order_paymethod" value="">
 	<input type="hidden" name="order_price">
 	<input type="hidden" name="cart_noList">
 	<!-- 주문 수량(상세페이지에서 바로 주문한 경우, 상품 1개의 상품코드, 수량) -->
 	<input type="hidden" name="product_code" value="${cDTO.get(0).product_code}">
	<input type="hidden" name="odd_count" value="${cDTO.get(0).cart_count}">
 </form>
<input type="button" id="inicisPayment" value="카드결제">
<input type="button" id="kakaoPayment" value="카카오페이">
<input type="button" id="Deposit" value="무통장입금">
</div>
</section>
  </body>
</html>