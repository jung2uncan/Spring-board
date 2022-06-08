<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<style> 
		<%@ include file="/WEB-INF/views/includes/uploadAjax.css" %>
	</style>
	
	<h1>Upload with Ajax</h1>
	
	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>
	
	<div class='uploadResult'>
		<ul>
			<!-- 업로드된 파일명이 추가되는 부분  -->
		</ul>
	</div>
	
	<button id='uploadBtn'>Upload</button>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	  crossorigin="anonymous">
	</script>
	  
	<script>
	$(document).ready(function(){
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		function checkExtension(fileName, fileSize) {
			
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			
			return true;
		}
		
		var uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr) {	//JSON 데이터를 받아서 해당 파일의 이름을 추ㅏ=가
			var str = "";
			
			$(uploadResultArr).each(function(i, obj) {
				
				if(!obj.image) {	//이미지가 아니면,
					str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>";
				} else {
					//str += "<li>"+ obj.fileName + "</li>";
					
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					
					console.log("fileCallPath : " + fileCallPath);
					
					str += "<li> <img src='/display?fileName=" + fileCallPath + "'></li>";
				}
			})
			
			uploadResult.append(str);
		}

		/* 
			<input type='file'>은 다른 DOM 요소들과 다르게 readonly라 안쪽의 내용을 수정할 수 없기 때문에,
			별도의 방법으로 초기화시켜서 또 다른 첨부파일을 추가할 수 있도록 해야한다.
			
			1) 첨부파일 업로드 전 아무 내용이 없는 <input type='file'> 객체가 포함된 <div> 복사
			2) 첨부파일 업로드한 뒤에는 복사항 객체를 <div> 내에 다시 추가해서 첨부파일 부분 초기화
		*/
		var cloneObj = $(".uploadDiv").clone();
			
		$("#uploadBtn").on("click", function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			console.log(files);
			
			//add filedate to formdata
			for(var i=0; i < files.length; i++){
				
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
					type: 'POST',
					dataType : 'json',
					success: function(result){
						console.log(result);
						
						showUploadedFile(result);
						
						$(".uploadDiv").html(cloneObj.html());					
				}
			}); //$.ajax
			
		});
	});
	</script>
	  
</body>
</html>