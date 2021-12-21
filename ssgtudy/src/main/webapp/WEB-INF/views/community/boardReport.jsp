<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function sendOk() {
    var f = document.reportForm;
	var str;
	
    str = f.reason.value.trim();
    if(! str) {
        alert("신고사유를 입력해주세요.");
        f.reason.focus();
        return;
    }
    if(str == "기타" && f.reason_etc.value.trim() == "") {
        alert("신고사유를 입력해주세요.");
        f.reason_etc.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/community/boardReport";
    f.submit();
    
    alert("신고가 완료되었습니다.");
}

$(function(){
	 
	$('input[name="reason"]').on('click', function(){
	  var chkValue = $(this).val();
	  if(chkValue == "기타"){
	     $('#etc_view').css('display','block');
	  } else {
	     $('#etc_view').css('display','none');
	  }
	});
});



</script>

<section class="row">
	<div class="card">
		<form name="reportForm" method="post">
			<table class="table table-lg">
					<tr>
						<td colspan="2" align="center" style="font-weight:bold">
							[게시글 신고]
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left">
							신고자 : ${sessionScope.member.nickName}
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="font-weight:bold">
							신고에 신중해주시길 바랍니다.
							적절하지 않은 신고는 반영되지 않으며 불이익이 있을 수 있습니다.
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left">
							신고사유 : 
							<br>
							<br>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="reason" id="reason1" value="회원에 대한 욕설 혹은 비방">
							  <label class="form-check-label" for="reason1">
							    회원에 대한 욕설 혹은 비방
							  </label>
							</div>
							<br>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="reason" id="reason2" value="허위사실 유포">
							  <label class="form-check-label" for="reason2">
							   허위사실 유포
							  </label>
							</div>
							<br>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="reason" id="reason3" value="게시자료의 저작권 위반">
							  <label class="form-check-label" for="reason3">
							    게시자료의 저작권 위반
							  </label>
							</div>
							<br>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="reason" id="reason4" value="일반인 신상정보 게시">
							  <label class="form-check-label" for="reason4">
							   일반인 신상정보 게시
							  </label>
							</div>
							<br>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="reason" id="reason5" value="지나친 홍보 또는 상거래 유도">
							  <label class="form-check-label" for="reason5">
							  지나친 홍보 또는 상거래 유도
							  </label>
							</div>
							<br>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="reason" id="reason6" value="다른 게시판에 적절한 게시글">
							  <label class="form-check-label" for="reason6">
							   다른 게시판에 적절한 게시글
							  </label>
							</div>
							<br>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="reason" id="reason_etc" value="기타">
							  <label class="form-check-label" for="reason_etc">
							   기타
							  </label>
							</div>
							<div id="etc_view" style="display:none;">
								<input type="text" id="reason_etc_view" name="reason_etc" class="form-control" style="width:300px;" placeholder="기타 선택 시 입력해주세요."/>
							</div>
						</td>
					</tr>
			</table>
			
			<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-danger" onclick="sendOk();">신고하기</button>
							<button type="reset" class="btn btn-light-secondary me-1 mb-1">다시입력</button>
							<button type="button" class="btn btn-light-secondary me-1 mb-1" onclick="${pageContext.request.contextPath}/community/article?boardNum=${boardNum}&page=${page}">신고취소</button>
							<input type="hidden" name="boardNum" value="${boardNum}">
							<input type="hidden" name="page" value="${page}">
						</td>
					</tr>
			</table>
		</form>
	                                            
	
	</div>   
</section>