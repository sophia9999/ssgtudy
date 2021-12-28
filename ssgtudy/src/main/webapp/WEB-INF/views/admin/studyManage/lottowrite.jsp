<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	
	if(! $(".lottoDate").val().trim() ) {
		alert("마감일을 입력해주세요.");
		$(".lottoDate").focus();
		return false;
	}
	
	if(! $("#content").val().trim() ) {
		alert("내용을 입력해주세요.");
		$("#content").focus();
		return false;
	}
	
	// f.action = "${pageContext.request.contextPath}/studyManage/${mode=='update'?'update':'write'}";
	// f.submit();
	
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
                                        		<option value="indiviual" ${eventCategory=="indiviual"?"selected='selected'":""}>개인</option>
                                        		<option value="group" ${eventCategory=="group"?"selected='selected'":""}>그룹</option>
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
                                        <label>이벤트 마감일</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                        <input type="date" class="form-control lottoDate"
                                            name="lottoDate" value="${dto.lottoDate}">
                                    </div>
                                    <div class="col-md-4">
                                        <label>이벤트 내용</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                        <textarea class="form-control" id="content" name="content" style="height: 200px; resize: none;">${dto.content}</textarea>
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
<!-- // Basic Horizontal form layout section end -->