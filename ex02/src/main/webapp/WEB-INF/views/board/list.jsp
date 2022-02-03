<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading"> Board List Page 
                        	<button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>#번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                
                                <c:forEach items="${list}" var="board">
                                	<tr>
                                		<td><c:out value="${board.bno}"/> </td>
                                		<td><a href='/board/get?bno=<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></td>
                                		<td><c:out value="${board.writer}"/> </td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.cdate}"/> </td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.udate}"/> </td>
                                	</tr>
                                </c:forEach>
                                
                            </table>
                            <!-- /.table-responsive -->
                            
                             <!-- start Pagination -->
                            <div class='pull-right'>
                            	<ul class="pagination">
                            	
                            		<c:if test="${pageMaker.prev}">
                            			<li class="paginate_button previous"> 
                            				<!--  <a href="#">Previous</a> -->
                            				<a href="${pageMaker.startPage - 1 }">Previous</a>
                            			</li>
                            		</c:if>
                            		
                            		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            			<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : "" } "> 
                            		<!--<li class="paginate_button"> 
                            				  <a href="#">${num}</a>  -->
                            				<a href="${num}">${num}</a>
                            			</li>
                            		</c:forEach>
                            		
                            		<c:if test="${pageMaker.next}">
                            			<li class="paginate_button next"> 
                            				<!--  <a href="#">Next</a> -->
                            				<a href="${pageMaker.endPage + 1 }">Next</a>
                            			</li>
                            		</c:if>
                            		
                            	</ul>
                            </div>
                            <!-- end Pagination -->
                            
                            <form id='actionForm' action="/board/list" method='get'>
                            	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum}'>
                            	<input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
                            </form>
                            
	                        <!-- Modal  추가 -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">Modal title</h4>
										</div>
										<div class="modal-body">처리가 완료되었습니다.</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
											<button type="button" class="btn btn-primary">Save changes</button>
										</div>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
							<!-- /.modal -->
							
                        </div>
                        <!-- /.end panel-body -->
                    </div>
                    <!-- /.end panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

<script type="text/javascript">
	$(document).ready(function(){
		var result= '<c:out value="${result}"/>';
		
		checkModal(result);
		
		history.replaceState({}, null, null); //뒤로가기시에 모달창이 또 뜨는 것을 방지하기 위함.
		
		function checkModal(result){
			if(result === '' || history.state){
				return;
			}
			
			if(result === 'success'){
				$(".modal-body").html("정상적으로 처리 되었습니다.");
				$("#myModal").modal("show");
				return;
			}
			
			if(parseInt(result) > 0){
				$(".modal-body").html("게시글 "+ parseInt(result) + "번이 등록되었습니다.");
				$("#myModal").modal("show");
				return;
			}
		}
		
		$("#regBtn").on("click", function() {
			self.location ="/board/register";
		});
		
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();	//<a> 태크를 클릭해도 페이지 이동이 없도록 하는 함수
			
			console.log('Click');
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));	//<form> 태그 내 pageNum 값은 href 속성값으로 변형하는 것
			actionForm.submit();
		});
	});	
	
</script>

<%@include file="../includes/footer.jsp" %>