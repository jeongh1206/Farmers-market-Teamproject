<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <link href="resources/main.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>팀플젝 메인</title>
</head>
<body>
<div id="topControl">
	<jsp:include page="common/top.jsp"  flush="true"/> 
</div>
<jsp:include page="menu/productList.jsp" flush="true"/> 
<%-- <jsp:include page="common/bottom.jsp" flush="true"/>  --%>
</body>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var params = new URLSearchParams(window.location.search);
		if(params.get("keyword") == "ifm"){
			$("#topControl").remove();
		}
	});
</script>
</html>