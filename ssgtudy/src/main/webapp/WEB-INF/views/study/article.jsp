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
<c:if test="${sessionScope.member.userId==dto.userId||sessionScope.member.membership>50}">
	function deleteBoard() {
	    if(confirm("게시글을 삭제 하시겠습니까 ? ")) {
		    var query = "boardNum=${dto.boardNum}&${query}";
		    var url = "${pageContext.request.contextPath}/study/ad/delete?" + query;
	    	location.href = url;
	    }
	}
</c:if>
</script>
<script type="text/javascript">
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
				alert("요청 처리 중 에러가 발생했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}
function memberAdd() {
	var userId = "${sessionScope.member.userId}";
	var studyNum = "${dto.studyNum}";
	
	var query = "userId="+userId+"&studyNum="+studyNum;
	var url = "${pageCcontext.request.contextPath}/study/study/member";
	var fn  = function(data) {
		
		if(data.status === "400") {
			alert("이미 참여중인 스터디이거나, 대기중입니다.");
		} else {
			alert("스터디 참여 신청이 완료되었습니다:)");
		}
	}
	ajaxFun(url, "get", query, "json", fn);
}
</script>

<div class="page-title">
	<div class="row">
		<div class="col-12 col-md-6 order-md-1 order-last">
			<h3>스터디 홍보 게시판</h3>
			<p class="text-subtitle text-muted">스터디 홍보하고 함께할 스터디 구성원을 모아봐요:)</p>
		</div>
	</div>
</div>
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
			<tr>
				<td colspan="2" align="center">
					<c:choose>
						<c:when test="${sessionScope.member.userId == dto.userId }">
							<button type="button" class="btn-danger btn btn-lg" disabled="disabled">스터디 참여 신청하기</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn-danger btn btn-lg" onclick="memberAdd()">스터디 참여 신청하기</button>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
				
	<table class="table table-borderless mb-2 table-lg">
		<tr>
			<td width="50%">
				<c:choose>
					<c:when test="${sessionScope.member.userId==dto.userId}">
						<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/study/ad/update?boardNum=${dto.boardNum}&page=${page}';">수정</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-outline-primary me-1 mb-1" disabled="disabled">수정</button>
					</c:otherwise>
				</c:choose>
		    	
				<c:choose>
		    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.membership>50}">
		    			<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="deleteBoard();">삭제</button>
		    		</c:when>
		    		<c:otherwise>
		    			<button type="button" class="btn btn-outline-primary me-1 mb-1" disabled="disabled">삭제</button>
		    		</c:otherwise>
		    	</c:choose>
			</td>
			<td class="text-end">
				<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/study/ad?${query}';">리스트</button>
			</td>
		</tr>
	</table>
</div>
		