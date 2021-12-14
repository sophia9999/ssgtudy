<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function search() {
	var f = document.searchForm;
	f.action = "${pageContext.request.contextPath}/study/ad";
	f.submit();
}
</script>

<div class="page-title">
	<div class="row">
		<div class="col-12 col-md-6 order-md-1 order-last">
			<h3>스터디 순위</h3>
			<p class="text-subtitle text-muted">목표 달성 횟수에 따른 스터디 순위입니다.</p>
		</div>
	</div>
</div>
<section class="section">
	<div class="row" id="basic-table">
		<div class="col-12 col-md-12">
           	<div class="card row match-height justify-content-center">
           		<div class="card-header">
					<form class="form form-horizontal" name="searchForm" method="post">
						<div class="form-body">
							<div class="row">
								<div class="col-md-2 form-group"></div> 
								<div class="col-md-2 form-group">
								<div class="col-auto">
								<div style="width:120px;" class="text-end">
									<select name="condition" class="form-select">
										<option value="all" ${condition=="all"?"selected='selected'":""}>이름+목표</option>
										<option value="studyName" ${condition=="studyName"?"selected='selected'":""}>스터디이름</option>
										<option value="studyGoal" ${condition=="studyGoal"?"selected='selected'":""}>스터디목표</option>
									</select>
								</div>
								</div>                                                      
								</div>                                      
								<div class="col-md-3 form-group">
									<input type="text" id="" class="form-control" name="keyword" value="${dto.keyword}">                                          
								</div>
								<div class="col-md-1 form-group">                                                     
									<button type="button" class="btn btn-outline-primary me-1 mb-1 btnSearch" onclick="search()">검색</button>
								</div>				                                                   
							</div>
						</div>
					</form> 
           		</div>
                   <div class="card-content">
                   	<div class="card-body">
                       	<div class="table-responsive">
                           	<table class="table table-lg" style="text-align: center">
                               	<thead>
                                   	<tr>
                                       	<th class="col-md-1">순위</th>
                                       	<th class="col-auto">스터디이름</th>
                                       	<th class="col-md-1">목표달성횟수</th>
                                    </tr>
                                </thead>
                                   <tbody>
                                   	<c:forEach var="dto" items="${list}">
                                    	<tr>
                                        	<td class="text-bold-500">${dto.listNum}</td>
                                        	<td><a href="${articleUrl}&boardNum=${dto.boardNum}">${dto.subject}</a></td>
                                        	<td class="text-bold-500">${dto.nickName}</td>
											<td>${dto.reg_date}</td>
                                        	<td class="text-bold-500">${dto.hitCount}</td>
                                    	</tr>
                                   	</c:forEach>	
                                   </tbody>
                               </table>
                               
                           </div>
                       </div>
                   </div>
               </div>
           </div>
	</div>
</section>
