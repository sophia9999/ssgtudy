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
.img-viewer {
	cursor: pointer;
	border: 1px solid #ccc;
	width: 45px;
	height: 45px;
	border-radius: 45px;
	background-image: url("${pageContext.request.contextPath}/resources/images/add_photo.png");
	position: relative;
	z-index: 9999;
	background-repeat : no-repeat;
	background-size : cover;
}
</style>

<script type="text/javascript">
function sendOk() {
	var f = document.boardForm;
	var str;
	
	str = f.testName.value.trim();
	if(!str) {
		alert("시험명을 입력하세요");
		f.testName.focus();
		return;
	}
	
	str = f.testDate.value.trim();
	if(!str) {
		alert("시험일을 입력하세요");
		f.testDate.focus();
		return;
	}
	
	str = f.subName.value.trim();
	if(!str) {
		alert("과목명을 입력하세요");
		f.subName.focus();
		return;
	}
	
	str = f.content.value.trim();
	if(!str) {
		alert("내용을 입력하세요");
		f.content.focus();
		return;
	}
	
	 var mode = "${mode}";
     if( (mode === "write") && (!f.selectFile.value) ) {
         alert("시험지 파일을 추가 하세요. ");
         f.selectFile.focus();
         return;
 	}
	

	f.action = "${pageContext.request.contextPath}/test/${mode}";
	f.submit();
}

<c:if test="${mode=='update'}">
	function deleteFile(test_fileNum){
		var url = "${pageContext.request.contextPath}/test/deleteFile";
		$.post(url, {test_fileNum : test_fileNum}, function(data){
			$("#f"+test_fileNum).remove();
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
								<label>시험명</label>
							</div>
							<div class="col-md-10 form-group">
								<input type="text" id="testName" class="form-control" name="testName" placeholder="시험명을 작성하세요." 
									maxlength="100" value="${dto.testName}">
							</div>
							<div class="col-md-2">
								<label>과목명</label>
							</div>
							<div class="col-md-10 form-group">
								<input type="text" id="subName" class="form-control" name="subName" placeholder="과목명을 작성하세요." 
									maxlength="100" value="${dto.subName}">
							</div>
							<div class="col-md-2">
								<label>홀수형 / 짝수형</label>
							</div>
							<div class="col-md-10 form-group">
								<input type="text" id="isOdd" class="form-control" name="isOdd" placeholder="홀수형/짝수형" 
									maxlength="100" value="${dto.isOdd}">
							</div>
							<div class="col-md-2">
								<label>시험일</label>
							</div>
							<div class="col-md-10 form-group">
								<input type="text" id="testDate" class="form-control" name="testDate" placeholder="시험일을 작성하세요." 
									maxlength="100" value="${dto.testDate}">
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
							<div class="col-md-10 form-group ">
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
									<div id="f${vo.test_fileNum}">
										<p class="form-control-plaintext">
											<a href="javascript:deleteFile('${vo.test_fileNum}');">
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
									onclick="location.href='${pageContext.request.contextPath}/test/mock';">${mode=="update"?"수정취소":"등록취소"}</button>	
								<button type="button" class="btn btn-primary me-1 mb-1" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="testNum" value="${dto.testNum}">
									<input type="hidden" name="page" value="${page}">
								</c:if>
							</div>
							
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>		
