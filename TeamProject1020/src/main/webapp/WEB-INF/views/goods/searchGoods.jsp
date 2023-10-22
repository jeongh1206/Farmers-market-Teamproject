<%@page import="com.example.dto.PageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 검색 페이지</title>
<style type="text/css">
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

    /* Added CSS for the product list */
    
    ul.productView {
        list-style-type: none;
        padding: 0;
    }
    
    ul.productView li {
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 10px;
        display: flex;
        align-items: center;
    }
    
    ul.productView li .thumb {
        flex: 0 0 100px;
    }
    
    ul.productView li .thumb img {
        max-width: 100%;
        height: auto;
    }
    
    ul.productView li .productInfo {
        flex: 1;
        padding-left: 20px;
    }
    ul.productView li .productInfo a {
   		color: #333;
		text-decoration: none;
}
    
    ul.productView hr {
        margin: 10px 0;
        border: none;
        border-top: 1px solid #ddd;
    }
    div.pagination {
        text-align: center;
        margin-top: 20px;
    }

    div.pagination a {
        display: inline-block;
        padding: 5px 10px;
        margin: 2px;
        background-color: #007bff;
        color: #fff;
        text-decoration: none;
        border-radius: 3px;
    }

    div.pagination a:hover {
        background-color: #0056b3;
    }

    div.pagination .current {
        background-color: #f0f0f0;
        color: #333;
        border: 1px solid #ccc;
    }
    p.search-result-heading {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
    } 
</style>
</head>
<body>

<section id="content">
   <p class="search-result-heading">"${searchWord}" 에 대한 검색 결과</p>
   <ul class="productView">
    <c:forEach items="${goodsList}" var="goodsList">       
    <li>
     <div class="thumb">
     <a href="productDetails?product_code=${goodsList.product_code }">
      <img src="${goodsList.product_img}">
      </a>
     </div>
     <div class="productInfo">
      <p>
      <a href="productDetails?product_code=${goodsList.product_code }">
       <span>상품명 ${goodsList.product_name}</span>
       </a>
       <br />
       <span> 가격 <fmt:formatNumber pattern="###,###,###" value="${goodsList.product_price}" /> 원</span><br />           
      </p>
     </div>
    </li>
    <hr>      
    </c:forEach>
   </ul>
	<div class="pagination">
		<%
				String searchWord = (String) request.getAttribute("searchWord");
				PageDTO pDTO = (PageDTO) request.getAttribute("pDTO");
		        int curPage = pDTO.getCurPage();
		        int perPage = pDTO.getPerPage();
				int totalCount = pDTO.getTotalCount();
				int totalPage = totalCount/perPage;
				if(totalCount%perPage!=0) totalPage++;
				
				// 이전 페이지 링크
		        if (curPage > 1) {
		            out.print("<a href='searchGoods?curPage=" + (curPage - 1) + "&searchWord=" + searchWord + "'>이전</a>&nbsp;");
		        }else {
		            out.print("&nbsp;이전&nbsp;");
		        }

		        // 페이지 번호 링크
		        for (int i = 1; i <= totalPage; i++) {
		            if (i == curPage) {
		                out.print(i + "&nbsp;");
		            } else {
		                out.print("<a href='searchGoods?curPage=" + i + "&searchWord=" + searchWord + "'>" + i + "</a>&nbsp;");
		            }
		        }

		        // 다음 페이지 링크
		        if (curPage < totalPage) {
		            out.print("<a href='searchGoods?curPage=" + (curPage + 1) + "&searchWord=" + searchWord + "'>다음</a>&nbsp;");
		        }else {
		            out.print("&nbsp;다음&nbsp;");
		        }
		   %>
	</div>
</section>
</body>
</html>