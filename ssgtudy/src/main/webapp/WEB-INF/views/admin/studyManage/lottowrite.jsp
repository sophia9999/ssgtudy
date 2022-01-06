<%@ page contentType="text/html; charset=UTF-8" %>
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
	var f = document.eventform;

	if(! $("#subject").val().trim() ) {
		alert("제목을 입력해주세요.");
		$("#subject").focus();
		return false;
	}
	
	if(! $(".eventCategory").val().trim() ) {
		alert("카테고리를 선택해주세요.");
		$(".eventCategory").focus();
		return false;
	}
	
	if(! $(".prize").val().trim() ) {
		alert("경품을 입력해주세요.");
		$(".prize").focus();
		return false;
	}
	
	if(! $(".needPoint").val().trim() < 0 ) {
		alert("필요한 포인트를 입력해주세요.");
		$(".needPoint").focus();
		return false;
	}
	
	if(! $(".lottoDate").val().trim() ) {
		alert("마감일을 입력해주세요.");
		$(".lottoDate").focus();
		return false;
	}
	
	str = window.editor.getData().trim();
    if(! str) {
        alert("내용을 입력하세요. ");
        window.editor.focus();
        return;
    }
	f.content.value = str;

	
	f.action = "${pageContext.request.contextPath}/studyManage/event/${mode=='update'?'update':'write'}";
	f.submit();
	
}
</script>

 <!-- Basic Horizontal form layout section start -->
 
<section id="basic-horizontal-layouts">
    <div class="row match-height justify-content-center">
        <div class="col-10">
        <div class="page-title">
			<div class="row">
				<div class="col-12 col-md-6 order-md-1 order-last">
					<h3><span class="align-middle"></span> ${mode=='update'?'이벤트 수정':'이벤트 등록하기'}</h3>
					<p class="text-subtitle text-muted"></p>
				</div>
			</div>
		</div>
            <div class="card">
                <div class="card-content">
                    <div class="card-body">
                        <form class="form form-horizontal" name="eventform" method="post">
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>이벤트 제목</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                        <input type="text" id="subject" class="form-control"
                                            name="subject" value="${dto.subject}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>카테고리</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                        <div class="input-group">
                                        	<select class="form-select eventCategory" name="eventCategory">
                                        		<option value="">:: 이벤트 카테고리 ::</option> 
                                        		<option value="individual" ${dto.eventCategory=="individual"?"selected='selected'":""}>개인</option>
                                        		<option value="group" ${dto.eventCategory=="group"?"selected='selected'":""}>그룹</option>
                                        	</select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label>이벤트 경품</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                        <input type="text" class="form-control prize"
                                            name="prize" value="${dto.prize}">
                                    </div>
                                     <div class="col-md-4">
                                        <label>응모에 필요한 포인트</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                        <input type="number" class="form-control needPoint"
                                            name="needPoint" value="${dto.needPoint}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>이벤트 마감일</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                    	<c:choose>
                                    	<c:when test="${not empty list}">
	                                        <input type="date" class="form-control lottoDate"
	                                            name="lottoDate" value="${dto.lottoDate}" disabled="disabled">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="date" class="form-control lottoDate"
	                                            name="lottoDate" value="${dto.lottoDate}">
                                        </c:otherwise>
                                    	</c:choose>
                                    </div>
                                    <div class="col-md-4">
                                        <label>이벤트 내용</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                        <div class="editor">${dto.content}</div>
										<input type="hidden" name="content" maxlength="1330">
                                        <c:if test="${mode == 'update'}">
                                        	<input type="hidden" value="${dto.eventNum}" name="eventNum">
                                        </c:if>
                                    </div>
                                    <div class="col-sm-12 d-flex justify-content-end">
                                        <button type="button"
                                            class="btn btn-primary me-1 mb-1" onclick="sendOk()">${mode=='update'?'수정하기':'등록하기'}</button>
                                        <c:if test="${mode == 'write' }">
                                        	<button type="reset" class="btn btn-light-secondary me-1 mb-1">다시입력</button>
                                        </c:if>
                                       	<button type="button" class="btn btn-light-secondary me-1 mb-1" onclick="javascript:history.back();">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
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