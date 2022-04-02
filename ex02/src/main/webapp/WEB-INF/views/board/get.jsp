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
                        	<div class="form-group">
                           		<label>Bno</label> <input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly="readonly">
                           	</div>
                           	
                           	<div class="form-group">
                           		<label>Title</label> <input class="form-control" name="title" value='<c:out value="${board.title }"/>' readonly="readonly">
                           	</div>
                            	
                           	<div class="form-group">
                           		<label>Text area</label> <textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content }"/> </textarea>
                           	</div>
                            	
                            <div class="form-group">
                            	<label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
                            </div>
                            
                            <!--  
                            	<button data-oper='modify' class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">Modify</button>
                            	<button data-oper='list' class="btn btn-info" onclick="location.href='/board/list'">List</button>
							-->	
							
							<button data-oper='modify' class="btn btn-default">Modify</button>
                            <button data-oper='list' class="btn btn-info">List</button>
							
							<form id='operForm' action="/board/modify" method="get">
								<input type="hidden" id='bno' name='bno' value='<c:out value="${board.bno }"/>'>
								<input type="hidden" id='pageNum' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
								<input type="hidden" id='amount' name='amount' value='<c:out value="${cri.amount }"/>'>
								<input type="hidden" id='type' name='type' value='<c:out value="${cri.type }"/>'>
								<input type="hidden" id='keyword' name='keyword' value='<c:out value="${cri.keyword }"/>'>
							</form>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.end panel-body -->
                    </div>
                    <!-- /.end panel -->
                </div>
                <!-- /.col-lg-12 -->
                
                <!-- 댓글 목록 -->
	            <div class='row'>
	            	<div class="col-lg-12">
	            		
	            		<!-- /. panel -->
	            		<div class="panel panel-default">
	            			<div class="panel-heading">
	            				<i class="fa fa-comments fa-fw"></i> Reply
	            			</div>
	            		</div>
	            		
	            		<!-- ./ panel-heading -->
	            		<div class="panel-body">
	            			<ul class="chat">
	            				<!-- start reply -->
	            				<li class="left clearfix" data-rno='12'>
	            					<div>
		            					<div class="header">
		            						<strong class="primary-font">user00</strong>
		            						<small class="pull-right text-muted">2022-04-02 22:40</small>
		            					</div>
		            					<p> Good Job!</p>
	            					</div>
	            				</li>
	            				<!-- end reply -->
	            			</ul>
	            			<!-- end ul -->
	            		</div>
	            		<!-- ./ panel .chat-panel -->
	            	</div>
	            </div>
	            <!-- ./ end row -->
	            
            </div>
            <!-- /.row -->
            

<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/reply.js"> </script>

<script type="text/javascript">
	$(document).ready(function(){
		
		console.log("===============================");
		console.log("============JS TEST============");
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page) {
			//해당 게시물의 모든 댓글을 가져오는지 확인
			replyService.getList(
					{bno:bnoValue, page: page || 1}, 
					function(list){
						var str = "";

						if(list==null || list.length ==0) {
							replyUL.html("");
							return;
						}
						
						for(var i=0, len = list.length||0; i<len; i++){
							str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
							str += "<div> <div class='header'> <strong class='primary-font'> " + list[i].replyer + "</strong>";
							str += "<small class='pull-right text-muted'> " + list[i].replyDate + "</small></div>";
							str += "<p>" + list[i].reply + "</p></div></li>";
						}
						
						replyUL.html(str);
					}
			); //end function
		}	//end showList
		
		/*
		//해당 게시물의 모든 댓글을 가져오는지 확인
		replyService.getList(
				{bno:bnoValue, page:1}, 
				function(list){
					for(var i=0, len = list.length||0; i<len; i++){
						console.log(list[i]);
					}
				}
		);
		*/

		/*
		//댓글 삭제 테스트
		replyService.remove(23, 
				function(count){
					console.log(count);
					if(count == "success"){
						alert("REMOVED SUCCESS");
					}
				}, function(err) {
					alert("ERROR,,,");
				}
		);
		*/
		
		/*
		//댓글 수정 테스트
		replyService.modify(
			{rno : 22, bno:bnoValue, reply : "Modify Reply...."},
			function(result){
				alert("댓글 수정 완료");
			}
		);
		*/
		
		/*
		//댓글 조회 테스트
		replyService.get(22, 
			function(data){
				console.log(data + "조회 성공");
			}
		);
		*/
		
		/*
		//for replyServuce add test
		replyService.add(
			{reply : "JS TEST", replyer :"tester", bno:bnoValue},
			function(result){
				alert("RESELT : " + result);
			}
		);
		*/
		
		
		var operForm=  $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/modify");
			operForm.submit();
		});
		
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
		});
	});	
	
</script>