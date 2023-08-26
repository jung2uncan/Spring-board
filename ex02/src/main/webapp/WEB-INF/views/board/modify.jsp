<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
<style><%@ include file="/WEB-INF/views/includes/uploadAjax.css" %></style>

	<div calss='bigPictureWrapper'>
		<div class='bigPicture'>
		</div>
	</div>

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
	                        <form role="form" action="/board/modify" method="post" >

	                        	<input type="hidden" id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
								<input type="hidden" id='amount' name='amount' value='<c:out value="${cri.amount }"/>'>
								<input type="hidden" id='pageNum' name='type' value='<c:out value="${cri.type }"/>'>
								<input type="hidden" id='amount' name='keyword' value='<c:out value="${cri.keyword }"/>'>
								
	                        	<div class="form-group">
	                           		<label>Bno</label> <input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly="readonly">
	                           	</div>
	                           	
	                           	<div class="form-group">
	                           		<label>Title</label> <input class="form-control" name="title" value='<c:out value="${board.title }"/>'>
	                           	</div>
	                            	
	                           	<div class="form-group">
	                           		<label>Text area</label> <textarea class="form-control" rows="3" name="content"> <c:out value="${board.content }"/></textarea>
	                           	</div>
	                            	
	                            <div class="form-group">
	                            	<label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
	                            </div>
	                            	
	                            <button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
	                            <button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
	                            <button type="submit" data-oper='list' class="btn btn-info">List</button>
							</form>
							<!-- 첨부파일 목록 -->
			                <div class="row">
			                	<div class="col-lg-12">
			                		<div class="panel panel-default">
				                		<div class="panel-heading">Files</div>
				                		<!-- /.panel-heading -->
				                		<div class="panel-body">
				                			<div class="form-group uploadDiv">
				                				<input type="file" name='uploadFile' multiple="multiple">
				                			</div>
				                			<div class='uploadResult'>
				                				<ul>
				                				
				                				</ul>
				                			</div>
				                		</div>
				                		<!-- end panel body -->
				                	</div>
				                	<!-- end panel body -->
				                </div>
				                <!-- end panel -->
			                </div>
			                <!-- end row -->
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.end panel-body -->
                    </div>
                    <!-- /.end panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

<%@include file="../includes/footer.jsp" %>

<script>
	$(document).ready(function() {
		var formObj = $("form");
		
		$('button').on("click", function(e) {
	
			e.preventDefault();		// 기본 동작인 submit을 막고, 'data-oper' 속성을 이용해서 원하는 기능을 동작할 수 있도록 함. (마지막에 submit 처리)
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			//변수의 타입까지 모두 값을 때
			if(operation === 'remove'){
				formObj.attr("action", "/board/remove");
			} else if (operation === 'list'){
				//move to list 
				//self.location = "/board/list";   // self.location : 현재 페이지를 다른 페이지(URL)로 이동
				formObj.attr("action", "/board/list").attr("method", "get");
				
				//list 페이지로 이동할 때는 모든 값이 필요없고, pageNum, amount, type, keyword값만 필요함
				var pageNumTag = $("input[name='pageNum']").clone();	//pageNum값을 복사하여 pageNumTag 변수에 저장
				var amountTag = $("input[name='amount']").clone();		//amount값을 복사하여 pageNumTag 변수에 저장
				var typeTag = $("input[name='type']").clone();		//type값을 복사하여 typeTag 변수에 저장
				var keywordTag = $("input[name='keyword']").clone();	//keyword값을 복사하여 keywordTag 변수에 저장
				
				//form 태그 내 모든 내용 삭제 후, 필요 태그(pageNum, amount, type, keyword)만 다시 추가
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
			} else if (operation === 'modify'){
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
			}
			
			formObj.submit();
		});	
	});
</script>

<script> type="text/javascript">
$(document).ready(function(){
	var bno = '<c:out value="${board.bno}"/>';
	
	$.getJSON("/board/getAttachList", {bno:bno}, function(arr) {
		//console.log(arr);
		
		var str ="";
		
		$(arr).each(function(i, attach){
			//image Type
			if(attach.fileType) {
				var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
				
				str += "<li data-path='" + attach.uploadPath + "'";
				str += " data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
				str += "<span>" + attach.fileName + "</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' ";
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName=" + fileCallPath + "'>";
				str += "</div>";
				str + "</li>";
			} else {
				str += "<li data-path='" + attach.uploadPath + "'";
				str += " data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
				str += "<span>" + attach.fileName + "</span><br/>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' ";
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str + "</li>";
			}
		});
		
		$(".uploadResult ul").html(str);
		
		$(".uploadResult").on("click", "button", function(e) {
			console.log("Delete File");
			
			if(confirm("Remove this file?")) {
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
	}); //end getJson
	
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
				var fileCallPath = encodeURIComponent(obj.uploadPath + "\s_" + obj.uuid + "_" + obj.fileName);
				console.log("fileCallPath : " + fileCallPath);
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
}); //end function
</script>