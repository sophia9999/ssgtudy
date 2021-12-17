<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function search() {
	var f = document.searchForm;
	f.action = "${pageContext.request.contextPath}/study/rank/list2";
	f.submit();
}

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
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리 중 에러가 발생했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}
function memberAdd(studyNum) {
	var userId = "${sessionScope.member.userId}";
	
	var query = "userId="+userId+"&studyNum="+studyNum;
	var url = "${pageContext.request.contextPath}/study/member";
	var fn  = function(data) {

		if(data.status === "400") {
			alert("이미 참여중인 스터디이거나, 대기중입니다.");
		} else {
			alert("스터디 참여 신청이 완료되었습니다:)");
		}
	}
	ajaxFun(url, "get", query, "json", fn);
}

function visitHome(studyNum) {
	var url = "${pageContext.request.contextPath}/study/home/"+studyNum;
	location.href = url;
}

</script>

<section id="basic-horizontal-layouts">
    <div class="row match-height justify-content-center">
        <div class="col-8">
        <div class="page-title">
			<div class="row">
				<div class="col-12 col-md-6 order-md-1 order-last">
					<h3><span style="color: #ffc800;"><i class="icofont-trophy-alt"></i></span> 스터디 순위</h3>
					<p class="text-subtitle text-muted">
						목표달성횟수에 따른 스터디 순위입니다. <br>
						스터디상태가 비활성화되어있는 경우 순위에 산정되지 않습니다.
					</p>
				</div>
			</div>
		</div>
            <div class="card">
                <div class="card-content">
                    <div class="card-body">
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
									<div class="col-md-2 form-group">                                                     
										<button type="button" class="btn btn-outline-primary me-1 mb-1 btnSearch" onclick="search()">검색</button>
									</div>				                                                   
									<div class="col-md-2">
										<button type="button" class="btn btn-outline-primary me-1 mb-1 btnSearch" onclick="javascript:location.href='${pageContext.request.contextPath}/study/rank';">새로고침</button>
									</div>
								</div>
							</div>
						</form>   
                            <div class="form-body">
                                <div class="row" >
	                                <div class='list-header'>
										<span class='rank-count' data-pageNo="1" data-totalPage="1">검색된 스터디 ${dataCount}개</span>
										<span class='rank-title'></span>
									</div>
                                    <table class="table table-responsive rank-list">
                                    	<thead>
	                                    	<tr class="text-center">
	                                    		<th class="col-2">순위</th>
	                                    		<th class="col-auto">스터디이름</th>
	                                    		<th class="col-2">달성횟수</th>
	                                    		<th class="col-3">스터디홈</th>
	                                    	</tr>
                                    	</thead>
                                    	<tbody class="rank-list-body">
                                    		<c:if test="${not empty postRankList}">
                                    			<c:forEach items="${postRankList}" var="dto">
                                    				<tr class="text-center">
                                    					<td>${dto.rank}</td>
                                    					<td>${dto.studyName}</td>
                                    					<td>${dto.questCount}</td>
                                    					<td>
                                    						<button type='button' class='btn btn-primary' onclick="visitHome('${dto.studyNum}')">구경하기</button>
															<button type='button' class='btn btn-danger' onclick="memberAdd('${dto.studyNum}')">참여신청</button>
                                    					</td>
                                    				</tr>		
                                    			</c:forEach>
                                    		</c:if>
										</tbody>
                                    </table>
										<div class="page-box">
											${dataCount == 0 ? "등록된 스터디가 없습니다." : paging}
										</div>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>