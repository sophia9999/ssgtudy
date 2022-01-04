 <%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
$(function(){
	var menu = "${menuItem}";
	$("#tab-"+menu).addClass("active");
	
    $("button[role='tab']").on("click", function(e){
		var tab = $(this).attr("data-tab");
		var url = "${pageContext.request.contextPath}/note/"+tab+"/noteForm";
		location.href=url;
    });
});

function searchList() {
	var f = document.searchForm;
	f.submit();
}

$(function() {
    $("#chkAll").click(function() {
	   if($(this).is(":checked")) {
		   $("input[name=nums]").prop("checked", true);
        } else {
		   $("input[name=nums]").prop("checked", false);
        }
    });
 
    $(".btnDelete").click(function(){
		var cnt = $("input[name=nums]:checked").length;

		if (cnt == 0) {
			alert("삭제할 쪽지를 먼저 선택 하세요 !!!");
			return;
		}
         
		if(confirm("선택한 쪽지를 삭제 하시 겠습니까 ? ")) {
			var f = document.listForm;
			f.action = "${pageContext.request.contextPath}/note/${menuItem}/delete";
			f.submit();
		}
	});
});
</script>

	<div class="body-title">
		<h3> 
			<i class="icofont-ui-messaging"></i>
 			쪽지함 
 		</h3>
 			
 	 <div class="body-main">  
 	 	<ul class="nav nav-tabs" id="myTab" role="tablist">
 	 	 	 <li class="nav-item" role="presentation">
 	 	 	 	<button class="nav-link" id="tab-receive" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="receive" aria-selected="true" data-tab="receive">받은 쪽지함</button>
 			 </li>
 			 	
 			 <li class="nav-item" role="presentation">
 			 	<button class="nav-link" id="tab-send" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="send" aria-selected="true" data-tab="send">보낸 쪽지함</button>
 			 </li>	 	
 	 	</ul>	
 	 <div class="tab-content pt-2" id="nav-tabContent">
 	 
 	 	<div class="tab-pane fade show active mt-3" id="nav-content" role="tabpanel" aria-labelledby="nav-tab-content">
 	 	
 	 		<table class="table table-borderless mb-0">
 	 		
 	 			<tr>
 	 				<td align="left" width="50%">
 	 					<button type="button" class="btn btnDelete p-1" title="삭제"><i class="bi bi-trash"></i></button>
 	 				</td>
 	 				
 	 				<td align="right">
 	 					<button type="button" class="btn btn-primary" onclick="javascript:location.href='${pageContext.request.contextPath}/note/noteWrite';">쪽지 쓰기</button>
 	 				</td>
 	 				
 	 			</tr>
 	 			
 	 		</table>
 	 		 	 <div class="card">	
 	 		
 	 		<form name="listForm" method="post">
 	 			<table class="table table-hover board-list">
 	 				<thead class="table-light">
 	 					<tr>
 	 						<th style="width: 10%"><input type="checkbox" name="chAll" id="chkAll" class="form-check-input"></th>
 	 						<th style="width: 10%">${menuItem=="receive"?"보낸사람":"받는사람"}</th>
 	 						<th style="width: 50%">내용</th>
 	 						<th style="width: 15%">${menuItem=="receive"?"받은날짜":"보낸날짜"}</th>
 	 						<th style="width: 15%">읽은날짜</th>
 	 					</tr>
 	 				</thead>
 	 				
 	 				<tbody>
 	 					<c:forEach var="dto" items="${list}">
 	 						<tr>
 	 							<td><input type="checkbox" name="nums" value="${dto.noteNum}" class="form-check-input"></td>
 	 							<td>${menuItem=="receive"?dto.senderId:dto.receiverId}</td>
 	 							
 	 							<td class="left ellipsis">
 	 								<span>
 	 									<a href="${articleUrl}&noteNum=${dto.noteNum}" class="text-reset">${dto.content}</a>
 	 								</span>
 	 							</td>
 	 							<td>${dto.sendDay}</td>
 	 							<td>${dto.identifyDay}</td>
 	 						</tr>		
 	 					</c:forEach>
 	 				</tbody>
 	 			</table>
 	 		
 	 		<input type="hidden" name="page" value="${page}">
 	 		<input type="hidden" name="condition" value="${page}">
 	 		<input type="hidden" name="keyword" value="${page}">
 	 	</form>
 	 	
 	 	<div class="page-box">
 	 		${dataCount == 0 ? "등록된 게시물이 없습니다." :paging }
 	 	</div>
 	 	
 	 	<div class="row board-list-footer">
 	 		<div class="col-md-4 text-center">
 	 			<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/note/${menuItem}/noteForm/';">
 	 				<i class="bi bi-arrow-counterclockwise"></i>
 	 			</button>
 	 		</div>
 	 		<div class="col-md-4 text-center">
 	 			<form class="row" name="searchForm" action="${pageContext.request.contextPath}/note/${menuItem}/noteForm" method="post">
 	 				<div class="col-auto p-1">
 	 					<select name="condition" class="form-select">
 	 						<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<c:choose>
								<c:when test="${menuItem=='receive'}">
									<option value="senderId" ${condition=="senderId"?"selected='selected'":""}>보낸 아이디</option>
									<option value="sendDay" ${condition=="sendDay"?"selected='selected'":""}>받은날짜</option>
								</c:when>
								<c:otherwise>
									<option value="receiverId" ${condition=="receiverId"?"selected='selected'":"" }>받는 아이디</option>
									<option value="sendDay" ${condition=="sendDay"?"selected='selected'":"" }>보낸날짜</option>
								</c:otherwise>	
							</c:choose> 	 					
 	 					</select>	 				
 	 				</div>
 	 				<div class="col-auto p-1" style="width:200px;">
 	 					<input type="text" name="keyword" value="${keyword}" class="form-control">
 	 				</div>				
 	 				<div class="col-auto p-1">
 	 					<button type="button" class="btn btn-outline-primary" onclick="searchList()"><i class="bi bi-search"></i> </button>
 	 				</div>				
 	 			</form> 	 		
 	 		</div>
 	 		<div class="col-md-4">
 	 		</div>
 	 	  </div>
 	 	  	</div>
 	 	   	 		 	  	 	
 	 	  
 	 		</div>
 	 	 	 				
 	 	
 	 	 </div>
 	 	</div>
 	 
 	 	
 	 	</div>
 	 	