<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <!-- CSS 스타일 추가 -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        
        section#content {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }
        
        ul.orderList {
            list-style-type: none;
            padding: 0;
        }
        
        ul.orderList li {
            margin-bottom: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
        }
        
        ul.orderList li div {
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
    </style>
<title>Insert title here</title>
</head>
<body>
<section id="content">
   
   <ul class="orderList">
    <c:forEach items="${orderList}" var="orderList">
    <li>
    <div>
     <p><span>주문번호 <a href="orderView?n=${orderList.order_no}">${orderList.order_no}</a></span></p>
     <p><span>주문인 ${orderList.order_name}</span></p>
     <p><span>수령인 ${orderList.order_receiver}</span></p>
     <p><span>주소 (${orderList.order_addr1}) ${orderList.order_addr2}</span></p>
     <p><span>주문상태 ${orderList.order_sta}</span></p>
     <p><span>결제상태 ${orderList.order_paysta}</span></p>
     <p><span>가격 <fmt:formatNumber pattern="###,###,###" value="${orderList.order_price}" /> 원</span></p>
     <p><span>결제방법 ${orderList.order_paymethod}</span></p>
    </div>
    </li>
    </c:forEach>
   </ul>

</section>
</body>
</html>