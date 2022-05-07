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
                                		<%-- <td><a href='/board/get?bno=<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></td> --%>
                                		<td>
                                			<a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/>
                                				<b>[ <c:out value="${board.replyCnt}"/> ]</b>
                                			</a>
                                		</td>
                                		<td><c:out value="${board.writer}"/> </td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.cdate}"/> </td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.udate}"/> </td>
                                	</tr>
                                </c:forEach>
                                
                            </table>
                            <!-- /.table-responsive -->
                            
<%--                             <!-- 수정 전 : 검색 조건 처리 부분 시작 -->
                            <div class='row'>
                            	<div class="col-lg-12">
                            		<form id='searchForm' action="/board/list" method="get">
                            			<select name='type'>
                            				<option value="">---</option>
                            				<option value="T">제목</option>
                            				<option value="C">내용</option>
                            				<option value="W">작성자</option>
                            				<option value="TC">제목 or 내용</option>
                            				<option value="TW">제목 or 작성자</option>
                            				<option value="WC">내용 or 작성자</option>
                            				<option value="TCW">제목 or 내용 or 작성자</option>
                            			</select>
                            			
                            			<input type='text' name='keyword' />
                            			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'/>
                            			<input type='hidden' name='amount' value='${pageMaker.cri.amount}'/>
                            			<button class='btn btn-default'>Search</button>
                            		</form>
                            	</div>
                            </div>
                            <!-- 수정 전 : 검색 조건 처리 부분 끝 --> --%>
                            
                            <!-- 수정 후 : 검색 조건 처리 부분 시작 -->
                            <div class='row'>
                            	<div class="col-lg-12">
                            		<form id='searchForm' action="/board/list" method="get">
                            			<select name='type'>
                            				<option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>---</option>
                            				<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected':'' }"/>>제목</option>
                            				<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected':'' }"/>>내용</option>
                            				<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected':'' }"/>>작성자</option>
                            				<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected':'' }"/>>제목 or 내용</option>
                            				<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected':'' }"/>>제목 or 작성자</option>
                            				<option value="WC" <c:out value="${pageMaker.cri.type eq 'WC' ? 'selected':'' }"/>>내용 or 작성자</option>
                            				<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected':'' }"/>>제목 or 내용 or 작성자</option>
                            			</select>
                            			
                            			<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'/>
                            			<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
                            			<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
                            			<button class='btn btn-default'>Search</button>
                            		</form>
                            	</div>
                            </div>
                            <!-- 수정 후 : 검색 조건 처리 부분 끝 -->
                            
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
                            	<input type='hidden' name='type' value = '${pageMaker.cri.type}'>
                            	<input type='hidden' name='keyword' value = '${pageMaker.cri.keyword}'>
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
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));	//현재 선택한 번호의 href값을 가져와 pageNum값으로 세팅한다.
			actionForm.submit();
		});
		
		
		$(".move").on("click", function(e) {
			e.preventDefault(); //<a> 태크를 클릭해도 페이지 이동이 없도록 하는 함수
			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>"); //현재 선택한 태그의 href 속성에 적혀져 있는 값을 가져와 bno값으로 세팅한다.
			actionForm.attr("action", "/board/get"); //action 값 변경
			actionForm.submit();
		});
		
		
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e) {
			
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");	//검색 후 페이지 번호는 1이 되도록 세팅
			e.preventDefault();
			
			searchForm.submit();
		});
	});	
	
</script>

<%@include file="../includes/footer.jsp" %>
