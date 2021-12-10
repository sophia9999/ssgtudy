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
.col-md-2 {
	text-align: center;
}
.content {
	text-align: center;
    display: flex;
    flex-flow: row nowrap;
    align-items: center;
}
</style>
<script type="text/javascript">
function sendOk() {
	var f = document.boardForm;
	
	var str = f.subject.value;
	if(!str) {
		alert("제목을 입력하세요");
		f.subject.focus();
		return;
	}
	
	str = f.content.value;
	if(!str) {
		alert("내용을 입력하세요");
		f.content.focus();
		return;
	}
	
	str = f.password.value;
	if(!str) {
		alert("비밀번호를 입력하세요");
		f.password.focus();
		return;
	}
	
	f.action = "${pageContext.request.contextPath}/bbs/${mode}";
	f.submit();
}

</script>
</head>
<body>
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
					<form class="form form-horizontal" name="boardForm" method="post">
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
										maxlength="10" value="${dto.nickName}">
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
									<label>비밀번호</label>
								</div>
								<div class="col-md-10 form-group">
									<input type="password" id="password" class="form-control" name="password" 
										maxlength="10" placeholder="Password">
								</div>
								<div class="col-12 col-md-10 offset-md-2 form-group">
									<div class="form-check">
										<div class="checkbox">
											<input type="checkbox" id="checkbox1" class="form-check-input" checked="">
											<label for="checkbox1">Remember Me</label>
										</div>
									</div>
								</div>
								<div class="col-sm-12 d-flex justify-content-end">
									<button type="reset" class="btn btn-light-secondary me-1 mb-1">다시입력</button>
									<button type="button" class="btn btn-light-secondary me-1 mb-1"
										onclick="location.href='${pageContext.request.contextPath}/bbs/list';">${mode=="update"?"수정취소":"등록취소"}</button>	
									<button type="button" class="btn btn-primary me-1 mb-1"
										onclick="sendOk();">등록하기</button>
								</div>
								
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>		
</body>
</html>