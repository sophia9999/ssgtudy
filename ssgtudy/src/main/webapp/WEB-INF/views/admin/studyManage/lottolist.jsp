<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function search() {
	var f = document.searchForm;
	f.action = "${pageContext.request.contextPath}/studyManage/lotto";
	f.submit();
}
</script>

<div class="page-title">
	<div class="row">
		<div class="col-12 col-md-6 order-md-1 order-last">
			<h3><span><i class="icofont-magic-alt"></i></span>이벤트 관리</h3>
			<p class="text-subtitle text-muted">이벤트 관리 페이지입니다.</p>
		</div>
	</div>
</div>
<section class="section">
	<div class="row" id="basic-table">
		<div class="col-12 col-md-12">
           	<div class="card">
            	<div class="card-header">
		        	${dataCount}개(${page}/${total_page} 페이지)
		        </div>
                   <div class="card-content">
                   	<div class="card-body">
                       	<div class="table-responsive">
                           	<table class="table table-lg" style="text-align: center">
                               	<thead>
                                   	<tr>
                                       	<th class="col-md-1">번호</th>
                                       	<th class="col-md-auto">이벤트제목</th>
                                       	<th class="col-md-2">마감일</th>
                                       	<th class="col-md-2">카테고리</th>
                                       	<th class="col-md-2">당첨정보</th>
                                      </tr>
                                   </thead>
                                   <tbody>
										<c:forEach var="dto" items="${list}">
										<tr>
                           	             	<td class="text-bold-500">${dto.listNum}</td>
                                        	<td class="text-bold-500"><a href="${articleUrl}&eventNum=${dto.eventNum}">${dto.subject}</a></td>
                                        	<td class="text-bold-500">${dto.lottoDate}</td>
											<td class="text-bold-500">${dto.eventCategory}</td>
                                        	<td class="text-bold-500">
                                        		<button type="button" class="btn btn-primary" data-eventNum="${dto.eventNum}"  data-bs-toggle="modal" data-bs-target="#checkWinning">확인</button>
                                        	</td>
                                    	</tr>
                                    	</c:forEach>
                                   </tbody>
                               </table>
                               
                               <div class="page-box text-center">
								${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
							</div>
                               
                           </div>
                           <form class="form form-horizontal" name="searchForm" method="post">
							<div class="form-body">
								<div class="row">
									<div class="col-md-2 form-group">
									</div> 
									<div class="col-md-2 form-group">
									<div class="col-auto">
									<div style="width:120px;" class="text-end">
										<select name="condition" class="form-select">
											<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
											<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
											<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
										</select>
									</div>
									</div>                                                      
									</div>                                      
									<div class="col-md-3 form-group">
										<input type="text" id="" class="form-control" name="keyword" value="${keyword}">                                          
									</div>
									<div class="col-md-1 form-group">                                                     
										<button type="button" class="btn btn-outline-primary me-1 mb-1 btnSearch" onclick="search()">검색</button>
									</div>				                                                   
									<div class="col-md-4 justify-content-end text-end">
										<button type="button" class="btn btn-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/studyManage/event/write';">글올리기</button>
									</div>
								</div>
							</div>
						</form>   
                       </div>
                   </div>
               </div>
           </div>
	</div>
</section>
<div class="modal fade" id="checkWinning" tabindex="-1" aria-labelledby="checkWinningLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="checkWinningLabel">이벤트 당첨 관리</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        	<table class="table table-lg">
	        		<thead>
	        			<tr class="text-center">
	        				<td>
	        					뽑을 명수/스터디그룹 개수를 입력하세요. <br>
	        					<input type="number" placeholder="숫자를 입력하세요." class="form-control" name="quantity">
	        				</td>
	        			</tr>
	        		</thead>
	        		<tbody>
	        		</tbody>
	        	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
	      </div>
	    </div>
	</div>
</div>

<script type="text/javascript">
var isRun = false; // AJAX 중복요청방지용 변수

function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
			isRun = false;
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}


</script>