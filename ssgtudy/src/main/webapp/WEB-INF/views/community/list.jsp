<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://kit.fontawesome.com/a8b55df315.js" crossorigin="anonymous"></script>

<style type="text/css">
.container {
	text-align: center;
	
}
.body-title {
	margin: 20px;
}

</style>

<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.submit();
}

$(function(){
	$("#chkAll").click(function(){
		$("input[name=chkRow]").prop("checked", $(this).is(":checked"));
	});
	
	$(".btnDeleteList").click(function(){
		var cnt = $("input[name=chkRow]:checked").length;
		
		if(cnt === 0) {
			alert("삭제할 게시글을 선택해주세요.");
			return false;
		}
		
		if(confirm("삭제하시겠습니까?")) {
			var f = document.listForm;
			f.action = "${pageContext.request.contextPath}/community/deleteList";
			f.submit();
		}
	});
});
</script>
	
<section class="row">
	<div class="container">
		<div class="body-title">
			<c:choose>
				<c:when test="${sessionScope.member.membership > 50}">
					<h3><i class="fas fa-school"></i><span> 학교 커뮤니티 관리자 모드 </span></h3>
				</c:when>
				<c:otherwise>
					<h3><i class="fas fa-school"></i><span> ${sessionScope.member.schoolName} 우리들 이야기 </span></h3>
				</c:otherwise>
			</c:choose>
		</div>
		
		<div class="body-main">
			<div class="row board-list-header">
				<div class="col-auto me-auto">
			    	${dataCount}개(${page}/${total_page} 페이지)
			     </div>
			    <div class="col-auto">&nbsp;</div>
			</div>
			        
			<div class="card">
				<form method="post" name="listForm">
				<table class="table table-lg">
					<thead>
						<tr>
							<c:if test="${sessionScope.member.membership > 50}">
								<th><input type="checkbox" name="chkAll" id="chkAll" value="all"></th>
							</c:if>
								<th class="col-1">번호</th>
								<th class="col-4">제목</th>
								<th class="col-2">작성자</th>
								<th class="col-2">작성일</th>
								<th class="col-1">조회수</th>
								<th class="col-2">파일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}">
							<tr>
								<c:if test="${sessionScope.member.membership > 50}">
									<td><input type="checkbox" name="chkRow" value="${dto.boardNum}"></td>
								</c:if>
								<td class="text-bold-500">${dto.listNum}</td>
								<td>
									<a href="${articleUrl}&boardNum=${dto.boardNum}">
										${dto.subject}
									</a>
									<c:if test="${dto.replyCount!=0}">(${dto.replyCount})</c:if>
								</td>
								<td class="text-bold-500">${dto.nickName}</td>
								<td class="text-bold-500">${dto.reg_date}</td>
								<td class="text-bold-500">${dto.hitCount}</td>
								<td>
									<c:if test="${dto.fileCount != 0}">
										<a href="${pageContext.request.contextPath}/community/zipdownload?boardNum=${dto.boardNum}" class="text-reset"><i class="bi bi-file-arrow-down"></i></a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</form>
				
			   <div class="page-box">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>
				
						<div class="row board-list-footer">
						<div class="col-md-4 text-start">
							<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/community/main';">새로고침</button>
							<c:if test="${sessionScope.member.membership > 50 }">
								<button type="button" class="btn btn-outline-primary me-1 mb-1 btnDeleteList">선택삭제</button>
							</c:if>
						</div>
						<div class="col-md-4 text-center">
							<form class="row" name="searchForm" action="${pageContext.request.contextPath}/community/main" method="post">
								<div class="col-auto p-1">
									<select name="condition" class="form-select">
										<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
										<option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
										<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
										<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
										<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
									</select>
								</div>
								<div class="col-auto p-1">
									<input type="text" name="keyword" value="${keyword}" class="form-control">
								</div>
								<div class="col-auto p-1">
									<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="searchList()"> <i class="bi bi-search"></i> </button>
								</div>
							</form>
						</div>
						<div class="col-md-4 text-end">
							<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/community/write';">글올리기</button>
						</div>
					</div>
           
				</div>
			</div>
		</div>   
</section>