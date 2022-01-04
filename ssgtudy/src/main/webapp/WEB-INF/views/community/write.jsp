<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://kit.fontawesome.com/a8b55df315.js" crossorigin="anonymous"></script>

<script type="text/javascript">
function sendOk() {
    var f = document.boardForm;
	var str;
	
    str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요.");
        f.subject.focus();
        return;
    }

    str = f.content.value.trim();
    if(!str) {
        alert("내용을 입력하세요.");
        f.content.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/community/${mode}";
    f.submit();
}

<c:if test="${mode=='update'}">
	function deleteFile(fileNum) {
		var url = "${pageContext.request.contextPath}/community/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
	}
</c:if>
</script>

<section class="row">
	<div class="card">
		<div class="body-title">
			&nbsp;
			<h3><i class="fas fa-pen-square"></i> 학교 커뮤니티 글쓰기 </h3>
			&nbsp;
		</div>
		<form name="boardForm" method="post" enctype="multipart/form-data">
			<table class="table table-lg">
						<tr>
							<td class="table-light col-sm-2" scope="row">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control" value="${dto.subject}">
							</td>
						</tr>
	        
						<tr>
							<td class="table-light col-sm-2" scope="row">작성자명</td>
	 						<td>
								<p class="form-control-plaintext">${sessionScope.member.nickName}</p>
							</td>
						</tr>
	
						<tr>
							<td class="table-light col-sm-2" scope="row">내 용</td>
							<td>
								<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
							</td>
						</tr>
						
						<tr>
							<td class="table-light col-sm-2">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
							<td> 
								<input type="file" name="selectFile" multiple="multiple" class="form-control">
							</td>
						</tr>
						
						<c:if test="${mode=='update'}">
							<c:forEach var="vo" items="${listFile}">
								<tr id="f${vo.fileNum}">
									<td class="table-light col-sm-2" scope="row">첨부된파일</td>
									<td> 
										<p class="form-control-plaintext">
												<a href="javascript:deleteFile('${vo.fileNum}');"><i class="bi bi-trash"></i></a>
												${vo.originalFilename}
										</p>
									</td>
								</tr>
							</c:forEach>
						</c:if>
			</table>
			
			<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="reset" class="btn btn-light-secondary">다시입력</button>
							<button type="button" class="btn btn-light-secondary" onclick="sendCancel('${page}');">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<button type="button" class="btn btn-primary" onclick="sendOk('${mode}', '${page}');">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="boardNum" value="${dto.boardNum}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</td>
					</tr>
			</table>
		</form>                              
	</div>   
</section>