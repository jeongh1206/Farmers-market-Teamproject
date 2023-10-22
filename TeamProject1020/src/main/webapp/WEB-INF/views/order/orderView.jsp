<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
 <!-- CSS 스타일 추가 -->
 <style>
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
    
    .orderInfo {
        border : 1px solid red;
        list-style-type: none;
        padding: 0;
        margin-bottom: 20px;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 10px;
    }
    
    ul.orderInfo li div {
        padding: 10px;
    }
    
    p span {
        font-weight: bold;
    }
    
    a {
        color: #007bff;
        text-decoration: none;
    }
    
    a:hover {
        text-decoration: underline;
    }
    
    .orderView {
        list-style-type: none;
        padding: 0;
    }
    
    .orderView table {
    	width: 100%;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 10px;
        display: flex;
        align-items: center;
    }
    .orderView table tr {
    border: none;
	}
    .orderView table td {
    border: none;
	}	
    
    ul.orderView li .thumb {
        flex: 0 0 100px;
    }
    
    ul.orderView li .thumb img {
        max-width: 100%;
        height: auto;
    }
    
    ul.orderView li .productInfo {
        flex: 1;
        padding-left: 20px;
    }
    
    ul.orderView hr {
        margin: 10px 0;
        border: none;
        border-top: 1px solid #ddd;
    }
    .orderDetail{
    	float:left;
    	margin-right: 50px;
    }
    .orderDetail span {
	    padding-top: 50px;
	    display: block;
    }
    .orderDel {
    	border-right: 1px solid rgb(238, 238, 238);
    }
    .orderDeleteBtn {
    	display: inline-flex;
	    -webkit-box-pack: center;
	    justify-content: center;
	    -webkit-box-align: center;
	    align-items: center;
	    padding-left: 12px;
	    padding-right: 12px;
	    user-select: none;
	    cursor: pointer;
	    text-decoration: none;
	    outline: none;
	    appearance: none;
	    height: 2.25rem;
	    width: 100%;
	    border-radius: 4px;
	    color: rgb(52, 106, 255);
	    background-color: rgb(255, 255, 255);
	    border: 1px solid rgb(52, 106, 255);
	    -webkit-tap-highlight-color: rgba(52, 106, 255, 0.1);
	    font-size: 0.875rem;
    }
</style>

<title>Insert title here</title>
</head>
<body>
<section id="content">

   <div class="orderInfo">
    <c:forEach items="${orderView}" var="orderView" varStatus="status">
     
     <c:if test="${status.first}">
      <p><span>수령인 ${orderView.order_receiver}</span></p>
      <p><span>주소 (${orderView.order_addr1}) ${orderView.order_addr2}</span></p>
      <p><span>가격 <fmt:formatNumber pattern="###,###,###" value="${orderView.order_price}" /> 원</span></p>
     </c:if>
     
    </c:forEach>
   </div>
   	
    <div id="orderView" class="orderView">
    <c:forEach items="${orderView}" var="orderView">       
    <table>
    <tr>
    <td>
     <div class="thumb">
     <div class="orderDetail">
      <img src="${orderView.product_img}" width="200">
      </div>
      <div class="orderDetail">
     <!--  <p> -->
       <span>상품명 ${orderView.product_name}<br />
	       개당 가격 <fmt:formatNumber pattern="###,###,###" value="${orderView.product_price}" /> 원<br />
	       구입 수량 ${orderView.odd_count} 개<br />
	       최종 가격 <fmt:formatNumber pattern="###,###,###" value="${orderView.product_price * orderView.odd_count}" /> 원
	   </span>                  
      <!-- </p> -->
      </div>
     </div>
     <form id="orderDeleteForm" action="orderDelete" method="post">
     <input type="hidden" name="order_no" value="${orderView.order_no}">
     <button type="submit" class="orderDeleteBtn">주문 삭제</button>
     </form>
     <!-- <div class="productInfo"> -->
     <%--  <p>
       <span>상품명 ${orderView.product_name}</span><br />
       <span>개당 가격 <fmt:formatNumber pattern="###,###,###" value="${orderView.product_price}" /> 원</span><br />
       <span>구입 수량 ${orderView.odd_count} 개</span><br />
       <span>최종 가격 <fmt:formatNumber pattern="###,###,###" value="${orderView.product_price * orderView.odd_count}" /> 원</span>                  
      </p>
     </div> --%>
     <td class="orderDel">
     <tr>
    </table>
    <hr>      
    </c:forEach>
   </div>
</section>
</body>
</html>