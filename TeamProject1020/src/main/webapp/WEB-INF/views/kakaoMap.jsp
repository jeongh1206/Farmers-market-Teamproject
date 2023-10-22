<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>카카오 지도 API</title>
    <style>
      .customoverlay {
        position: relative;
        bottom: 40px;
        border-radius: 6px;
        border: 1px solid #ccc;
        border-bottom: 2px solid #ddd;
        float: left;
      }
      .customoverlay:after {
        content: "";
        position: absolute;
        margin-left: -12px;
        left: 50%;
        bottom: -12px;
        width: 22px;
        height: 12px;
        background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png);
      }
      .customoverlay a {
        display: block;
        text-decoration: none;
        color: #000;
        text-align: center;
        border-radius: 6px;
        font-size: 14px;
        font-weight: bold;
        overflow: hidden;
        background: #000
          url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
          no-repeat right 14px center;
      }
      .customoverlay .title {
        display: block;
        text-align: center;
        background: #fff;
        margin-right: 35px;
        padding: 10px 15px;
        font-size: 14px;
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <input type="text" id="sample_postcode" placeholder="우편번호">
    <input type="button" id="sample" value="우편번호 찾기"><br>
    <input type="text" id="sample_address" placeholder="주소"><br>
    <input type="text" id="sample_detailAddress" placeholder="상세주소">
    <input type="text" id="sample_extraAddress" placeholder="참고항목">
    
    <!-- 결제페이지로 전달할 편의점 이름, 전화번호 -->
    <input type="hidden" id="CVSname">
    <input type="hidden" id="CVScontact">
    
    <div id="map" style="width:750px; height: 500px;"></div>


    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=1bae81f0980c5fdf3b1ac9a748639149&libraries=services"></script>
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="resources/js/kakaoMap.js"></script>
  </body>
</html>

