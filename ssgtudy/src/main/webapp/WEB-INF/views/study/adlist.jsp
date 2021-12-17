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
			<h3><span><i class="icofont-bullhorn"></i></span> 스터디 홍보 게시판</h3>
			<p class="text-subtitle text-muted">스터디 홍보하고 함께할 스터디 구성원을 모아봐요:)</p>
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
                                       	<th class="col-auto">제목</th>
                                       	<th class="col-md-2">작성자</th>
                                       	<th class="col-md-2">등록일</th>
                                       	<th class="col-md-1">조회수</th>
                                      </tr>
                                   </thead>
                                   <tbody>
                                   	<c:forEach var="dto" items="${list}">
                                    	<tr>
                                        	<td class="text-bold-500">${dto.listNum}</td>
                                        	<td class="text-start"><a href="${articleUrl}&boardNum=${dto.boardNum}">${dto.subject}</a></td>
                                        	<td class="text-bold-500">${dto.nickName}</td>
											<td>${dto.reg_date}</td>
                                        	<td class="text-bold-500">${dto.hitCount}</td>
                                    	</tr>
                                   	</c:forEach>	
                                   </tbody>
                               </table>
                               
                               <div class="page-box">
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
											<option value="userName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
											<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
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
										<button type="button" class="btn btn-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/study/ad/write';">글올리기</button>
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
