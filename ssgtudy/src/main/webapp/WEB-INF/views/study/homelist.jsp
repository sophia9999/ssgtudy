<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
                                       	<th style="width:16.66%">번호</th>
                                       	<th style="width:33.33%">제목</th>
                                        	<th style="width:16.66%">작성자</th>
                                       	<th style="width:16.66%">등록일</th>
                                       	<th style="width:16.66%">조회수</th>
                                       </tr>
                                   </thead>
                                   <tbody>
                                   	<c:forEach var="dto" items="${list}">
                                    	<tr>
                                        	<td class="text-bold-500">${dto.bbsNum}</td>
                                        	<td><a href="${articleUrl}">${dto.subject}</a></td>
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
           <form class="form form-horizontal">
			<div class="form-body">
				<div class="row"> 
					<div class="col-md-4 form-group">                                                           
					</div>                                      
					<div class="col-md-3 form-group">
						<input type="text" id="first-name" class="form-control" name="fname" placeholder="검색">                                          
					</div>
					<div class="col-md-1 form-group">                                                     
						<button type="button" class="btn btn-outline-primary me-1 mb-1">검색</button>
					</div>				                                                   
					<div class="col-md-4 d-flex justify-content-end">
						<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/study/home/${dto.studyNum}/list/write';">등록</button>
						<button type="reset" class="btn btn-outline-primary me-1 mb-1">취소</button>
					</div>
				</div>
			</div>
		</form>   
	</div>
</section>