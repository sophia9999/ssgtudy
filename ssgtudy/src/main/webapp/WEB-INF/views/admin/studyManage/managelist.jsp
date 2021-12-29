<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.btn-primary {
	background : #9e47a9;
	border-color : #713479;
}

.btn-primary:hover {
	background : #9e47a9;
	border-color : #713479;
}

.btn-primary:hover {
	background : #713479;
	border-color : #713479;
}


.page-item.active .page-link {
	background-color : #9e47a9;
	border-color : #713479;
}

.page-link {
	color : #9e47a9;
}

.btn-outline-primary:hover {
	border-color : #713479;
}

.form-control {
	border : 1px solid #e7d5ea;
}

.form-select {
	border : 1px solid #e7d5ea;
}

</style>
<script type="text/javascript">
function search() {
	var f = document.searchForm;
	f.action = "${pageContext.request.contextPath}/studyManage/all";
	f.submit();
}

function checkReason(studyNum) {
	var url = "${pageContext.request.contextPath}/studyManage/reasonList";
	var query = "studyNum="+studyNum;
	var fn = function(data) {
		// console.log(data);
		$(".modal-body tbody").empty();
		var list = data.reasonList;
		var out = "";
		
		if(list.length == 0) {
			out += "<div class='pt-3'>신고내역이 존재하지 않습니다.</div>";
		}
		
		for(var i = 0; i<list.length; i++) {
			out += "<tr>";
			out += "	<td>"+list[i].userId+"</td>";
			out += "	<td>"+list[i].reason+"</td>";
			out += "</tr>";
		}
		
		$(".modal-body tbody").append(out);
	};
	
	ajaxFun(url, "get", query, "json", fn);
}

$(function() {
	$("body").on("click", ".changeStatus", function() {
		
		var current = $(this).closest("tr").find(".current-status").attr("data-current");
		var change = $(this).closest("tr").find(".studyActive option:selected").val();
		
		if(current == change) {
			alert("현재 상태와 바꾸려는 상태가 같습니다.");
			return false;
		}
		
		var studyNum = $(this).attr("data-studyNum");
		var url = "${pageContext.request.contextPath}/studyManage/changeStatus";
		var query = "studyNum="+studyNum+"&studyStatus="+change;
		var fn = function(data) {
			
			if(data.status == 'true') {
				alert("변경이 완료되었습니다.");
				location.href = "${pageContext.request.contextPath}/studyManage/all";
			}
		}
		
		ajaxFun(url, "get", query, "json", fn);
	});
});

</script>

<div class="page-title">
	<div class="row">
		<div class="col-12 col-md-6 order-md-1 order-last">
			<h3><span></span>스터디 관리 페이지</h3>
			<p class="text-subtitle text-muted">스터디 관리 페이지입니다.</p>
		</div>
	</div>
</div>
<section class="section">
	<div class="row" id="basic-table">
		<div class="col-12 col-md-12">
           	<div class="card">
            	<div class="card-header">
		        	${dataCount}개(${page}/${total_page} 페이지)
		        	<div class="text-end">
		        		<button type="button" class="btn btn-secondary" onclick="javascript:location.href='${pageContext.request.contextPath}/studyManage/all?condition=inactive';">정지스터디보기</button>
		        	</div>
		        </div>
                   <div class="card-content">
                   	<div class="card-body">
                       	<div class="table-responsive">
                           	<table class="table table-lg" style="text-align: center">
                               	<thead>
                                   	<tr>
                                       	<th class="col-md-1">번호</th>
                                       	<th class="col-auto">스터디이름</th>
                                       	<th class="col-md-1">상태</th>
                                       	<th class="col-md-3">상태변경</th>
                                       	<th class="col-md-1">신고누적횟수</th> <!-- 내역확인버튼 누르고 모달에서 신고 이유 보여줄 것 -->
                                       	<th class="col-md-2">사유확인</th>
                                      </tr>
                                   </thead>
                                   <tbody>
										<c:forEach var="dto" items="${list}">
										<tr>
                           	             	<td class="text-bold-500">${dto.listNum}</td>
                                        	<td class="text-bold-500">
                            	            	<c:if test="${dto.studyStatus == '1' }">
                                        			${dto.studyName}
                                        		</c:if>
                                        		<c:if test="${dto.studyStatus == '0' }">
                                        			<a href="${articleUrl}${dto.studyNum}">${dto.studyName}</a>
                                        		</c:if>
                                        	</td>
                                        	<td class="text-bold-500">
                                        		<c:if test="${dto.studyStatus == '1' }">
                                        			<a href="#" class="btn icon btn-danger current-status" data-current="${dto.studyStatus}"></a>
                                        		</c:if>
                                        		<c:if test="${dto.studyStatus == '0' }">
                                        			<a href="#" class="btn icon btn-success current-status" data-current="${dto.studyStatus}"></a>
                                        		</c:if>
                                        	</td>
											<td>
												<div class="input-group">
					                            	<select name="studyStatus" class="select form-select studyActive">
															<option value="0" ${dto.studyStatus == '0' ? "selected='selected'":"" }>활성화</option>
															<option value="1" ${dto.studyStatus == '1' ? "selected='selected'":"" }>비활성화</option>
													</select>
					                           		<button type="button" class="btn btn-primary changeStatus" data-studyNum="${dto.studyNum}">변경</button>
					                            </div>
											</td>
                                        	<td class="text-bold-500">${dto.reportCount}</td>
                                        	<td>
                                        		<button type="button" class="btn btn-primary"  data-bs-toggle="modal" data-bs-target="#checkWinning" >확인하기</button>
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
											<option value="studyName" ${condition=="studyName"?"selected='selected'":""}>스터디이름</option>
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
										<button type="button" class="btn btn-outline-primary" onclick="javascript:location.href='${pageContext.request.contextPath}/studyManage/all';">새로고침</button>
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
<div class="modal fade" id="reportReason" tabindex="-1" aria-labelledby="reportReasonLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl modal-dialog-scrollable">
		<div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="reportReasonLabel">신고사유확인</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        	<table class="table table-lg">
	        		<thead>
	        			<tr class="text-center">
	        				<td style="width: 25%;">신고자 ID</td>
	        				<td>이유</td>
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