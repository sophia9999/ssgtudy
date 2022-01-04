<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.ck.ck-editor__main>.ck-editor__editable:not(.ck-focused) { 
	border: none;
}
</style>
<script type="text/javascript">
<c:if test="${sessionScope.member.userId==dto.userId||sessionScope.member.membership>50}">
	function deleteEvent() {
	    if(confirm("이벤트를 삭제 하시겠습니까 ? ")) {
		    var query = "eventNum=${dto.eventNum}";
		    var url = "${pageContext.request.contextPath}/studyManage/event/delete?" + query;
	    	location.href = url;
	    }
	}
</c:if>
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
				alert("요청 처리 중 에러가 발생했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}
function applyLotto() {
	var date = new Date();
	var nowY = date.getFullYear();
	var nowM = date.getMonth()+1;
	var nowD = date.getDate();
	
	var lottoDate = "${dto.lottoDate}";
	var lottoY = lottoDate.substring(0, 4);
	var lottoM = lottoDate.substring(5, 7);
	var lottoD = lottoDate.substring(8, 10);

	if(nowY > lottoY) {
		alert("지난 이벤트에 응모할 수 없습니다.");
		return false;
	} else if(nowY == lottoY && nowM > lottoM) {
		alert("지난 이벤트에 응모할 수 없습니다.");
		return false;
	} else if(nowY == lottoY && nowM == lottoM && nowD > lottoD) {
		alert("지난 이벤트에 응모할 수 없습니다.");
		return false;
	}
	
	var eventNum = "${dto.eventNum}";
	
	var query = "eventNum="+eventNum+"&needPoint="+${dto.needPoint};
	var url = "${pageContext.request.contextPath}/event/apply";
	var fn  = function(data) {
		// console.log(data);
		if(data.status == "true") {
			alert("이벤트 응모가 완료되었습니다.)");
		} else if(data.status == "duplication") {
			alert("이미 응모한 이벤트입니다.")
		} else if(data.status == "needMore") {
			alert("응모에 필요한 포인트가 부족합니다.")
		}
	}
	ajaxFun(url, "get", query, "json", fn);
}

$(function() {
	$("body").on("click", ".BtnGroupApply", function() {
		var query = "a=0";
		var url = "${pageContext.request.contextPath}/event/readStudy";
		var fn = function(data) {
			// console.log(data);
			$(".eventStudyList tbody").empty();
			var list = data.studyList;			
			var out = "";
			for(var i = 0; i < list.length ; i++) {
				out += "<tr class='text-center'>";
				out += "		<td><input type='checkbox' value='"+list[i].studyNum+"' name='studyNum' class='checkStudyNum'></input></td>";
				out += "		<td>"+list[i].studyName+"</td>";
				out += "		<td>"+(list[i].questCount - list[i].usedCount)+"</td>";
				out += "</tr>";
			}
			console.log(out);
			$(".eventStudyList tbody").append(out);
		};
		ajaxFun(url, "get", query, "json", fn);
	});
});

function btnGroup() {
	var studyNum = $(".eventStudyList input:checked").val();
	// console.log(studyNum);
	var hasPoint = $(".eventStudyList input:checked").closest("tr").find("td:eq(2)").html();
	// console.log(hasPoint);
	if( hasPoint < ${dto.needPoint}) {
		alert("포인트가 부족합니다.");
	} else {
		var url = "${pageContext.request.contextPath}/event/studyEventApply";
		var query = "studyNum="+studyNum+"&needPoint="+${dto.needPoint}+"&eventNum="+${dto.eventNum};
		var fn = function(data) {
			// console.log(data);
			if(data.status == "true") {
				alert("이벤트 응모가 완료되었습니다.)");
				$("#selectStudy").modal("hide");
			} else if(data.status == "duplication") {
				alert("이미 응모한 이벤트입니다.");
				$("#selectStudy").modal("hide");
			} else if(data.status == "needMore") {
				alert("응모에 필요한 포인트가 부족합니다.");
				$("#selectStudy").modal("hide");
			}
		};
		
		ajaxFun(url, "get", query, "json", fn);
	}
}

$(function() {
	$("body").on("click", ".eventStudyList tbody .checkStudyNum", function() {
		if($(this).prop("checked")) {
			$(".eventStudyList tbody .checkStudyNum").prop("checked", false);
			$(this).prop("checked", true);
		};
	});
});
</script>

<div class="page-title">
	<div class="row">
		<div class="col-12 col-md-6 order-md-1 order-last">
			<h3><span><i class="icofont-magic-alt"></i></span>이벤트</h3>
			<p class="text-subtitle text-muted">개인/스터디(그룹)별로 이벤트에 응모해봐요:)</p>
			<p class="text-subtitle text-muted">그룹응모는 스터디장만 가능합니다.</p>
		</div>
	</div>
</div>
<div class="card table-responsive">
	<table class="table mb-0 table-lg">
		<thead>
			<tr>
				<td colspan="2" align="center">
					<h5>${dto.subject}</h5>
				</td>
			</tr>
			<tr>
				<th colspan="2" align="center"><h6>응모에 필요한 포인트 : ${dto.needPoint}</h6></th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td colspan="2" valign="top" height="200" style="padding-top: 5px;">
					<div class="editor">${dto.content}</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<c:choose>
						<c:when test="${dto.eventCategory == 'group' }">
							<button type="button" class="btn-danger btn btn-lg BtnGroupApply" data-bs-toggle="modal" data-bs-target="#selectStudy">이벤트응모하기</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn-danger btn btn-lg" onclick="applyLotto()">이벤트응모하기</button>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<th colspan="2">경품 : ${dto.prize}</th>
			</tr>
			<tr>
				<th colspan="2">마감일 : ${dto.lottoDate}</th>
			</tr>
		</tfoot>
	</table>
				
	<table class="table table-borderless mb-2 table-lg">
		<tr>
			<td width="50%">
				<c:choose>
					<c:when test="${sessionScope.member.membership>50}">
						<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/studyManage/event/update?eventNum=${dto.eventNum}&page=${page}';">수정</button>
					</c:when>
				</c:choose>
				<c:choose>
		    		<c:when test="${sessionScope.member.membership>50}">
		    			<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="deleteEvent();">삭제</button>
		    		</c:when>
		    	</c:choose>
			</td>
			<td class="text-end">
				<c:choose>
		    		<c:when test="${sessionScope.member.membership>50}">
						<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/studyManage/lotto?${query}';">리스트</button>
		    		</c:when>
		    		<c:otherwise>
		    			<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/event/list?${query}';">리스트</button>
		    		</c:otherwise>
		    	</c:choose>
			</td>
		</tr>
	</table>
</div>
<div class="modal fade" id="selectStudy" tabindex="-1" aria-labelledby="selectStudyLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="selectStudyLabel">응모할 스터디 선택</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        	<table class="table table-lg eventStudyList">
	        		<thead>
	        			<tr class="text-center">
	        				<th>&nbsp;</th>
	        				<th>스터디명</th>
	        				<th>응모가능 포인트</th>
	        			</tr>
	        		</thead>
	        		<tbody>
	        		</tbody>
	        	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
	        <button type="button" class="btn btn-primary" onclick="btnGroup()">응모하기</button>
	      </div>
	    </div>
	</div>
</div>
		