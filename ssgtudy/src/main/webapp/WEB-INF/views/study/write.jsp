<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function sendOk() {
	var f = document.form;
	
	var studyName = $("#studyName").val().trim();
	var studyGoal = $("#studyGoal").val().trim();
	
	if(! studyName) {
		 $("#studyName").focus();
		return;
	}
	
	if(! studyGoal) {
		$("#studyGoal").focus();
		return;
	}
	
	if(! confirm("스터디그룹 [" + studyName +"]을/를 만드시겠습니까 ? ")) {
		return;
	}
	
	f.action = "${pageContext.request.contextPath}/study/enroll";
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
					<h3>스터디 그룹 등록하기</h3>
					<p class="text-subtitle text-muted">새로운 스터디 모임을 등록해봐요.</p>
				</div>
			</div>
		</div>
            <div class="card">
                <div class="card-content">
                    <div class="card-body">
                        <form class="form form-horizontal" name="form" method="post">
                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label>스터디그룹 이름</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                        <input type="text" id="studyName" class="form-control"
                                            name="studyName" placeholder="스터디이름">
                                    </div>
                                    <div class="col-md-4">
                                        <label>스터디그룹 목표</label>
                                    </div>
                                    <div class="col-md-8 form-group">
                                        <textarea class="form-control" id="studyGoal" name="studyGoal" style="height: 200px; resize: none;" placeholder="스터디그룹를 통해 이루고 싶은 목표를 입력해주세요:)"></textarea>
                                    </div>
                                    <div class="col-sm-12 d-flex justify-content-end">
                                        <button type="button"
                                            class="btn btn-primary me-1 mb-1" onclick="sendOk()">만들기</button>
                                        <button type="reset"
                                            class="btn btn-light-secondary me-1 mb-1">다시입력</button>
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