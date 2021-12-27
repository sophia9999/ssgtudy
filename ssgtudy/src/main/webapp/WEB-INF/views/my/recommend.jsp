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
</head>
<body>
	<div class="page-title">
		<div class="row">
			<div class="col-12 col-md-6 order-md-1 order-last">
				<h3>내가 추천한 글</h3>
				<p class="text-subtitle text-muted">내가 추천한 글</p>
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
                                        	<th style="width:16.66%">번호</th>
                                        	<th style="width:33.33%">게시판</th>
                                         	<th style="width:16.66%">제목</th>
                                        	<th style="width:16.66%">등록일</th>
                                        	<th style="width:16.66%">조회수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="dto" items="${list}">
	                                    	<tr>
	                                        	<td class="text-bold-500">${dto.listNum}</td>
	                                        	<td class="text-bold-500">${dto.boardTitle}</td>
	                                        	<td><a href="${pageContext.request.contextPath}/${dto.boardUrl}${dto.num}&page=1">${dto.subject}</a></td>
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
            
			<div class="page-box">
				${recdataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
			            
		</div>
	</section>
</body>
</html>