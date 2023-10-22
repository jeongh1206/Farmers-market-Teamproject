
var loopSearch=true;
function keywordSearch(){
	if(loopSearch==false)
		return;
 var value=document.frmSearch.searchWord.value;
 	if(value!=""){
	$.ajax({
		type : "get",
		async : true, //false인 경우 동기식으로 처리한다.
		url : "keywordSearch",
		data : {keyword:value},
		success : function(data, textStatus) {
		    var jsonInfo = JSON.parse(data);
			displayResult(jsonInfo);
		},
		error : function(data, textStatus) {
			
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax
 	}
}
function displayResult(jsonInfo){
	var count = jsonInfo.keyword.length;
	if(count > 0) {
	    var html = '';
	    for(var i in jsonInfo.keyword){
		   html += "<a class='searchWord' href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
	    }
	    var listView = document.getElementById("suggestList");
	    listView.innerHTML = html;
	    show('suggest');
	}else{
	    hide('suggest');
	} 
}

function select(selectedKeyword) {
	 document.frmSearch.searchWord.value=selectedKeyword;
	 loopSearch = false;
	 hide('suggest');
}
	
function show(elementId) {
	 var element = document.getElementById(elementId);
	 if(element) {
	  element.style.display = 'block';
	 }
	}

function hide(elementId){
   var element = document.getElementById(elementId);
   if(element){
	  element.style.display = 'none';
   }
   
	$(function() {
		$("#searchBtn").on("click", function() {
			var value=document.frmSearch.searchWord.value;
			$("searchKeyword").attr("value", value);
		})
	})
}
	
