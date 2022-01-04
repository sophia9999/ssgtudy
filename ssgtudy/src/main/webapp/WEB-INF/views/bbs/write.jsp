<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.col-md-2 {
	text-align: center;
}
.content {
	text-align: center;
    display: flex;
    flex-flow: row nowrap;
    align-items: center;
}
.fileBtn {
	background: white;
	color : #ce4848;
	border : none;
}
</style>
<script type="text/javascript">
function sendOk() {
	var f = document.boardForm;
	var str;
	
	str = f.subject.value.trim();
	if(!str) {
		alert("제목을 입력하세요");
		f.subject.focus();
		return;
	}
	
	str = f.content.value.trim();
	if(!str) {
		alert("내용을 입력하세요");
		f.content.focus();
		return;
	}

	f.action = "${pageContext.request.contextPath}/bbs/${mode}";
	f.submit();
}

<c:if test="${mode=='update'}">
	function deleteFile(bbs_fileNum){
		var url = "${pageContext.request.contextPath}/bbs/deleteFile";
		$.post(url, {bbs_fileNum : bbs_fileNum}, function(data){
			$("#f"+bbs_fileNum).remove();
		}, "json");
	}
</c:if>
</script>

<div class="col-md-12 col-12">
	<div class="card">
		<div class="card-header">
			<h4 class="card-title">
			<i class="bi bi-pencil-square fs-3"></i>                  
			게시글 작성하기
			</h4>
		</div>
		<div class="card-content">
			<div class="card-body">
				<form class="form form-horizontal" name="boardForm" method="post" enctype="multipart/form-data">
					<div class="form-body">
						<div class="row">
							<div class="col-md-2">
								<label>제목</label>
							</div>
							<div class="col-md-10 form-group">
								<input type="text" id="subject" class="form-control" name="subject" placeholder="제목을 작성하세요." 
									maxlength="100" value="${dto.subject}">
							</div>
							<div class="col-md-2">
								<label>작성자</label>
							</div>
							<div class="col-md-10 form-group">
								<input type="text" id="nickName" class="form-control" name="nickName" readonly="readonly"
									maxlength="10" value="${sessionScope.member.nickName}">
							</div>
							<div class="col-md-2 content">
								<label style="margin: auto">내용</label>
							</div>
							<div class="col-md-10 form-group">
								<textarea id="content" class="form-control" name="content"  style="height:300px">
									${dto.content}
								</textarea>
							</div>
							<div class="col-md-2">
								<label>첨부</label>
							</div>
							<div class="col-md-10 form-group">
								<input type="file" class="form-control" name="selectFile" multiple="multiple">
							</div>
							
							<div class="col-md-2">
								<label>첨부된 파일</label>
							</div>
							<div class="col-md-10">
							<c:if test="${mode=='update'}">
								<c:forEach var="vo" items="${listFile}">
									<div id="f${vo.bbs_fileNum}">
										<p class="form-control-plaintext">
											<a href="javascript:deleteFile('${vo.bbs_fileNum}');">
											${vo.originalFilename}&nbsp<label style="color:#b41758">X</label>
											</a>
										</p>
									</div>
								</c:forEach>
							</c:if>
							</div>
							<div class="col-sm-12 d-flex justify-content-end">
								<button type="reset" class="btn btn-light-secondary me-1 mb-1">다시입력</button>
								<button type="button" class="btn btn-light-secondary me-1 mb-1"
									onclick="location.href='${pageContext.request.contextPath}/bbs/list';">${mode=="update"?"수정취소":"등록취소"}&nbsp;<i class="bi bi-x"></i></button>	
								<button type="button" class="btn btn-primary me-1 mb-1" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="bbsNum" value="${dto.bbsNum}">
									<input type="hidden" name="page" value="${page}">
									<input type="hidden" name="bbs_fileNum" value="${dto.bbs_fileNum}">
								</c:if>
							</div>
							
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>		
