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
<style type="text/css">
.content {
	text-align: center;
    display: flex;
    flex-flow: row nowrap;
    align-items: center;
}
</style>
<script type="text/javascript">
<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	function deleteBoard(){
		if(confirm("게시글을 삭제하시겠습니까?")){
			var query = "bbsNum=${dto.bbsNum}&${query}";
			var url = "${pageContext.request.contextPath}/bbs/delete?" + query;
			location.href=url;
		}
	}
</c:if>
</script>
</head>
<body>
	<div class="page-title">
		<div class="row">
			<div class="col-12 col-md-6 order-md-1 order-last">
				<h3>자유게시판</h3>
				<p class="text-subtitle text-muted">친구들과 자유롭게 이야기해요</p>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-12">
       <div class="card">
           <div class="card-content">
               <div class="card-body">
                   <div class="table-responsive">
                       <table class="table table-lg">
                           <tr>
	                           <td colspan="2" align="center">${dto.subject}</td>
                           </tr>
                           <tr>
                           		<td width="50%">
                           			작성자 : ${dto.nickName}
                           		</td>
                           		<td align="right">
                           			${dto.reg_date} &nbsp|&nbsp 조회 ${dto.hitCount}
                           		</td>
                           </tr> 
                           <tr>
	                           <td colspan="2" height="300px">${dto.content}</td>
                           </tr>
                           
                           <c:forEach var="vo" items="${listFile}">
                           		<tr>
                           			<td colspan="2">
                           				파일 : 
                           				<a href="${pageContext.request.contextPath}/bbs/download?bbs_fileNum=${vo.bbs_fileNum}">${vo.originalFilename}</a>
                           				(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> kb)
                           			</td>
                           		</tr>
                           </c:forEach>
                           
                           <tr>
                           		<td colspan="2">
                           			이전글 :
                           			<c:if test="${not empty preReadDto}">
                           				<a href="${pageContext.request.contextPath}/bbs/article?bbsNum=${preReadDto.bbsNum}&${query}">${preReadDto.subject}</a>
                           			</c:if>
                           		</td>
                           </tr>  
                           <tr>
                           		<td colspan="2">
                           			다음글 :
                           			<c:if test="${not empty nextReadDto}">
                           				<a href="${pageContext.request.contextPath}/bbs/article?bbsNum=${nextReadDto.bbsNum}&${query}">${nextReadDto.subject}</a>
                           			</c:if>
                           		</td>
                           </tr>  
                       </table>
                      	<div class="col-md-2 justify-content-start">
                      		<button type="button"  class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/bbs/list?${query}';">리스트</button>	
                      		<c:choose>
                      			<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
									<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/bbs/update?bbsNum=${dto.bbsNum}&page=${page}';">수정</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-outline-primary me-1 mb-1" style="visibility: hidden;">수정</button>							
								</c:otherwise>
							</c:choose>	
							<c:choose>
                      			<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
									<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="deleteBoard();">삭제</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-outline-primary me-1 mb-1" style="visibility: hidden;">삭제</button>							
								</c:otherwise>
							</c:choose>	
						</div>
                   </div>
               </div>
           </div>
       </div>
   </div>
</body>
</html>