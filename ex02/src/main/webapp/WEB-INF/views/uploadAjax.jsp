<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

	<div class='bigPictureWrapper'>
		<div class='bigPicture'>
		
		</div>
	</div>
	
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
	
	//$(document).ready()의 바깥쪽에 작성함. 추후, <a> 태그에서 직접 showImage()를 호출할 수 있는 방식으로 작성하기 위함.
	function showImage(fileCallPath) { //섬네일을 클릭하였을 때 원본 이미지 보여주는 메소드
		//alert(fileCallPath);
	
		$(".bigPictureWrapper").css("display","flex").show();
		
		//내부적으로 화면 가운데 배치하는 작업 후 <img> 태스를 추가하고, JQuery의 animate()를 이룔해서 지정된 시간동안 화면에서 열리는 효과를 처리함. 
		$(".bigPicture")
		.html("<img src='display?fileName=" + encodeURI(fileCallPath) + "'>")
		.animate({width: '0%', height: '0%'}, 1000);
		
		//이미지를 다시 한 번 클릭하면 사라지도록 설정
 		$(".bigPictureWrapper").on("click", function(e) {
			$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
			setTimeout(() => {
				$(this).hide();
			}, 1000);
		}); 
	}
	
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
					
					// 파일을 클릭하면 다운로드에 필요한 경로와 UUID가 붙은 파일 이름을 이용해서 다운로드가 가능하도록 처리하는 부분
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					console.log(fileCallPath);
					
					//섬네일 이미지
					//str += "<li><a href='/download?fileName=" + fileCallPath + "'>" + "<img src='/resources/img/attach.png'>" + obj.fileName + "</a></li>";
					
					//섬네일 이미지
					str += "<li><a href='/download?fileName=" + fileCallPath + "'>" + "<img src='/resources/img/attach.png'>" + obj.fileName + "</a>"
							+ "<span data-file=\'" + fileCallPath +"\' data-type='file'> X </span>" + "<div></li>";
							
							
				} else {	//이미지가 일 때,
					//str += "<li>"+ obj.fileName + "</li>";
					
					//섬네일 이미지
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					
					var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g), "/");
					
					
					console.log("fileCallPath : " + fileCallPath);
					
					//str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\"> <img src='/display?fileName=" + fileCallPath + "'></a></li>";
					
					str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\"> <img src='/display?fileName=" + fileCallPath + "'></a>" 
							+ "<span data-file=\'" + fileCallPath +"\' data-type='image'> X </span>" + "</li>";
				}
			});
			
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
			
			console.log("UploadAjax.jsp -> files : " + files);
			
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
	
	
	// 파일 삭제 'x'표시에 대한 이벤트 처리
	$(".uploadResult").on("click", "span", function(e) {
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		console.log("UploadAjax.jsp -> targetFile: " + targetFile);
		console.log("UploadAjax.jsp -> type: " + type);
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type: type},
			dataType:'text',
			type: 'POST',
				success: function(result){
					alert(result);
				}
		});	//$.ajax
	});
	
	</script>
	  
</body>
</html>