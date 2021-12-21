<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.ck.ck-editor__main>.ck-editor__editable:not(.ck-focused) { 
	border: none;
}
</style>
<script type="text/javascript">
<c:if test="${sessionScope.member.userId==dto.userId||sessionScope.member.membership>50 || studyDto.role >= 10}">
	function deleteBoard() {
	    if(confirm("게시글을 삭제 하시겠습니까 ? ")) {
		    var query = "boardNum=${dto.boardNum}&${query}";
		    var url = "${pageContext.request.contextPath}/study/ad/delete?" + query;
	    	location.href = url;
	    }
	}
</c:if>
</script>
<div class="card table-responsive">
	<table class="table mb-0 table-lg">
		<thead>
			<tr>
				<td colspan="2" align="center">
					<h5>${dto.subject}</h5>
				</td>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td width="50%">
					작성자 : ${dto.nickName}
				</td>
				<td align="right">
					${dto.reg_date} | 조회 ${dto.hitCount}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" valign="top" height="200" style="padding-top: 5px;">
					<div class="editor">${dto.content}</div>
				</td>
			</tr>
		</tbody>
	</table>
				
	<table class="table table-borderless mb-2 table-lg">
		<tr>
			<td width="50%">
				<c:choose>
					<c:when test="${sessionScope.member.userId==dto.userId}">
						<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/study/home/'+${studyNum}+'/update?boardNum=${dto.boardNum}&page=${page}';">수정</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-outline-primary me-1 mb-1" disabled="disabled">수정</button>
					</c:otherwise>
				</c:choose>
		    	
				<c:choose>
		    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.membership>50 || studyDto.role >= 10}">
		    			<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="deleteBoard();">삭제</button>
		    		</c:when>
		    		<c:otherwise>
		    			<button type="button" class="btn btn-outline-primary me-1 mb-1" disabled="disabled">삭제</button>
		    		</c:otherwise>
		    	</c:choose>
			</td>
			<td class="text-end">
				<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='history.back()';">리스트</button>
			</td>
		</tr>
	</table>
</div>
		