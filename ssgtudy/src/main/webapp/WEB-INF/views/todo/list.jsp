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
				<h3>To Do List</h3>
				<p class="text-subtitle text-muted"> 내 게시판</p>
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
                                        	<th style="width:10%">번호</th>
                                        	<th style="width:10%">제목</th>
                                         	<th style="width:65%">내용</th>
                                        	<th style="width:15%">등록일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="dto" items="${list}">
	                                    	<tr>
	                                        	<td class="text-bold-500">${dto.listNum}</td> 
	                                        	<td>
	                                        		<a href="${articleUrl}&todoNum=${dto.todoNum}">${dto.subject}</a>
	                                        	</td>
	                                        	<td class="text-bold-500">${dto.content}</td>
												<td>${dto.reg_date}</td>
	                                    	</tr>
                                    	</c:forEach>	
                                    </tbody>
                                </table>
                                    <div class="page-box">
            							${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
          							</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            
            <form class="form form-horizontal" name="searchForm"
            	action="${pageContext.request.contextPath}/todo/list" method="post">
				<div class="form-body">
				    <div class="row" >
				    	<div class="col-md-3 justify-content-center">                                         
						</div>
						<fieldset class="col-md-2 justify-content-center">
	                        <select class="form-select" id="basicSelect" name="condition">
		                        <option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
								<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
								<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
								<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
	                        </select>
                        </fieldset>                           
						<div class="col-md-3 justify-content-center">
							<input type="text" id="first-name" class="form-control" name="keyword" value="${keyword}">                                          
						</div>
						<div class="col-md-2 form-group">                                                     
							<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="searchList()">검색</button>
						</div>				                                                   
						<div class="col-md-2 justify-content-end">
							<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/todo/write';">등록</button>
							<button type="reset" class="btn btn-outline-primary me-1 mb-1">새로고침</button>
						</div>
					</div>
				</div>
			</form>   
		</div>
	</section>
</body>
</html>