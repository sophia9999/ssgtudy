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

	if(! f.studyNum.value.trim() ) {
		alert("홍보할 스터디를 선택하세요. ");
		f.studyNum.focus();
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

	f.action="${pageContext.request.contextPath}/study/ad/${mode}";
	f.submit();
}
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
				alert("요청 처리가 실패했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

</script>
<div class="page-title">
		<div class="row">
			<div class="col-12 col-md-6 order-md-1 order-last">
				<h3><span><i class="icofont-bullhorn"></i></span> 스터디 홍보 게시판</h3>
				<p class="text-subtitle text-muted">스터디 홍보하고 함께할 스터디 구성원을 모아봐요:)</p>
			</div>
		</div>
	</div>
<div class="col-md-12 col-12">

	<div class="card">
		
		<div class="card-content p-3">

				<form class="form form-horizontal" name="boardForm" method="post">
					<div class="form-body">
						<div class="row">
							<div class="col-md-2">
								<label>제목</label>
							</div>
							<div class="col-md-10 form-group">
								<input type="text" name="subject" class="form-control" value="${dto.subject}">
							</div>
							<div class="col-md-2">
								<label>홍보할 스터디</label>
							</div>
							<div class="col-md-10 form-group">
								<select name="studyNum" class="form-select">
									<option value="">:: 스터디 선택 ::</option>
									<c:forEach var="vo" items="${myStudyList}">
										<c:choose>
											<c:when test="${vo.studyStatus == 0 && vo.role > 0}">
												<option value="${vo.studyNum}" ${dto.studyNum==vo.studyNum?"selected='selected'":""}>${vo.studyName}</option>
											</c:when>
											<c:otherwise>
												<option value="${vo.studyNum}" disabled="disabled">${vo.studyName} - 참여대기중이거나 비활성화된 스터디입니다.</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-2">
								<label>작성자</label>
							</div>
							<div class="col-md-10 form-group">
								<label>${sessionScope.member.nickName}</label>
							</div>
							<div class="col-md-2" style="height:300px" >
								<label>내용</label>
							</div>
							<div class="col-md-10 form-group">
								<div class="editor">${dto.content}</div>
								<input type="hidden" name="content">
							</div>
							<div class="col-sm-12 d-flex justify-content-end">
								<button type="button" class="btn btn-light-secondary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/study/ad';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
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
		</div>
	</div>
</div>		

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