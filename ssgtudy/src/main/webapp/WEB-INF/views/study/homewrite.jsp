<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/ckeditor5/ckeditor.js"></script>

<style type="text/css">
.col-md-2 {
	text-align: center;
}
.ck.ck-editor {
	max-width: 97%;
}
.ck-editor__editable {
    min-height: 250px;
}
.ck-content .image>figcaption {
	min-height: 25px;
}
.card-content {
	width: 95%;
}
</style>

<script type="text/javascript">
function sendOk() {
	var f = document.boardForm;
	var str;
	
	if(! f.subject.value.trim()) {
		alert("제목을 입력하세요. ");
		f.subject.focus();
		return;
	}

	if(! f.categoryNum.value.trim() ) {
		alert("카테고리를 선택하세요. ");
		f.categoryNum.focus();
		return;
	}
	
	// 값 가져오기
	// window.editor.getData();
	// 값 셋팅
	    // window.editor.setData('<p>example</p>');
	
	str = window.editor.getData().trim();
    if(! str) {
        alert("내용을 입력하세요. ");
        window.editor.focus();
        return;
    }
	f.content.value = str;
	
	<c:if test="${studyDto.role < 1}">
		location.href = "history.back()";
		return false;
	</c:if>
	
	f.action="${pageContext.request.contextPath}/study/home/${studyNum}/list/${mode}";
	f.submit();
}
</script>


<script type="text/javascript">

</script>
<form class="form form-horizontal" name="boardForm" method="post">
	<div class="form-body pt-5">
		<div class="row">
			<div class="col-md-2">
				<label>제목</label>
			</div>
			<div class="col-md-10 form-group">
				<input type="text" name="subject" class="form-control" value="${dto.subject}">
			</div>
			<div class="col-md-2">
				<label>카테고리</label>
			</div>
			<div class="col-md-10 form-group">
				<select name="categoryNum" class="form-select">
					<option value="">:: 카테고리 선택 ::</option>
					<c:forEach var="vo" items="${categoryList}">
						<option value="${vo.CATEGORYNUM}" ${dto.CATEGORYNUM==vo.CATEGORYNUM?"selected='selected'":""}>${vo.CATEGORYNAME}</option>
					</c:forEach>
				</select>
			</div>
			<div class="col-md-2">
				<label>작성자</label>
			</div>
			<div class="col-md-10 form-group">
				<label>
					<c:if test="${not empty dto.nickName}">${dto.nickName}</c:if>
					<c:if test="${empty dto.nickName}">${sessionScope.member.nickName}</c:if>
				</label>
			</div>
			<div class="col-md-2" style="height:300px" >
				<label>내용</label>
			</div>
			<div class="col-md-10 form-group">
				<div class="editor">${dto.content}</div>
				<input type="hidden" name="content">
			</div>
			<div class="col-sm-12 d-flex justify-content-end">
				<button type="button" class="btn btn-light-secondary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/study/home/${studyNum}';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
				<button type="reset" class="btn btn-light-secondary me-1 mb-1">다시작성</button>
				<button type="button" class="btn btn-primary me-1 mb-1" onclick="sendOk();">${mode=='update'?'수정하기':'등록하기'}<i class="bi bi-check2"></i></button>
				<c:if test="${mode=='update'}">
					<input type="hidden" name="boardNum" value="${dto.boardNum}">
					<input type="hidden" name="page" value="${page}">
				</c:if>
			</div>
		</div>
	</div>
</form>

<script type="text/javascript">
	ClassicEditor
		.create( document.querySelector( '.editor' ), {
			fontFamily: {
	            options: [
	                'default',
	                '맑은 고딕, Malgun Gothic, 돋움, sans-serif',
	                '나눔고딕, NanumGothic, Arial'
	            ]
	        },
	        fontSize: {
	            options: [
	                9, 11, 13, 'default', 17, 19, 21
	            ]
	        },
			toolbar: {
				items: [
					'heading','|',
					'fontFamily','fontSize','bold','italic','fontColor','|',
					'alignment','bulletedList','numberedList','|',
					'imageUpload','insertTable','sourceEditing','blockQuote','mediaEmbed','|',
					'undo','redo','|',
					'link','outdent','indent','|',
				]
			},
			image: {
	            toolbar: [
	                'imageStyle:side',
	                '|',
	                'imageTextAlternative'
	            ],
	
	            // The default value.
	            styles: [
	                'full',
	                'side'
	            ]
	        },
			language: 'ko',
			ckfinder: {
		        uploadUrl: '${pageContext.request.contextPath}/image/upload' // 업로드 url (post로 요청 감)
		    }
		})
		.then( editor => {
			window.editor = editor;
		})
		.catch( err => {
			console.error( err.stack );
		});
</script>
</html>