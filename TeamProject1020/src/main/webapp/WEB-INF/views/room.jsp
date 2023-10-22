<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
	<title>Room</title>
	<style>
		*{
			margin:0;
			padding:0;
		}
		.container{
			width: 500px;
			margin: 0 auto;
			padding: 25px
		}
		.container h1{
			text-align: left;
			padding: 5px 5px 5px 15px;
			color: gray;
			border-left: 3px solid gray;
			margin-bottom: 20px;
		}
		.roomContainer{
			background-color: #F6F6F6;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.roomList{
			border: none;
		}
		.roomList th{
			border: 1px solid #FFBB00;
			background-color: gray;
			color: green;
		}
		.roomList td{
			border: 1px solid #FFBB00;
			background-color: gray;
			text-align: left;
			color: green;
		}
		.roomList .num{
			width: 75px;
			text-align: center;
		}
		.roomList .room{
			width: 350px;
		}
		.roomList .go{
			width: 120px;
			text-align: center;
		}
		button{
			background-color: green;
			font-size: 14px;
			color: yellow;
			border: 1px solid #000;
			border-radius: 5px;
			padding: 3px;
			margin: 3px;
		}
		.inputTable th{
			padding: 5px;
		}
		.inputTable input{
			width: 330px;
			height: 25px;
		}
	</style>
</head>

<script type="text/javascript">
	var ws;
	window.onload = function(){
		
		// 1. 채팅버튼 클릭시 
		getRoom();
// 		createRoom(); // 나중에 쓸수도
	}
	// 방리스트 보여줘야한다.
	function getRoom(){
		commonAjax('getRoom', "", 'post', function(result){
			createChatingRoom(result);
		});
	}
	// 방을 만들겠다.
	function createRoom(){
// 		1. 방 만들기 버튼을 누르면 {roomName : 방제목} -> HashMap<Object, Object> 이 형태로 백단에서 받을 수 있다.
			var msg = {	roomName : $('#roomName').val()	};
			commonAjax('createRoom', msg, 'post', function(result){
				createChatingRoom(result);
			});

			$("#roomName").val("");
	}
	// 방에 입장하겠다.
	function goRoom(number, name){
		location.href="moveChating?roomName="+name+"&"+"roomNumber="+number;
	}

	function createChatingRoom(res){
		if(res != null){
			var tag = "<tr><th class='num'>순서</th><th class='room'>방 이름</th><th class='go'>참여가능여부</th></tr>";
// console.log("res : "+res);			
			res.forEach(function(d, idx){
				var rn = d.roomName.trim();
				var roomNumber = d.roomNumber;
// console.log("roomNumber : "+roomNumber)
				tag += 
					"<tr>"+
					"<td class='num'>"+(idx+1)+"</td>"+
					"<td class='room'>"+ rn +"</td>"+
					"<td class='go'><button type='button' onclick='goRoom(\""+roomNumber+"\", \""+rn+"\")'>참여</button></td>" +
					"</tr>";	
			});
			$("#roomList").empty().append(tag);
		}
	}

	function commonAjax(url, parameter, type, calbak, contentType){
		$.ajax({
			url: url,
			data: parameter,
			type: type,
			contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
			success: function (res) {
				calbak(res);
			},
			error : function(err){
				console.log('error');
				calbak(err);
			}
		});
	} // 공통 Ajax
	
	
	
</script>
<body>
	<div class="container">
		<h1>채팅방</h1>
		<div id="roomContainer" class="roomContainer">
			<table id="roomList" class="roomList"></table>
		</div>
		<div>
			<table class="inputTable">
				<tr>
					<th>방 제목</th>
					<th><input type="text" name="roomName" id="roomName"></th>
					<th><button id="createRoom" onclick="createRoom()">방 만들기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>