<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.dialog-receiver-list {
	height: 200px;
	overflow-y: scroll;
}
.dialog-receiver-list ul, .dialog-receiver-list li {
	list-style: none;
	padding: 0;
}



.receiver-user {
	color: #0d58ba;
	margin-right: 3px;
	cursor: pointer;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<script type="text/javascript">
$(function(){
    $("button[role='tab']").on("click", function(e){
		var tab = $(this).attr("data-tab");
		if(tab === "send") {
			return false;
		}		
		var url = "${pageContext.request.contextPath}/note/receive/noteForm";
		location.href=url;
    });
});

function sendOk() {
	var f = document.noteForm;
	var str;

	if($("#forms-receiver-list input[name=receivers]").length === 0) {
		alert("받는 사람을 추가하세요. ");
		return;
	}

	str = f.content.value.trim();
	if(!str) {
		alert("내용을 입력하세요. ");
		f.content.focus();
		return;
	}

	f.action="${pageContext.request.contextPath}/note/noteWrite";

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

$(function(){
	$(".btnReceiverDialog").click(function(){
		$("#condition").val("nickName");
		//$("#condition").val("userId");
		$("#keyword").val("");
		$(".dialog-receiver-list ul").empty();
		
		$("#myDialogModal").modal("show");
	});
	
	// 대화상자 - 받는사람 검색 버튼
	$(".btnReceiverFind").click(function(){
		var condition = $("#condition").val();
		var keyword = $("#keyword").val();
		if(condition != "friend" && keyword == "") {
			$("#keyword").focus();
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/note/listFriend"; 
		var query = "condition="+condition+"&keyword="+encodeURIComponent(keyword);
		
		var fn = function(data){
			$(".dialog-receiver-list ul").empty();
			searchListFriend(data);
		};
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function searchListFriend(data) {
		
		var s;
		for(var i=0; i<data.listFriend.length; i++) {
			var userId = data.listFriend[i].userId;
			var nickName = data.listFriend[i].nickName;
			
			s = "<li><input type='checkbox' class='form-check-input' data-userId='"+userId+"' title='"+userId+"'> <span>"+nickName+"</span> </li>";
			$(".dialog-receiver-list ul").append(s);
		}
		
	}
	
	// 대화상자-받는 사람 추가 버튼
	$(".btnAdd").click(function(){
		var len1 = $(".dialog-receiver-list ul input[type=checkbox]:checked").length;
		var len2 = $("#forms-receiver-list input[name=receivers]").length;
		
	
		
		if(len1 == 0) {
			alert("추가할 사람을 먼저 선택하세요.");
			return false;			
		}
		
		if(len1 + len2 >= 4) {
			alert("받는사람은 최대 5명까지만 가능합니다.");
			return false;
		}
		
		var b, userId, nickName, s;

		b = false;
		$(".dialog-receiver-list ul input[type=checkbox]:checked").each(function(){
			userId = $(this).attr("data-userId");
			nickName = $(this).next("span").text();
			
			$("#forms-receiver-list input[nickName=receivers]").each(function(){
				if($(this).val() == userId) {
					b = true;
					return false;
				}
			});
			
			if(! b) {
				s = "<span class='receiver-user btn border px-1'>"+nickName+" <i class='bi bi-trash' data-userId='"+userId+"'></i></span>";
				$(".forms-receiver-name").append(s);
				
				s = "<input type='hidden' name='receivers' value='"+userId+"'>";
				$("#forms-receiver-list").append(s);
							}
		});
		
		$("#myDialogModal").modal("hide");
	});
	
	$(".btnClose").click(function(){
		$("#myDialogModal").modal("hide");
	});
	
	$("body").on("click", ".bi-trash", function(){
		var userId = $(this).attr("data-userId");
		
		$(this).parent().remove();
		$("#forms-receiver-list input[name=receivers]").each(function(){
			var receiver = $(this).val();
			if(userId == receiver) {
				$(this).remove();
				return false;
			}
		});
		
	});

});

</script>


<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-messenger"></i> 쪽지함 
			
			</h3>
		</div>
	
	
		
		<div class="body-main">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-receive" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="receive" aria-selected="true" data-tab="receive">받은 쪽지함</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="tab-send" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="send" aria-selected="true" data-tab="send">보낸 쪽지함</button>
				</li>
			</ul>
			
			
			<div class="tab-content pt-2" id="nav-tabContent">
				<div class="tab-pane show active mt-3" id="nav-content" role="tabpanel" aria-labelledby="nav-tab-content">
					
					<form name="noteForm" method="post">
							<div class="card">
					
						<table class="table write-form mt-5">
						
							<tr>
							
								<td class="table-light col-sm-2" scope="row">받는사람</td>
								<td>
									<div class="row">
										<div class="col-auto pe-0">
											<button type="button" class="btn btn-light btnReceiverDialog">추가</button>
										</div>
										<div class="col">
											<div class="forms-receiver-name" >
												<c:if test="${not empty userId}">
													<span class='receiver-user btn border px-1'>
													${nickName} <i class='bi bi-trash' data-userId='"+userId+"'></i></span>
												</c:if>
											
											</div>
										</div>
									</div>
									<small class="form-control-plaintext">한번에 보낼수 있는 최대 인원은 5명입니다.</small>
								</td>
							</tr>
		        
							<tr>
								<td class="table-light col-sm-2" scope="row">내 용</td>
								<td>
									<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
								</td>
							</tr>
						</table>
						
						<table class="table table-borderless">
		 					<tr>
								<td class="text-center">
									<button type="reset" class="btn btn-light-secondary">다시입력</button>
									<button type="button" class="btn btn-light-secondary" onclick="location.href='${pageContext.request.contextPath}/note/send/noteForm';">취소&nbsp;<i class="bi bi-x"></i></button>
									<button type="button" class="btn btn-primary" onclick="sendOk();">보내기&nbsp;<i class="bi bi-check2"></i></button>
									<div id="forms-receiver-list">	
										
										<c:if test="${not empty userId}">
										<input type='hidden' name='receivers' value= "${userId}">
										</c:if>
									</div>
								</td>
							</tr>
						</table>
						</div>
					</form>
				
				</div>
			</div>		
		
		</div>
		</div>
	</div>


<div class="modal fade" id="myDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">받는 사람</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-auto p-1">
						<select name="condition" id="condition" class="form-select">
							<option value="nickName">닉네임</option>
							<option value="userId">아이디</option>
							<option value="friend">친구목록</option>
							
						</select>
					</div>
					<div class="col-auto p-1">
						<input type="text" name="keyword" id="keyword" class="form-control">
					</div>
					<div class="col-auto p-1">
						<button type="button" class="btn btn-light btnReceiverFind"> <i class="bi bi-search"></i> </button>
					</div>				
				</div>
				<div class="row p-1">
					<div class="border p-1 dialog-receiver-list">
						<ul></ul>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btnAdd">추가</button>
				<button type="button" class="btn btn-secondary btnClose">닫기</button>
			</div>			
		</div>
	</div>
</div>
