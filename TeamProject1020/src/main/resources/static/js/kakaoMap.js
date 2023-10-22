function CVSdata() {
	var cName = document.getElementById("CVSname").value;
	var cContact = document.getElementById("CVScontact").value;
	opener.document.getElementById("DeliveryMethod2").checked=true;
	opener.document.getElementById("CVSname").value = document.getElementById("CVSname").value;
	opener.document.getElementById("CVScontact").value = document.getElementById("CVScontact").value;
}

(() => {
  const _tr = (select) => document.querySelector(select);
  const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
  mapOption = {
      center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
      level: 3 // 지도의 확대 레벨
  };  

  // 지도를 생성합니다    
  const map = new kakao.maps.Map(mapContainer, mapOption); 

  // 주소-좌표 변환 객체를 생성합니다
  const geocoder = new kakao.maps.services.Geocoder();

  // 주소로 좌표를 검색합니다
  function postCode() {
    new daum.Postcode({
      oncomplete: function(data) {
        const { address, roadAddress, jibunAddress, zonecode } = data;
        
        //daum 우편 API에서 주소 정보를 화면에 뿌려줍니다.
        _tr('#sample_postcode').value = zonecode;
          if(roadAddress !== ''){
            _tr("#sample_address").value = roadAddress;
          } 
          else if(jibunAddress !== ''){
            _tr("#sample_address").value = jibunAddress;
          }

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch(address, function(result, status) {
          // 우편번호 서비스로 위도 경도 찾기
          data = {"name": "편의점", "latitude": result[0], "longitude": result[1]}
          console.log(data)
          $.ajax({ //ajax로 위도 경도 및 정보를 담아서 서버로 보내기
            type: "GET",
            data: { data },
            success: function(response){
              console.log(response['msg'])
            }
          });
          
          // 정상적으로 검색이 완료됐으면 
          if (status === kakao.maps.services.Status.OK) {
        	  
              // 마커 이미지의 이미지 주소입니다
              var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
              
           // 마커 이미지의 이미지 크기 입니다
              var imageSize = new kakao.maps.Size(24, 35); 
              
              // 마커 이미지를 생성합니다    
              var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

              const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
              
              // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
              map.setCenter(coords);
              
              // 지도에 마커를 표시하는 함수입니다
              function displayMarker(place) {
                  // 마커를 생성하고 지도에 표시합니다
                  var marker = new kakao.maps.Marker({
                      map: map,
                      position: new kakao.maps.LatLng(place.y, place.x),
                  	  image : markerImage // 마커 이미지
                  });
                var infowindow = new kakao.maps.InfoWindow({zIndex:1});
//                infowindow.open(map, marker);

                  // 마커에 클릭이벤트를 등록합니다
                  kakao.maps.event.addListener(marker, 'click', function() {

                	// 편의점 정보 창 열기
                	    var newWindow = window.open('delCVS', 'popForm', 'width=324,height=400,location=no,status=no,scrollbars=yes');

                	    
                	    if (newWindow) {
                	    	console.log(place);
                	    	console.log(place.address_name);
                	        var formHTML = '<form name="popForm" action="delCVS" method="post" target="popForm">' +
                	            '<input type="hidden" name="address_name" value="'+place.address_name+'">' +
                	            '<input type="hidden" name="phone" value="'+place.phone+'">' +
                	            '<input type="hidden" name="place_name" value="'+place.place_name+'">' +
                	            '<input type="hidden" name="road_address_name" value="'+place.road_address_name+'">' +
                	            '</form>';
                	        newWindow.document.write(formHTML);

                	        // Submit the form in the new window
                	        newWindow.document.forms['popForm'].submit();
                	    } else {
                	    	
                	    }
                      
                  });
              }
              
              //검색 된 곳 주변 반경 5km 이내 편의점 검색 
              $.ajax({
                  url: "https://dapi.kakao.com/v2/local/search/category.json?" +
                  		"y="+result[0].y+"&x="+result[0].x+"&category\_group\_code=CS2&radius=5000",
                  type:'GET',
                  headers: {'Authorization' : 'KakaoAK af2bae00a6ba66523fb7e85b798eac73'},
		          success:function(data){
		              console.log(data);
		              console.log(data.documents);
		              var data = data.documents;
		              for (var i=0; i<data.length; i++) {
		            	  console.log("실행됨");
                          displayMarker(data[i]);
		              }
		          },
		          error : function(e){
		              console.log(e);
		          }
		       });    
              
//           // 장소 검색 객체를 생성합니다
//              var ps = new kakao.maps.services.Places(map);
//              
//           // 카테고리로 편의점을 검색합니다
//              ps.categorySearch('CS2', placesSearchCB, {useMapBounds:true}); 

              // 키워드 검색 완료 시 호출되는 콜백함수 입니다
              function placesSearchCB (data, status, pagination) {
                  if (status === kakao.maps.services.Status.OK) {
                      for (var i=0; i<data.length; i++) {
                          displayMarker(data[i]);    
                      }       
                  }
              }

          } 
        });
      }
    }).open();
  };
  
  _tr('#sample').addEventListener('click', postCode)
})();
