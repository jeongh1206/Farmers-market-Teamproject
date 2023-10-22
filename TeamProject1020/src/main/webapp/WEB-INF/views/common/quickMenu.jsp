<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> --%>

<script>
	var array_index=0;
	//var SERVER_URL="${contextPath}/thumbnails.do";
	function fn_show_next_goods() {
    var img_sticky = document.getElementById("img_sticky");
    var cur_goods_num = document.getElementById("cur_goods_num");
    var _h_product_code = document.frm_sticky.h_product_code;
    var _h_product_img = document.frm_sticky.h_product_img;

    array_index = (array_index + 1) % _h_product_code.length;

    var product_code = _h_product_code[array_index].value;
    var fileName = _h_product_img[array_index].value;
    img_sticky.src = "resources/img/items/" + fileName + ".gif";
    cur_goods_num.innerHTML = array_index + 1;
}

function fn_show_previous_goods() {
    var img_sticky = document.getElementById("img_sticky");
    var cur_goods_num = document.getElementById("cur_goods_num");
    var _h_product_code = document.frm_sticky.h_product_code;
    var _h_product_img = document.frm_sticky.h_product_img;
    array_index = (array_index - 1 + _h_product_code.length) % _h_product_code.length;

    var product_code = _h_product_code[array_index].value;
    var fileName = _h_product_img[array_index].value;
    img_sticky.src = "resources/img/items/" + fileName + ".gif";
    cur_goods_num.innerHTML = array_index + 1;
}

function goodsDetail(){
	var cur_goods_num=document.getElementById("cur_goods_num");
	arrIdx=cur_goods_num.innerHTML-1;
	
	var img_sticky=document.getElementById("img_sticky");
	var h_product_code=document.frm_sticky.h_product_code;
	var len=h_product_code.length;
	
	if(len>1){
		product_code=h_product_code[arrIdx].value;
	}else{
		product_code=h_product_code.value;
	}
	
	
	var formObj=document.createElement("form");
	var i_product_code = document.createElement("input"); 
    
	i_product_code.name="product_code";
	i_product_code.value=product_code;
	
    formObj.appendChild(i_product_code);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="productDetails?gCode="+product_code;
    formObj.submit();
	
	
}
</script>  
 
<body>    
    <div id="sticky" >
	<ul id="social-icons">
		<li><a href="#">
		   <img	width="24" height="24" src="resources/img/facebook_icon.png">
				페이스북
		</a></li>
		<li><a href="#">
		   <img width="24" height="24" src="resources/img/twitter_icon.png">
			트위터
		</a></li>
		<li><a href="#">
		   <img	width="24" height="24" src="resources/img/rss_icon.png">
				RSS 피드
		 </a></li>
	</ul>
	<div class="recent">
		<h3>최근 본 상품</h3>
		  <ul>
		<!--   상품이 없습니다. -->
		 <c:choose>
			<c:when test="${ empty quickGoodsList }">
				     <strong>상품이 없습니다.</strong>
			</c:when>
			<c:otherwise>
	       <form name="frm_sticky"  >	        
		      <c:forEach var="item" items="${quickGoodsList }" varStatus="itemNum">
		         <c:choose>
		           <c:when test="${itemNum.count==1 }">
			      <a href="javascript:goodsDetail();">
			  	         <img width="75" height="80" id="img_sticky"  
			                 src="${item.product_img}">
			      </a>
			        <input type="hidden"  name="h_product_code" value="${item.product_code}" />
			        <input type="hidden" name="h_product_img" value="${item.product_img}" />
			      <br>
			      </c:when>
			      <c:otherwise>
			        <input type="hidden"  name="h_product_code" value="${item.product_code}" />
			        <input type="hidden" name="h_product_img" value="${item.product_img}" />
			      </c:otherwise>
			      </c:choose>
		     </c:forEach>
		   </c:otherwise>
	      </c:choose>
		 </ul>
     </form>		 
	</div>
	 <div>
	 <c:choose>
	    <c:when test="${ empty quickGoodsList }">
		    <h5>0/0</h5>
	    </c:when>
	    <c:otherwise>
           <h5><a  href='javascript:fn_show_previous_goods();'>이전</a><span id="cur_goods_num">1</span>/${quickGoodsListNum}<a href='javascript:fn_show_next_goods();'>다음 </a> </h5>
       </c:otherwise>
       </c:choose>
    </div>
</div>
</body>
</html>
 
