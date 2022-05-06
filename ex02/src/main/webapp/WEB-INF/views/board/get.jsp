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
	            				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'> New Reply </button>
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
	            		
	            		<div class="panel-footer">
	            		
	            		</div>
	            	</div>
	            </div>
	            <!-- ./ end row -->
	            
            </div>
            <!-- /.row -->
<%@include file="../includes/footer.jsp" %>


<!-- 댓글 Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
           		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
                        
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
                    <input class="form-control" name='reply' value='New Reply!!'>
                </div>
                        	
                <div class="form-group">
                    <label>Replyer</label>
                    <input class="form-control" name='replyer' value='New Replyer'>
                </div>
                        	
                <div class="form-group">
                    <label>Date</label>
                    <input class="form-control" name='replyDate' value=''>
                </div>    	
			</div>
                        
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
                <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                <button id="modalRegisterBtn" type="button" class="btn btn-danger">Register</button>
                <button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
            </div>
		</div>
		<!-- /.modal-content -->
	</div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->		

<script type="text/javascript" src="/resources/js/reply.js"> </script>

<script type="text/javascript">
	$(document).ready(function(){
		
		//console.log("===============================");
		//console.log("============JS TEST============");
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
/* 		function showList(page) {
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
							str += "<small class='pull-right text-muted'> " + replyService.displayTime(list[i].replyDate) + "</small></div>";
							str += "<p>" + list[i].reply + "</p></div></li>";
						}
						
						replyUL.html(str);
					}
			); //end function
		}	//end showList */
		
		function showList(page) {
			console.log("show list " + page);
			
			//해당 게시물의 모든 댓글을 가져오는지 확인
			replyService.getList(
					{bno:bnoValue, page: page || 1}, 
					function(replyCnt, list){
						console.log("replyCnt : " + replyCnt);
						console.log("list : " + list);
						console.log(list);
						
						//마지막 페이지를 찾아 다시 호출 (새로운 댓글 등록시)
						if(page == -1){
							pageNum = Math.ceil(replyCnt/10.0);
							showList(pageNum);
							return;
						}
						
						var str = "";

						if(list==null || list.length ==0) {
							//replyUL.html("");
							return;
						}
						
						for(var i=0, len = list.length||0; i<len; i++){
							str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
							str += "<div> <div class='header'> <strong class='primary-font'> " + list[i].replyer + "</strong>";
							str += "<small class='pull-right text-muted'> " + replyService.displayTime(list[i].replyDate) + "</small></div>";
							str += "<p>" + list[i].reply + "</p></div></li>";
						}
						
						replyUL.html(str);
						
						showReplyPage(replyCnt);
					}
			); //end function
		}	//end showList
		
		//댓글의 페이지 번호 출력 함수
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			var endNum = Math.ceil(pageNum/ 10.0) *10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum*10 < replyCnt){
				enxt=true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str += "<li class='page-item'> <a class='page-link' href='" +(startNum -1)+"'>Previous</a></li>";
			}
			
			for(var i= startNum; i <= endNum; i++){
				var active = pageNum == i? "active":"";
				
				str+="<li class='page-item " + active + "'><a class='page-link' href = '" + i + "'>" + i + "</a></li>";
			}
			
			if(next){
				str += "<li class='page-item'> <a class='page-link' href='" +(endNum + 1)+"'>Next</a></li>";
			}
			
			str += "</ul></div>";
			
			console.log(str);
			
			replyPageFooter.html(str);
		}
		
		var modal = $(".modal");	//class로 가져올 때 .
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");	//id로 가져올 때 #
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		var modalCloseBtn = $("modalCloseBtn");
		
		//댓글 입력 버튼 눌렀을 때,
		$("#addReplyBtn").on("click", function(e){
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show")		
		});
		
 		//새로운 댓글 추가 처리 
		modalRegisterBtn.on("click", function(e){
			var reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
			};
			
			replyService.add(
					reply,
					function(result){
						alert("RESELT : " + result);
						modal.find("input").val("");
						modal.modal("hide");
					}
				);
			
			//showList(1);
			showList(-1);	//마지막 페이지로 이동
		}); 
		
		//댓글 수정 처리
		modalModBtn.on("click", function(e){
			var reply = {
					rno : modal.data("rno"),
					reply : modalInputReply.val()
			};
			
			replyService.modify(
					reply,
					function(result){
						alert("RESELT : " + result);
						modal.modal("hide");
						//showList(1);
						showList(pageNum);
					}
				);
		});
		
		//댓글 삭제 처리
		modalRemoveBtn.on("click", function(e){
			var rno = modal.data("rno");
			
			replyService.remove(
					rno,
					function(result){
						alert("RESELT : " + result);
						modal.modal("hide");
						//showList(1);
						showList(pageNum);
					}
				);
		});
		
		
		//댓글 페이지 번호 클릭했을 때, 새로운 댓글 가져오는 부분
		replyPageFooter.on("click", "li a", function(e){
				e.preventDefault();
				console.log("Reply pageBtn Click");
				
				var targetPageNum = $(this).attr("href");
				
				console.log("targetPageNum : " + targetPageNum);
				
				pageNum = targetPageNum;
				showList(pageNum);
			});
				
		
		//댓글마다 이벤트 걸기
		$(".chat").on("click", "li", function(e) {
			var rno = $(this).data("rno");
			console.log("현재 선택한 댓글 번호 : " + rno);	
			
			replyService.get(rno, 
					function(reply){
						modalInputReply.val(reply.reply);
						modalInputReplyer.val(reply.replyer);
						modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
						modal.data("rno", reply.rno);
						
						modal.find("button[id != 'modalCloseBtn']").hide();
						modalModBtn.show();
						modalRemoveBtn.show();
						
						$(".modal").modal("show");
					}
			);
		});
		
		
		
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