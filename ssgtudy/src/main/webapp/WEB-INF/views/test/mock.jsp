<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">
function searchList(){
	var f = document.searchForm;
	f.submit();
}

</script>
</head>
<body>
	<div class="page-title">
		<div class="row">
			<div class="col-12 col-md-6 order-md-1 order-last">
				<h3>대학수학능력시험</h3>
				<p class="text-subtitle text-muted">평가원 기출문제입니다.</p>
			</div>
		</div>
	</div>
	<section class="section">
		<div class="row" id="basic-table">
			<div class="col-12 col-md-12">
            	<div class="card">
                    <div class="card-content">
                    	<div class="card-body">
                        	<div class="table-responsive">
                            	<table class="table table-lg" style="text-align: center">
                                	<thead>
                                    	<tr>
                                        	<th style="width:14.2%">번호</th>
                                        	<th style="width:29%">제목</th>
                                         	<th style="width:14.2%">작성자</th>
                                        	<th style="width:14.2%">등록일</th>
                                        	<th style="width:14.2%">조회수</th>
                                        	<th style="width:14.2%">파일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="dto" items="${list}">
	                                    	<tr>
	                                        	<td class="text-bold-500">${dto.listNum}</td> 
	                                        	<td>
	                                        		<a href="${articleUrl}&testNum=${dto.testNum}">${dto.testName} - ${dto.subName}(${dto.isOdd})</a>
	                                        	</td>
	                                        	<td class="text-bold-500">${dto.nickName}</td>
												<td>${dto.reg_date}</td>
	                                        	<td class="text-bold-500">${dto.hitCount}</td>
	                                        	<td class="text-bold-500">
	                                        		<c:if test="${dto.fileCount != 0}">
	                                        			<a href="${pageContext.request.contextPath}/test/zipdownload?testNum=${dto.testNum}">
	                                        				<i class="bi bi-download text-muted"></i>
	                                        			</a>
	                                        		</c:if>
	                                        	</td>
	                                    	</tr>
                                    	</c:forEach>	
                                    </tbody>
                                </table>
                                    <div class="page-box">
            							${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
          							</div>
                            </div>
                        </div>
                        		<div class="row board-list-footer">
							    	<div class="col-md-4 text-start">                                         
									</div>
									
									<div class="col-md-4 text-center">
										<form class="row" name="searchForm" action="${pageContext.request.contextPath}/test/mock" method="post">
											<div class="col-auto p-1 justify-content-center">
						                        <select class="form-select" id="basicSelect" name="condition">
							                        <option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
													<option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
													<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
													<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
													<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
						                        </select>
					                        </div>                           
											<div class="col-auto p-1 justify-content-center">
												<input type="text" id="first-name" class="form-control" name="keyword" value="${keyword}">                                          
											</div>
											<div class="col-auto p-1">                                                     
												<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="searchList()"><i class="bi bi-search"></i></button>
											</div>	
										</form> 
									</div>			                                                   
									<div class="col-md-4 text-end">
										<c:choose>  
			                      			<c:when test="${sessionScope.member.membership>50}">
												<button type="button" class="btn btn-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/test/write';">등록하기</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-primary me-1 mb-1" style="visibility: hidden;">등록하기</button>							
											</c:otherwise>
										</c:choose>
									</div>
								</div>
                    </div>
                </div>
            </div>
            
            
           
		</div>
	</section>
</body>
</html>