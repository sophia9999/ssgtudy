<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function search() {
	var f = document.searchForm;
	f.action = "${pageContext.request.contextPath}/study/manageMember";
	f.submit();
}
</script>
<section id="basic-horizontal-layouts">
    <div class="row match-height justify-content-center">
        <div class="col-10">
        <div class="page-title">
			<div class="row">
				<div class="col-12 col-md-6 order-md-1 order-last">
					<h3><span class="align-middle"><i class="bi bi-person-square"></i></span> ${vo.studyName} 구성원관리</h3>
				</div>
			</div>
		</div>

    <div class="card mx-auto">
        <div class="card-header">
        	${dataCount}개(${page}/${total_page} 페이지)
        	<c:if test="${vo.role < 20}"><p class="text-center">관리자는 대기멤버와 일반멤버만 볼 수 있습니다.</p></c:if>
        </div>
        <div class="card-body">
            <table class="table table-lg" id="table1">
                <thead>
                    <tr class="text-center">
                    	<th class="col-md-2">번호</th>
                        <th class="col-auto">멤버 닉네임</th>
                        <th class="col-md-3">멤버 역할</th>
                        <th class="col-md-3">변경</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="dto" items="${list}">
                		<tr class="text-center">
                			<td>${dto.listNum}</td>
                			<td>${dto.nickName}
                				<input type="hidden" value="${dto.nickName}" class="nickName-check">
                				<input type="hidden" value="${dto.userId}" class="userId-check">
                			</td>
                			<c:choose>
                				<c:when test="${dto.role > 10 }">
                					<td>스터디 장(최고관리자)
                						<input type="hidden" value="${dto.role}" class="current_role">
                					</td>
                				</c:when>
                				<c:when test="${dto.role > 1 }">
                					<td>스터디관리자
                						<input type="hidden" value="${dto.role}" class="current_role">
                					</td>
                				</c:when>
                				<c:when test="${dto.role == '1' }">
                					<td>일반멤버
                						<input type="hidden" value="${dto.role}" class="current_role">
                					</td>
                				</c:when>
                				<c:otherwise>
                					<td>대기멤버</td>
                				</c:otherwise>
                			</c:choose>
							<td>
							<div class="input-group">
                            	<select name="role" class="select form-select memberRole">
									<c:choose>
										<c:when test="${vo.role > 10}">
											<option value="20" ${dto.role == '20' ? "selected='selected'":"" }>스터디장</option>
											<option value="10" ${dto.role == '10' ? "selected='selected'":"" }>스터디관리자</option>
											<option value="1" ${dto.role == '1' ? "selected='selected'":"" }>일반멤버</option>
											<option value="0" ${dto.role == '0' ? "selected='selected'":"" }>대기멤버</option>
										</c:when>
										<c:otherwise>
											<option value="1" ${dto.role == '1' ? "selected='selected'":"" }>일반멤버</option>
											<option value="0" ${dto.role == '0' ? "selected='selected'":"" }>대기멤버</option>
										</c:otherwise>
									</c:choose>
								</select>
                           		<button type="button" class="btn btn-primary changeRole" value="${dto.memberNum}">변경</button>
								<button type="button" class="btn btn-danger deleteMember" value="${dto.memberNum}">강퇴</button>
                            </div>
							</td>
                		</tr>
                	</c:forEach>
                </tbody>
            </table>
            <form class="form form-horizontal" name="searchForm" method="post">
				<div class="form-body">
					<div class="row">
						<div class="col-md-2 form-group">
						</div> 
						<div class="col-md-2 form-group">
						<div class="col-auto">
						<div style="width:120px;" class="text-end">
							<select name="condition" class="form-select">
								<option value="nickName" ${condition=="studyName"?"selected='selected'":""}>닉네임</option>
							</select>
						</div>
						</div>                                                      
						</div>                                      
						<div class="col-md-3 form-group">
							<input type="text" id="" class="form-control" name="keyword" value="${keyword}">                                          
						</div>
						<div class="col-md-2 form-group">                                                     
							<button type="button" class="btn btn-outline-primary me-1 mb-1 btnSearch" onclick="search()">검색</button>
						</div>				                                                   
						<div class="col-md-2"></div>
					</div>
				</div>
				<input type="hidden" value="${studyNum}" name="studyNum">
			</form> 
        </div>
        <div class="page-box text-center">
			${dataCount == 0 ? "등록된 멤버가 없습니다." : paging}
		</div>
		<div class="p-2 text-center">
			<button type="button" class="btn btn-primary" onclick="javascript:location.href='${pageContext.request.contextPath}/study/home/${studyNum}';">홈으로</button>
		</div>
    </div>
    </div>
    </div>
</section>

<script type="text/javascript">
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
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

function changeRole(memberNum) {
	

	
	// var selector = $(this).closest("tr").find(".nickName").html();
	
}

$(function() {
	$("body").on("click", ".changeRole", function() {
		var memberNum = $(this).val();
		var nickName = $(this).closest("tr").find(".nickName-check").val();
		var userId = $(this).closest("tr").find(".userId-check").val();
		console.log(memberNum);
		
		var role = $(this).closest("tr").find(".memberRole option:selected").html();
		var roleValue = $(this).closest("tr").find(".memberRole option:selected").val();
		console.log(role);
		console.log(roleValue);
		if(! confirm(nickName+'의 역할을 '+ role+'(으)로 변경하시겠습니까?')) {
			return false;
		}
		
		if(userId == '${sessionScope.member.userId}') {
			alert("자기자신은 바꿀 수 없습니다.");
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/study/memberstatus?studyNum="+${studyNum}+"&memberNum="+memberNum+"&roleValue="+roleValue;
		
		location.href = url;
	});
})

$(function() {
	$("body").on("click", ".deleteMember", function() {
		var memberNum = $(this).val();
		var nickName = $(this).closest("tr").find(".nickName-check").val();
		// console.log(memberNum);
		
		var current_role = $(this).closest("tr").find(".current_role").val();
		// console.log(current_role);
		
		if(! confirm(nickName+'을 탈퇴 시키겠습니까 ? ')) {
			return false;
		}
		
		if(current_role >= 10) {
			alert("스터디장/스터디관리자는 탈퇴시킬 수 없습니다. 일반멤버로 강등 후 진행해주세요.");
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/study/memberRemove?studyNum="+${studyNum}+"&memberNum="+memberNum;
		
		location.href = url;
	});
})


/* $(function() {
	function changeRole(memberNum) {
		var num = memberNum;
		var selector = $(this).closest("tr").find("td:eq(2)").html();
		console.log(num);
		console.log(selector);
	}
}); */

</script>
