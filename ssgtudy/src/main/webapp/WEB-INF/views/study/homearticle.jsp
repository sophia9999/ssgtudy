<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.ck.ck-editor__main>.ck-editor__editable:not(.ck-focused) { 
	border: none;
}
</style>
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
			<c:if test="${not empty message}">
				<tr>
					<td colspan="2" valign="top" height="200" style="padding-top: 5px;">
					<div><h5 class="text-center">${message.msg}</h5></div>
				</td>
				</tr>
			</c:if>
			<c:if test="${empty message}">
			<tr>
				<td colspan="2" valign="top" height="200" style="padding-top: 5px;">
					<div class="editor">${dto.content}</div>
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>
				
	<table class="table table-borderless mb-2 table-lg">
		<tr>
			<td width="50%">
				<c:choose>
					<c:when test="${sessionScope.member.userId==dto.userId}">
						<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="amendArticle()">수정</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-outline-primary me-1 mb-1" disabled="disabled">수정</button>
					</c:otherwise>
				</c:choose>
		    	
				<c:choose>
		    		<c:when test="${studyDto.role >= 10 || sessionScope.member.userId==dto.userId}}">
		    			<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="deleteBoard('${dto.boardNum}');">삭제</button>
		    		</c:when>
		    		<c:otherwise>
		    			<button type="button" class="btn btn-outline-primary me-1 mb-1" disabled="disabled">삭제</button>
		    		</c:otherwise>
		    	</c:choose>
			</td>
			<td class="text-end">
				<button type="button" class="btn btn-outline-primary me-1 mb-1 btnBack">리스트</button>
			</td>
			
		</tr>
	</table>
</div>

<script type="text/javascript">


$(function() {
	$("body").on("click", ".btnBack", function() {
		var url = '${pageContext.request.contextPath}/study/home/${studyNum}/list';
		var query = '${query}'+"&categoryNum="+${categoryNum};
		
		// console.log(query);
		var selector = "#myTabContent";
		
		var fn = function(data){
			$(".box").empty();
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
		
	});
});

function deleteBoard(boardNum) {
	if(! confirm("게시글을 삭제하시겠습니까 ?")) {
		return false;
	}
	var url = "${pageContext.request.contextPath}/study/home/remove";
	var query = "categoryNum="+${categoryNum}+"&boardNum="+boardNum+"&studyNum="+${studyNum};
	var fn = function(data) {
		listPage(1);
	};
	
	ajaxFun(url, "get", query, "html", fn);
}

<c:if test="${sessionScope.member.userId==dto.userId}">
function amendArticle() {
	var url = '${pageContext.request.contextPath}/study/home/'+${studyNum}+'/list/update';
	var query = "studyNum="+${studyNum}+"&categoryNum="+${categoryNum}+"&boardNum="+${dto.boardNum}+"&page="+${page};
	
	var selector = "#myTabContent";
	
	var fn = function(data) {
		console.log(data);
		$(".box").empty();
		$(selector).html(data);
	}
	ajaxFun(url, "get", query, "html", fn);
}
</c:if>
</script>
		