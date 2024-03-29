<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
<style><%@ include file="/WEB-INF/views/includes/uploadAjax.css" %></style>
	
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading"> Board Register </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <!-- form 태그를 이용하여 필요한 데이터를 전송한다. name의 속성은 BoardVO 클래스의 변수와 일치시켜줘야 한다. -->
                            <form role="form" action="/board/register" method="post">
                            	<div class="form-group">
                            		<label>Title</label> <input class="form-control" name="title">
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>Text area</label> <textarea class="form-control" rows="3" name="content"></textarea>
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>Writer</label> <input class="form-control" name="writer">
                            	</div>
                            	
                            	<button type="submit" class="btn btn-default">Submit Button</button>
                            	<button type="reset" class="btn btn-default">Reset Button</button>
                            <form>
                            
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.end panel-body -->
                    </div>
                    <!-- /.end panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- 첨부파일을 추가 전달하는 부분 -->
            <div class="row">
            	<div class="col-lg-12">
            		<div class="panel panel-default">
            		
	            		<div class="panel-heading">File Attach</div>
	            		<!-- /.panel-heading -->
	            		<div class="panel-body">
	            		
		            		<div class="form-group uploadDiv">
		            			<input type="file" name='uploadFile' multiple/>
		            		</div>
	            		
		            		<div class='uploadResult'>
		            			<ul>
		            			
		            			</ul>
		            		</div>
	            		
	            		</div>
	            		<!-- end panel-body -->
	            	</div>
	            	<!-- end panel-body -->
	            </div>
	            <!-- end panel -->
            </div>
            <!-- /.row -->


<script>
	<!-- Submit Button을 클릭하였을 때, 첨부파일 관련된 처리를 할 수 있도록 기본 동작을 막는 작업 -->
	$(document).ready(function(e){
		
		var formObj = $("form[role='form']");
		
 		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			
			console.log("submit clicked");
			
			var str = "";
			
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
				
				console.dir(jobj);

				//BoardVO에서 attachList라는 이름의 변수로 첨부파일의 정보를 수집하고 있음. 따라서, <input type='hidden'>의 name은 'attachList[idx]'와 같은 이름을 사용하도록 함
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			});
			
			formObj.append(str).submit();
		});
		
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		function checkExtension(fileName, fileSize){
			
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
		
		//업로드된 결과를 화면에 섬네일 등을 만들어서 처리하는 부분
		function showUploadResult(uploadResultArr){
			
			if(!uploadResultArr || (uploadResultArr.length == 0)){
				return;
			}
			
			var uploadUL = $(".uploadResult ul");
			var str ="";
			
			$(uploadResultArr).each(function(i, obj){
				
				//image type
				if(obj.image){
					console.log(obj.uploadPath);
					var fileCallPath = encodeURIComponent(obj.uploadPath + "\s_" + obj.uuid + "_" + obj.fileName);
					str += "<li data-path='" + obj.uploadPath + "'";
					str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'";
					str += " ><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' ";
					str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str + "</li>";
				} else{
					
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li data-path='" + obj.uploadPath + "'";
					str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'";
					str += " ><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' ";
					str += "data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str + "</li>";
				}
			});
			
			console.log(str);
			uploadUL.append(str);
		}
		
		$(".uploadResult").on("click", "button", function(e) {
			
			console.log("delete file");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			
			var targetLi = $(this).closest("li");
			
			$.ajax({
				url: '/deleteFile',
				data: {fileName: targetFile, type:type},
				dataType: 'text',
				type: 'POST',
					success: function(result){
						alert(result);
						targetLi.remove();
					}
			}); //$.ajax
		});
		
		$("input[type='file']").change(function(e){
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			for(var i=0; i<files.length; i++){
				
				//파일 사이즈 초과하거나, 업로드할 수 없는 확장자라면 return
				if(!checkExtension(files[i].name, files[i].size) ){
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
				dataType: 'json',
					success: function(result){
						console.log(result);
						showUploadResult(result); //업로드 결과 처리 함수
				}
			}); //$.ajax
		});
		
	});
	
</script>

<%@include file="../includes/footer.jsp" %>