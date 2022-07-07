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
                            	<button typr="reset" class="btn btn-default">Reset Button</button>
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
		
/* 		$("button[type='submit']").on("click", function(2){
			e.preventDefault();
			
			console.log("submit clicked");
		}); */
		
		
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
						//showUploadResult(result); //업로드 결과 처리 함수
					}
			}); //$.ajax
		});
		
	});
	
</script>

<%@include file="../includes/footer.jsp" %>