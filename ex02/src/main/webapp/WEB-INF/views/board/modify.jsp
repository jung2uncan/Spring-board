<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

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

<script type="text/javascript">

	$(document).ready(function() {
		
		var formObj = $("form");
		
		$('button').on("click", function(e) {
			
			e.preventDefault();		// 기본 동작인 submit을 막고, 'data-oper' 속성을 이용해서 원하는 기능을 동작할 수 있도록 함. (마지막에 submit 처리)
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation === 'remove'){
			    formObj.attr("action", "/board/remove");
			} else if (operation === 'list'){
				//move to list 
				//self.location = "/board/list";   // self.location : 현재 페이지를 다른 페이지(URL)로 이동
				formObj.attr("action", "/board/list").attr("method", "get");
				formObj.empty();
			}
			
			formObj.submit();
		});	
		
	});
</script>
